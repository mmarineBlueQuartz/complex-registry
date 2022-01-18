if(NOT VCPKG_TARGET_IS_LINUX AND NOT VCPKG_TARGET_IS_OSX)
  vcpkg_fail_port_install(ON_ARCH "arm" "arm64" ON_TARGET "uwp")
endif()

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO oneapi-src/oneTBB
  REF v2021.4.0
  SHA512 96da2bc351fd64dfa854f8e6cabc1c4e53af3d55760e99d6f83ad53779c727af333d13d6be0828ed70371cf796498d2063e9dd0e4b2f6451623bb5d28ccbf20b
  HEAD_REF master
)

vcpkg_configure_cmake(
  SOURCE_PATH ${SOURCE_PATH}
  PREFER_NINJA
  OPTIONS
    -DTBB_TEST=OFF
)

vcpkg_install_cmake()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/TBB)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/tbb)

file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/tbb RENAME copyright)

file(RENAME "${CURRENT_PACKAGES_DIR}/share/doc/TBB/README.md" "${CURRENT_PACKAGES_DIR}/share/tbb/README.md")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/pkgconfig")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/doc")
