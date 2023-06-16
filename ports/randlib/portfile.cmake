vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO BlueQuartzSoftware/RandLib
  REF v1.0.0
  SHA512 c5e75f6377b09b046891220a9ba5f89461b6a44c949ff1f8c32aad0b8d6cedf1478aa0acb3d1651cdfc6b3d76a0feb4396bad62ee2eab46d669744250c812a93
  HEAD_REF master
)

vcpkg_configure_cmake(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    -DBUILD_TESTING=OFF
    -DRANDLIB_INSTALL_CMAKE_PREFIX=share/${PORT}
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
