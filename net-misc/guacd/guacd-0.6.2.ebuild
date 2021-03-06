# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/guacd/guacd-0.6.2.ebuild,v 1.2 2012/11/11 01:07:56 mr_bones_ Exp $

EAPI=4

inherit eutils
DESCRIPTION="This is the proxy-daemon used by www-apps/guacamole."

HOMEPAGE="http://guacamole.sourceforge.net/"
SRC_URI="mirror://sourceforge/guacamole/${P}.tar.gz"

LICENSE="AGPL-3"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="net-libs/libguac"
RDEPEND="${DEPEND}"

src_configure() {
	econf
}

src_compile() {
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	doinitd ${S}/init.d/guacd
}
