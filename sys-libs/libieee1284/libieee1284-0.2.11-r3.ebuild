# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libieee1284/libieee1284-0.2.11-r3.ebuild,v 1.1 2013/08/10 20:36:53 aballier Exp $

EAPI="4"

PYTHON_DEPEND="python? 2"
inherit python multilib-minimal

DESCRIPTION="Library to query devices using IEEE1284"
HOMEPAGE="http://cyberelk.net/tim/libieee1284/index.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="doc python static-libs"

RDEPEND="abi_x86_32? ( !<=app-emulation/emul-linux-x86-medialibs-20130224-r9
		!app-emulation/emul-linux-x86-medialibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	doc? (
		app-text/docbook-sgml-utils
		>=app-text/docbook-sgml-dtd-4.1
		app-text/docbook-dsssl-stylesheets
		dev-perl/XML-RegExp
	)"

DOCS="AUTHORS NEWS README* TODO doc/interface*"

pkg_setup() {
	use python && python_set_active_version 2
}

multilib_src_configure() {
	local myconf="--without-python"
	multilib_is_native_abi && myconf="$(use_with python)"

	ECONF_SOURCE="${S}" econf \
		--enable-shared \
		$(use_enable static-libs static) \
		${myconf}
}

multilib_src_install_all() {
	find "${D}" -name '*.la' -delete
}