FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://openvario-common.dts \
    file://${KERNEL_DEVICETREE_SOURCE} \
    file://lima-debug/0001-drm-lima-save-process-info-for-debug-usage.patch \
    file://lima-debug/0002-drm-lima-add-max_error_tasks-module-parameter.patch \
    file://lima-debug/0003-drm-lima-save-task-info-dump-when-task-fail.patch \
    file://lima-debug/0004-drm-lima-add-error-sysfs-to-export-error-task-dump.patch \
    file://lima-debug/0005-drm-lima-add-trace-point-for-tasks.patch \
    file://lima-debug/0006-drm-lima-add-LIMA_BO_FLAG_FORCE_VA.patch \
    "

PR = "r0"

# Create /etc/modprobe.d/lima.conf file
# Make sure lima loads after drm modules, so that /dev/dri/card0 would be
# claimed by sun4-drm modules (display driver) and card1 would belong to
# lima (gpu).
KERNEL_MODULE_PROBECONF = "lima"
module_conf_lima = "softdep lima pre: sun4i-drm sun4i-drm-hdmi sun4i-frontend sun4i-tcon sun4i-backend"

do_configure_prepend() {
    cp ${WORKDIR}/openvario-common.dts ${S}/arch/arm/boot/dts/openvario-common.dts
    cp ${WORKDIR}/${KERNEL_DEVICETREE_SOURCE} ${S}/arch/arm/boot/dts/openvario.dts
}
