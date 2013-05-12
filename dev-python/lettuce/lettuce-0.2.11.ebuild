# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_2 )

inherit distutils-r1

DESCRIPTION="BDD tool for python, 100% inspired by cucumber; BDD with elegance
and joy"
HOMEPAGE="http://lettuce.it/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	${DEPEND}
	dev-python/sure
	dev-python/fuzzywuzzy
	dev-python/ipdb
	"
