## Tarea: Implementar la carga dinámica de estas dos bibliotecas con la modificación mínima del archivo main.cpp
# Modificaciones:

Para este caso específico, el wrapper de C sería un error de diseño. 
El wrapper de C tiene sentido cuando querés exponer una biblioteca a otro lenguaje (Python, Rust, etc.) o construir un sistema de plugins independientes. En este caso, main.cpp es la aplicación, no un consumidor externo. Reescribir json["password"] como api->obtener_valor("password") sería agregar complejidad sin ningún beneficio real, ya que seguirías compilando todo junto de todas formas.

Los PCH resuelven exactamente el problema declarado: tiempo de compilación lento por headers gigantes que no cambian. json.hpp tiene ~25.000 líneas. httplib.h tiene ~12.000. El compilador las reprocesa completas cada vez. Con PCH, las procesa una sola vez.

1. Crear server/include/pch.h
```cpp
// pch.h - Cabecera Precompilada
// Incluye SOLO las dependencias estables que no cambian
#pragma once
#include "httplib.h"
#include "json.hpp"
```
2. Modificar server/main.cpp
```cpp
// ANTES:
#include "include/httplib.h"
#include "include/json.hpp"

// DESPUÉS (una sola línea):
#include "include/pch.h"
```
3. Modificar y cambiar build.sh por build.bat (para Windows)

## compilacion y ejecucion
1. primero
.\build.bat

2. luego ejecutar
build\intraned.exe

3. abrir navegador en 
http://localhost:8080

Probar en el navegador
* http://localhost:8080 - Biblioteca pública
* http://localhost:8080/login.html - Login admin
* http://localhost:8080/admin.html - Panel de administración
La contraseña de admin es admin123 (definida en main.cpp).