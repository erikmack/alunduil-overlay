# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/docker-compose/docker-compose-1.1.0_rc2.ebuild,v 1.1 2015/01/31 16:49:42 alunduil Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit bash-completion-r1 distutils-r1 vcs-snapshot

MY_PV="${PV//_/}"

DESCRIPTION="Multi-container orchestration for Docker"
HOMEPAGE="https://www.docker.com/"
SRC_URI="https://github.com/docker/compose/archive/${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

CDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/dockerpty-0.3.2[${PYTHON_USEDEP}]
	<dev-python/dockerpty-0.4[${PYTHON_USEDEP}]
	>=dev-python/docker-py-1.0.0[${PYTHON_USEDEP}]
	<dev-python/docker-py-1.2[${PYTHON_USEDEP}]
	>=dev-python/docopt-0.6.1[${PYTHON_USEDEP}]
	<dev-python/docopt-0.7[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	<dev-python/pyyaml-4[${PYTHON_USEDEP}]
	>=dev-python/requests-2.2.1[${PYTHON_USEDEP}]
	<dev-python/requests-2.6[${PYTHON_USEDEP}]
	>=dev-python/six-1.3.0[${PYTHON_USEDEP}]
	<dev-python/six-2[${PYTHON_USEDEP}]
	>=dev-python/texttable-0.8.1[${PYTHON_USEDEP}]
	<dev-python/texttable-0.9[${PYTHON_USEDEP}]
	>=dev-python/websocket-client-0.11.0[${PYTHON_USEDEP}]
	<dev-python/websocket-client-1.0[${PYTHON_USEDEP}]
"
DEPEND="
	doc? ( dev-python/mkdocs[${PYTHON_USEDEP}] )
	test? (
		${CDEPEND}
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)
"
RDEPEND="${CDEPEND}"

python_compile_all() {
	use doc && mkdocs build || die "docs failed to build"
}

python_test() {
	nosetests tests/unit || die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( site/. )

	newbashcomp contrib/completion/bash/docker-compose ${PN}

	distutils-r1_python_install_all
}