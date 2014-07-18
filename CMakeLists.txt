cmake_minimum_required(VERSION 2.8)

project(Scanalyze)

include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)
if(COMPILER_SUPPORTS_CXX11)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
elseif(COMPILER_SUPPORTS_CXX0X)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
else()
    message(FATAL_ERROR "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive -DUSE_INTERP_RESULT")

find_package(TCL REQUIRED)
find_package(OpenGL REQUIRED)
find_package(X11 REQUIRED)
find_package(ZLIB REQUIRED)

if(NOT ${X11_Xmu_FOUND})
    message(FATAL_ERROR "X11 Xmu libs not found")
endif()

set(SOURCES
    accpersp.c
    cmdassert.c
    cyfile.c
    jitter.c
    strings.c
    togl.c

    plvMain.cc
    plvCmds.cc
    plvDraw.cc
    Mesh.cc
    plvScene.cc
    plvGlobals.cc
    RangeGrid.cc
    plvInit.cc
    Image.cc
    plvImageCmds.cc
    plvDrawCmds.cc
    plvViewerCmds.cc
    plvPlyCmds.cc
    plvClipBoxCmds.cc
    plvMeshCmds.cc
    plvCybCmds.cc
    plvMMCmds.cc
    Trackball.cc
    KDindtree.cc
    plyfile.cc
    ToglHash.cc
    sczRegCmds.cc
    absorient.cc
    plvAnalyze.cc
    ColorUtils.cc
    GlobalReg.cc
    DisplayMesh.cc
    VertexFilter.cc
    ResolutionCtrl.cc
    RigidScan.cc
    GenericScan.cc
    CyberScan.cc
    CyraScan.cc
    MMScan.cc
    TriMeshUtils.cc
    VolCarve.cc
    SyntheticScan.cc
    Progress.cc
    MCEdgeTable.cc
    fitplane.cc
    ToglCache.cc
    plycrunch.cc
    CyraSubsample.cc
    TriangleCube.cc
    ScanFactory.cc
    GroupScan.cc
    CyraResLevel.cc	KDtritree.cc
    CyberXform.cc
    CyberCalib.cc
    CyberCmds.cc
    TbObj.cc
    GroupUI.cc
    BailDetector.cc
    MeshTransport.cc
    SDfile.cc
    TextureObj.cc
    RefCount.cc
    cameraparams.cc
    ProxyScan.cc
    WorkingVolume.cc
    ToglText.cc
    Projector.cc
    OrganizingScan.cc
    TclCmdUtils.cc
)

include_directories(
    ${TCL_INCLUDE_PATH}
    "${TCL_INCLUDE_PATH}/tk-private/generic"
    ${TK_INCLUDE_PATH}
    ${OPENGL_INCLUDE_DIR}
    ${X11_INCLUDE_DIR}
    ${CMAKE_SOURCE_DIR}
    "${CMAKE_SOURCE_DIR}/auxlibs/include/tnt"
    "${CMAKE_SOURCE_DIR}/auxlibs/include/tnt"
)

message(INFO "Tcl include dir: ${TCL_INCLUDE_PATH}")

add_executable(scanalyze ${SOURCES})

target_link_libraries(scanalyze
    ${TK_LIBRARY}
    ${TCL_LIBRARY}
    ${OPENGL_LIBRARIES}
    ${X11_LIBRARIES}
    ${X11_Xmu_LIB}
    ${ZLIB_LIBRARIES}
    -lm
)
