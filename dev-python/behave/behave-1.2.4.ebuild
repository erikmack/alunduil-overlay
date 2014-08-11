# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 pypy )

inherit distutils-r1

DESCRIPTION="behaviour-driven development, Python style"
HOMEPAGE="http://github.com/behave/behave"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	doc? (
		>=dev-python/sphinx-1.2.2[${PYTHON_USEDEP}]
		>=dev-python/sphinxcontrib-cheeseshop-0.2[${PYTHON_USEDEP}]
	)
	test? (
		>=dev-python/mock-1.0[${PYTHON_USEDEP}]
		>=dev-python/nose-1.1[${PYTHON_USEDEP}]
		>=dev-python/PyHamcrest-1.8[${PYTHON_USEDEP}]
	)
"
RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/parse-1.6.3[${PYTHON_USEDEP}]
	>=dev-python/parse-type-0.3.4[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	nosetests || die 'nosetests'
	behave -f progress --junit --tags=~@xfail features/ || die 'behave features'
	behave -f progress --junit --tags=~@xfail tools/test-features/ || die 'behave test-festures'
	behave -f progress --junit --tags=~@xfail issue.features/ || die 'behave issue.features'
}

python_install_all() {
	use doc && local HTML_DOCS=( build/docs/html/. )

	distutils-r1_python_install_all
}
