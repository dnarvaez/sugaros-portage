# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_auth_pgsql/mod_auth_pgsql-2.0.3-r1.ebuild,v 1.6 2012/10/12 09:47:35 patrick Exp $

inherit apache-module multilib

DESCRIPTION="This module allows user authentication against information stored in a PostgreSQL database."
HOMEPAGE="http://www.giuseppetanzilli.it/mod_auth_pgsql2/"
SRC_URI="http://www.giuseppetanzilli.it/mod_auth_pgsql2/dist/${P}.tar.gz"

LICENSE="freedist"
SLOT="2"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

DEPEND="dev-db/postgresql-base"
RDEPEND="${DEPEND}"

APXS2_ARGS="-a -c -I/usr/include/postgresql -L/usr/$(get_libdir)/postgresql -lpq mod_auth_pgsql.c"

APACHE2_MOD_CONF="80_mod_auth_pgsql"
APACHE2_MOD_DEFINE="AUTH_PGSQL"

DOCFILES="INSTALL README mod_auth_pgsql.html"

need_apache2_2

src_install() {
	apache-module_src_install
	fperms 600 "${APACHE_MODULES_CONFDIR}"/${APACHE2_MOD_CONF}.conf
}