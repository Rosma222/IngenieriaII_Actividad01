@echo off
setlocal

echo Iniciando compilacion de Intraned...

:: Crear carpetas si no existen
if not exist build mkdir build
if not exist uploads mkdir uploads

set PCH_HEADER=server\include\pch.h
set PCH_OUTPUT=server\include\pch.h.gch

:: Precompilar headers si no existe el .gch
if not exist %PCH_OUTPUT% (
    echo [1/2] Precompilando headers, solo esta vez...
    g++ -O3 -x c++-header %PCH_HEADER% -o %PCH_OUTPUT% -pthread
    if errorlevel 1 (
        echo Error al precompilar headers.
        exit /b 1
    )
    echo Headers precompilados exitosamente.
) else (
    echo [1/2] Headers ya precompilados, omitiendo.
)

:: Compilacion principal
echo [2/2] Compilando aplicacion...
g++ -O3 server\main.cpp -o build\intraned.exe -pthread -I server\include -lws2_32

if errorlevel 1 (
    echo Error en la compilacion.
    exit /b 1
)

echo =========================================
echo  Compilacion exitosa: build\intraned.exe
echo =========================================
echo Para iniciar: build\intraned.exe