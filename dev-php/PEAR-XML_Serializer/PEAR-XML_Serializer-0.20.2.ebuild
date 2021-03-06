# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_Serializer/PEAR-XML_Serializer-0.20.2.ebuild,v 1.6 2012/02/09 01:25:37 jer Exp $

EAPI="2"
inherit php-pear-r1

DESCRIPTION="Swiss-army knife for reading and writing XML files"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/php[xml]"
RDEPEND="${DEPEND}
	>=dev-php/PEAR-XML_Parser-1.2.7
	>=dev-php/PEAR-XML_Util-1.1.1-r1
	"
