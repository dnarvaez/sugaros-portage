# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libcryptui/libcryptui-3.8.0.ebuild,v 1.2 2013/04/07 21:57:37 eva Exp $

EAPI="5"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="User interface components for OpenPGP"
HOMEPAGE="http://www.gnome.org/projects/seahorse/index.html"

LICENSE="GPL-2+ LGPL-2.1+ FDL-1.1"
SLOT="0"
IUSE="+introspection libnotify test"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"

# Pull in libnotify-0.7 because it's controlled via an automagic ifdef
COMMON_DEPEND="
	>=dev-libs/glib-2.32:2
	>=x11-libs/gtk+-3:3[introspection?]
	>=dev-libs/dbus-glib-0.72
	>=gnome-base/gnome-keyring-2.91.2
	x11-libs/libICE
	x11-libs/libSM

	>=app-crypt/gpgme-1
	|| (
		=app-crypt/gnupg-2.0*
		=app-crypt/gnupg-1.4* )

	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )
	libnotify? ( >=x11-libs/libnotify-0.7:= )
"
DEPEND="${COMMON_DEPEND}
	>=app-text/scrollkeeper-0.3
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig
"
# Before 3.1.4, libcryptui was part of seahorse
RDEPEND="${COMMON_DEPEND}
	!<app-crypt/seahorse-3.1.4
"

src_prepare() {
	# FIXME: Do not mess with CFLAGS with USE="debug"
	sed -e '/CFLAGS="$CFLAGS -g -O0/d' \
		-e 's/-Werror//' \
		-i configure.ac configure || die "sed failed"

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-static \
		--disable-update-mime-database \
		$(use_enable introspection) \
		$(use_enable libnotify) \
		$(use_enable test tests)
}
