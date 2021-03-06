# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sepolgen/sepolgen-1.1.9-r3.ebuild,v 1.1 2013/07/19 20:16:05 swift Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit python-r1 eutils

DESCRIPTION="SELinux policy generation library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20130423/${P}.tar.gz
	http://dev.gentoo.org/~swift/patches/sepolgen/patchbundle-${P}-r2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-libs/libselinux-2.0[python]
		app-admin/setools[python]
		${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

src_prepare() {
	EPATCH_MULTI_MSG="Applying sepolgen patches ... " \
	EPATCH_SUFFIX="patch" \
	EPATCH_SOURCE="${WORKDIR}/gentoo-patches" \
	EPATCH_FORCE="yes" \
	epatch

	epatch_user

	python_copy_sources
}

src_compile() {
	:
}

src_test() {
	if has_version sec-policy/selinux-base-policy; then
		invoke_sepolgen_test() {
			emake test
		}
		python_foreach_impl invoke_sepolgen_test
	else
		ewarn "Sepolgen requires sec-policy/selinux-base-policy to run tests."
	fi
}

src_install() {
	installation() {
		emake DESTDIR="${D}" PYTHONLIBDIR="$(python_get_sitedir)" install
	}
	python_foreach_impl installation

	# Create sepolgen.conf with different devel location definition
	local selinuxtype=$(awk -F'=' '/^SELINUXTYPE/ {print $2}' /etc/selinux/config);
	mkdir -p "${D}"/etc/selinux || die "Failed to create selinux directory";
	echo "SELINUX_DEVEL_PATH=/usr/share/selinux/${selinuxtype}/include" > "${D}"/etc/selinux/sepolgen.conf;
}
