# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-savage/xf86-video-savage-2.3.6.ebuild,v 1.8 2012/12/30 14:50:36 ago Exp $

EAPI=4
XORG_DRI=dri
inherit xorg-2

DESCRIPTION="S3 Savage video driver"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~amd64-fbsd ~x86-fbsd"

IUSE="dri"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	>=x11-proto/xextproto-7.0.99.1"

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable dri)
	)
	xorg-2_pkg_setup
}

pkg_postinst() {
	if has_version ">=x11-base/xorg-server-1.12.99"; then
		elog "Your X server no longer supports XAA, so xf86-video-savage will fall back"
		elog "to shadowFB. Enable EXA in your X.org configuration to still have some 2D"
		elog "acceleration. See \"man 4 savage\" for details."
	fi
}
