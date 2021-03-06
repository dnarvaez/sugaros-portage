# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-krigstask/lc-krigstask-9999.ebuild,v 1.1 2013/05/24 15:16:42 pinkbyte Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="The taskbar quark for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
	dev-qt/qtdeclarative:4"
RDEPEND="${DEPEND}
	 ~virtual/leechcraft-quark-sideprovider-${PV}"
