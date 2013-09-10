# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/formencode/formencode-1.2.6-r1.ebuild,v 1.2 2013/09/05 18:46:15 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

MY_PN="FormEncode"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="HTML form validation, generation, and conversion package"
HOMEPAGE="http://formencode.org/ http://pypi.python.org/pypi/FormEncode"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
	# https://bugs.gentoo.org/show_bug.cgi?id=473154
#	test? ( dev-python/nose[${PYTHON_USEDEP}]
#		dev-python/pycountry[${PYTHON_USEDEP}]
#		dev-python/pydns[${PYTHON_USEDEP}] )"
RDEPEND=""
RESTRICT="test"
DOCS=( docs/{index.txt,modules.txt} )

S="${WORKDIR}/${MY_P}"

python_test() {
	esetup.py test
}