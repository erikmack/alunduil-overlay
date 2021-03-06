# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 python3_4 )

inherit distutils-r1

DESCRIPTION="OpenStack Client Configuation Library"
HOMEPAGE="http://www.openstack.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

CDEPEND="
	>=dev-python/pbr-0.11[${PYTHON_USEDEP}]
	<dev-python/pbr-2.0[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${CDEPEND}
	test? (
		dev-python/extras[${PYTHON_USEDEP}]
		>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
		>=dev-python/hacking-0.9.2[${PYTHON_USEDEP}]
		<dev-python/hacking-0.10[${PYTHON_USEDEP}]
		>=dev-python/oslotest-1.5.1[${PYTHON_USEDEP}]
		<dev-python/oslotest-1.6.0[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/subunit-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-0.9.36[${PYTHON_USEDEP}]
		!~dev-python/testtools-1.2.0[${PYTHON_USEDEP}]
	)
	doc? (
		>=dev-python/oslo-sphinx-2.5.0[${PYTHON_USEDEP}]
		<dev-python/oslo-sphinx-2.6.0[${PYTHON_USEDEP}]
		>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
		!~dev-python/sphinx-1.2.0[${PYTHON_USEDEP}]
		<dev-python/sphinx-1.3[${PYTHON_USEDEP}]
	)
"
RDEPEND="
	${CDEPEND}
	>=dev-python/appdirs-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.1.0[${PYTHON_USEDEP}]
"

python_compile_all() {
	use doc && esetup.py build_sphinx
}

python_test() {
	distutils_install_for_testing

	rm -rf .testrepository || die "couldn't remove '.testrepository' under ${EPTYHON}"

	testr init || die "testr init failed under ${EPYTHON}"
	testr run || die "testr run failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/html/. )

	distutils-r1_python_install_all
}
