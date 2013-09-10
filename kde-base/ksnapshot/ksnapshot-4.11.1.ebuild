# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksnapshot/ksnapshot-4.11.1.ebuild,v 1.1 2013/09/03 19:04:13 creffett Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE Screenshot Utility"
HOMEPAGE="http://www.kde.org/applications/graphics/ksnapshot/"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug kipi"

DEPEND="
	x11-libs/libXfixes
	!aqua? (
		x11-libs/libX11
		x11-libs/libXext
	)
	kipi? ( $(add_kdebase_dep libkipi) )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with kipi)
	)

	kde4-base_src_configure
}