#!/bin/sh

mkdir build
cd build

cmake ${CMAKE_ARGS} -GNinja .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_TESTING=ON \
      -DIDYNTREE_USES_IPOPT:BOOL=ON \
      -DIDYNTREE_USES_OSQPEIGEN:BOOL=ON \
      -DIDYNTREE_USES_IRRLICHT:BOOL=ON \
      -DIDYNTREE_USES_ASSIMP:BOOL=ON \
      -DIDYNTREE_USES_MATLAB:BOOL=OFF \
      -DIDYNTREE_USES_PYTHON:BOOL=ON \
      -DIDYNTREE_USES_OCTAVE:BOOL=OFF \
      -DIDYNTREE_USES_LUA:BOOL=OFF \
      -DIDYNTREE_COMPILES_YARP_TOOLS:BOOL=OFF \
      -DPython3_EXECUTABLE:PATH=$PYTHON \
      -DIDYNTREE_DETECT_ACTIVE_PYTHON_SITEPACKAGES:BOOL=ON \
      -DIDYNTREE_PYTHON_PIP_METADATA_INSTALLER=conda

cmake --build . --config Release
cmake --build . --config Release --target install
if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
  ctest --output-on-failure -C Release
fi
