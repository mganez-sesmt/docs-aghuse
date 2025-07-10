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
echo JBOSS_HOME=%JBOSS_HOME%

REM EXISTE ENV_FILTER CONFIGURADA
REM Verifica se a variável de ambiente ENV_FILTER está definida
if "%ENV_FILTER%"=="" (
    echo [ERRO] Variável de ambiente ENV_FILTER não está definida
    echo Defina a variável ENV_FILTER apontando para o arquivo de filtro
    pause
    exit /b 1
)

REM Verifica se o arquivo existe
if not exist "%ENV_FILTER%" (
    echo [ERRO] Arquivo de filtro não encontrado: %ENV_FILTER%
    pause
    exit /b 1
)

echo ENV_FILTER=%ENV_FILTER%

del "%JBOSS_HOME%\standalone\tmp\*" /Q /F /S
del "%JBOSS_HOME%\standalone\deployments\*" /Q /F /S
del "%JBOSS_HOME%\standalone\data\content\*" /Q /F /S
::rd -r %JBOSS_HOME%\standalone\tmp
::rd -r %JBOSS_HOME%\standalone\data\content
::rd -r %JBOSS_HOME%\standalone\deployments
::-Ddatasource.driver=org.postgresql.Driver ^
::-Ddatasource.driver.classname=org.postgresql.Driver ^
::-Ddatasource.dialect.classname=br.gov.mec.aghu.core.persistence.dialect.PostgreSQLExtendedDialect ^

REM Execução Maven
echo Executando Maven em: %cd%
echo Comando: 

mvn initialize ^
-Denvfilter=%ENV_FILTER% ^
-Djboss.home=%JBOSS_HOME% ^
-Ddatasource.url=jdbc:postgresql://10.15.1.21:5432/agh ^
-Ddatasource.user.name=aghu_dev ^
-Ddatasource.password=dtgjes#768359 ^
-Ddatasource-fit.user.name=aghu_dev ^
-Ddatasource-fit.password=dtgjes#768359 ^
-Dejb.security-domain=AghuseApplicationDomain ^
-Dsecurity-realm.class=br.gov.mec.aghu.casca.autenticacao.AghuseApenasNegocialSecurityRealm ^
-Dsecurity-realm-pesquisa.class=br.gov.mec.aghu.casca.autenticacao.AghusePesquisaApenasNegocialSecurityRealm ^
-Dsecure.cookies=false ^
-Ddbfilter=pg ^
-X -P configuracao 



if %ERRORLEVEL% neq 0 (
    echo [ERRO] Build falhou. Código: %ERRORLEVEL%
    pause
    exit /b %ERRORLEVEL%
)

echo [SUCESSO] Build concluído em: %cd%
pause
endlocal

::OUTRAS CONFIGURACOES POSSIVEIS DE SEREM PASSADAS
::aghu.external.version -> 1.0-SNAPSHOT
::dbuserfit -> ugen_aghu
::mail.ssl -> false
::aghuse-wildfly-bom.version -> 0.0.3a
::logQueries -> false
::cadsus-token -> kUXNmiiii#RDdlOELdoe00966
::notification-service-key -> PREENCHA-A-KEY
::fab.enable.security.contraint.end ->
::overwrite-wildfly-auth -> false
::dbuser -> ugen_aghu
::exclude-mobile -> false
::vidaas-client-id -> a381a072-625c-42f0-902d-920e4c6a1401
::luceneMassIndexerLoadSize -> 25
::datasource.driver -> PostgresqlDriver
::ejb.versao -> 3.2
::security-realm-validar-auth-externa-pesquisa -> select usuario.id, usuario.login, usuario.ATIVO, senha.HASH_SENHA, (select count(*) from casca.CSC_PERFIS_USUARIOS perfilusuario inner join casca.CSC_PERFIL perfil on perfil.id = perfilusuario.id_perfil  where perfilusuario.id_usuario = usuario.id and (perfilusuario.dthr_expiracao is null or perfilusuario.dthr_expiracao > sysdate) and perfil.SITUACAO = 'A') perfilcount       from CASCA.CSC_USUARIO usuario, CASCA.CSC_SENHA senha          where senha.id_usuario = usuario.id and (upper(login) = upper(?) OR (upper(email) = upper(?)))            and senha.DATA_CRIACAO = (select max(DATA_CRIACAO) from CASCA.CSC_SENHA where id_usuario = usuario.id)
::ldap.enabled.attribute ->
::mascara.quarto -> ****
::login.sso.attribute.consuming.service.index ->
::casca-key -> PREENCHA-A-KEY
::mail.starttls -> false
::jboss.java.metaspace -> 850M
::login.sso.redirecionamento.erro ->
::ldap.server.port -> 389
::geracao-service-client-secret ->
::dosewatch-user -> dosewatch
::sd.user.name.attribute -> sAMAccountName
::jasper-governor-max-pages-enabled -> true
::ejb-server-hash -> 27a925f98c7ebe50f6be7947d2225bc4
::ldap.user.context.DN -> dc=aghu
::luceneMassIndexerThreadCount -> 3
::ad.user.name.attribute -> sAMAccountName
::security-realm.validar-autenticacao-negocial -> select usuario.id, usuario.login, usuario.ATIVO , (select count(*) from casca.CSC_PERFIS_USUARIOS perfilusuario inner join casca.CSC_PERFIL perfil on perfil.id = perfilusuario.id_perfil     where perfilusuario.id_usuario = usuario.id     and (perfilusuario.dthr_expiracao is null or perfilusuario.dthr_expiracao > now()) and perfil.SITUACAO = 'A' ) perfilcount from CASCA.CSC_USUARIO usuario where login = upper(?)
::documentacao.url -> https://aghu-documentacao.hcpa.ufrgs.br
::ldap.bind.credentials -> ***_INFORME_AQUI_A_SENHA_***
::ldap.user.DN.suffix -> ,dc=aghu
::jasper-governor-max-pages -> 5000
::security-realm.verificar-vinculo-servidor -> select serv.matricula, serv.vin_codigo, serv.dt_inicio_vinculo, serv.CCT_CODIGO, serv.HTR_CODIGO, serv.OCA_CAR_CODIGO, serv.OCA_CODIGO, vin.IND_SITUACAO, vin.IND_CCUST_LOTACAO, vin.IND_HORARIO, vin.IND_OCUPACAO, vin.NRO_DIAS_ADMISSAO from agh.RAP_SERVIDORES serv inner join agh.RAP_PESSOAS_FISICAS pes on pes.codigo = serv.PES_CODIGO inner join agh.RAP_VINCULOS vin on vin.codigo = serv.vin_codigo where usuario = upper(?) and ( serv.ind_situacao = 'A' or (serv.ind_situacao = 'P' and serv.dt_fim_vinculo >= now()))
::skipDaoTest -> false
::"security-realm.class"
::security-realm.class -> br.gov.mec.aghu.casca.autenticacao.AghuseApenasNegocialSecurityRealm
::maven-pmd-plugin.version -> 3.21.2
::siafi-usuario-token ->
::sd.enabled.attribute ->
::version.war.plugin -> 3.4.0
::"jboss.home"
::jboss.home -> c:\develop\wildfly
::remote-ejb-key -> bN3bG4+bLByHXDUR+C2Ky5LTSvnIkXYq
::ad.server.port -> 389
::securecookies -> false
::dbpwdfit -> -3ac45e7dcbab3aa5207a6df87216de44
::quartz.dataSource.driver -> org.postgresql.xa.PGXADataSource
::login.sso.idp.url ->
::mascara.leito -> a
::cobertura-maven-plugin.version -> 2.7
::ambiente -> homolog
::cadsus-numero-cnes -> 6963447
::root.logger -> GRAYLOG
::sd.bind.credentials -> c1l2rad3
::mail.password ->
::findbugs-maven-plugin.version -> 3.0.5
::mail.user ->
::version.compiler.plugin -> 3.14.0
::graylog.server -> 127.0.0.1
::jasperreports.versao -> 6.21.4
::meuclinicas-key -> PREENCHA-A-KEY
::valid-connection-checker -> org.jboss.resource.adapter.jdbc.vendor.PostgreSQLValidConnectionChecker
::dbpwd -> -3ac45e7dcbab3aa5207a6df87216de44
::file-service-password -> f1l3@2017
::fab.saml.auth.filter ->
::version.sonar -> 5.1.0.4751
::recaptcha-secret-key -> MY_SECRET_KEY
::auth-method -> FORM
::login.sso.consumer.url ->
::solr-key ->
::"dbfilter"
::dbfilter -> pg
::"datasource.url"
::datasource.url -> jdbc:postgresql://10.15.1.21:5432/agh
::remote-ejb-user -> ejbuser
::"security-realm-pesquisa.class"
::security-realm-pesquisa.class -> br.gov.mec.aghu.casca.autenticacao.AghusePesquisaApenasNegocialSecurityRealm
::siafi-token ->
::certificadonfe ->
::ad.server.address -> local.hcpa.ufrgs.br
::solr-user ->
::recaptcha-site-key -> MY_SITE_KEY
::jboss.activemq.pool.maxsize -> 10
::safeid-client-id ->
::version.ear.plugin -> 3.3.0
::geracao-service-client-id ->
::logoutunload -> true
::maven.compiler.target -> 17
::groovy.versao -> 4.0.26
::cadsus-usuario-cnes -> LEONARDO
::fab.saml.consumer ->
::safeid-client-secret ->
::security-realm-dominio-local -> @hcpa.edu.br
::msv-key -> msv@2021
::maven.compiler.test.target -> 17
::host.sonar ->
::executaquartzExames -> false
::maven-checkstyle-plugin.version -> 3.6.0
::ad.bind.DN -> aghujboss@local.hcpa.ufrgs.br
::cadsus-password-cnes ->
::sd.bind.dn -> aghujboss@local.hcpa.ufrgs.br
::nome.ambiente -> PGH
::pmd.version -> 6.55.0
::keycloak-url ->
::aghuse-bom.version -> 0.0.161
::datatable-logo -> /img/print/logo-hcpa-pdf.jpg
::db-pollsize-max -> 5
::ejb-security-domain -> AghuseApplicationDomain
::contexto -> aghu
::failurePriority -> 2
::pagtesouro-password -> 97o2bN2KIt@hcpa
::login.sso.root.return ->
::dialeto ->
::sd.server.address -> local.hcpa.ufrgs.br
::arg.java.memoria -> -Xms1024m -Xmx1024m -XX:MaxMetaspaceSize=768m -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC
::mail.host -> 10.247.247.6
::ad.user.context.DN -> DC=local,DC=hcpa,DC=ufrgs,DC=br
::project.stage -> Development
::log.level -> WARN
::sd.user.dn -> %s@local.hcpa.ufrgs.br
::ldap.bind.DN -> cn=admin,dc=aghu
::login.sso.issuer ->
::hibernate.dialect.classname -> br.gov.mec.aghu.core.persistence.dialect.PostgreSQLExtendedDialect
::sd.filter.expression -> (&(objectClass=user)(sAMAccountName=%s))
::login.sso.atributo.usuario ->
::graylog.port -> 12201
::version.ejb.plugin -> 3.2.1
::tipo.encoding -> UTF-8
::tiss-client-version -> 1.0.3
::entidades.versao -> 13.262-STABLE
::cadsus-usuario-token -> CADSUS.CNS.PDQ.PUBLICO
::graylog.level -> OFF
::ldap.server.address -> local.hcpa.ufrgs.br
::descompactar -> false
::maven.compiler.source -> 17
::surefireArgLine ->
::bloq-metodo-logout -> websocket
::threadCount -> 100
::altcha-hmac-key -> ef12MN3npd
::exclude-aghu -> false
::ad.bind.credentials -> c1l2rad3
::msv-user -> msv
::mail.port -> 25
::version.jacoco.plugin -> 0.8.13
::ldap.user.DN.prefix -> cn=
::api_token_integracao ->
::sd.user.context.dn -> DC=local,DC=hcpa,DC=ufrgs,DC=br
::jboss.java.heapspace -> 3G
::sms-broker -> INTELLY
::solr-server -> aghuse-solr-homolog:8983
::notification-service-user -> PREENCHA-O-USUARIO
::key.sonar -> branch
::maven.compiler.test.source -> 17
::pagtesouro-user -> pagtesouro
::file-service-user -> file
::bloq.mult.login -> false
::login.sso.servidor.logout ->
::version.git-commit-id-plugin -> 4.9.10
::token.sonar ->
::wildfly.version -> 26.1.3.Final
::project.build.sourceEncoding -> UTF-8
::ad.domain -> local.hcpa.ufrgs.br
::meuclinicas-usuario -> PREENCHA-O-USUARIO
::realm-name -> AghuseApplicationDomain
::geracao-service-url ->
::casca-usuario -> PREENCHA-O-USUARIO
::sql-connection-check-valid-new -> select now()
::maven-antrun-plugin.versao -> 3.1.0
::fab.saml.login.filter ->
::fab.enable.security.contraint.init ->
::vidaas-client-secret -> XcS8R6m7R38e0824
::sistemacups -> false
::security-realm.validar-autenticacao-api -> select t.token from casca.csc_usuarios_api u, casca.csc_tokens_api t where u.login_hcpa = upper(?) and t.seq_usuario = u.seq and t.token = ? and t.data_expiracao >= ?
::quartz.jobStore.driver.delegate.class -> org.quartz.impl.jdbcjobstore.PostgreSQLDelegate
::geracao-service-realm -> contingencia-realm
::tema -> default
::remote-ejb-server -> localhost:8080
::exclude-pesquisa -> false
::version.surefire.plugin -> 3.5.3
::dosewatch-key -> dosewatch
::bloq.metodo.logout -> websocket
::clover.version -> 4.5.2
::allow-query-endpoint -> false
::ldap.user.name.attribute -> cn
::db-pollsize-min -> 1
::sd.server.port -> 389
::"datasource.user.name"
::datasource.user.name -> aghu_dev
::"security-realm-pesquisa.class"
::security-realm-pesquisa.class -> br.gov.mec.aghu.casca.autenticacao.AghusePesquisaApenasNegocialSecurityRealm
::"security-realm.class"
::security-realm.class -> br.gov.mec.aghu.casca.autenticacao.AghuseApenasNegocialSecurityRealm
::"datasource-fit.user.name"
::datasource-fit.user.name -> aghu_dev
::"datasource-fit.password"
::datasource-fit.password -> dtgjes#768359
::"jboss.home"
::jboss.home -> c:\develop\wildfly
::"dbfilter"
::dbfilter -> pg
::"datasource.url"
::datasource.url -> jdbc:postgresql://10.15.1.21:5432/agh
::"envfilter"
::envfilter -> C:\develop\arquivos\app_sesmt.properties
::"ejb.security-domain"
::ejb.security-domain -> AghuseApplicationDomain
::"datasource.password"
::datasource.password -> dtgjes#768359
::"secure.cookies"
::secure.cookies -> false
::ant.file -> C:\develop\aghuse-hcpa\aghu\aghu-ear\pom.xml
::[DEBUG] Setting properties with prefix:
::project.groupId -> br.gov.mec
::project.artifactId -> aghu-ear
::project.name -> aghu: EAR Module
::project.version -> 13.262-STABLE
::project.packaging -> ear
::project.build.directory -> C:\develop\aghuse-hcpa\aghu\aghu-ear\target
::project.build.outputDirectory -> C:\develop\aghuse-hcpa\aghu\aghu-ear\target\classes
::project.build.testOutputDirectory -> C:\develop\aghuse-hcpa\aghu\aghu-ear\target\test-classes
::project.build.sourceDirectory -> C:\develop\aghuse-hcpa\aghu\aghu-ear\src\main\java
::project.build.testSourceDirectory -> C:\develop\aghuse-hcpa\aghu\aghu-ear\src\test\java
::localRepository ->       id: local
::      url: file:///C:/Users/mateusanez/.m2/repository/
::   layout: default
::snapshots: [enabled => true, update => always]
:: releases: [enabled => true, update => always]
::   blocked: false
::
::settings.localRepository -> C:\Users\mateusanez\.m2\repository
::br.gov.mec:aghu-messages-bundle:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-messages-bundle\13.262-STABLE\aghu-messages-bundle-13.262-STABLE.jar
::br.gov.mec:aghu-relatorios:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-relatorios\13.262-STABLE\aghu-relatorios-13.262-STABLE.jar
::net.sf.jasperreports:jasperreports:jar -> C:\Users\mateusanez\.m2\repository\net\sf\jasperreports\jasperreports\6.21.4\jasperreports-6.21.4.jar
::com.fasterxml.jackson.dataformat:jackson-dataformat-xml:jar -> C:\Users\mateusanez\.m2\repository\com\fasterxml\jackson\dataformat\jackson-dataformat-xml\2.17.1\jackson-dataformat-xml-2.17.1.jar
::org.codehaus.woodstox:stax2-api:jar -> C:\Users\mateusanez\.m2\repository\org\codehaus\woodstox\stax2-api\4.2.2\stax2-api-4.2.2.jar
::com.fasterxml.woodstox:woodstox-core:jar -> C:\Users\mateusanez\.m2\repository\com\fasterxml\woodstox\woodstox-core\6.6.2\woodstox-core-6.6.2.jar
::org.eclipse.jdt:ecj:jar -> C:\Users\mateusanez\.m2\repository\org\eclipse\jdt\ecj\3.41.0\ecj-3.41.0.jar
::br.gov.mec:aghu-dao:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-dao\13.262-STABLE\aghu-dao-13.262-STABLE.jar
::org.apache.commons:commons-collections4:jar -> C:\Users\mateusanez\.m2\repository\org\apache\commons\commons-collections4\4.4\commons-collections4-4.4.jar
::br.gov.mec.aghu-core:aghu-core-commons:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-core\aghu-core-commons\8.0.54\aghu-core-commons-8.0.54.jar
::javax.annotation:javax.annotation-api:jar -> C:\Users\mateusanez\.m2\repository\javax\annotation\javax.annotation-api\1.3.2\javax.annotation-api-1.3.2.jar
::javax.xml.bind:jaxb-api:jar -> C:\Users\mateusanez\.m2\repository\javax\xml\bind\jaxb-api\2.4.0-b180830.0359\jaxb-api-2.4.0-b180830.0359.jar
::javax.activation:javax.activation-api:jar -> C:\Users\mateusanez\.m2\repository\javax\activation\javax.activation-api\1.2.0\javax.activation-api-1.2.0.jar
::com.sun.xml.bind:jaxb-core:jar -> C:\Users\mateusanez\.m2\repository\com\sun\xml\bind\jaxb-core\2.3.0.1\jaxb-core-2.3.0.1.jar
::com.sun.xml.bind:jaxb-impl:jar -> C:\Users\mateusanez\.m2\repository\com\sun\xml\bind\jaxb-impl\2.3.6\jaxb-impl-2.3.6.jar
::com.sun.activation:jakarta.activation:jar -> C:\Users\mateusanez\.m2\repository\com\sun\activation\jakarta.activation\1.2.2\jakarta.activation-1.2.2.jar
::org.jsoup:jsoup:jar -> C:\Users\mateusanez\.m2\repository\org\jsoup\jsoup\1.19.1\jsoup-1.19.1.jar
::org.bouncycastle:bcprov-jdk18on:jar -> C:\Users\mateusanez\.m2\repository\org\bouncycastle\bcprov-jdk18on\1.80\bcprov-jdk18on-1.80.jar
::org.bouncycastle:bcpkix-jdk18on:jar -> C:\Users\mateusanez\.m2\repository\org\bouncycastle\bcpkix-jdk18on\1.80\bcpkix-jdk18on-1.80.jar
::org.bouncycastle:bcutil-jdk18on:jar -> C:\Users\mateusanez\.m2\repository\org\bouncycastle\bcutil-jdk18on\1.80\bcutil-jdk18on-1.80.jar
::org.apache.commons:commons-lang3:jar -> C:\Users\mateusanez\.m2\repository\org\apache\commons\commons-lang3\3.17.0\commons-lang3-3.17.0.jar
::org.apache.httpcomponents:httpclient:jar -> C:\Users\mateusanez\.m2\repository\org\apache\httpcomponents\httpclient\4.5.14\httpclient-4.5.14.jar
::org.apache.httpcomponents:httpcore:jar -> C:\Users\mateusanez\.m2\repository\org\apache\httpcomponents\httpcore\4.4.15\httpcore-4.4.15.jar
::commons-logging:commons-logging:jar -> C:\Users\mateusanez\.m2\repository\commons-logging\commons-logging\1.2\commons-logging-1.2.jar
::org.apache.pdfbox:pdfbox:jar -> C:\Users\mateusanez\.m2\repository\org\apache\pdfbox\pdfbox\3.0.4\pdfbox-3.0.4.jar
::org.apache.pdfbox:pdfbox-io:jar -> C:\Users\mateusanez\.m2\repository\org\apache\pdfbox\pdfbox-io\3.0.4\pdfbox-io-3.0.4.jar
::org.apache.pdfbox:fontbox:jar -> C:\Users\mateusanez\.m2\repository\org\apache\pdfbox\fontbox\3.0.4\fontbox-3.0.4.jar
::org.apache.pdfbox:pdfbox-tools:jar -> C:\Users\mateusanez\.m2\repository\org\apache\pdfbox\pdfbox-tools\3.0.4\pdfbox-tools-3.0.4.jar
::info.picocli:picocli:jar -> C:\Users\mateusanez\.m2\repository\info\picocli\picocli\4.7.6\picocli-4.7.6.jar
::org.apache.pdfbox:preflight:jar -> C:\Users\mateusanez\.m2\repository\org\apache\pdfbox\preflight\3.0.4\preflight-3.0.4.jar
::org.apache.pdfbox:xmpbox:jar -> C:\Users\mateusanez\.m2\repository\org\apache\pdfbox\xmpbox\3.0.4\xmpbox-3.0.4.jar
::org.verapdf:validation-model:jar -> C:\Users\mateusanez\.m2\repository\org\verapdf\validation-model\1.26.5\validation-model-1.26.5.jar
::org.verapdf:parser:jar -> C:\Users\mateusanez\.m2\repository\org\verapdf\parser\1.26.1\parser-1.26.1.jar
::org.verapdf:pdf-model:jar -> C:\Users\mateusanez\.m2\repository\org\verapdf\pdf-model\1.26.1\pdf-model-1.26.1.jar
::org.verapdf:core:jar -> C:\Users\mateusanez\.m2\repository\org\verapdf\core\1.26.5\core-1.26.5.jar
::org.verapdf:verapdf-xmp-core:jar -> C:\Users\mateusanez\.m2\repository\org\verapdf\verapdf-xmp-core\1.26.5\verapdf-xmp-core-1.26.5.jar
::org.mozilla:rhino:jar -> C:\Users\mateusanez\.m2\repository\org\mozilla\rhino\1.7.13\rhino-1.7.13.jar
::net.java.dev.stax-utils:stax-utils:jar -> C:\Users\mateusanez\.m2\repository\net\java\dev\stax-utils\stax-utils\20070216\stax-utils-20070216.jar
::org.verapdf:feature-reporting:jar -> C:\Users\mateusanez\.m2\repository\org\verapdf\feature-reporting\1.26.5\feature-reporting-1.26.5.jar
::org.verapdf:metadata-fixer:jar -> C:\Users\mateusanez\.m2\repository\org\verapdf\metadata-fixer\1.26.5\metadata-fixer-1.26.5.jar
::com.twelvemonkeys.imageio:imageio-jpeg:jar -> C:\Users\mateusanez\.m2\repository\com\twelvemonkeys\imageio\imageio-jpeg\3.12.0\imageio-jpeg-3.12.0.jar
::com.twelvemonkeys.imageio:imageio-core:jar -> C:\Users\mateusanez\.m2\repository\com\twelvemonkeys\imageio\imageio-core\3.12.0\imageio-core-3.12.0.jar
::com.twelvemonkeys.imageio:imageio-metadata:jar -> C:\Users\mateusanez\.m2\repository\com\twelvemonkeys\imageio\imageio-metadata\3.12.0\imageio-metadata-3.12.0.jar
::com.twelvemonkeys.common:common-lang:jar -> C:\Users\mateusanez\.m2\repository\com\twelvemonkeys\common\common-lang\3.12.0\common-lang-3.12.0.jar
::com.twelvemonkeys.common:common-io:jar -> C:\Users\mateusanez\.m2\repository\com\twelvemonkeys\common\common-io\3.12.0\common-io-3.12.0.jar
::com.twelvemonkeys.common:common-image:jar -> C:\Users\mateusanez\.m2\repository\com\twelvemonkeys\common\common-image\3.12.0\common-image-3.12.0.jar
::org.apache.poi:poi:jar -> C:\Users\mateusanez\.m2\repository\org\apache\poi\poi\5.4.1\poi-5.4.1.jar
::org.apache.commons:commons-math3:jar -> C:\Users\mateusanez\.m2\repository\org\apache\commons\commons-math3\3.6.1\commons-math3-3.6.1.jar
::com.zaxxer:SparseBitSet:jar -> C:\Users\mateusanez\.m2\repository\com\zaxxer\SparseBitSet\1.3\SparseBitSet-1.3.jar
::org.apache.poi:poi-ooxml:jar -> C:\Users\mateusanez\.m2\repository\org\apache\poi\poi-ooxml\5.4.1\poi-ooxml-5.4.1.jar
::org.apache.poi:poi-ooxml-lite:jar -> C:\Users\mateusanez\.m2\repository\org\apache\poi\poi-ooxml-lite\5.4.1\poi-ooxml-lite-5.4.1.jar
::org.apache.xmlbeans:xmlbeans:jar -> C:\Users\mateusanez\.m2\repository\org\apache\xmlbeans\xmlbeans\5.3.0\xmlbeans-5.3.0.jar
::com.github.virtuald:curvesapi:jar -> C:\Users\mateusanez\.m2\repository\com\github\virtuald\curvesapi\1.08\curvesapi-1.08.jar
::org.apache.commons:commons-compress:jar -> C:\Users\mateusanez\.m2\repository\org\apache\commons\commons-compress\1.27.1\commons-compress-1.27.1.jar
::br.gov.mec.aghu-core:aghu-core-business:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-core\aghu-core-business\8.0.22\aghu-core-business-8.0.22.jar
::org.apache.commons:commons-jexl3:jar -> C:\Users\mateusanez\.m2\repository\org\apache\commons\commons-jexl3\3.4.0\commons-jexl3-3.4.0.jar
::org.jboss.ejb3:jboss-ejb3-ext-api:jar -> C:\Users\mateusanez\.m2\repository\org\jboss\ejb3\jboss-ejb3-ext-api\2.3.0.Final\jboss-ejb3-ext-api-2.3.0.Final.jar
::org.apache.lucene:lucene-queryparser:jar -> C:\Users\mateusanez\.m2\repository\org\apache\lucene\lucene-queryparser\5.5.5\lucene-queryparser-5.5.5.jar
::org.apache.lucene:lucene-core:jar -> C:\Users\mateusanez\.m2\repository\org\apache\lucene\lucene-core\5.5.5\lucene-core-5.5.5.jar
::org.apache.lucene:lucene-queries:jar -> C:\Users\mateusanez\.m2\repository\org\apache\lucene\lucene-queries\5.5.5\lucene-queries-5.5.5.jar
::br.gov.mec:aghu-web:war -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-web\13.262-STABLE\aghu-web-13.262-STABLE.war
::br.gov.mec:aghu-api-web:war -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-api-web\13.262-STABLE\aghu-api-web-13.262-STABLE.war
::br.gov.mec:aghu-api-jwt-web:war -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-api-jwt-web\13.262-STABLE\aghu-api-jwt-web-13.262-STABLE.war
::br.gov.mec:aghu-pesquisa-web:war -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-pesquisa-web\13.262-STABLE\aghu-pesquisa-web-13.262-STABLE.war
::br.gov.mec:aghu-mobile-web:war -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-mobile-web\13.262-STABLE\aghu-mobile-web-13.262-STABLE.war
::br.gov.mec:aghu-persistence:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-persistence\13.262-STABLE\aghu-persistence-13.262-STABLE.jar
::br.gov.mec:aghu-envers:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-envers\2.0.2\aghu-envers-2.0.2.jar
::br.gov.mec:aghu-casca:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-casca\13.262-STABLE\aghu-casca-13.262-STABLE.jar
::br.gov.mec:aghu-casca-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-casca-client\13.262-STABLE\aghu-casca-client-13.262-STABLE.jar
::br.gov.mec:aghu-registrocolaborador:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-registrocolaborador\13.262-STABLE\aghu-registrocolaborador-13.262-STABLE.jar
::br.gov.mec:aghu-integracao-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-integracao-client\13.262-STABLE\aghu-integracao-client-13.262-STABLE.jar
::javax.xml.ws:jaxws-api:jar -> C:\Users\mateusanez\.m2\repository\javax\xml\ws\jaxws-api\2.3.1\jaxws-api-2.3.1.jar
::javax.xml.soap:javax.xml.soap-api:jar -> C:\Users\mateusanez\.m2\repository\javax\xml\soap\javax.xml.soap-api\1.4.0\javax.xml.soap-api-1.4.0.jar
::br.gov.mec:aghu-registrocolaborador-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-registrocolaborador-client\13.262-STABLE\aghu-registrocolaborador-client-13.262-STABLE.jar
::br.gov.mec:aghu-bancoleitehumano:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-bancoleitehumano\13.262-STABLE\aghu-bancoleitehumano-13.262-STABLE.jar
::br.gov.mec:aghu-bancoleitehumano-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-bancoleitehumano-client\13.262-STABLE\aghu-bancoleitehumano-client-13.262-STABLE.jar
::br.gov.mec:aghu-financeiro:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-financeiro\13.262-STABLE\aghu-financeiro-13.262-STABLE.jar
::br.gov.mec:aghu-financeiro-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-financeiro-client\13.262-STABLE\aghu-financeiro-client-13.262-STABLE.jar
::br.gov.mec:aghu-escalas-enfermagem:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-escalas-enfermagem\13.262-STABLE\aghu-escalas-enfermagem-13.262-STABLE.jar
::br.gov.mec:aghu-escalas-enfermagem-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-escalas-enfermagem-client\13.262-STABLE\aghu-escalas-enfermagem-client-13.262-STABLE.jar
::br.gov.mec:aghu-escalas-profissionais:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-escalas-profissionais\13.262-STABLE\aghu-escalas-profissionais-13.262-STABLE.jar
::br.gov.mec:aghu-escalas-profissionais-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-escalas-profissionais-client\13.262-STABLE\aghu-escalas-profissionais-client-13.262-STABLE.jar
::br.gov.mec:aghu-registrocolaborador-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-registrocolaborador-service\13.262-STABLE\aghu-registrocolaborador-service-13.262-STABLE.jar
::br.gov.mec.aghu-core:aghu-core-service:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-core\aghu-core-service\8.0.16\aghu-core-service-8.0.16.jar
::io.swagger.core.v3:swagger-jaxrs2:jar -> C:\Users\mateusanez\.m2\repository\io\swagger\core\v3\swagger-jaxrs2\2.2.30\swagger-jaxrs2-2.2.30.jar
::io.swagger.core.v3:swagger-models:jar -> C:\Users\mateusanez\.m2\repository\io\swagger\core\v3\swagger-models\2.2.30\swagger-models-2.2.30.jar
::org.yaml:snakeyaml:jar -> C:\Users\mateusanez\.m2\repository\org\yaml\snakeyaml\2.3\snakeyaml-2.3.jar
::io.swagger.core.v3:swagger-annotations:jar -> C:\Users\mateusanez\.m2\repository\io\swagger\core\v3\swagger-annotations\2.2.30\swagger-annotations-2.2.30.jar
::io.swagger.core.v3:swagger-integration:jar -> C:\Users\mateusanez\.m2\repository\io\swagger\core\v3\swagger-integration\2.2.30\swagger-integration-2.2.30.jar
::io.swagger.core.v3:swagger-core:jar -> C:\Users\mateusanez\.m2\repository\io\swagger\core\v3\swagger-core\2.2.30\swagger-core-2.2.30.jar
::jakarta.validation:jakarta.validation-api:jar -> C:\Users\mateusanez\.m2\repository\jakarta\validation\jakarta.validation-api\2.0.2\jakarta.validation-api-2.0.2.jar
::org.jboss.spec.javax.ws.rs:jboss-jaxrs-api_2.1_spec:jar -> C:\Users\mateusanez\.m2\repository\org\jboss\spec\javax\ws\rs\jboss-jaxrs-api_2.1_spec\2.0.2.Final\jboss-jaxrs-api_2.1_spec-2.0.2.Final.jar
::org.mapstruct:mapstruct:jar -> C:\Users\mateusanez\.m2\repository\org\mapstruct\mapstruct\1.6.3\mapstruct-1.6.3.jar
::br.gov.mec:aghu-transporte-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-transporte-service\13.262-STABLE\aghu-transporte-service-13.262-STABLE.jar
::br.gov.mec:aghu-pesquisa-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-pesquisa-service\13.262-STABLE\aghu-pesquisa-service-13.262-STABLE.jar
::br.gov.mec:aghu-paciente-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-paciente-service\13.262-STABLE\aghu-paciente-service-13.262-STABLE.jar
::br.gov.mec:aghu-paciente:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-paciente\13.262-STABLE\aghu-paciente-13.262-STABLE.jar
::br.gov.mec:aghu-paciente-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-paciente-client\13.262-STABLE\aghu-paciente-client-13.262-STABLE.jar
::org.jfree:jfreechart:jar -> C:\Users\mateusanez\.m2\repository\org\jfree\jfreechart\1.5.5\jfreechart-1.5.5.jar
::org.apache.commons:commons-csv:jar -> C:\Users\mateusanez\.m2\repository\org\apache\commons\commons-csv\1.14.0\commons-csv-1.14.0.jar
::org.jboss.spec.javax.enterprise.concurrent:jboss-concurrency-api_1.0_spec:jar -> C:\Users\mateusanez\.m2\repository\org\jboss\spec\javax\enterprise\concurrent\jboss-concurrency-api_1.0_spec\2.0.0.Final\jboss-concurrency-api_1.0_spec-2.0.0.Final.jar
::br.gov.mec:aghu-pesquisa:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-pesquisa\13.262-STABLE\aghu-pesquisa-13.262-STABLE.jar
::br.edu.hcpa:lattes-proxy:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\lattes-proxy\0.0.1\lattes-proxy-0.0.1.jar
::br.gov.mec:aghu-pesquisa-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-pesquisa-client\13.262-STABLE\aghu-pesquisa-client-13.262-STABLE.jar
::org.apache.commons:commons-email:jar -> C:\Users\mateusanez\.m2\repository\org\apache\commons\commons-email\1.6.0\commons-email-1.6.0.jar
::com.sun.mail:jakarta.mail:jar -> C:\Users\mateusanez\.m2\repository\com\sun\mail\jakarta.mail\1.6.7\jakarta.mail-1.6.7.jar
::commons-io:commons-io:jar -> C:\Users\mateusanez\.m2\repository\commons-io\commons-io\2.19.0\commons-io-2.19.0.jar
::br.gov.mec:aghu-api-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-api-service\13.262-STABLE\aghu-api-service-13.262-STABLE.jar
::br.gov.mec:aghu-internacao:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-internacao\13.262-STABLE\aghu-internacao-13.262-STABLE.jar
::br.gov.mec:aghu-internacao-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-internacao-client\13.262-STABLE\aghu-internacao-client-13.262-STABLE.jar
::br.gov.mec:aghu-configuracao:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-configuracao\13.262-STABLE\aghu-configuracao-13.262-STABLE.jar
::br.gov.mec:aghu-configuracao-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-configuracao-client\13.262-STABLE\aghu-configuracao-client-13.262-STABLE.jar
::org.apache.commons:commons-rng-simple:jar -> C:\Users\mateusanez\.m2\repository\org\apache\commons\commons-rng-simple\1.5\commons-rng-simple-1.5.jar
::org.apache.commons:commons-rng-client-api:jar -> C:\Users\mateusanez\.m2\repository\org\apache\commons\commons-rng-client-api\1.5\commons-rng-client-api-1.5.jar
::org.apache.commons:commons-rng-core:jar -> C:\Users\mateusanez\.m2\repository\org\apache\commons\commons-rng-core\1.5\commons-rng-core-1.5.jar
::org.jeasy:easy-random-core:jar -> C:\Users\mateusanez\.m2\repository\org\jeasy\easy-random-core\5.0.0\easy-random-core-5.0.0.jar
::org.objenesis:objenesis:jar -> C:\Users\mateusanez\.m2\repository\org\objenesis\objenesis\3.1\objenesis-3.1.jar
::io.github.classgraph:classgraph:jar -> C:\Users\mateusanez\.m2\repository\io\github\classgraph\classgraph\4.8.90\classgraph-4.8.90.jar
::br.gov.mec:aghu-certificacaodigital:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-certificacaodigital\13.262-STABLE\aghu-certificacaodigital-13.262-STABLE.jar
::br.gov.mec:aghu-certificacaodigital-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-certificacaodigital-client\13.262-STABLE\aghu-certificacaodigital-client-13.262-STABLE.jar
::sun.com:sunpksc11:jar -> C:\Users\mateusanez\.m2\repository\sun\com\sunpksc11\1.0\sunpksc11-1.0.jar
::br.ufrgs.hcpa:crypto-spongy-api:jar -> C:\Users\mateusanez\.m2\repository\br\ufrgs\hcpa\crypto-spongy-api\3.0.1\crypto-spongy-api-3.0.1.jar
::com.madgag:scprov-jdk15on:jar -> C:\Users\mateusanez\.m2\repository\com\madgag\scprov-jdk15on\1.47.0.2\scprov-jdk15on-1.47.0.2.jar
::com.madgag:sc-light-jdk15on:jar -> C:\Users\mateusanez\.m2\repository\com\madgag\sc-light-jdk15on\1.47.0.2\sc-light-jdk15on-1.47.0.2.jar
::com.madgag:scpkix-jdk15on:jar -> C:\Users\mateusanez\.m2\repository\com\madgag\scpkix-jdk15on\1.47.0.2\scpkix-jdk15on-1.47.0.2.jar
::com.madgag:scmail-jdk15on:jar -> C:\Users\mateusanez\.m2\repository\com\madgag\scmail-jdk15on\1.47.0.2\scmail-jdk15on-1.47.0.2.jar
::br.gov.mec:aghu-timerservice:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-timerservice\13.262-STABLE\aghu-timerservice-13.262-STABLE.jar
::br.gov.mec:aghu-timerservice-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-timerservice-client\13.262-STABLE\aghu-timerservice-client-13.262-STABLE.jar
::net.oneandone.reflections8:reflections8:jar -> C:\Users\mateusanez\.m2\repository\net\oneandone\reflections8\reflections8\0.11.7\reflections8-0.11.7.jar
::org.javassist:javassist:jar -> C:\Users\mateusanez\.m2\repository\org\javassist\javassist\3.27.0-GA\javassist-3.27.0-GA.jar
::br.gov.mec:aghu-certificacaodigital-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-certificacaodigital-service\13.262-STABLE\aghu-certificacaodigital-service-13.262-STABLE.jar
::br.gov.mec:aghu-casca-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-casca-service\13.262-STABLE\aghu-casca-service-13.262-STABLE.jar
::br.gov.mec:aghu-estoque-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-estoque-service\13.262-STABLE\aghu-estoque-service-13.262-STABLE.jar
::br.gov.mec:aghu-prescricaomedica-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-prescricaomedica-service\13.262-STABLE\aghu-prescricaomedica-service-13.262-STABLE.jar
::br.gov.mec:aghu-configuracao-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-configuracao-service\13.262-STABLE\aghu-configuracao-service-13.262-STABLE.jar
::br.gov.mec:aghu-entidades:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-entidades\13.262-STABLE\aghu-entidades-13.262-STABLE.jar
::br.ufrgs.inf.proschedulersolver:communicator-model:jar -> C:\Users\mateusanez\.m2\repository\br\ufrgs\inf\proschedulersolver\communicator-model\0.0.13\communicator-model-0.0.13.jar
::com.esotericsoftware:kryo:jar -> C:\Users\mateusanez\.m2\repository\com\esotericsoftware\kryo\5.0.0\kryo-5.0.0.jar
::com.esotericsoftware:reflectasm:jar -> C:\Users\mateusanez\.m2\repository\com\esotericsoftware\reflectasm\1.11.8\reflectasm-1.11.8.jar
::com.esotericsoftware:minlog:jar -> C:\Users\mateusanez\.m2\repository\com\esotericsoftware\minlog\1.3.1\minlog-1.3.1.jar
::org.apache.groovy:groovy-all:pom -> C:\Users\mateusanez\.m2\repository\org\apache\groovy\groovy-all\4.0.26\groovy-all-4.0.26.pom
::org.apache.groovy:groovy:jar -> C:\Users\mateusanez\.m2\repository\org\apache\groovy\groovy\4.0.26\groovy-4.0.26.jar
::org.apache.groovy:groovy-datetime:jar -> C:\Users\mateusanez\.m2\repository\org\apache\groovy\groovy-datetime\4.0.26\groovy-datetime-4.0.26.jar
::org.apache.groovy:groovy-json:jar -> C:\Users\mateusanez\.m2\repository\org\apache\groovy\groovy-json\4.0.26\groovy-json-4.0.26.jar
::org.apache.groovy:groovy-jsr223:jar -> C:\Users\mateusanez\.m2\repository\org\apache\groovy\groovy-jsr223\4.0.26\groovy-jsr223-4.0.26.jar
::org.apache.groovy:groovy-nio:jar -> C:\Users\mateusanez\.m2\repository\org\apache\groovy\groovy-nio\4.0.26\groovy-nio-4.0.26.jar
::org.apache.groovy:groovy-templates:jar -> C:\Users\mateusanez\.m2\repository\org\apache\groovy\groovy-templates\4.0.26\groovy-templates-4.0.26.jar
::org.apache.groovy:groovy-xml:jar -> C:\Users\mateusanez\.m2\repository\org\apache\groovy\groovy-xml\4.0.26\groovy-xml-4.0.26.jar
::org.apache.groovy:groovy-yaml:jar -> C:\Users\mateusanez\.m2\repository\org\apache\groovy\groovy-yaml\4.0.26\groovy-yaml-4.0.26.jar
::com.fasterxml.jackson.dataformat:jackson-dataformat-yaml:jar -> C:\Users\mateusanez\.m2\repository\com\fasterxml\jackson\dataformat\jackson-dataformat-yaml\2.18.2\jackson-dataformat-yaml-2.18.2.jar
::com.fasterxml.jackson.core:jackson-databind:jar -> C:\Users\mateusanez\.m2\repository\com\fasterxml\jackson\core\jackson-databind\2.16.1\jackson-databind-2.16.1.jar
::br.gov.mec:aghu-vo:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-vo\13.262-STABLE\aghu-vo-13.262-STABLE.jar
::org.opensaml:opensaml:jar -> C:\Users\mateusanez\.m2\repository\org\opensaml\opensaml\2.6.4\opensaml-2.6.4.jar
::commons-collections:commons-collections:jar -> C:\Users\mateusanez\.m2\repository\commons-collections\commons-collections\3.2.1\commons-collections-3.2.1.jar
::commons-lang:commons-lang:jar -> C:\Users\mateusanez\.m2\repository\commons-lang\commons-lang\2.6\commons-lang-2.6.jar
::org.apache.velocity:velocity:jar -> C:\Users\mateusanez\.m2\repository\org\apache\velocity\velocity\1.7\velocity-1.7.jar
::org.owasp.esapi:esapi:jar -> C:\Users\mateusanez\.m2\repository\org\owasp\esapi\esapi\2.0.1\esapi-2.0.1.jar
::org.apache.santuario:xmlsec:jar -> C:\Users\mateusanez\.m2\repository\org\apache\santuario\xmlsec\1.5.7\xmlsec-1.5.7.jar
::org.opensaml:openws:jar -> C:\Users\mateusanez\.m2\repository\org\opensaml\openws\1.5.4\openws-1.5.4.jar
::org.opensaml:xmltooling:jar -> C:\Users\mateusanez\.m2\repository\org\opensaml\xmltooling\1.4.4\xmltooling-1.4.4.jar
::ca.juliusdavies:not-yet-commons-ssl:jar -> C:\Users\mateusanez\.m2\repository\ca\juliusdavies\not-yet-commons-ssl\0.3.9\not-yet-commons-ssl-0.3.9.jar
::commons-httpclient:commons-httpclient:jar -> C:\Users\mateusanez\.m2\repository\commons-httpclient\commons-httpclient\3.1\commons-httpclient-3.1.jar
::br.gov.mec:aghu-administracao:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-administracao\13.262-STABLE\aghu-administracao-13.262-STABLE.jar
::br.gov.mec:aghu-administracao-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-administracao-client\13.262-STABLE\aghu-administracao-client-13.262-STABLE.jar
::br.gov.mec:aghu-administracao-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-administracao-service\13.262-STABLE\aghu-administracao-service-13.262-STABLE.jar
::br.gov.mec:aghu-escalas-profissionais-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-escalas-profissionais-service\13.262-STABLE\aghu-escalas-profissionais-service-13.262-STABLE.jar
::br.gov.mec:aghu-faturamento-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-faturamento-service\13.262-STABLE\aghu-faturamento-service-13.262-STABLE.jar
::br.gov.mec:aghu-compras-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-compras-service\13.262-STABLE\aghu-compras-service-13.262-STABLE.jar
::br.gov.mec:aghu-emergencia:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-emergencia\13.262-STABLE\aghu-emergencia-13.262-STABLE.jar
::br.gov.mec:aghu-emergencia-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-emergencia-client\13.262-STABLE\aghu-emergencia-client-13.262-STABLE.jar
::br.gov.mec:aghu-ambulatorio:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-ambulatorio\13.262-STABLE\aghu-ambulatorio-13.262-STABLE.jar
::br.gov.mec:aghu-ambulatorio-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-ambulatorio-client\13.262-STABLE\aghu-ambulatorio-client-13.262-STABLE.jar
::thrif-aghu-esus:thrif-aghu-esus:jar -> C:\Users\mateusanez\.m2\repository\thrif-aghu-esus\thrif-aghu-esus\1.0.0\thrif-aghu-esus-1.0.0.jar
::org.apache.thrift:libthrift:jar -> C:\Users\mateusanez\.m2\repository\org\apache\thrift\libthrift\0.9.2\libthrift-0.9.2.jar
::br.gov.mec:aghu-ambulatorio-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-ambulatorio-service\13.262-STABLE\aghu-ambulatorio-service-13.262-STABLE.jar
::br.gov.mec:aghu-bancosangue-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-bancosangue-service\13.262-STABLE\aghu-bancosangue-service-13.262-STABLE.jar
::br.gov.mec:aghu-emergencia-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-emergencia-service\13.262-STABLE\aghu-emergencia-service-13.262-STABLE.jar
::br.gov.mec:aghu-bancosangue:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-bancosangue\13.262-STABLE\aghu-bancosangue-13.262-STABLE.jar
::br.gov.mec:aghu-bancosangue-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-bancosangue-client\13.262-STABLE\aghu-bancosangue-client-13.262-STABLE.jar
::br.gov.mec:aghu-blococirurgico:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-blococirurgico\13.262-STABLE\aghu-blococirurgico-13.262-STABLE.jar
::br.gov.mec:aghu-blococirurgico-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-blococirurgico-client\13.262-STABLE\aghu-blococirurgico-client-13.262-STABLE.jar
::br.gov.mec:aghu-centrocusto:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-centrocusto\13.262-STABLE\aghu-centrocusto-13.262-STABLE.jar
::br.gov.mec:aghu-centrocusto-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-centrocusto-client\13.262-STABLE\aghu-centrocusto-client-13.262-STABLE.jar
::br.gov.mec:aghu-centrocusto-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-centrocusto-service\13.262-STABLE\aghu-centrocusto-service-13.262-STABLE.jar
::br.gov.mec:aghu-farmacia-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-farmacia-service\13.262-STABLE\aghu-farmacia-service-13.262-STABLE.jar
::br.gov.mec:aghu-blococirurgico-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-blococirurgico-service\13.262-STABLE\aghu-blococirurgico-service-13.262-STABLE.jar
::br.gov.mec:aghu-checagemeletronica:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-checagemeletronica\13.262-STABLE\aghu-checagemeletronica-13.262-STABLE.jar
::br.gov.mec:aghu-checagemeletronica-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-checagemeletronica-client\13.262-STABLE\aghu-checagemeletronica-client-13.262-STABLE.jar
::br.gov.mec:aghu-comissoes:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-comissoes\13.262-STABLE\aghu-comissoes-13.262-STABLE.jar
::br.gov.mec:aghu-comissoes-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-comissoes-client\13.262-STABLE\aghu-comissoes-client-13.262-STABLE.jar
::br.gov.mec:aghu-compras:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-compras\13.262-STABLE\aghu-compras-13.262-STABLE.jar
::br.gov.mec:aghu-compras-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-compras-client\13.262-STABLE\aghu-compras-client-13.262-STABLE.jar
::br.gov.mec:aghu-abstract:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-abstract\4.0\aghu-abstract-4.0.jar
::commons-net:commons-net:jar -> C:\Users\mateusanez\.m2\repository\commons-net\commons-net\3.11.1\commons-net-3.11.1.jar
::org.antlr:antlr-runtime:jar -> C:\Users\mateusanez\.m2\repository\org\antlr\antlr-runtime\3.5.2\antlr-runtime-3.5.2.jar
::org.antlr:stringtemplate:jar -> C:\Users\mateusanez\.m2\repository\org\antlr\stringtemplate\3.2.1\stringtemplate-3.2.1.jar
::antlr:antlr:jar -> C:\Users\mateusanez\.m2\repository\antlr\antlr\2.7.7\antlr-2.7.7.jar
::br.gov.mec:aghu-controleinfeccao:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-controleinfeccao\13.262-STABLE\aghu-controleinfeccao-13.262-STABLE.jar
::br.gov.mec:aghu-controleinfeccao-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-controleinfeccao-client\13.262-STABLE\aghu-controleinfeccao-client-13.262-STABLE.jar
::br.gov.mec:aghu-controlepaciente:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-controlepaciente\13.262-STABLE\aghu-controlepaciente-13.262-STABLE.jar
::br.gov.mec:aghu-controlepaciente-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-controlepaciente-client\13.262-STABLE\aghu-controlepaciente-client-13.262-STABLE.jar
::br.gov.mec:aghu-estoque:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-estoque\13.262-STABLE\aghu-estoque-13.262-STABLE.jar
::br.gov.mec:aghu-estoque-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-estoque-client\13.262-STABLE\aghu-estoque-client-13.262-STABLE.jar
::br.ufrgs.hcpa:NFe_PL_006g:jar -> C:\Users\mateusanez\.m2\repository\br\ufrgs\hcpa\NFe_PL_006g\2.00.006g\NFe_PL_006g-2.00.006g.jar
::br.ufrgs.hcpa:sce-nfe:jar -> C:\Users\mateusanez\.m2\repository\br\ufrgs\hcpa\sce-nfe\3.20\sce-nfe-3.20.jar
::br.ufrgs.hcpa:NFe_PL_008d:jar -> C:\Users\mateusanez\.m2\repository\br\ufrgs\hcpa\NFe_PL_008d\3.10.008d\NFe_PL_008d-3.10.008d.jar
::javax.mail:mail:jar -> C:\Users\mateusanez\.m2\repository\javax\mail\mail\1.4\mail-1.4.jar
::javax.activation:activation:jar -> C:\Users\mateusanez\.m2\repository\javax\activation\activation\1.1\activation-1.1.jar
::br.edu.hcpa:sefaz-rs-proxy:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\sefaz-rs-proxy\0.0.2\sefaz-rs-proxy-0.0.2.jar
::br.gov.mec:aghu-patrimonio:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-patrimonio\13.262-STABLE\aghu-patrimonio-13.262-STABLE.jar
::br.gov.mec:aghu-patrimonio-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-patrimonio-client\13.262-STABLE\aghu-patrimonio-client-13.262-STABLE.jar
::net.sourceforge.barbecue:barbecue:jar -> C:\Users\mateusanez\.m2\repository\net\sourceforge\barbecue\barbecue\1.5-beta1\barbecue-1.5-beta1.jar
::asm:asm:jar -> C:\Users\mateusanez\.m2\repository\asm\asm\1.5.3\asm-1.5.3.jar
::org.codehaus.jettison:jettison:jar -> C:\Users\mateusanez\.m2\repository\org\codehaus\jettison\jettison\1.5.4\jettison-1.5.4.jar
::org.freemarker:freemarker:jar -> C:\Users\mateusanez\.m2\repository\org\freemarker\freemarker\2.3.32\freemarker-2.3.32.jar
::org.jfree:jcommon:jar -> C:\Users\mateusanez\.m2\repository\org\jfree\jcommon\1.0.24\jcommon-1.0.24.jar
::javax.mail:javax.mail-api:jar -> C:\Users\mateusanez\.m2\repository\javax\mail\javax.mail-api\1.6.2\javax.mail-api-1.6.2.jar
::br.gov.mec:aghu-coreme:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-coreme\13.262-STABLE\aghu-coreme-13.262-STABLE.jar
::br.gov.mec:aghu-coreme-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-coreme-client\13.262-STABLE\aghu-coreme-client-13.262-STABLE.jar
::br.gov.mec:aghu-investimentos:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-investimentos\13.262-STABLE\aghu-investimentos-13.262-STABLE.jar
::br.gov.mec:aghu-investimentos-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-investimentos-client\13.262-STABLE\aghu-investimentos-client-13.262-STABLE.jar
::br.gov.mec:aghu-transplante:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-transplante\13.262-STABLE\aghu-transplante-13.262-STABLE.jar
::br.gov.mec:aghu-transplante-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-transplante-client\13.262-STABLE\aghu-transplante-client-13.262-STABLE.jar
::br.gov.mec:aghu-transporte:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-transporte\13.262-STABLE\aghu-transporte-13.262-STABLE.jar
::br.gov.mec:aghu-transporte-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-transporte-client\13.262-STABLE\aghu-transporte-client-13.262-STABLE.jar
::br.gov.mec:aghu-contasreceber:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-contasreceber\13.262-STABLE\aghu-contasreceber-13.262-STABLE.jar
::br.gov.mec:aghu-contasreceber-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-contasreceber-client\13.262-STABLE\aghu-contasreceber-client-13.262-STABLE.jar
::br.gov.mec:aghu-engenharia:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-engenharia\13.262-STABLE\aghu-engenharia-13.262-STABLE.jar
::br.gov.mec:aghu-engenharia-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-engenharia-client\13.262-STABLE\aghu-engenharia-client-13.262-STABLE.jar
::br.gov.mec:aghu-exames:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-exames\13.262-STABLE\aghu-exames-13.262-STABLE.jar
::br.gov.mec:aghu-exames-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-exames-client\13.262-STABLE\aghu-exames-client-13.262-STABLE.jar
::net.sourceforge.dynamicreports:dynamicreports-core:jar -> C:\Users\mateusanez\.m2\repository\net\sourceforge\dynamicreports\dynamicreports-core\6.12.1\dynamicreports-core-6.12.1.jar
::com.google.zxing:core:jar -> C:\Users\mateusanez\.m2\repository\com\google\zxing\core\3.3.3\core-3.3.3.jar
::net.sf.barcode4j:barcode4j:jar -> C:\Users\mateusanez\.m2\repository\net\sf\barcode4j\barcode4j\2.1\barcode4j-2.1.jar
::avalon-framework:avalon-framework-impl:jar -> C:\Users\mateusanez\.m2\repository\avalon-framework\avalon-framework-impl\4.2.0\avalon-framework-impl-4.2.0.jar
::commons-cli:commons-cli:jar -> C:\Users\mateusanez\.m2\repository\commons-cli\commons-cli\1.4\commons-cli-1.4.jar
::org.apache.ant:ant:jar -> C:\Users\mateusanez\.m2\repository\org\apache\ant\ant\1.7.1\ant-1.7.1.jar
::org.apache.ant:ant-launcher:jar -> C:\Users\mateusanez\.m2\repository\org\apache\ant\ant-launcher\1.7.1\ant-launcher-1.7.1.jar
::br.gov.mec:aghu-exames-service:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-exames-service\13.262-STABLE\aghu-exames-service-13.262-STABLE.jar
::xerces:xercesImpl:jar -> C:\Users\mateusanez\.m2\repository\xerces\xercesImpl\2.12.0\xercesImpl-2.12.0.jar
::xml-apis:xml-apis:jar -> C:\Users\mateusanez\.m2\repository\xml-apis\xml-apis\1.4.01\xml-apis-1.4.01.jar
::com.sun.jersey:jersey-client:jar -> C:\Users\mateusanez\.m2\repository\com\sun\jersey\jersey-client\1.19.4\jersey-client-1.19.4.jar
::com.sun.jersey:jersey-core:jar -> C:\Users\mateusanez\.m2\repository\com\sun\jersey\jersey-core\1.19.4\jersey-core-1.19.4.jar
::javax.ws.rs:jsr311-api:jar -> C:\Users\mateusanez\.m2\repository\javax\ws\rs\jsr311-api\1.1.1\jsr311-api-1.1.1.jar
::com.sun.jersey.contribs:jersey-multipart:jar -> C:\Users\mateusanez\.m2\repository\com\sun\jersey\contribs\jersey-multipart\1.19.4\jersey-multipart-1.19.4.jar
::org.jvnet.mimepull:mimepull:jar -> C:\Users\mateusanez\.m2\repository\org\jvnet\mimepull\mimepull\1.9.3\mimepull-1.9.3.jar
::com.github.joschi.jackson:jackson-datatype-threetenbp:jar -> C:\Users\mateusanez\.m2\repository\com\github\joschi\jackson\jackson-datatype-threetenbp\2.6.4\jackson-datatype-threetenbp-2.6.4.jar
::org.threeten:threetenbp:jar -> C:\Users\mateusanez\.m2\repository\org\threeten\threetenbp\1.3.1\threetenbp-1.3.1.jar
::br.gov.mec:aghu-farmacia:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-farmacia\13.262-STABLE\aghu-farmacia-13.262-STABLE.jar
::br.gov.mec:aghu-farmacia-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-farmacia-client\13.262-STABLE\aghu-farmacia-client-13.262-STABLE.jar
::br.gov.mec:aghu-faturamento:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-faturamento\13.262-STABLE\aghu-faturamento-13.262-STABLE.jar
::br.gov.mec:aghu-faturamento-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-faturamento-client\13.262-STABLE\aghu-faturamento-client-13.262-STABLE.jar
::br.gov.mec:aghu-faturamento-convenio:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-faturamento-convenio\13.262-STABLE\aghu-faturamento-convenio-13.262-STABLE.jar
::br.gov.mec:aghu-faturamento-convenio-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-faturamento-convenio-client\13.262-STABLE\aghu-faturamento-convenio-client-13.262-STABLE.jar
::com.monitorjbl:xlsx-streamer:jar -> C:\Users\mateusanez\.m2\repository\com\monitorjbl\xlsx-streamer\3.0.0-HCPA\xlsx-streamer-3.0.0-HCPA.jar
::org.slf4j:slf4j-api:jar -> C:\Users\mateusanez\.m2\repository\org\slf4j\slf4j-api\1.7.36\slf4j-api-1.7.36.jar
::br.gov.mec:aghu-faturamento-batch:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-faturamento-batch\13.262-STABLE\aghu-faturamento-batch-13.262-STABLE.jar
::br.gov.mec:aghu-faturamento-batch-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-faturamento-batch-client\13.262-STABLE\aghu-faturamento-batch-client-13.262-STABLE.jar
::br.gov.mec:aghu-indicadores:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-indicadores\13.262-STABLE\aghu-indicadores-13.262-STABLE.jar
::br.gov.mec:aghu-indicadores-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-indicadores-client\13.262-STABLE\aghu-indicadores-client-13.262-STABLE.jar
::br.gov.mec:aghu-nutricao:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-nutricao\13.262-STABLE\aghu-nutricao-13.262-STABLE.jar
::br.gov.mec:aghu-nutricao-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-nutricao-client\13.262-STABLE\aghu-nutricao-client-13.262-STABLE.jar
::br.gov.mec:aghu-orcamento:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-orcamento\13.262-STABLE\aghu-orcamento-13.262-STABLE.jar
::br.gov.mec:aghu-orcamento-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-orcamento-client\13.262-STABLE\aghu-orcamento-client-13.262-STABLE.jar
::br.gov.mec:aghu-perinatologia:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-perinatologia\13.262-STABLE\aghu-perinatologia-13.262-STABLE.jar
::br.gov.mec:aghu-perinatologia-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-perinatologia-client\13.262-STABLE\aghu-perinatologia-client-13.262-STABLE.jar
::br.gov.mec:aghu-prescricaoenfermagem:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-prescricaoenfermagem\13.262-STABLE\aghu-prescricaoenfermagem-13.262-STABLE.jar
::br.gov.mec:aghu-prescricaoenfermagem-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-prescricaoenfermagem-client\13.262-STABLE\aghu-prescricaoenfermagem-client-13.262-STABLE.jar
::br.gov.mec:aghu-prescricaomedica:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-prescricaomedica\13.262-STABLE\aghu-prescricaomedica-13.262-STABLE.jar
::br.gov.mec:aghu-prescricaomedica-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-prescricaomedica-client\13.262-STABLE\aghu-prescricaomedica-client-13.262-STABLE.jar
::br.gov.mec:aghu-procedimentoterapeutico:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-procedimentoterapeutico\13.262-STABLE\aghu-procedimentoterapeutico-13.262-STABLE.jar
::br.gov.mec:aghu-procedimentoterapeutico-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-procedimentoterapeutico-client\13.262-STABLE\aghu-procedimentoterapeutico-client-13.262-STABLE.jar
::br.gov.mec:aghu-protocolos:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-protocolos\13.262-STABLE\aghu-protocolos-13.262-STABLE.jar
::br.gov.mec:aghu-protocolos-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-protocolos-client\13.262-STABLE\aghu-protocolos-client-13.262-STABLE.jar
::br.gov.mec:aghu-sicon:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-sicon\13.262-STABLE\aghu-sicon-13.262-STABLE.jar
::br.gov.mec:aghu-sicon-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-sicon-client\13.262-STABLE\aghu-sicon-client-13.262-STABLE.jar
::br.gov.mec:sicon-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\sicon-client\1.0.2-jdk17\sicon-client-1.0.2-jdk17.jar
::br.gov.mec:aghu-sig:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-sig\13.262-STABLE\aghu-sig-13.262-STABLE.jar
::br.gov.mec:aghu-sig-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-sig-client\13.262-STABLE\aghu-sig-client-13.262-STABLE.jar
::br.gov.mec:aghu-integracao:ejb -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-integracao\13.262-STABLE\aghu-integracao-13.262-STABLE.jar
::org.apache.solr:solr-solrj:jar -> C:\Users\mateusanez\.m2\repository\org\apache\solr\solr-solrj\9.6.1\solr-solrj-9.6.1.jar
::org.apache.solr:solr-api:jar -> C:\Users\mateusanez\.m2\repository\org\apache\solr\solr-api\9.6.1\solr-api-9.6.1.jar
::io.swagger.core.v3:swagger-annotations-jakarta:jar -> C:\Users\mateusanez\.m2\repository\io\swagger\core\v3\swagger-annotations-jakarta\2.2.20\swagger-annotations-jakarta-2.2.20.jar
::jakarta.ws.rs:jakarta.ws.rs-api:jar -> C:\Users\mateusanez\.m2\repository\jakarta\ws\rs\jakarta.ws.rs-api\3.1.0\jakarta.ws.rs-api-3.1.0.jar
::org.semver4j:semver4j:jar -> C:\Users\mateusanez\.m2\repository\org\semver4j\semver4j\5.2.3\semver4j-5.2.3.jar
::org.eclipse.jetty.http2:http2-client:jar -> C:\Users\mateusanez\.m2\repository\org\eclipse\jetty\http2\http2-client\10.0.20\http2-client-10.0.20.jar
::org.eclipse.jetty.http2:http2-common:jar -> C:\Users\mateusanez\.m2\repository\org\eclipse\jetty\http2\http2-common\10.0.20\http2-common-10.0.20.jar
::org.eclipse.jetty.http2:http2-hpack:jar -> C:\Users\mateusanez\.m2\repository\org\eclipse\jetty\http2\http2-hpack\10.0.20\http2-hpack-10.0.20.jar
::org.apache.httpcomponents:httpmime:jar -> C:\Users\mateusanez\.m2\repository\org\apache\httpcomponents\httpmime\4.5.14\httpmime-4.5.14.jar
::com.fasterxml.jackson.core:jackson-annotations:jar -> C:\Users\mateusanez\.m2\repository\com\fasterxml\jackson\core\jackson-annotations\2.16.1\jackson-annotations-2.16.1.jar
::org.eclipse.jetty.http2:http2-http-client-transport:jar -> C:\Users\mateusanez\.m2\repository\org\eclipse\jetty\http2\http2-http-client-transport\10.0.20\http2-http-client-transport-10.0.20.jar
::org.slf4j:jcl-over-slf4j:jar -> C:\Users\mateusanez\.m2\repository\org\slf4j\jcl-over-slf4j\1.7.36\jcl-over-slf4j-1.7.36.jar
::org.apache.solr:solr-solrj-streaming:jar -> C:\Users\mateusanez\.m2\repository\org\apache\solr\solr-solrj-streaming\9.6.1\solr-solrj-streaming-9.6.1.jar
::org.apache.solr:solr-solrj-zookeeper:jar -> C:\Users\mateusanez\.m2\repository\org\apache\solr\solr-solrj-zookeeper\9.6.1\solr-solrj-zookeeper-9.6.1.jar
::org.apache.zookeeper:zookeeper:jar -> C:\Users\mateusanez\.m2\repository\org\apache\zookeeper\zookeeper\3.9.1\zookeeper-3.9.1.jar
::io.netty:netty-tcnative-boringssl-static:jar -> C:\Users\mateusanez\.m2\repository\io\netty\netty-tcnative-boringssl-static\2.0.61.Final\netty-tcnative-boringssl-static-2.0.61.Final.jar
::io.netty:netty-tcnative-classes:jar -> C:\Users\mateusanez\.m2\repository\io\netty\netty-tcnative-classes\2.0.61.Final\netty-tcnative-classes-2.0.61.Final.jar
::io.netty:netty-tcnative-boringssl-static:jar:linux-x86_64 -> C:\Users\mateusanez\.m2\repository\io\netty\netty-tcnative-boringssl-static\2.0.61.Final\netty-tcnative-boringssl-static-2.0.61.Final-linux-x86_64.jar
::io.netty:netty-tcnative-boringssl-static:jar:linux-aarch_64 -> C:\Users\mateusanez\.m2\repository\io\netty\netty-tcnative-boringssl-static\2.0.61.Final\netty-tcnative-boringssl-static-2.0.61.Final-linux-aarch_64.jar
::io.netty:netty-tcnative-boringssl-static:jar:osx-x86_64 -> C:\Users\mateusanez\.m2\repository\io\netty\netty-tcnative-boringssl-static\2.0.61.Final\netty-tcnative-boringssl-static-2.0.61.Final-osx-x86_64.jar
::io.netty:netty-tcnative-boringssl-static:jar:osx-aarch_64 -> C:\Users\mateusanez\.m2\repository\io\netty\netty-tcnative-boringssl-static\2.0.61.Final\netty-tcnative-boringssl-static-2.0.61.Final-osx-aarch_64.jar
::io.netty:netty-tcnative-boringssl-static:jar:windows-x86_64 -> C:\Users\mateusanez\.m2\repository\io\netty\netty-tcnative-boringssl-static\2.0.61.Final\netty-tcnative-boringssl-static-2.0.61.Final-windows-x86_64.jar
::org.apache.zookeeper:zookeeper-jute:jar -> C:\Users\mateusanez\.m2\repository\org\apache\zookeeper\zookeeper-jute\3.9.1\zookeeper-jute-3.9.1.jar
::br.edu.hcpa:msv-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\msv-client\0.0.12\msv-client-0.0.12.jar
::br.edu.hcpa:dosewatch-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\dosewatch-client\0.0.1\dosewatch-client-0.0.1.jar
::br.edu.hcpa:vidaas-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\vidaas-client\1.0.9\vidaas-client-1.0.9.jar
::br.edu.hcpa:safeid-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\safeid-client\0.0.2a\safeid-client-0.0.2a.jar
::br.edu.hcpa:pagtesouro-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\pagtesouro-client\0.0.4\pagtesouro-client-0.0.4.jar
::br.com.qualitor:webservice:jar -> C:\Users\mateusanez\.m2\repository\br\com\qualitor\webservice\2.0\webservice-2.0.jar
::br.edu.hcpa:serpro-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\serpro-client\0.0.9\serpro-client-0.0.9.jar
::io.swagger:swagger-annotations:jar -> C:\Users\mateusanez\.m2\repository\io\swagger\swagger-annotations\1.5.15\swagger-annotations-1.5.15.jar
::com.fasterxml.jackson.jaxrs:jackson-jaxrs-json-provider:jar -> C:\Users\mateusanez\.m2\repository\com\fasterxml\jackson\jaxrs\jackson-jaxrs-json-provider\2.16.1\jackson-jaxrs-json-provider-2.16.1.jar
::com.fasterxml.jackson.jaxrs:jackson-jaxrs-base:jar -> C:\Users\mateusanez\.m2\repository\com\fasterxml\jackson\jaxrs\jackson-jaxrs-base\2.16.1\jackson-jaxrs-base-2.16.1.jar
::com.fasterxml.jackson.module:jackson-module-jaxb-annotations:jar -> C:\Users\mateusanez\.m2\repository\com\fasterxml\jackson\module\jackson-module-jaxb-annotations\2.16.1\jackson-module-jaxb-annotations-2.16.1.jar
::com.brsanthu:migbase64:jar -> C:\Users\mateusanez\.m2\repository\com\brsanthu\migbase64\2.2\migbase64-2.2.jar
::javax.ws.rs:javax.ws.rs-api:jar -> C:\Users\mateusanez\.m2\repository\javax\ws\rs\javax.ws.rs-api\2.1.1\javax.ws.rs-api-2.1.1.jar
::br.edu.hcpa:sispro-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\sispro-client\2.0.12\sispro-client-2.0.12.jar
::br.gov.mec:senior-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\senior-client\1.0.15-jdk17\senior-client-1.0.15-jdk17.jar
::com.sun.xml.ws:jaxws-ri:pom -> C:\Users\mateusanez\.m2\repository\com\sun\xml\ws\jaxws-ri\2.3.2\jaxws-ri-2.3.2.pom
::jakarta.annotation:jakarta.annotation-api:jar -> C:\Users\mateusanez\.m2\repository\jakarta\annotation\jakarta.annotation-api\1.3.4\jakarta.annotation-api-1.3.4.jar
::com.sun.xml.ws:jaxws-rt:jar -> C:\Users\mateusanez\.m2\repository\com\sun\xml\ws\jaxws-rt\2.3.2\jaxws-rt-2.3.2.jar
::com.sun.xml.ws:policy:jar -> C:\Users\mateusanez\.m2\repository\com\sun\xml\ws\policy\2.7.6\policy-2.7.6.jar
::org.glassfish.gmbal:gmbal:jar -> C:\Users\mateusanez\.m2\repository\org\glassfish\gmbal\gmbal\4.0.0\gmbal-4.0.0.jar
::org.glassfish.external:management-api:jar -> C:\Users\mateusanez\.m2\repository\org\glassfish\external\management-api\3.2.1\management-api-3.2.1.jar
::org.glassfish.pfl:pfl-basic:jar -> C:\Users\mateusanez\.m2\repository\org\glassfish\pfl\pfl-basic\4.0.1\pfl-basic-4.0.1.jar
::org.glassfish.pfl:pfl-tf:jar -> C:\Users\mateusanez\.m2\repository\org\glassfish\pfl\pfl-tf\4.0.1\pfl-tf-4.0.1.jar
::org.glassfish.pfl:pfl-asm:jar -> C:\Users\mateusanez\.m2\repository\org\glassfish\pfl\pfl-asm\4.0.1\pfl-asm-4.0.1.jar
::org.glassfish.pfl:pfl-dynamic:jar -> C:\Users\mateusanez\.m2\repository\org\glassfish\pfl\pfl-dynamic\4.0.1\pfl-dynamic-4.0.1.jar
::org.glassfish.pfl:pfl-basic-tools:jar -> C:\Users\mateusanez\.m2\repository\org\glassfish\pfl\pfl-basic-tools\4.0.1\pfl-basic-tools-4.0.1.jar
::org.glassfish.pfl:pfl-tf-tools:jar -> C:\Users\mateusanez\.m2\repository\org\glassfish\pfl\pfl-tf-tools\4.0.1\pfl-tf-tools-4.0.1.jar
::org.jvnet.staxex:stax-ex:jar -> C:\Users\mateusanez\.m2\repository\org\jvnet\staxex\stax-ex\1.8.1\stax-ex-1.8.1.jar
::com.sun.xml.stream.buffer:streambuffer:jar -> C:\Users\mateusanez\.m2\repository\com\sun\xml\stream\buffer\streambuffer\1.5.7\streambuffer-1.5.7.jar
::com.sun.xml.fastinfoset:FastInfoset:jar -> C:\Users\mateusanez\.m2\repository\com\sun\xml\fastinfoset\FastInfoset\1.2.16\FastInfoset-1.2.16.jar
::org.glassfish.ha:ha-api:jar -> C:\Users\mateusanez\.m2\repository\org\glassfish\ha\ha-api\3.1.12\ha-api-3.1.12.jar
::com.sun.xml.messaging.saaj:saaj-impl:jar -> C:\Users\mateusanez\.m2\repository\com\sun\xml\messaging\saaj\saaj-impl\1.5.1\saaj-impl-1.5.1.jar
::com.sun.xml.ws:jaxws-tools:jar -> C:\Users\mateusanez\.m2\repository\com\sun\xml\ws\jaxws-tools\2.3.2\jaxws-tools-2.3.2.jar
::com.sun.xml.bind:jaxb-xjc:jar -> C:\Users\mateusanez\.m2\repository\com\sun\xml\bind\jaxb-xjc\2.3.2\jaxb-xjc-2.3.2.jar
::com.sun.xml.bind:jaxb-jxc:jar -> C:\Users\mateusanez\.m2\repository\com\sun\xml\bind\jaxb-jxc\2.3.2\jaxb-jxc-2.3.2.jar
::jakarta.xml.ws:jakarta.xml.ws-api:jar -> C:\Users\mateusanez\.m2\repository\jakarta\xml\ws\jakarta.xml.ws-api\2.3.2\jakarta.xml.ws-api-2.3.2.jar
::jakarta.xml.soap:jakarta.xml.soap-api:jar -> C:\Users\mateusanez\.m2\repository\jakarta\xml\soap\jakarta.xml.soap-api\1.4.1\jakarta.xml.soap-api-1.4.1.jar
::jakarta.jws:jakarta.jws-api:jar -> C:\Users\mateusanez\.m2\repository\jakarta\jws\jakarta.jws-api\1.1.1\jakarta.jws-api-1.1.1.jar
::br.edu.hcpa:notification-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\notification-client\0.1.0\notification-client-0.1.0.jar
::br.edu.hcpa:medispan-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\medispan-client\0.0.8-jdk17\medispan-client-0.0.8-jdk17.jar
::br.edu.hcpa:file-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\file-client\0.0.16\file-client-0.0.16.jar
::br.gov.mec:rua-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\rua-client\2.0.20-jdk17\rua-client-2.0.20-jdk17.jar
::br.gov.mec:cadsus-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\cadsus-client\0.0.8-jdk17\cadsus-client-0.0.8-jdk17.jar
::br.gov.mec:siafi-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\siafi-client\0.0.33\siafi-client-0.0.33.jar
::br.ufrgs.hcpa:redeimagem-client:jar -> C:\Users\mateusanez\.m2\repository\br\ufrgs\hcpa\redeimagem-client\2.0.0\redeimagem-client-2.0.0.jar
::br.gov.mec:epimed-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\epimed-client\0.0.18b\epimed-client-0.0.18b.jar
::br.edu.hcpa:smspoa-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\smspoa-client\2.0.34\smspoa-client-2.0.34.jar
::br.edu.hcpa:npt-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\npt-client\0.0.14\npt-client-0.0.14.jar
::br.edu.hcpa:qualitor-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\qualitor-client\1.3-jdk17\qualitor-client-1.3-jdk17.jar
::org.apache.axis:axis:jar -> C:\Users\mateusanez\.m2\repository\org\apache\axis\axis\1.4\axis-1.4.jar
::org.apache.axis:axis-jaxrpc:jar -> C:\Users\mateusanez\.m2\repository\org\apache\axis\axis-jaxrpc\1.4\axis-jaxrpc-1.4.jar
::commons-discovery:commons-discovery:jar -> C:\Users\mateusanez\.m2\repository\commons-discovery\commons-discovery\0.4\commons-discovery-0.4.jar
::wsdl4j:wsdl4j:jar -> C:\Users\mateusanez\.m2\repository\wsdl4j\wsdl4j\1.6.2\wsdl4j-1.6.2.jar
::br.gov.mec:bionexo-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\bionexo-client\0.0.13\bionexo-client-0.0.13.jar
::br.ufrgs.inf.proschedulersolver:communicator-client:jar -> C:\Users\mateusanez\.m2\repository\br\ufrgs\inf\proschedulersolver\communicator-client\0.0.13\communicator-client-0.0.13.jar
::br.edu.hcpa:solis-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\solis-client\0.0.8-jdk17\solis-client-0.0.8-jdk17.jar
::br.gov.ba.saude:reds-client:jar -> C:\Users\mateusanez\.m2\repository\br\gov\ba\saude\reds-client\0.0.1\reds-client-0.0.1.jar
::org.apache.logging.log4j:log4j-core:jar -> C:\Users\mateusanez\.m2\repository\org\apache\logging\log4j\log4j-core\2.24.3\log4j-core-2.24.3.jar
::org.apache.logging.log4j:log4j-api:jar -> C:\Users\mateusanez\.m2\repository\org\apache\logging\log4j\log4j-api\2.24.3\log4j-api-2.24.3.jar
::com.fasterxml.jackson.core:jackson-core:jar -> C:\Users\mateusanez\.m2\repository\com\fasterxml\jackson\core\jackson-core\2.16.1\jackson-core-2.16.1.jar
::br.edu.hcpa:aghu-esb-core:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\aghu-esb-core\0.0.4\aghu-esb-core-0.0.4.jar
::org.nuxeo.client:nuxeo-java-client:jar -> C:\Users\mateusanez\.m2\repository\org\nuxeo\client\nuxeo-java-client\4.0.1\nuxeo-java-client-4.0.1.jar
::com.squareup.retrofit2:retrofit:jar -> C:\Users\mateusanez\.m2\repository\com\squareup\retrofit2\retrofit\2.11.0\retrofit-2.11.0.jar
::com.squareup.okhttp3:okhttp:jar -> C:\Users\mateusanez\.m2\repository\com\squareup\okhttp3\okhttp\4.12.0\okhttp-4.12.0.jar
::org.jetbrains.kotlin:kotlin-stdlib-jdk8:jar -> C:\Users\mateusanez\.m2\repository\org\jetbrains\kotlin\kotlin-stdlib-jdk8\1.8.21\kotlin-stdlib-jdk8-1.8.21.jar
::org.jetbrains.kotlin:kotlin-stdlib:jar -> C:\Users\mateusanez\.m2\repository\org\jetbrains\kotlin\kotlin-stdlib\1.8.21\kotlin-stdlib-1.8.21.jar
::org.jetbrains.kotlin:kotlin-stdlib-common:jar -> C:\Users\mateusanez\.m2\repository\org\jetbrains\kotlin\kotlin-stdlib-common\1.8.21\kotlin-stdlib-common-1.8.21.jar
::org.jetbrains:annotations:jar -> C:\Users\mateusanez\.m2\repository\org\jetbrains\annotations\13.0\annotations-13.0.jar
::org.jetbrains.kotlin:kotlin-stdlib-jdk7:jar -> C:\Users\mateusanez\.m2\repository\org\jetbrains\kotlin\kotlin-stdlib-jdk7\1.8.21\kotlin-stdlib-jdk7-1.8.21.jar
::com.squareup.okio:okio:jar -> C:\Users\mateusanez\.m2\repository\com\squareup\okio\okio\3.10.2\okio-3.10.2.jar
::com.squareup.okio:okio-jvm:jar -> C:\Users\mateusanez\.m2\repository\com\squareup\okio\okio-jvm\3.10.2\okio-jvm-3.10.2.jar
::org.apache.kafka:kafka-clients:jar -> C:\Users\mateusanez\.m2\repository\org\apache\kafka\kafka-clients\3.9.0\kafka-clients-3.9.0.jar
::com.github.luben:zstd-jni:jar -> C:\Users\mateusanez\.m2\repository\com\github\luben\zstd-jni\1.5.6-4\zstd-jni-1.5.6-4.jar
::org.lz4:lz4-java:jar -> C:\Users\mateusanez\.m2\repository\org\lz4\lz4-java\1.8.0\lz4-java-1.8.0.jar
::org.xerial.snappy:snappy-java:jar -> C:\Users\mateusanez\.m2\repository\org\xerial\snappy\snappy-java\1.1.10.5\snappy-java-1.1.10.5.jar
::com.google.code.gson:gson:jar -> C:\Users\mateusanez\.m2\repository\com\google\code\gson\gson\2.13.0\gson-2.13.0.jar
::com.google.errorprone:error_prone_annotations:jar -> C:\Users\mateusanez\.m2\repository\com\google\errorprone\error_prone_annotations\2.37.0\error_prone_annotations-2.37.0.jar
::org.webjars:font-awesome:jar -> C:\Users\mateusanez\.m2\repository\org\webjars\font-awesome\4.7.0\font-awesome-4.7.0.jar
::io.reactivex.rxjava3:rxjava:jar -> C:\Users\mateusanez\.m2\repository\io\reactivex\rxjava3\rxjava\3.1.10\rxjava-3.1.10.jar
::org.reactivestreams:reactive-streams:jar -> C:\Users\mateusanez\.m2\repository\org\reactivestreams\reactive-streams\1.0.3\reactive-streams-1.0.3.jar
::com.github.librepdf:openpdf:jar -> C:\Users\mateusanez\.m2\repository\com\github\librepdf\openpdf\2.0.3\openpdf-2.0.3.jar
::commons-codec:commons-codec:jar -> C:\Users\mateusanez\.m2\repository\commons-codec\commons-codec\1.15\commons-codec-1.15.jar
::org.hibernate:hibernate-search-orm:jar -> C:\Users\mateusanez\.m2\repository\org\hibernate\hibernate-search-orm\5.10.11.Final\hibernate-search-orm-5.10.11.Final.jar
::org.hibernate:hibernate-search-engine:jar -> C:\Users\mateusanez\.m2\repository\org\hibernate\hibernate-search-engine\5.10.11.Final\hibernate-search-engine-5.10.11.Final.jar
::org.hibernate.common:hibernate-commons-annotations:jar -> C:\Users\mateusanez\.m2\repository\org\hibernate\common\hibernate-commons-annotations\5.0.5.Final\hibernate-commons-annotations-5.0.5.Final.jar
::org.apache.lucene:lucene-misc:jar -> C:\Users\mateusanez\.m2\repository\org\apache\lucene\lucene-misc\5.5.5\lucene-misc-5.5.5.jar
::org.apache.lucene:lucene-analyzers-common:jar -> C:\Users\mateusanez\.m2\repository\org\apache\lucene\lucene-analyzers-common\5.5.5\lucene-analyzers-common-5.5.5.jar
::org.apache.lucene:lucene-facet:jar -> C:\Users\mateusanez\.m2\repository\org\apache\lucene\lucene-facet\5.5.5\lucene-facet-5.5.5.jar
::org.hibernate:hibernate-core:jar -> C:\Users\mateusanez\.m2\repository\org\hibernate\hibernate-core\5.3.24.Final\hibernate-core-5.3.24.Final.jar
::javax.persistence:javax.persistence-api:jar -> C:\Users\mateusanez\.m2\repository\javax\persistence\javax.persistence-api\2.2\javax.persistence-api-2.2.jar
::org.jboss.spec.javax.transaction:jboss-transaction-api_1.2_spec:jar -> C:\Users\mateusanez\.m2\repository\org\jboss\spec\javax\transaction\jboss-transaction-api_1.2_spec\1.1.1.Final\jboss-transaction-api_1.2_spec-1.1.1.Final.jar
::org.jboss:jandex:jar -> C:\Users\mateusanez\.m2\repository\org\jboss\jandex\2.4.2.Final\jandex-2.4.2.Final.jar
::com.fasterxml:classmate:jar -> C:\Users\mateusanez\.m2\repository\com\fasterxml\classmate\1.5.1\classmate-1.5.1.jar
::org.dom4j:dom4j:jar -> C:\Users\mateusanez\.m2\repository\org\dom4j\dom4j\2.1.3\dom4j-2.1.3.jar
::org.glassfish.jaxb:jaxb-runtime:jar -> C:\Users\mateusanez\.m2\repository\org\glassfish\jaxb\jaxb-runtime\2.3.3-b02-jbossorg-2\jaxb-runtime-2.3.3-b02-jbossorg-2.jar
::org.glassfish.jaxb:txw2:jar -> C:\Users\mateusanez\.m2\repository\org\glassfish\jaxb\txw2\2.3.3-b02-jbossorg-2\txw2-2.3.3-b02-jbossorg-2.jar
::com.sun.istack:istack-commons-runtime:jar -> C:\Users\mateusanez\.m2\repository\com\sun\istack\istack-commons-runtime\3.0.12\istack-commons-runtime-3.0.12.jar
::br.edu.hcpa:tiss-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\tiss-client\1.0.3\tiss-client-1.0.3.jar
::jakarta.xml.bind:jakarta.xml.bind-api:jar -> C:\Users\mateusanez\.m2\repository\jakarta\xml\bind\jakarta.xml.bind-api\2.3.3\jakarta.xml.bind-api-2.3.3.jar
::jakarta.activation:jakarta.activation-api:jar -> C:\Users\mateusanez\.m2\repository\jakarta\activation\jakarta.activation-api\1.2.2\jakarta.activation-api-1.2.2.jar
::br.edu.hcpa:csc-client:jar -> C:\Users\mateusanez\.m2\repository\br\edu\hcpa\csc-client\0.0.17\csc-client-0.0.17.jar
::log4j:log4j:jar -> C:\Users\mateusanez\.m2\repository\log4j\log4j\1.2.17\log4j-1.2.17.jar
::jakarta.persistence:jakarta.persistence-api:jar -> C:\Users\mateusanez\.m2\repository\jakarta\persistence\jakarta.persistence-api\2.2.3\jakarta.persistence-api-2.2.3.jar
::commons-beanutils:commons-beanutils:jar -> C:\Users\mateusanez\.m2\repository\commons-beanutils\commons-beanutils\1.9.4\commons-beanutils-1.9.4.jar
::org.hamcrest:hamcrest:jar -> C:\Users\mateusanez\.m2\repository\org\hamcrest\hamcrest\3.0\hamcrest-3.0.jar
::net.bytebuddy:byte-buddy:jar -> C:\Users\mateusanez\.m2\repository\net\bytebuddy\byte-buddy\1.15.0\byte-buddy-1.15.0.jar
::br.gov.mec.aghu-core:aghu-core-test:jar -> C:\Users\mateusanez\.m2\repository\br\gov\mec\aghu-core\aghu-core-test\8.1.2\aghu-core-test-8.1.2.jar
::org.junit.jupiter:junit-jupiter-api:jar -> C:\Users\mateusanez\.m2\repository\org\junit\jupiter\junit-jupiter-api\5.12.2\junit-jupiter-api-5.12.2.jar
::org.opentest4j:opentest4j:jar -> C:\Users\mateusanez\.m2\repository\org\opentest4j\opentest4j\1.3.0\opentest4j-1.3.0.jar
::org.junit.platform:junit-platform-commons:jar -> C:\Users\mateusanez\.m2\repository\org\junit\platform\junit-platform-commons\1.12.2\junit-platform-commons-1.12.2.jar
::org.apiguardian:apiguardian-api:jar -> C:\Users\mateusanez\.m2\repository\org\apiguardian\apiguardian-api\1.1.2\apiguardian-api-1.1.2.jar
::org.mockito:mockito-core:jar -> C:\Users\mateusanez\.m2\repository\org\mockito\mockito-core\5.13.0\mockito-core-5.13.0.jar
::net.bytebuddy:byte-buddy-agent:jar -> C:\Users\mateusanez\.m2\repository\net\bytebuddy\byte-buddy-agent\1.15.0\byte-buddy-agent-1.15.0.jar
::org.mockito:mockito-junit-jupiter:jar -> C:\Users\mateusanez\.m2\repository\org\mockito\mockito-junit-jupiter\5.13.0\mockito-junit-jupiter-5.13.0.jar
::org.wildfly.security:wildfly-elytron-auth-server:jar -> C:\Users\mateusanez\.m2\repository\org\wildfly\security\wildfly-elytron-auth-server\1.19.1.Final\wildfly-elytron-auth-server-1.19.1.Final.jar
::org.wildfly.common:wildfly-common:jar -> C:\Users\mateusanez\.m2\repository\org\wildfly\common\wildfly-common\1.6.0.Final\wildfly-common-1.6.0.Final.jar
::org.wildfly.security:wildfly-elytron-auth:jar -> C:\Users\mateusanez\.m2\repository\org\wildfly\security\wildfly-elytron-auth\1.19.1.Final\wildfly-elytron-auth-1.19.1.Final.jar
::org.wildfly.security:wildfly-elytron-base:jar -> C:\Users\mateusanez\.m2\repository\org\wildfly\security\wildfly-elytron-base\1.19.1.Final\wildfly-elytron-base-1.19.1.Final.jar
::org.wildfly.security:wildfly-elytron-credential:jar -> C:\Users\mateusanez\.m2\repository\org\wildfly\security\wildfly-elytron-credential\1.20.4.Final\wildfly-elytron-credential-1.20.4.Final.jar
::org.wildfly.security:wildfly-elytron-asn1:jar -> C:\Users\mateusanez\.m2\repository\org\wildfly\security\wildfly-elytron-asn1\1.19.1.Final\wildfly-elytron-asn1-1.19.1.Final.jar
::org.wildfly.security:wildfly-elytron-keystore:jar -> C:\Users\mateusanez\.m2\repository\org\wildfly\security\wildfly-elytron-keystore\1.19.1.Final\wildfly-elytron-keystore-1.19.1.Final.jar
::org.wildfly.security:wildfly-elytron-x500-cert:jar -> C:\Users\mateusanez\.m2\repository\org\wildfly\security\wildfly-elytron-x500-cert\1.20.4.Final\wildfly-elytron-x500-cert-1.20.4.Final.jar
::org.wildfly.security:wildfly-elytron-x500-cert-util:jar -> C:\Users\mateusanez\.m2\repository\org\wildfly\security\wildfly-elytron-x500-cert-util\1.19.1.Final\wildfly-elytron-x500-cert-util-1.19.1.Final.jar
::org.apache.sshd:sshd-common:jar -> C:\Users\mateusanez\.m2\repository\org\apache\sshd\sshd-common\2.7.0\sshd-common-2.7.0.jar
::org.wildfly.security:wildfly-elytron-provider-util:jar -> C:\Users\mateusanez\.m2\repository\org\wildfly\security\wildfly-elytron-provider-util\1.19.1.Final\wildfly-elytron-provider-util-1.19.1.Final.jar
::org.wildfly.security:wildfly-elytron-permission:jar -> C:\Users\mateusanez\.m2\repository\org\wildfly\security\wildfly-elytron-permission\1.19.1.Final\wildfly-elytron-permission-1.19.1.Final.jar
::org.wildfly.security:wildfly-elytron-util:jar -> C:\Users\mateusanez\.m2\repository\org\wildfly\security\wildfly-elytron-util\1.19.1.Final\wildfly-elytron-util-1.19.1.Final.jar
::org.wildfly.security:wildfly-elytron-x500:jar -> C:\Users\mateusanez\.m2\repository\org\wildfly\security\wildfly-elytron-x500\1.20.4.Final\wildfly-elytron-x500-1.20.4.Final.jar
::org.jboss.logging:jboss-logging:jar -> C:\Users\mateusanez\.m2\repository\org\jboss\logging\jboss-logging\3.4.3.Final\jboss-logging-3.4.3.Final.jar
::org.jboss.spec.javax.ejb:jboss-ejb-api_3.2_spec:jar -> C:\Users\mateusanez\.m2\repository\org\jboss\spec\javax\ejb\jboss-ejb-api_3.2_spec\2.0.0.Final\jboss-ejb-api_3.2_spec-2.0.0.Final.jar
::org.jboss.spec.javax.transaction:jboss-transaction-api_1.3_spec:jar -> C:\Users\mateusanez\.m2\repository\org\jboss\spec\javax\transaction\jboss-transaction-api_1.3_spec\2.0.0.Final\jboss-transaction-api_1.3_spec-2.0.0.Final.jar
::org.jboss.spec.javax.xml.rpc:jboss-jaxrpc-api_1.1_spec:jar -> C:\Users\mateusanez\.m2\repository\org\jboss\spec\javax\xml\rpc\jboss-jaxrpc-api_1.1_spec\1.0.1.Final\jboss-jaxrpc-api_1.1_spec-1.0.1.Final.jar
::org.jboss.spec.javax.servlet:jboss-servlet-api_3.0_spec:jar -> C:\Users\mateusanez\.m2\repository\org\jboss\spec\javax\servlet\jboss-servlet-api_3.0_spec\1.0.1.Final\jboss-servlet-api_3.0_spec-1.0.1.Final.jar
::jakarta.enterprise:jakarta.enterprise.cdi-api:jar -> C:\Users\mateusanez\.m2\repository\jakarta\enterprise\jakarta.enterprise.cdi-api\2.0.2\jakarta.enterprise.cdi-api-2.0.2.jar
::jakarta.inject:jakarta.inject-api:jar -> C:\Users\mateusanez\.m2\repository\jakarta\inject\jakarta.inject-api\1.0.5\jakarta.inject-api-1.0.5.jar
::biz.paluch.logging:logstash-gelf:jar -> C:\Users\mateusanez\.m2\repository\biz\paluch\logging\logstash-gelf\1.15.1\logstash-gelf-1.15.1.jar
::commons-validator:commons-validator:jar -> C:\Users\mateusanez\.m2\repository\commons-validator\commons-validator\1.9.0\commons-validator-1.9.0.jar
::commons-digester:commons-digester:jar -> C:\Users\mateusanez\.m2\repository\commons-digester\commons-digester\2.1\commons-digester-2.1.jar
::com.google.guava:guava:jar -> C:\Users\mateusanez\.m2\repository\com\google\guava\guava\33.4.8-jre\guava-33.4.8-jre.jar
::com.google.guava:failureaccess:jar -> C:\Users\mateusanez\.m2\repository\com\google\guava\failureaccess\1.0.3\failureaccess-1.0.3.jar
::com.google.guava:listenablefuture:jar -> C:\Users\mateusanez\.m2\repository\com\google\guava\listenablefuture\9999.0-empty-to-avoid-conflict-with-guava\listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar
::org.jspecify:jspecify:jar -> C:\Users\mateusanez\.m2\repository\org\jspecify\jspecify\1.0.0\jspecify-1.0.0.jar
::com.google.j2objc:j2objc-annotations:jar -> C:\Users\mateusanez\.m2\repository\com\google\j2objc\j2objc-annotations\3.0.0\j2objc-annotations-3.0.0.jar
::org.apache.commons:commons-text:jar -> C:\Users\mateusanez\.m2\repository\org\apache\commons\commons-text\1.13.1\commons-text-1.13.1.jar