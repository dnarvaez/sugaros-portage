# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdbackup/dvdbackup-0.4.2.ebuild,v 1.1 2013/07/27 23:17:19 sping Exp $

EAPI=4

DESCRIPTION="Backup content from DVD to hard disk"
HOMEPAGE="http://dvdbackup.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE="nls"

RDEPEND=">=media-libs/libdvdread-4.2.0_pre
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS ChangeLog NEWS README )

src_configure() {
	econf \
		$(use_enable nls) \
		--disable-rpath \
		--docdir=/usr/share/doc/${PF}
}
