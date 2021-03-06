# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/irman-python/irman-python-0.1-r1.ebuild,v 1.2 2013/09/05 18:47:03 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A minimal set of Python bindings for libirman."
HOMEPAGE="http://bluweb.com/chouser/proj/irman-python/"
SRC_URI="http://bluweb.com/chouser/proj/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libirman"
RDEPEND="${DEPEND}"
DOCS=( README test_name.py )
