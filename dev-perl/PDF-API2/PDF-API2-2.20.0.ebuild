# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDF-API2/PDF-API2-2.20.0.ebuild,v 1.1 2013/01/21 17:21:41 tove Exp $

EAPI=5

MODULE_AUTHOR=SSIMMS
MODULE_VERSION=2.020
inherit perl-module

DESCRIPTION="Facilitates the creation and modification of PDF files"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="virtual/perl-IO-Compress
	dev-perl/Font-TTF"
DEPEND="${RDEPEND}"

SRC_TEST="do"
