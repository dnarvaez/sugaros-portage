# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/qxmpp/qxmpp-0.7.6.ebuild,v 1.1 2013/03/11 10:14:05 pinkbyte Exp $

EAPI=5

inherit qt4-r2 multilib

DESCRIPTION="A cross-platform C++ XMPP client library based on the Qt framework."
HOMEPAGE="http://code.google.com/p/qxmpp/"
SRC_URI="http://qxmpp.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="debug doc test"

RDEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4
	media-libs/speex"
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:4 )"

src_prepare(){
	if ! use doc; then
		sed -i \
			-e '/SUBDIRS/s/doc//' \
			-e '/INSTALLS/d' \
			qxmpp.pro || die "sed for removing docs failed"
	fi
	if ! use test; then
		sed -i -e '/SUBDIRS/s/tests//' \
			qxmpp.pro || die "sed for removing tests failed"
	fi
	qt4-r2_src_prepare
}

src_configure(){
	eqmake4 "${S}"/qxmpp.pro "PREFIX=${EPREFIX}/usr" "LIBDIR=$(get_libdir)"
}

src_install() {
	qt4-r2_src_install
	if use doc; then
		# Use proper path for documentation
		mv "${ED}"/usr/share/doc/${PN} "${ED}"/usr/share/doc/${PF} || die "doc mv failed"
	fi
}
