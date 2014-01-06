#!/bin/bash
#
# Change file permissions of overlay directory. Algorithm:
#  1) If same file exists in your /, immitate it
#  2) Else use Linux defaults

if [ $# -ne 2 ]; then
    echo "usage ${0} overlay_dir target_dir"
    exit 1
fi

overlay_dir="${1}/"
target_dir="${2}/"
compare_dir="/"
default_own="root:root"
default_dir_mod="755"
default_file_mod="644"

RED='\x1b[31;01m'
YELLOW='\x1b[33;01m'
NO_COLOR='\x1b[0m'

change_own() {
    overlay_own=$(stat --format=%U:%G "${1}")

    if [ -e ${2} ]; then
        compare_own=$(stat --format=%U:%G "${2}")
    else
        compare_own=${default_own}
        echo -e "${YELLOW}WARNING:${NO_COLOR} Wild guess; using default own '${compare_own} for ${1}"
    fi

    if [ ${overlay_own} != ${compare_own} ]; then
        echo -e "INFO: aligning chown of ${1}"
        chown ${compare_own} ${1}
    fi
}

change_mod() {
    overlay_mod=$(stat --format=%a "${1}")

    if [ -e ${2} ]; then
        compare_mod=$(stat --format=%a "${2}")
    else
        if [ -d ${1} ]; then
            compare_mod=${default_dir_mod}
        elif [ -f ${1} ]; then
            compare_mod=${default_file_mod}
        else
            echo -e "${RED}ERROR:${NO_COLOR} ${1} is neither a file nor a directory"
            compare_mod=${default_file_mod}
        fi
        echo -e "${YELLOW}WARNING:${NO_COLOR} Wild guess; using default mod '${compare_mod}' for ${1}"
    fi

    if [ ${overlay_mod} != ${compare_mod} ]; then
        echo -e "INFO: aligning chmod of ${1}"
        chmod ${compare_mod} ${1}
    fi
}

for file in $(cd "${overlay_dir}" && find *); do
    change_own "${target_dir}${file}" "${compare_dir}${file}"
    change_mod "${target_dir}${file}" "${compare_dir}${file}"
done
