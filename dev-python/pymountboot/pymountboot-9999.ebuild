# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymountboot/pymountboot-9999.ebuild,v 1.5 2013/09/05 18:46:31 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

#if LIVE
EGIT_REPO_URI="http://bitbucket.org/mgorny/${PN}.git"
inherit git-2
#endif

DESCRIPTION="Python extension module to (re)mount /boot"
HOMEPAGE="https://bitbucket.org/mgorny/pymountboot/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-apps/util-linux-2.20"
DEPEND="${RDEPEND}"
#if LIVE

KEYWORDS=
SRC_URI=
#endif