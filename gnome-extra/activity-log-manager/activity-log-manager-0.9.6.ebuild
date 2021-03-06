# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/activity-log-manager/activity-log-manager-0.9.6.ebuild,v 1.2 2013/07/10 07:02:54 jlec Exp $

EAPI=5

GNOME2_LA_PUNT="yes"
VALA_MIN_API_VERSION="0.10"
WANT_AUTOMAKE=1.13

inherit autotools eutils gnome2 vala versionator

DESCRIPTION="GUI which lets you easily control what gets logged by Zeitgeist"
HOMEPAGE="https://launchpad.net/activity-log-manager/"
SRC_URI="
	http://dev.gentoo.org/~jlec/distfiles/${P}-backport.patch.xz
	http://launchpad.net/history-manager/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.xz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/libgee:0
	dev-libs/glib:2
	gnome-extra/zeitgeist
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/pango"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_prepare() {
	DOCS="README NEWS INSTALL ChangeLog AUTHORS"
	epatch \
		"${FILESDIR}"/${PN}-0.9.0.1-gold.patch \
		"${WORKDIR}"/${P}-backport.patch \
		"${FILESDIR}"/${P}-whoopsie.patch
	sed \
		-e "/^almdocdir/s:=.*$:= \${prefix}/share/doc/${PF}:g" \
		-i Makefile.am || die
	vala_src_prepare
	eautoreconf
	gnome2_src_prepare
}
