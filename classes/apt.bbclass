APT_DIR = "${WORKDIR}/apt"
APT_SOURCES_LIST = "${APT_DIR}/sources.list"

APT_REPO ?= "${DEBIAN_REPO}"
APT_CODENAME ?= "${DEBIAN_CODENAME}"

APT_OPTS ?= "-o Apt::Architecture=${DEB_HOST_ARCH} \
             -o Dir::Etc::sourcelist=${APT_SOURCES_LIST} \
             -o Dir::State=${APT_DIR}/state \
             -o Dir::State::Status=${APT_DIR}/state/status \
             -o Dir::Cache=${APT_DIR}/cache \
             -o Debug::NoLocking=true \
            "

apt_update() {
	rm -rf ${APT_DIR}

	bbnote "Creating apt working directory"
	mkdir -p ${APT_DIR}
	mkdir -p ${APT_DIR}/state
	touch ${APT_DIR}/state/status
	mkdir -p ${APT_DIR}/cache

	bbnote "Generating sources.list"
	echo "deb ${APT_REPO} ${APT_CODENAME} main" >> ${APT_SOURCES_LIST}

	bbnote "Running apt-get update"
	apt-get ${APT_OPTS} update
}
