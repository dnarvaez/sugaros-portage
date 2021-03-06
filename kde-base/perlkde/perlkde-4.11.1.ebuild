# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/perlkde/perlkde-4.11.1.ebuild,v 1.1 2013/09/03 19:04:51 creffett Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE Perl bindings"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="akonadi attica debug kate okular test"

RDEPEND="
	>=dev-lang/perl-5.10.1
	>=dev-libs/soprano-2.9.0
	$(add_kdebase_dep perlqt)
	$(add_kdebase_dep smokekde 'attica?,kate?,okular?')
"
DEPEND="${RDEPEND}
	test? ( dev-perl/List-MoreUtils )
"

PATCHES=( "${FILESDIR}/${PN}-4.7.2-vendor.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_with attica LibAttica)
		$(cmake-utils_use_disable kate)
		$(cmake-utils_use_with okular)
	)
	kde4-base_src_configure
}
