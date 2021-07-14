vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO pybind/pybind11
    REF v2.6.2
    SHA512 1eb346ff6b8f827053265340925e2c8038b1e2a89c352fc09f15ebe86128e7ba1f48c4368b193941f034b30bee7f72a94343e05d4841fdbbd0e4d91ed3d32025
    HEAD_REF master
)

vcpkg_find_acquire_program(PYTHON3)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DPYBIND11_TEST=OFF
        -DPYBIND11_FINDPYTHON=ON
        -DPython3_EXECUTABLE=${PYTHON3}
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH share/cmake/pybind11)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/)

# copy license
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
