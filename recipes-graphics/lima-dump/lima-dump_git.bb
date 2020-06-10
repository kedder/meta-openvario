SUMMARY = "Tool for assemble/disassemble/replay task dumps"
HOMEPAGE = "https://gitlab.freedesktop.org/lima/lima_dump"

AUTHOR = "Qiang Yu <yuq825@gmail.com>"
SECTION = "base"
LICENSE = "GPL-3.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/${LICENSE};md5=c79ff39f19dfec6d293b95dea7b07891"
S = "${WORKDIR}/git"

SRC_URI = "git://gitlab.freedesktop.org/lima/lima_dump.git;protocol=https;branch=master \
    file://0001-Fix-compilation-for-OE.patch \
"
DEPENDS = "libdrm"
SRCREV_pn-${PN} = "${AUTOREV}"

inherit base pkgconfig

do_configure() {
    rm -f lima_dump
}

do_compile() {
    cd ${WORKDIR}/git
    make
}

do_install() {
    install -d ${D}/usr/bin
    install -m 0755 ${S}/lima_dump ${D}/usr/bin
}

PACKAGES = "${PN}"
INHIBIT_PACKAGE_DEBUG_SPLIT = '1'
FILES_${PN} = "\
        /usr/bin/lima_dump \
"
