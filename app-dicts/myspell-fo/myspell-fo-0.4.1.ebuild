# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-fo/myspell-fo-0.4.1.ebuild,v 1.1 2012/06/13 17:35:18 scarabeus Exp $

EAPI=4

MYSPELL_DICT=(
	"${P}/fo_FO.aff"
	"${P}/fo_FO.dic"
)

MYSPELL_HYPH=(
	"hyph_fo_FO.dic"
)

MYSPELL_THES=(
)

inherit myspell-r2

DESCRIPTION="Faroese dictionaries for myspell/hunspell"
HOMEPAGE="http://fo.speling.org/"
SRC_URI="
	http://fo.speling.org/filer/${P}.tar.bz2
	http://fo.speling.org/filer/hyph_fo_FO-20040420a.zip
"

LICENSE="GPL-2 LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""
