# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools git-2 python bash-completion-r1

DESCRIPTION="Command line load generator (HTTP/HTTPS/Stateless)"
HOMEPAGE="https://github.com/yandex-load/yandex-tank"
EGIT_REPO_URI="git://github.com/yandex-load/yandex-tank.git"
SRC_URI=

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
PYTHON_DEPEND="*"

#perl-core/libnet
DEPEND="
	net-misc/phantom[ssl]
	virtual/perl-Term-ANSIColor
	dev-perl/Net-IP
	dev-perl/config-general
	dev-perl/JSON
	dev-perl/XML-Simple
	dev-perl/TermReadKey
	dev-perl/Term-ReadLine-Perl
	dev-perl/File-Which
	>=dev-lang/python-2.6
	dev-python/simplejson
	dev-python/progressbar

	dev-python/ipaddr
	dev-python/lxml
"
RDEPEND="${DEPEND}"

src_install() {
	insinto "/usr/lib/yandex-tank/"
	doins -r Tank tankcore.py

	exeinto "/usr/lib/yandex-tank/"
	doexe tank.py *.sh

	insinto "/etc/yandex-tank/"
	doins 00-base.ini

	newbashcomp yandex-tank.completion yandex-tank.completion

	dosym /usr/lib/yandex-tank/tank.py /usr/bin/yandex-tank
	dosym /usr/lib/yandex-tank/tank.py /usr/bin/lunapark
	dosym /usr/lib/yandex-tank/ab.sh /usr/bin/yandex-tank-ab
	dosym /usr/lib/yandex-tank/jmeter.sh /usr/bin/yandex-tank-jmeter

	keepdir "/etc/yandex-tank/"
}
