# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/glade/glade-0.12.1.ebuild,v 1.5 2013/04/03 05:26:31 gienah Exp $

# ebuild generated by hackport 0.2.17.9999

EAPI=4

#nocabaldep is for the fancy cabal-detection feature at build-time
CABAL_FEATURES="lib profile haddock hscolour hoogle nocabaldep"
inherit haskell-cabal

DESCRIPTION="Binding to the glade library."
HOMEPAGE="http://projects.haskell.org/gtk2hs/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="=dev-haskell/glib-0.12*:2[profile?]
		=dev-haskell/gtk-0.12*:2[profile?]
		>=dev-lang/ghc-6.10.1
		gnome-base/libglade:2.0"
DEPEND="${RDEPEND}
		dev-haskell/gtk2hs-buildtools:2"