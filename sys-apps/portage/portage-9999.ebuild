# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-9999.ebuild,v 1.88 2013/09/08 12:45:39 mgorny Exp $

EAPI=3
PYTHON_COMPAT=(
	pypy2_0
	python3_2 python3_3 python3_4
	python2_6 python2_7
)
inherit git-2 eutils multilib

DESCRIPTION="Portage is the package management and distribution system for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/index.xml"
LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="build doc epydoc +ipc linguas_ru pypy2_0 python2 python3 selinux xattr"

for _pyimpl in ${PYTHON_COMPAT[@]} ; do
	IUSE+=" python_targets_${_pyimpl}"
done
unset _pyimpl

# Import of the io module in python-2.6 raises ImportError for the
# thread module if threading is disabled.
python_dep_ssl="python3? ( =dev-lang/python-3*[ssl] )
	!pypy2_0? ( !python2? ( !python3? (
		|| ( >=dev-lang/python-2.7[ssl] dev-lang/python:2.6[threads,ssl] )
	) ) )
	pypy2_0? ( !python2? ( !python3? ( virtual/pypy:2.0[bzip2] ) ) )
	python2? ( !python3? ( || ( dev-lang/python:2.7[ssl] dev-lang/python:2.6[ssl,threads] ) ) )"
python_dep="${python_dep_ssl//\[ssl\]}"
python_dep="${python_dep//,ssl}"
python_dep="${python_dep//ssl,}"

python_dep="${python_dep}
	python_targets_pypy2_0? ( virtual/pypy:2.0 )
	python_targets_python2_6? ( dev-lang/python:2.6 )
	python_targets_python2_7? ( dev-lang/python:2.7 )
	python_targets_python3_2? ( dev-lang/python:3.2 )
	python_targets_python3_3? ( dev-lang/python:3.3 )
	python_targets_python3_4? ( dev-lang/python:3.4 )
"

# make-3.82 is for bug #455858
DEPEND="${python_dep}
	>=sys-devel/make-3.82
	>=sys-apps/sed-4.0.5 sys-devel/patch
	doc? ( app-text/xmlto ~app-text/docbook-xml-dtd-4.4 )
	epydoc? ( >=dev-python/epydoc-2.0 )"
# Require sandbox-2.2 for bug #288863.
# For xattr, we can spawn getfattr and setfattr from sys-apps/attr, but that's
# quite slow, so it's not considered in the dependencies as an alternative to
# to python-3.3 / pyxattr. Also, xattr support is only tested with Linux, so
# for now, don't pull in xattr deps for other kernels.
# For whirlpool hash, require python[ssl] or python-mhash (bug #425046).
# For compgen, require bash[readline] (bug #445576).
RDEPEND="${python_dep}
	!build? ( >=sys-apps/sed-4.0.5
		|| ( >=app-shells/bash-4.2_p37[readline] ( <app-shells/bash-4.2_p37 >=app-shells/bash-3.2_p17 ) )
		>=app-admin/eselect-1.2
		|| ( ${python_dep_ssl} dev-python/python-mhash )
	)
	elibc_FreeBSD? ( sys-freebsd/freebsd-bin )
	elibc_glibc? ( >=sys-apps/sandbox-2.2 )
	elibc_uclibc? ( >=sys-apps/sandbox-2.2 )
	>=app-misc/pax-utils-0.1.17
	xattr? ( kernel_linux? ( || ( >=dev-lang/python-3.3_pre20110902 dev-python/pyxattr ) ) )
	selinux? ( || ( >=sys-libs/libselinux-2.0.94[python] <sys-libs/libselinux-2.0.94 ) )
	!<app-shells/bash-3.2_p17
	!<app-admin/logrotate-3.8.0"
PDEPEND="
	!build? (
		>=net-misc/rsync-2.6.4
		userland_GNU? ( >=sys-apps/coreutils-6.4 )
	)"
# coreutils-6.4 rdep is for date format in emerge-webrsync #164532
# NOTE: FEATURES=installsources requires debugedit and rsync

SRC_ARCHIVES="http://dev.gentoo.org/~zmedico/portage/archives"

prefix_src_archives() {
	local x y
	for x in ${@}; do
		for y in ${SRC_ARCHIVES}; do
			echo ${y}/${x}
		done
	done
}

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/portage.git"
S="${WORKDIR}"/${PN}

compatible_python_is_selected() {
	[[ $("${EPREFIX}/usr/bin/python" -c 'import sys ; sys.stdout.write(sys.hexversion >= 0x2060000 and "good" or "bad")') = good ]]
}

current_python_has_xattr() {
	[[ ${EPYTHON} ]] || die 'No Python implementation set (EPYTHON is null).'
	local PYTHON=${EPREFIX}/usr/bin/${EPYTHON}
	[[ $("${PYTHON}" -c 'import sys ; sys.stdout.write(sys.hexversion >= 0x3030000 and "yes" or "no")') = yes ]] || \
	"${PYTHON}" -c 'import xattr' 2>/dev/null
}

call_with_python_impl() {
	[[ ${EPYTHON} ]] || die 'No Python implementation set (EPYTHON is null).'
	env EPYTHON=${EPYTHON} "$@"
}

get_python_interpreter() {
	[ $# -eq 1 ] || die "expected 1 argument, got $#: $*"
	local impl=$1 python
	case "${impl}" in
		python*)
			python=${impl/_/.}
			;;
		pypy*)
			python=${impl/_/.}
			python=${python/pypy/pypy-c}
			;;
		*)
			die "Unrecognized python target: ${impl}"
	esac
	echo ${python}
}

get_python_sitedir() {
	[ $# -eq 1 ] || die "expected 1 argument, got $#: $*"
	local impl=$1
	local site_dir=/usr/$(get_libdir)/${impl/_/.}/site-packages
	[[ -d ${EROOT}${site_dir} ]] || \
		ewarn "site-packages dir missing for ${impl}: ${EROOT}${site_dir}"
	echo "${site_dir}"
}

python_compileall() {
	[[ ${EPYTHON} ]] || die 'No Python implementation set (EPYTHON is null).'
	local d=${EPREFIX}$1 PYTHON=${EPREFIX}/usr/bin/${EPYTHON}
	local d_image=${D}${d#/}
	[[ -d ${d_image} ]] || die "directory does not exist: ${d_image}"
	case "${EPYTHON}" in
		python*)
			"${PYTHON}" -m compileall -q -f -d "${d}" "${d_image}" || die
			# Note: Using -OO breaks emaint, since it requires __doc__,
			# and __doc__ is None when -OO is used.
			"${PYTHON}" -O -m compileall -q -f -d "${d}" "${d_image}" || die
			;;
		pypy*)
			"${PYTHON}" -m compileall -q -f -d "${d}" "${d_image}" || die
			;;
		*)
			die "Unrecognized EPYTHON value: ${EPYTHON}"
	esac
}

pkg_setup() {
	if use python2 && use python3 ; then
		ewarn "Both python2 and python3 USE flags are enabled, but only one"
		ewarn "can be in the shebangs. Using python3."
	fi
	if use pypy2_0 && use python3 ; then
		ewarn "Both pypy2_0 and python3 USE flags are enabled, but only one"
		ewarn "can be in the shebangs. Using python3."
	fi
	if use pypy2_0 && use python2 ; then
		ewarn "Both pypy2_0 and python2 USE flags are enabled, but only one"
		ewarn "can be in the shebangs. Using python2"
	fi
	if ! use pypy2_0 && ! use python2 && ! use python3 && \
		! compatible_python_is_selected ; then
		ewarn "Attempting to select a compatible default python interpreter"
		local x success=0
		for x in "${EPREFIX}"/usr/bin/python2.* ; do
			x=${x#${EPREFIX}/usr/bin/python2.}
			if [[ $x -ge 6 ]] 2>/dev/null ; then
				eselect python set python2.$x
				if compatible_python_is_selected ; then
					elog "Default python interpreter is now set to python-2.$x"
					success=1
					break
				fi
			fi
		done
		if [ $success != 1 ] ; then
			eerror "Unable to select a compatible default python interpreter!"
			die "This version of portage requires at least python-2.6 to be selected as the default python interpreter (see \`eselect python --help\`)."
		fi
	fi

	# We use EPYTHON to designate the active python interpreter,
	# but we only export when needed, via call_with_python_impl.
	EPYTHON=python
	export -n EPYTHON
	if use python3; then
		EPYTHON=python3
	elif use python2; then
		EPYTHON=python2
	elif use pypy2_0; then
		EPYTHON=pypy-c2.0
	fi
}

src_prepare() {
	epatch_user

	einfo "Producing ChangeLog from Git history..."
	pushd "${S}/.git" >/dev/null || die
	git log ebcf8975b37a8aae9735eb491a9b4cb63549bd5d^.. \
		> "${S}"/ChangeLog || die
	popd >/dev/null || die

	local _version=$(cd "${S}/.git" && git describe --tags | sed -e 's|-\([0-9]\+\)-.\+$|_p\1|')
	_version=${_version:1}
	einfo "Setting portage.VERSION to ${_version} ..."
	sed -e "s/^VERSION=.*/VERSION='${_version}'/" -i pym/portage/__init__.py || \
		die "Failed to patch portage.VERSION"
	sed -e "1s/VERSION/${_version}/" -i doc/fragment/version || \
		die "Failed to patch VERSION in doc/fragment/version"
	sed -e "1s/VERSION/${_version}/" -i $(find man -type f) || \
		die "Failed to patch VERSION in man page headers"

	if ! use ipc ; then
		einfo "Disabling ipc..."
		sed -e "s:_enable_ipc_daemon = True:_enable_ipc_daemon = False:" \
			-i pym/_emerge/AbstractEbuildProcess.py || \
			die "failed to patch AbstractEbuildProcess.py"
	fi

	if use xattr && use kernel_linux ; then
		einfo "Adding FEATURES=xattr to make.globals ..."
		echo -e '\nFEATURES="${FEATURES} xattr"' >> cnf/make.globals \
			|| die "failed to append to make.globals"
	fi

	local set_shebang=
	if use python3; then
		set_shebang=python3
	elif use python2; then
		set_shebang=python2
	elif use pypy2_0; then
		set_shebang=pypy-c2.0
	fi
	if [[ -n ${set_shebang} ]] ; then
		einfo "Converting shebangs for ${set_shebang}..."
		while read -r -d $'\0' ; do
			local shebang=$(head -n1 "$REPLY")
			if [[ ${shebang} == "#!/usr/bin/python"* ]] ; then
				sed -i -e "1s:python:${set_shebang}:" "$REPLY" || \
					die "sed failed"
			fi
		done < <(find . -type f -print0)
	fi

	if [[ -n ${EPREFIX} ]] ; then
		einfo "Setting portage.const.EPREFIX ..."
		sed -e "s|^\(SANDBOX_BINARY[[:space:]]*=[[:space:]]*\"\)\(/usr/bin/sandbox\"\)|\\1${EPREFIX}\\2|" \
			-e "s|^\(FAKEROOT_BINARY[[:space:]]*=[[:space:]]*\"\)\(/usr/bin/fakeroot\"\)|\\1${EPREFIX}\\2|" \
			-e "s|^\(BASH_BINARY[[:space:]]*=[[:space:]]*\"\)\(/bin/bash\"\)|\\1${EPREFIX}\\2|" \
			-e "s|^\(MOVE_BINARY[[:space:]]*=[[:space:]]*\"\)\(/bin/mv\"\)|\\1${EPREFIX}\\2|" \
			-e "s|^\(PRELINK_BINARY[[:space:]]*=[[:space:]]*\"\)\(/usr/sbin/prelink\"\)|\\1${EPREFIX}\\2|" \
			-e "s|^\(EPREFIX[[:space:]]*=[[:space:]]*\"\).*|\\1${EPREFIX}\"|" \
			-i pym/portage/const.py || \
			die "Failed to patch portage.const.EPREFIX"

		einfo "Prefixing shebangs ..."
		while read -r -d $'\0' ; do
			local shebang=$(head -n1 "$REPLY")
			if [[ ${shebang} == "#!"* && ! ${shebang} == "#!${EPREFIX}/"* ]] ; then
				sed -i -e "1s:.*:#!${EPREFIX}${shebang:2}:" "$REPLY" || \
					die "sed failed"
			fi
		done < <(find . -type f -print0)

		einfo "Adjusting make.globals ..."
		sed -e "s|\(/usr/portage\)|${EPREFIX}\\1|" \
			-e "s|^\(PORTAGE_TMPDIR=\"\)\(/var/tmp\"\)|\\1${EPREFIX}\\2|" \
			-i cnf/make.globals || die "sed failed"

		einfo "Adjusting repos.conf ..."
		sed -e "s|^\(main-repo = \).*|\\1gentoo_prefix|" \
			-e "s|^\\[gentoo\\]|[gentoo_prefix]|" \
			-e "s|^\(location = \)\(/usr/portage\)|\\1${EPREFIX}\\2|" \
			-e "s|^\(sync-uri = \).*|\\1rsync://rsync.prefix.freens.org/gentoo-portage-prefix|" \
			-i cnf/repos.conf || die "sed failed"

		einfo "Adding FEATURES=force-prefix to make.globals ..."
		echo -e '\nFEATURES="${FEATURES} force-prefix"' >> cnf/make.globals \
			|| die "failed to append to make.globals"
	fi

	cd "${S}/cnf" || die
	if [ -f "make.conf.example.${ARCH}".diff ]; then
		patch make.conf.example "make.conf.example.${ARCH}".diff || \
			die "Failed to patch make.conf.example"
	else
		eerror ""
		eerror "Portage does not have an arch-specific configuration for this arch."
		eerror "Please notify the arch maintainer about this issue. Using generic."
		eerror ""
	fi
}

src_compile() {
	if use doc; then
		call_with_python_impl \
		emake docbook || die
	fi

	if use epydoc; then
		einfo "Generating api docs"
		call_with_python_impl \
		emake epydoc || die
	fi
}

src_test() {
	./runtests.sh || die "tests failed"
}

src_install() {
	call_with_python_impl \
	emake DESTDIR="${D}" \
		sysconfdir="${EPREFIX}/etc" \
		prefix="${EPREFIX}/usr" \
		install || die

	# Use dodoc for compression, since the Makefile doesn't do that.
	dodoc "${S}"/{ChangeLog,NEWS,RELEASE-NOTES} || die

	# Allow external portage API consumers to import portage python modules
	# (this used to be done with PYTHONPATH setting in /etc/env.d).
	# For each of PYTHON_TARGETS, install a tree of *.py symlinks in
	# site-packages, and compile with the corresponding interpreter.
	local impl files mod_dir dest_mod_dir python relative_path x
	for impl in "${PYTHON_COMPAT[@]}" ; do
		use "python_targets_${impl}" || continue
		if use build && [[ ${ROOT} == / &&
			! -x ${EPREFIX}/usr/bin/$(get_python_interpreter ${impl}) ]] ; then
			# Tolerate --nodeps at beginning of stage1 for catalyst
			ewarn "skipping python_targets_${impl}, interpreter not found"
			continue
		fi
		while read -r mod_dir ; do
			cd "${ED}/usr/lib/portage/pym/${mod_dir}" || die
			files=$(echo *.py)
			if [ -z "${files}" ] || [ "${files}" = "*.py" ]; then
				# __pycache__ directories contain no py files
				continue
			fi
			dest_mod_dir=$(get_python_sitedir ${impl})/${mod_dir}
			dodir "${dest_mod_dir}" || die
			relative_path=../../../lib/portage/pym/${mod_dir}
			x=/${mod_dir}
			while [ -n "${x}" ] ; do
				relative_path=../${relative_path}
				x=${x%/*}
			done
			for x in ${files} ; do
				dosym "${relative_path}/${x}" \
					"${dest_mod_dir}/${x}" || die
			done
		done < <(cd "${ED}"/usr/lib/portage/pym || die ; find * -type d ! -path "portage/tests*")
		cd "${S}" || die
		EPYTHON=$(get_python_interpreter ${impl}) \
		python_compileall "$(get_python_sitedir ${impl})"
	done

	# Compile /usr/lib/portage/pym with the active interpreter, since portage
	# internal commands force this directory to the beginning of sys.path.
	python_compileall /usr/lib/portage/pym
}

pkg_preinst() {
	if [[ $ROOT == / ]] ; then
		# Run some minimal tests as a sanity check.
		local test_runner=$(find "${ED}" -name runTests)
		if [[ -n $test_runner && -x $test_runner ]] ; then
			einfo "Running preinst sanity tests..."
			"$test_runner" || die "preinst sanity tests failed"
		fi
	fi

	if use xattr && ! current_python_has_xattr ; then
		ewarn "For optimal performance in xattr handling, install"
		ewarn "dev-python/pyxattr, or install >=dev-lang/python-3.3 and"
		ewarn "enable USE=python3 for $CATEGORY/$PN."
	fi

	# elog dir must exist to avoid logrotate error for bug #415911.
	# This code runs in preinst in order to bypass the mapping of
	# portage:portage to root:root which happens after src_install.
	keepdir /var/log/portage/elog
	# This is allowed to fail if the user/group are invalid for prefix users.
	if chown portage:portage "${ED}"var/log/portage{,/elog} 2>/dev/null ; then
		chmod g+s,ug+rwx "${ED}"var/log/portage{,/elog}
	fi
}
