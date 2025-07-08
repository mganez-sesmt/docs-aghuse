``` sh
/bin/sh /home/wildfly/bin/standalone.sh 
-b=0.0.0.0 
--server-config=standalone-full.xml


#\_ 
java -D[Standalone] 
-server 
-Xms5G 
-Xmx5G 
-XX:MaxMetaspaceSize=2G 
-Djava.net.preferIPv4Stack=true 
-Dorg.jboss.resolver.warning=true 
-Dsun.rmi.dgc.client.gcInterval=3600000 
-Dsun.rmi.dgc.server.gcInterval=3600000 
-Dorg.apache.el.parser.COERCE_TO_ZERO=false 
-Djboss.as.management.blocking.timeout=900 
-Djboss.modules.system.pkgs=org.jboss.byteman 
-Djava.awt.headless=true 
-Djboss.server.default.config=standalone-full.xml 
-Dorg.jboss.as.logging.per-deployment=false 
-Doracle.jdbc.DateZeroTime=true 
-Dactivemq.artemis.client.global.thread.pool.max.size=30 
-agentlib:jdwp=transport=dt_socket,address=8787,server=y,suspend=n 
--add-exports=java.desktop/sun.awt=ALL-UNNAMED 
--add-exports=java.naming/com.sun.jndi.ldap=ALL-UNNAMED 
--add-exports=java.naming/com.sun.jndi.url.ldap=ALL-UNNAMED 
--add-exports=java.naming/com.sun.jndi.url.ldaps=ALL-UNNAMED 
--add-opens=java.base/java.lang=ALL-UNNAMED 
--add-opens=java.base/java.lang.invoke=ALL-UNNAMED 
--add-opens=java.base/java.lang.reflect=ALL-UNNAMED 
--add-opens=java.base/java.io=ALL-UNNAMED 
--add-opens=java.base/java.security=ALL-UNNAMED 
--add-opens=java.base/java.util=ALL-UNNAMED 
--add-opens=java.base/java.util.concurrent=ALL-UNNAMED 
--add-opens=java.management/javax.management=ALL-UNNAMED 
--add-opens=java.naming/javax.naming=ALL-UNNAMED 
-Djava.security.manager=allow 
-Dorg.jboss.boot.log.file=/home/wildfly/standalone/log/server.log 
-Dlogging.configuration=file:/home/wildfly/standalone/configuration/logging.properties 
-jar /home/wildfly/jboss-modules.jar 
-mp /home/wildfly/modules org.jboss.as.standalone 
-Djboss.home.dir=/home/wildfly 
-Djboss.server.base.dir=/home/wildfly/standalone 
-b=0.0.0.0 
--server-config=standalone-full.xml
```




`$JAVA_HOME : /usr/lib/jvm/java-17-openjdk-amd64`

/etc/systemd/system/wildfly.service
``` sh
[Unit]
Description=WildFly Application Server
After=network.target

[Service]
User=root
Group=root
ExecStart=/home/wildfly/bin/standalone.sh -b=0.0.0.0 --server-config=standalone-full.xml
Restart=always
StandardOutput=syslog
StandardError=syslog

[Install]
WantedBy=multi-user.target
```


### Para fazer compilação eles estavam usando um arquivo .xml na /.m2
``` xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

  <pluginGroups>
          <pluginGroup>org.wildfly.plugins</pluginGroup>
    </pluginGroups>

  <proxies>
    <!--<proxy>
      <id>optional</id>
      <active>true</active>
      <protocol>http</protocol>
      <username>foo</username>
      <password>bar</password>
      <host>web.hcpa</host>
      <port>8080</port> -->
<!--      <nonProxyHosts>local.net|some.host.com</nonProxyHosts>-->
   <!-- </proxy>   -->
  </proxies>

  <servers>
    <server>
      <id>internal</id>
    </server>

  </servers>

  <mirrors>
        <mirror>
                <id>internal</id>
                <mirrorOf>*</mirrorOf>
                <url>https://nexus.hcpa.edu.br/repository/maven-public/</url>
        </mirror>
      <mirror>
        <id>internal2</id>
        <mirrorOf>*</mirrorOf>
          <url>http://aghu-dev.hcpa/archiva/repository/internal/</url>
        </mirror>
        <mirror>
               <id>mygrid-restlet</id>
               <url>http://maven.restlet.com</url>
               <mirrorOf>maven-restlet</mirrorOf>
        </mirror>
  </mirrors>

  <profiles>
        <profile>
                        <id>archiva</id>
                        <repositories>
                                <repository>
                                        <id>central</id>
                                        <url>http://central</url>
                                        <releases>
                                                <enabled>true</enabled>
                                        </releases>
                                        <snapshots>
                                                <enabled>true</enabled>
                                        </snapshots>
                                </repository>
                        </repositories>
                        <pluginRepositories>
                                <pluginRepository>
                                        <id>central</id>
                                        <url>http://central</url>
                                        <releases>
                                                <enabled>true</enabled>
                                        </releases>
                                        <snapshots>
                                                <enabled>true</enabled>
                                        </snapshots>
                                </pluginRepository>
                        </pluginRepositories>
                </profile>

        <profile>
                        <id>restlet</id>
                        <repositories>
                                <repository>
                                        <id>maven-restlet</id>
                                        <url>http://maven.restlet.com</url>
                                </repository>
                        </repositories>
                </profile>
  </profiles>

        <activeProfiles>
                <activeProfile>archiva</activeProfile>
        </activeProfiles>

</settings>
```
