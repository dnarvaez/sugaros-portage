# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/solid-runtime/solid-runtime-4.11.1.ebuild,v 1.1 2013/09/03 19:04:17 creffett Exp $

EAPI=5

KMNAME="kde-runtime"
KMNOMODULE=true
inherit kde4-meta

DESCRIPTION="KDE SC solid runtime modules (autoeject, automounter and others)"
HOMEPAGE="http://solid.kde.org"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

KMEXTRA="
	solid-device-automounter/
	solid-hardware/
	solid-networkstatus/
	solidautoeject/
	soliduiserver/
"
