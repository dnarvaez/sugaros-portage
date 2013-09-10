# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/openglraw/openglraw-1.2.0.0.ebuild,v 1.2 2012/09/12 15:47:54 qnikst Exp $

EAPI=4

# ebuild generated by hackport 0.2.18.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="OpenGLRaw"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A raw binding for the OpenGL graphics system"
HOMEPAGE="http://www.haskell.org/haskellwiki/Opengl"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.2
		virtual/opengl"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

S="${WORKDIR}/${MY_P}"