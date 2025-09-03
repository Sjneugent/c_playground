@echo off
setlocal

REM Remove build directory
if exist "..\build" rmdir /s /q "..\build"

REM Remove dist directory
if exist "..\dist" rmdir /s /q "..\dist"

endlocal
