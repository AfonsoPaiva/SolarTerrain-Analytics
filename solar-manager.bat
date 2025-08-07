@echo off
chcp 65001 >nul
title Solar Terrain Analytics - Gerenciador do Projeto

:MENU
cls
echo ╔══════════════════════════════════════════════════════════════╗
echo ║               🌞 SOLAR TERRAIN ANALYTICS 🌞                  ║
echo ║                   Gerenciador do Projeto                    ║
echo ╠══════════════════════════════════════════════════════════════╣
echo ║                                                              ║
echo ║  1. 📦 Instalar/Atualizar Dependências                      ║
echo ║  2. 🚀 Iniciar Todos os Serviços                           ║
echo ║  3. 🧪 Testar Todos os Serviços                            ║
echo ║  4. 🛠️  Corrigir Problemas Comuns                           ║
echo ║  5. 🔄 Reiniciar Serviços                                   ║
echo ║  6. 🛑 Parar Todos os Serviços                             ║
echo ║  7. 📊 Status dos Serviços                                  ║
echo ║  8. 🔧 Configurações e URLs                                 ║
echo ║  9. ❌ Sair                                                  ║
echo ║                                                              ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
set /p choice="Escolha uma opção (1-9): "

if "%choice%"=="1" goto INSTALL
if "%choice%"=="2" goto START_ALL
if "%choice%"=="3" goto TEST_ALL
if "%choice%"=="4" goto FIX_ISSUES
if "%choice%"=="5" goto RESTART
if "%choice%"=="6" goto STOP_ALL
if "%choice%"=="7" goto STATUS
if "%choice%"=="8" goto CONFIG
if "%choice%"=="9" goto EXIT

echo Opção inválida! Pressione qualquer tecla para continuar...
pause >nul
goto MENU

:INSTALL
cls
echo ════════════════════════════════════════════════════════════════
echo 📦 INSTALANDO/ATUALIZANDO DEPENDÊNCIAS
echo ════════════════════════════════════════════════════════════════
echo.

echo [1/5] 🔍 Verificando pré-requisitos...
call :CHECK_PREREQUISITES
if errorlevel 1 goto MENU

echo.
echo [2/5] 🧹 Limpando instalações anteriores...
call :CLEAN_PREVIOUS

echo.
echo [3/5] ☕ Instalando Backend (Spring Boot)...
call :INSTALL_BACKEND
if errorlevel 1 goto MENU

echo.
echo [4/5] 🌐 Instalando Frontend Web (React)...
call :INSTALL_WEB
if errorlevel 1 goto MENU

echo.
echo [5/5] 📱 Instalando Frontend Mobile (Expo SDK 53)...
call :INSTALL_MOBILE
if errorlevel 1 goto MENU

echo.
echo ✅ INSTALAÇÃO CONCLUÍDA COM SUCESSO!
echo.
echo Componentes instalados:
echo • Backend Spring Boot (Java 21) - Porta 8081
echo • Frontend Web (React 18) - Porta 3000  
echo • Frontend Mobile (Expo SDK 53) - QR Code
echo.
pause
goto MENU

:START_ALL
cls
echo ════════════════════════════════════════════════════════════════
echo 🚀 INICIANDO TODOS OS SERVIÇOS
echo ════════════════════════════════════════════════════════════════
echo.

echo 🔍 Verificando e liberando portas...
call :FREE_PORTS

echo.
echo 🌐 Iniciando Backend Spring Boot (Porta 8081)...
cd backend
start "🌞 Solar Backend" cmd /k "echo Iniciando Spring Boot... && mvn spring-boot:run"
cd ..

echo ⏳ Aguardando backend inicializar (15 segundos)...
timeout /t 15 >nul

echo.
echo 🎨 Iniciando Frontend Web (Porta 3000)...
cd frontend-web
start "🌞 Solar Web" cmd /k "echo Iniciando React Web... && npm start"
cd ..

echo.
echo 📱 Iniciando Frontend Mobile (Expo)...
cd frontend-mobile
start "🌞 Solar Mobile" cmd /k "echo Iniciando Expo... && npx expo start"
cd ..

echo.
echo ✅ TODOS OS SERVIÇOS INICIADOS!
echo.
echo 🔗 URLs de acesso:
echo • Backend API: http://localhost:8081/api/counter
echo • Frontend Web: http://localhost:3000
echo • Frontend Mobile: Escaneie QR code com Expo Go
echo.
echo ⚠️  Aguarde alguns segundos para todos os serviços ficarem prontos
pause
goto MENU

:TEST_ALL
cls
echo ════════════════════════════════════════════════════════════════
echo 🧪 TESTANDO TODOS OS SERVIÇOS
echo ════════════════════════════════════════════════════════════════
echo.

echo [1/4] 🔍 Verificando processos ativos...
call :CHECK_PROCESSES

echo.
echo [2/4] 🌐 Testando Backend (Porta 8081)...
curl -X GET http://localhost:8081/api/counter --connect-timeout 5 --max-time 10 --silent 2>nul
if errorlevel 1 (
    echo ❌ Backend não está respondendo
    echo    URL: http://localhost:8081/api/counter
    echo    Solução: Execute opção 2 para iniciar serviços
) else (
    echo ✅ Backend funcionando corretamente!
)

echo.
echo [3/4] 🎨 Testando Frontend Web (Porta 3000)...
curl -X GET http://localhost:3000 --connect-timeout 5 --max-time 10 --silent 2>nul | find "Solar" >nul 2>&1
if errorlevel 1 (
    echo ❌ Frontend Web não está respondendo
    echo    URL: http://localhost:3000
    echo    Solução: Execute opção 2 para iniciar serviços
) else (
    echo ✅ Frontend Web funcionando corretamente!
)

echo.
echo [4/4] 📊 Testando conectividade Backend ↔ Frontend...
echo Teste manual: Abra http://localhost:3000 e clique no botão
echo Se o contador incrementar, a comunicação está OK!

echo.
echo 🔗 URLs para teste manual:
echo • Backend JSON: http://localhost:8081/api/counter
echo • Frontend Web: http://localhost:3000
echo • Incrementar: curl -X POST http://localhost:8081/api/counter/increment
echo.
pause
goto MENU

:FIX_ISSUES
cls
echo ════════════════════════════════════════════════════════════════
echo 🛠️ CORRIGINDO PROBLEMAS COMUNS
echo ════════════════════════════════════════════════════════════════
echo.

echo [1/5] 🛑 Parando processos problemáticos...
call :FORCE_STOP_ALL

echo.
echo [2/5] 🔧 Corrigindo npm (ENOENT)...
if not exist "C:\Users\%USERNAME%\AppData\Roaming\npm" (
    mkdir "C:\Users\%USERNAME%\AppData\Roaming\npm" 2>nul
    echo ✅ Diretório npm criado
) else (
    echo ✅ Diretório npm OK
)
npm cache clean --force 2>nul
echo ✅ Cache npm limpo

echo.
echo [3/5] 📁 Verificando estrutura de pastas...
call :CHECK_STRUCTURE
if errorlevel 1 goto MENU

echo.
echo [4/5] 🔄 Limpando builds anteriores...
if exist "backend\target" rmdir /s /q "backend\target" 2>nul
if exist "frontend-web\build" rmdir /s /q "frontend-web\build" 2>nul
if exist "frontend-mobile\.expo" rmdir /s /q "frontend-mobile\.expo" 2>nul
echo ✅ Builds limpos

echo.
echo [5/5] 🧪 Testando compilação...
cd backend
mvn clean compile -q 2>nul
if errorlevel 1 (
    echo ❌ Erro na compilação do backend
    cd ..
    pause
    goto MENU
) else (
    echo ✅ Backend compila corretamente
)
cd ..

echo.
echo ✅ TODOS OS PROBLEMAS FORAM CORRIGIDOS!
echo Agora você pode usar a opção 2 para iniciar os serviços
pause
goto MENU

:RESTART
cls
echo ════════════════════════════════════════════════════════════════
echo 🔄 REINICIANDO SERVIÇOS
echo ════════════════════════════════════════════════════════════════
echo.

echo 🛑 Parando serviços...
call :FORCE_STOP_ALL

echo ⏳ Aguardando 5 segundos...
timeout /t 5 >nul

echo 🚀 Iniciando novamente...
goto START_ALL

:STOP_ALL
cls
echo ════════════════════════════════════════════════════════════════
echo 🛑 PARANDO TODOS OS SERVIÇOS
echo ════════════════════════════════════════════════════════════════
echo.

call :FORCE_STOP_ALL

echo ✅ TODOS OS SERVIÇOS FORAM PARADOS!
pause
goto MENU

:STATUS
cls
echo ════════════════════════════════════════════════════════════════
echo 📊 STATUS DOS SERVIÇOS
echo ════════════════════════════════════════════════════════════════
echo.

echo 🔍 Processos Java (Backend):
tasklist /FI "IMAGENAME eq java.exe" 2>nul | find "java.exe"
if errorlevel 1 (
    echo ❌ Nenhum processo Java rodando
) else (
    echo ✅ Processos Java encontrados
)

echo.
echo 🔍 Processos Node (Frontend):
tasklist /FI "IMAGENAME eq node.exe" 2>nul | find "node.exe"
if errorlevel 1 (
    echo ❌ Nenhum processo Node rodando
) else (
    echo ✅ Processos Node encontrados
)

echo.
echo 🌐 Portas em uso:
echo Backend (8081):
netstat -an | findstr ":8081" 2>nul
if errorlevel 1 (
    echo ❌ Porta 8081 livre
) else (
    echo ✅ Porta 8081 em uso
)

echo Frontend Web (3000):
netstat -an | findstr ":3000" 2>nul
if errorlevel 1 (
    echo ❌ Porta 3000 livre  
) else (
    echo ✅ Porta 3000 em uso
)

echo.
echo 📁 Estrutura do projeto:
if exist "backend\pom.xml" (echo ✅ Backend OK) else (echo ❌ Backend faltando)
if exist "frontend-web\package.json" (echo ✅ Frontend Web OK) else (echo ❌ Frontend Web faltando)
if exist "frontend-mobile\package.json" (echo ✅ Frontend Mobile OK) else (echo ❌ Frontend Mobile faltando)

pause
goto MENU

:CONFIG
cls
echo ════════════════════════════════════════════════════════════════
echo 🔧 CONFIGURAÇÕES E URLs
echo ════════════════════════════════════════════════════════════════
echo.
echo 🌐 URLs de Acesso:
echo • Backend API: http://localhost:8081/api/counter
echo • Frontend Web: http://localhost:3000
echo • Admin Backend: http://localhost:8081/actuator/health
echo.
echo 📱 Mobile (Expo):
echo • Execute: cd frontend-mobile ^&^& npx expo start
echo • Escaneie QR code com Expo Go
echo • Alternativa: npx expo start --tunnel
echo.
echo 🧪 Testes manuais:
echo • GET contador: curl -X GET http://localhost:8081/api/counter
echo • POST incrementar: curl -X POST http://localhost:8081/api/counter/increment
echo.
echo 📂 Estrutura:
echo • Backend: Java 21 + Spring Boot (porta 8081)
echo • Frontend Web: React 18 (porta 3000)
echo • Frontend Mobile: React Native + Expo SDK 53
echo • Base dados: Contador local (em memória)
echo.
echo 🚀 Comandos manuais:
echo • Backend: cd backend ^&^& mvn spring-boot:run
echo • Web: cd frontend-web ^&^& npm start  
echo • Mobile: cd frontend-mobile ^&^& npx expo start
echo.
pause
goto MENU

:EXIT
cls
echo ════════════════════════════════════════════════════════════════
echo 👋 SAINDO...
echo ════════════════════════════════════════════════════════════════
echo.
set /p stop_services="Deseja parar todos os serviços antes de sair? (s/N): "
if /i "%stop_services%"=="s" (
    echo Parando serviços...
    call :FORCE_STOP_ALL
)
echo.
echo Obrigado por usar Solar Terrain Analytics! 🌞
timeout /t 3 >nul
exit

REM ═══════════════════════════════════════════════════════════════════
REM FUNÇÕES AUXILIARES
REM ═══════════════════════════════════════════════════════════════════

:CHECK_PREREQUISITES
echo Verificando Node.js...
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js não encontrado! Instale Node.js primeiro.
    pause
    exit /b 1
)

echo Verificando Java...
java -version >nul 2>&1
if errorlevel 1 (
    echo ❌ Java não encontrado! Instale Java 17+ primeiro.
    pause
    exit /b 1
)

echo Verificando Maven...
mvn --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Maven não encontrado! Instale Maven primeiro.
    pause
    exit /b 1
)

echo ✅ Todos os pré-requisitos OK!
exit /b 0

:CHECK_STRUCTURE
if not exist "backend" (
    echo ❌ Diretório backend não encontrado!
    echo Execute este script da pasta raiz do projeto
    pause
    exit /b 1
)
if not exist "frontend-web" (
    echo ❌ Diretório frontend-web não encontrado!
    pause
    exit /b 1
)
if not exist "frontend-mobile" (
    echo ❌ Diretório frontend-mobile não encontrado!
    pause
    exit /b 1
)
echo ✅ Estrutura de pastas OK!
exit /b 0

:CLEAN_PREVIOUS
echo Limpando instalações anteriores...
if exist "frontend-web\node_modules" rmdir /s /q "frontend-web\node_modules" 2>nul
if exist "frontend-mobile\node_modules" rmdir /s /q "frontend-mobile\node_modules" 2>nul
if exist "backend\target" rmdir /s /q "backend\target" 2>nul
echo ✅ Limpeza concluída
exit /b 0

:INSTALL_BACKEND
cd backend
if not exist pom.xml (
    echo ❌ pom.xml não encontrado!
    cd ..
    pause
    exit /b 1
)
mvn clean compile -q
if errorlevel 1 (
    echo ❌ Erro na compilação do backend
    cd ..
    pause
    exit /b 1
)
cd ..
echo ✅ Backend instalado
exit /b 0

:INSTALL_WEB
cd frontend-web
if not exist package.json (
    echo ❌ package.json não encontrado!
    cd ..
    pause
    exit /b 1
)
npm install --silent
if errorlevel 1 (
    echo ❌ Erro na instalação do frontend web
    cd ..
    pause
    exit /b 1
)
cd ..
echo ✅ Frontend Web instalado
exit /b 0

:INSTALL_MOBILE
cd frontend-mobile
if not exist package.json (
    echo ❌ package.json não encontrado!
    cd ..
    pause
    exit /b 1
)
npm install --silent
if errorlevel 1 (
    echo ❌ Erro na instalação do frontend mobile
    cd ..
    pause
    exit /b 1
)
cd ..
echo ✅ Frontend Mobile instalado
exit /b 0

:FREE_PORTS
echo Liberando porta 8081...
for /f "tokens=5" %%a in ('netstat -aon 2^>nul ^| findstr ":8081"') do (
    taskkill /F /PID %%a 2>nul
)

echo Liberando porta 3000...
for /f "tokens=5" %%a in ('netstat -aon 2^>nul ^| findstr ":3000"') do (
    taskkill /F /PID %%a 2>nul
)
echo ✅ Portas liberadas
exit /b 0

:FORCE_STOP_ALL
echo Parando processos Java...
tasklist /FI "IMAGENAME eq java.exe" 2>nul | find "java.exe" >nul
if not errorlevel 1 (
    taskkill /F /IM java.exe 2>nul
    echo ✅ Processos Java parados
)

echo Parando processos Node...
tasklist /FI "IMAGENAME eq node.exe" 2>nul | find "node.exe" >nul
if not errorlevel 1 (
    taskkill /F /IM node.exe 2>nul
    echo ✅ Processos Node parados
)

timeout /t 2 >nul
exit /b 0

:CHECK_PROCESSES
echo Processos Java:
tasklist /FI "IMAGENAME eq java.exe" 2>nul | find "java.exe"
if errorlevel 1 (echo ❌ Nenhum processo Java) else (echo ✅ Java rodando)

echo Processos Node:
tasklist /FI "IMAGENAME eq node.exe" 2>nul | find "node.exe"
if errorlevel 1 (echo ❌ Nenhum processo Node) else (echo ✅ Node rodando)
exit /b 0
