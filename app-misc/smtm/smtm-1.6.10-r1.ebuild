# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/smtm/smtm-1.6.10-r1.ebuild,v 1.1 2013/08/28 13:37:22 idella4 Exp $

EAPI=5

inherit perl-module

DESCRIPTION="Stock ticker, profit/loss calculator and chart tool"
HOMEPAGE="http://eddelbuettel.com/dirk/code/smtm.html"
SRC_URI="http://eddelbuettel.com/dirk/code/smtm/smtm_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
# This warrants USE examples
IUSE=""

DEPEND="dev-perl/perl-tk
	dev-perl/DateManip
	dev-perl/HTML-Parser
	dev-perl/Finance-YahooQuote
	dev-perl/libwww-perl"

SRC_TEST="do parallel"

src_install() {
	perl-module_src_install
	# install examples into own folder for now
	docompress -x usr/share/doc/${PF}/examples
	insinto usr/share/doc/${PF}/examples
	doins examples/*
}
