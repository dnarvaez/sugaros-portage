# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-voamrwbenc/gst-plugins-voamrwbenc-1.0.10.ebuild,v 1.1 2013/09/01 17:51:31 eva Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for encoding AMR-WB"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/vo-amrwbenc-0.1"
DEPEND="${RDEPEND}"