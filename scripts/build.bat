@echo off
setlocal

REM Create build directory if it doesn't exist
if not exist ../dist mkdir ../dist
if not exist ../vs2022-win64 mkdir ../vs2022-win64
if not exist ../build mkdir ../build
cd ../build


cmake  -G "Visual Studio 17 2022" .. 
REM Build and install Debug configuration
cmake --build . --config Debug --target ALL_BUILD
cmake --install . --config Debug --prefix ../dist/Debug

REM Build and install Release configuration
cmake --build . --config Release --target ALL_BUILD
cmake --install . --config Release --prefix ../dist/Release
