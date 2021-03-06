# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/jdk-with-com-sun/jdk-with-com-sun-20111111-r1.ebuild,v 1.1 2013/06/30 09:09:12 tomwij Exp $

EAPI="5"

inherit java-virtuals-2

DESCRIPTION="Virtual ebuilds that require internal com.sun classes from a JDK"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND="|| (
			dev-java/icedtea-bin:6
			dev-java/icedtea:6
			dev-java/icedtea-bin:7
			dev-java/icedtea:7
			dev-java/oracle-jdk-bin:1.7
			dev-java/diablo-jdk:1.6
			dev-java/apple-jdk-bin:1.6
			dev-java/apple-jdk-bin:1.5
			dev-java/apple-jdk-bin:1.4
		)"

JAVA_VIRTUAL_VM="icedtea-bin-6 icedtea6-bin icedtea-6 icedtea6 icedtea-bin-6 icedtea-bin-7 icedtea-7 oracle-jdk-bin-1.7 diablo-jdk-1.6 apple-jdk-bin-1.6 apple-jdk-bin-1.5 apple-jdk-bin-1.4"
