@echo off
setlocal

REM DIRETÓRIO COMO PARAMETRO
REM Verifica se o diretório foi passado como argumento
if "%~1"=="" (
    echo [ERRO] Por favor, informe o diretório do projeto.
    echo Exemplo: configura-servidor.bat "C:\develop\aghuse\aghu\aghu-ear"
    pause
    exit /b 1
)

REM Acessa o diretório informado
cd /d "%~1"
if %ERRORLEVEL% neq 0 (
    echo [ERRO] Diretório não encontrado: "%~1"
    pause
    exit /b 1
)

REM EXISTE JBOSS_HOME CONFIGURADA
REM Verifica se a variável de ambiente JBOSS_HOME está definida
if "%JBOSS_HOME%"=="" (
    echo [ERRO] Variável de ambiente JBOSS_HOME não está definida
    echo Defina a variável JBOSS_HOME apontando para a instalação do WildFly
    pause
    exit /b 1
)

REM Verifica se o diretório existe
if not exist "%JBOSS_HOME%" (
    echo [ERRO] Diretório do WildFly não encontrado: %JBOSS_HOME%
    pause
    exit /b 1
)


REM Execução Maven
echo Executando Maven em: %cd%
echo Comando: 

mvn "initialize" ^
"-X" "-P configuracao" "-Dmaven.test.skip=true" ^
"tema.aghu=laranja" ^
"sistema.cups=false" ^
"certificado.nfe=12345678" ^
"logout.unload=false" ^
"login-module.class=br.gov.mec.aghu.casca.autenticacao.AghuseApenasNegocialSecurityRealm" ^
"login-module-pesquisa.class=br.gov.mec.aghu.casca.autenticacao.AghusePesquisaApenasNegocialSecurityRealm" ^
"jboss.home=%JBOSS_HOME%" ^
"envfilter=%ENV_FILTER%" ^
"maven.wagon.http.ssl.insecure=true" ^
"maven.wagon.http.ssl.allowall=true" ^
"logQueries=true" ^
"dbfilter=pg"


if %ERRORLEVEL% neq 0 (
    echo [ERRO] Build falhou. Código: %ERRORLEVEL%
    pause
    exit /b %ERRORLEVEL%
)

echo [SUCESSO] Build concluído em: %cd%
pause
endlocal