@echo off
setlocal

REM Build the project with tests
cmake --build ..\build --config Debug --target c_playground_test

REM Run the tests
cd ..\build
ctest -C Debug --output-on-failure

endlocal
