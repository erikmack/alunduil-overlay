# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/oslotest/oslotest-1.6.0.ebuild,v 1.1 2015/04/25 21:10:12 alunduil Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 python3_4 )

inherit distutils-r1

DESCRIPTION="Oslo test framework"
HOMEPAGE="http://launchpad.net/oslo"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~x86-linux"
IUSE="doc test"

CDEPEND="
	>=dev-python/pbr-0.6[${PYTHON_USEDEP}]
	!~dev-python/pbr-0.7[${PYTHON_USEDEP}]
	<dev-python/pbr-1.0[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${CDEPEND}
	test? (
		<dev-python/hacking-0.11[${PYTHON_USEDEP}]
		>=dev-python/hacking-0.10.0[${PYTHON_USEDEP}]
	)
	doc? (
		>=dev-python/oslo-sphinx-2.5.0[${PYTHON_USEDEP}]
		>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
		!~dev-python/sphinx-1.2.0[${PYTHON_USEDEP}]
		<dev-python/sphinx-1.3[${PYTHON_USEDEP}]
	)
"
RDEPEND="
	>=dev-python/fixtures-1.3.1[${PYTHON_USEDEP}]
	>=dev-python/mock-1.1[${PYTHON_USEDEP}]
	>=dev-python/mox3-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/os-client-config-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/subunit-0.0.18[${PYTHON_USEDEP}]
	>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
	>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
	>=dev-python/testtools-1.4.0[${PYTHON_USEDEP}]
"

python_compile_all() {
	use doc && esetup.py build_sphinx
}

python_test() {
	rm -rf .testrepository || die "couldn't remove '.testrepository' under ${EPYTHON}"

	testr init || die "testr init failed under ${EPYTHON}"
	testr run || die "testr run failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/html/. )
	use doc && doman doc/build/man/oslotest.1

	distutils-r1_python_install_all
}

pkg_postinst() {
	elog "man page installation requires USE=doc"
}
