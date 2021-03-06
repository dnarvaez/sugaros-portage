# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyplusplus/pyplusplus-1.0.0.ebuild,v 1.1 2013/08/30 10:49:59 heroxbd Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Object-oriented framework for creating a code generator for Boost.Python library"
HOMEPAGE="http://www.language-binding.net/"
SRC_URI="mirror://sourceforge/pygccxml/${P}.zip"

LICENSE="freedist Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="doc? ( >=dev-python/epydoc-3 )
	app-arch/unzip"
RDEPEND="=dev-python/pygccxml-1.0.0"

S=${WORKDIR}/Py++-${PV}

python_compile_all() {
	if use doc; then
		python_export_best
		"$(PYTHON)" setup.py doc
	fi
}

python_test() {
	"$(PYTHON)" unittests/test_all.py
}

python_install_all() {
	use doc && local HTML_DOCS=(  docs/documentation/apidocs/* )

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	distutils-r1_python_install_all
}
