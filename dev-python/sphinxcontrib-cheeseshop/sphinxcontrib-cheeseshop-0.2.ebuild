# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 pypy)

inherit distutils-r1

DESCRIPTION="Sphinx extension cheeseshop"
HOMEPAGE="http://bitbucket.org/birkenfeld/sphinx-contrib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/sphinx-1.0[${PYTHON_USEDEP}]"

python_prepare_all() {
	ebegin 'patching setup.py'
	sed \
		-e 's:\(long_desc = \)file:\1open:' \
		-i setup.py || die 'sed'
	eend $?

	distutils-r1_python_prepare_all
}