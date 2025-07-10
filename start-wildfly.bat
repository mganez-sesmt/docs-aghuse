@echo off

REM (Program arguments) : -mp "C:\develop\wildfly\modules" org.jboss.as.standalone -b localhost --server-config=standalone-full.xml -Djboss.server.base.dir=C:\develop\wildfly\standalone 
REM (VM arguments) : "-Dprogram.name=JBossTools: WildFly 24+" -server -Xms5G -Xmx5G -XX:MetaspaceSize=99M -XX:MaxMetaspaceSize=999M -Dorg.jboss.resolver.warning=true -Djava.net.preferIPv4Stack=true -Dsun.rmi.dgc.client.gcInterval=3600000 -Dsun.rmi.dgc.server.gcInterval=3600000 -Djboss.modules.system.pkgs=org.jboss.byteman -Djava.awt.headless=true "-Dorg.jboss.boot.log.file=C:\develop\wildfly\standalone\log\boot.log" "-Dlogging.configuration=file:C:\develop\wildfly\standalone\configuration\logging.properties" "-Djboss.home.dir=C:\develop\wildfly" -Dorg.jboss.logmanager.nocolor=true --add-exports=java.desktop/sun.awt=ALL-UNNAMED --add-exports=java.naming/com.sun.jndi.ldap=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.invoke=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.security=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.util.concurrent=ALL-UNNAMED --add-opens=java.management/javax.management=ALL-UNNAMED --add-opens=java.naming/javax.naming=ALL-UNNAMED --add-exports=java.base/sun.nio.ch=ALL-UNNAMED --add-exports=jdk.unsupported/sun.misc=ALL-UNNAMED --add-exports=jdk.unsupported/sun.reflect=ALL-UNNAMED --add-modules=java.se -Djboss.bind.address.management=localhost -Djboss.as.management.blocking.timeout=9999999 -Daghu.automatic.timers.enable=true -Djboss.mail.server.host=smtp.gmail.com -Djboss.mail.server.port=587 -Djboss.bind.address=0.0.0.0 

REM -Xms5G -Xmx5G ^
REM -server ^

rem configuracao da jvm
set JAVA_OPTS=-Xms5G -Xmx5G -XX:MetaspaceSize=99M -XX:MaxMetaspaceSize=2G
set DB_DRIVER=org.postgresql.Driver
set DB_DIALECT=br.gov.mec.aghu.core.persistence.dialect.PostgreSQLExtendedDialect
set DB_URL=jdbc:postgresql://10.15.1.21:5432/agh
set DB_USER=aghu_dev
set DB_PWD=dtgjes#768359

%JBOSS_HOME%\bin\standalone.bat ^
  -b 0.0.0.0 ^
  --server-config=standalone-full.xml ^
  -Djboss.server.base.dir="%JBOSS_HOME%\standalone" ^
  -Djboss.home.dir="%JBOSS_HOME%" ^
  -Djboss.server.base.dir=%JBOSS_HOME%\standalone ^
  -Dprogram.name="JBossTools: WildFly 24+" ^
  -Dorg.jboss.resolver.warning=true ^
  -Djava.net.preferIPv4Stack=true ^
  -Dsun.rmi.dgc.client.gcInterval=3600000 ^
  -Dsun.rmi.dgc.server.gcInterval=3600000 ^
  -Djboss.modules.system.pkgs=org.jboss.byteman ^
  -Djava.awt.headless=true ^
  -Dorg.jboss.boot.log.file=%JBOSS_HOME%\standalone\log\boot.log ^
  -Dlogging.configuration=file:%JBOSS_HOME%\standalone\configuration\logging.properties ^
  -Djboss.home.dir=%JBOSS_HOME% ^
  -Dorg.jboss.logmanager.nocolor=true 
  -Djboss.bind.address.management=localhost ^
  -Djboss.as.management.blocking.timeout=9999999 ^
  -Daghu.automatic.timers.enable=true ^
  -Djboss.mail.server.host=smtp.gmail.com ^
  -Djboss.mail.server.port=587 ^
  -Djboss.bind.address=0.0.0.0 ^
  -Ddbfilter=pg ^
  -Ddatasource.driver.classname=org.postgresql.Driver ^
  -Ddatasource.dialect.classname=br.gov.mec.aghu.core.persistence.dialect.PostgreSQLExtendedDialect ^
  --add-exports=java.desktop/sun.awt=ALL-UNNAMED ^
  --add-exports=java.naming/com.sun.jndi.ldap=ALL-UNNAMED ^
  --add-opens=java.base/java.lang=ALL-UNNAMED ^
  --add-opens=java.base/java.lang.invoke=ALL-UNNAMED ^
  --add-opens=java.base/java.lang.reflect=ALL-UNNAMED ^
  --add-opens=java.base/java.io=ALL-UNNAMED ^
  --add-opens=java.base/java.security=ALL-UNNAMED ^
  --add-opens=java.base/java.util=ALL-UNNAMED ^
  --add-opens=java.base/java.util.concurrent=ALL-UNNAMED ^
  --add-opens=java.management/javax.management=ALL-UNNAMED ^
  --add-opens=java.naming/javax.naming=ALL-UNNAMED ^
  --add-exports=java.base/sun.nio.ch=ALL-UNNAMED ^
  --add-exports=jdk.unsupported/sun.misc=ALL-UNNAMED ^
  --add-exports=jdk.unsupported/sun.reflect=ALL-UNNAMED ^
  --add-modules=java.se ^