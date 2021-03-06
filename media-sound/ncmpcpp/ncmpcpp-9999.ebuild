# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ncmpcpp/ncmpcpp-9999.ebuild,v 1.1 2013/08/04 16:08:40 jer Exp $

EAPI=5

inherit autotools bash-completion-r1 eutils git-2

DESCRIPTION="NCurses Music Player Client (Plus Plus)"
HOMEPAGE="http://ncmpcpp.rybczak.net/"
EGIT_REPO_URI="git://repo.or.cz/ncmpcpp.git"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS=""
IUSE="bash-completion clock curl outputs taglib unicode visualizer"

RDEPEND="
	>=dev-libs/boost-1.50[nls]
	sys-libs/ncurses[unicode?]
	>=media-libs/libmpdclient-2.1
	curl? ( net-misc/curl )
	visualizer? ( sci-libs/fftw:3.0 )
	taglib? ( media-libs/taglib )
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	sed -i -e '/^docdir/d' {,doc/}Makefile.am || die
	sed -i -e 's|COPYING||g' Makefile.am || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable clock) \
		$(use_enable outputs) \
		$(use_enable unicode) \
		$(use_enable visualizer) \
		$(use_with curl) \
		$(use_with taglib) \
		$(use_with visualizer fftw) \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	default
	use bash-completion && newbashcomp doc/${PN}-completion.bash ${PN}
}

pkg_postinst() {
	echo
	elog "Example configuration files have been installed at"
	elog "${ROOT}usr/share/doc/${PF}"
	elog "${P} uses ~/.ncmpcpp/config and ~/.ncmpcpp/keys"
	elog "as user configuration files."
	echo
	if use visualizer; then
	elog "If you want to use the visualizer, you need mpd with fifo enabled."
	echo
	fi
}
