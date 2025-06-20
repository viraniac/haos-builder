#!/bin/bash
# shellcheck disable=SC2155

function hassos_pre_image() {
    local BOOT_DATA="$(path_boot_dir)"

    cp "${BINARIES_DIR}/boot.scr" "${BOOT_DATA}/boot.scr"
    cp "${BINARIES_DIR}/kvim1s.dtb" "${BOOT_DATA}/"

    cp "${BOARD_DIR}/boot-env.txt" "${BOOT_DATA}/haos-config.txt"
    cp "${BOARD_DIR}/cmdline.txt" "${BOOT_DATA}/cmdline.txt"
}

function convert_disk_image_xze() {
    local hdd_ext=${1:-img}
    local hdd_img
    local board_name="${BOARD_NAME##* }"
    hdd_img="$(hassos_image_name "${hdd_ext}")"

    rm -f "${hdd_img}.xz"
    "${BR2_EXTERNAL_KHADAS_PATH}"/scripts/xze "${hdd_img}" \
        --meta \
        LABEL="${HASSOS_NAME}" \
        BOARD="${board_name}" \
        BUILDER="khadas_haos" \
        LINK="https://dl.khadas.com/products/oowow/images/${board_name,,}" \
        DESC="${HASSOS_NAME} - v${VERSION_MAJOR}.${VERSION_MINOR}${VERSION_SUFFIX:+-}${VERSION_SUFFIX}" \
        > "${hdd_img}.xz"
}

function hassos_post_image() {
    convert_disk_image_xze
}

