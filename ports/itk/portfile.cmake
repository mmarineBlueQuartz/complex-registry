vcpkg_buildpath_length_warning(37)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO InsightSoftwareConsortium/ITK
  REF v5.2.1
  SHA512 cccb64766acaebe49ee2dd8b82b7b5aaa6a35e97f2cc7738ad7f3cd65006b73b880ac59341cd640abd64c2ac665633f01504760071f5492e40aa97e7ba6db2a9
  HEAD_REF master
)

vcpkg_configure_cmake(
  SOURCE_PATH "${SOURCE_PATH}"
  DISABLE_PARALLEL_CONFIGURE
  OPTIONS
    -DBUILD_TESTING:BOOL=OFF
    -DBUILD_EXAMPLES:BOOL=OFF
    -DBUILD_PKGCONFIG_FILES:BOOL=OFF
    -DITK_DOXYGEN_HTML:BOOL=OFF
    -DDO_NOT_INSTALL_ITK_TEST_DRIVER:BOOL=ON
    -DITK_SKIP_PATH_LENGTH_CHECKS:BOOL=ON
    -DITK_INSTALL_DATA_DIR:PATH=share/itk/data
    -DITK_INSTALL_DOC_DIR:PATH=share/itk/doc
    -DITK_INSTALL_PACKAGE_DIR:PATH=share/itk

    -DBUILD_DOCUMENTATION:BOOL=OFF
    -DBUILD_EXAMPLES:BOOL=OFF
    -DBUILD_TESTING:BOOL=OFF
    -DITK_USE_SYSTEM_EIGEN:BOOL=ON
    -DITK_USE_SYSTEM_HDF5:BOOL=ON
    -DITKV4_COMPATIBILITY:BOOL=ON
    -DITK_LEGACY_REMOVE:BOOL=OFF
    -DITK_FUTURE_LEGACY_REMOVE:BOOL=ON
    -DITK_LEGACY_SILENT:BOOL=OFF
    -DITK_BUILD_DEFAULT_MODULES:BOOL=OFF
    -DITKGroup_Core:BOOL=ON
    -DITKGroup_Filtering:BOOL=ON
    -DITKGroup_Registration:BOOL=ON
    -DITKGroup_Segmentation:BOOL=ON
    -DModule_ITKIOMRC:BOOL=ON
    -DModule_ITKReview:BOOL=ON
    -DModule_ITKMetricsv4:BOOL=ON
    -DModule_ITKOptimizersv4:BOOL=ON
    -DModule_ITKRegistrationMethodsv4:BOOL=ON
    -DModule_ITKIOTransformBase:BOOL=ON
    -DModule_ITKConvolution:BOOL=ON
    -DModule_ITKDenoising:BOOL=ON
    -DModule_ITKImageNoise:BOOL=ON
    -DModule_Montage:BOOL=ON
    -DModule_Montage_GIT_TAG:STRING=v0.7.3
    -DModule_TotalVariation:BOOL=ON
    -DModule_TotalVariation_GIT_TAG:STRING=v0.2.1
  OPTIONS_DEBUG
    -DCMAKE_DEBUG_POSTFIX:STRING=_d
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

vcpkg_fixup_cmake_targets()

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/${PORT}/Modules/TotalVariation.cmake" "set(Eigen3_DIR \"\${_IMPORT_PREFIX}/share/eigen3\")" "set(Eigen3_DIR \"\${ITK_INSTALL_PREFIX}/share/eigen3\")")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/${PORT}/Modules/TotalVariation.cmake" "set(proxTV_DIR \"${CURRENT_PACKAGES_DIR}/share/itk/Modules\")" "set(proxTV_DIR \"\${ITK_INSTALL_PREFIX}/share/itk/Modules\")")

set(IMPORT_PREFIX_LINE "get_filename_component(_IMPORT_PREFIX \"\${_IMPORT_PREFIX}\" PATH)")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/${PORT}/Modules/proxTVTargets.cmake" "get_filename_component(_IMPORT_PREFIX \"\${CMAKE_CURRENT_LIST_FILE}\" PATH)\n${IMPORT_PREFIX_LINE}\n${IMPORT_PREFIX_LINE}" "get_filename_component(_IMPORT_PREFIX \"\${CMAKE_CURRENT_LIST_FILE}\" PATH)\n${IMPORT_PREFIX_LINE}\n${IMPORT_PREFIX_LINE}\n${IMPORT_PREFIX_LINE}")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
