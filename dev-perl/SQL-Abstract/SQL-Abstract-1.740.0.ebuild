# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Abstract/SQL-Abstract-1.740.0.ebuild,v 1.1 2013/08/25 10:56:39 patrick Exp $

EAPI=4

MODULE_AUTHOR=RIBASUSHI
MODULE_VERSION=1.74
inherit perl-module

DESCRIPTION="Generate SQL from Perl data structures"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-aix ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	>=dev-perl/Class-Accessor-Grouped-0.100.50
	>=dev-perl/Getopt-Long-Descriptive-0.91.0
	dev-perl/Hash-Merge
"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Deep-0.106
		dev-perl/Test-Exception
		dev-perl/Test-Pod
		>=virtual/perl-Test-Simple-0.92
		dev-perl/Test-Warn
		>=dev-perl/Clone-0.31
	)
"
#		dev-perl/Test-Pod-Coverage

SRC_TEST="do"
