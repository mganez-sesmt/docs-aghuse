#!/bin/bash

echo "JBOSS_HOME: $JBOSS_HOME"

# Verify JBOSS_HOME is set
if [ -z "$JBOSS_HOME" ]; then
    echo "Error: JBOSS_HOME environment variable is not set"
    exit 1
fi

# Change to WildFly bin directory
cd "$JBOSS_HOME/bin" || { echo "Failed to enter $JBOSS_HOME/bin directory"; exit 1; }

# Start WildFly with all configurations
./standalone.sh \
  -b 0.0.0.0 \
  --server-config=standalone-full.xml \
  -Djboss.server.base.dir="$JBOSS_HOME/standalone" \
  -Djboss.home.dir="$JBOSS_HOME" \
  -Dprogram.name="JBossTools: WildFly 24+" \
  -XX:MetaspaceSize=99M -XX:MaxMetaspaceSize=999M \
  -Dorg.jboss.resolver.warning=true \
  -Djava.net.preferIPv4Stack=true \
  -Dsun.rmi.dgc.client.gcInterval=3600000 \
  -Dsun.rmi.dgc.server.gcInterval=3600000 \
  -Djboss.modules.system.pkgs=org.jboss.byteman \
  -Djava.awt.headless=true \
  -Dorg.jboss.boot.log.file="$JBOSS_HOME/standalone/log/boot.log" \
  -Dlogging.configuration="file://$JBOSS_HOME/standalone/configuration/logging.properties" \
  -Djboss.home.dir="$JBOSS_HOME" \
  -Dorg.jboss.logmanager.nocolor=true \
  --add-exports=java.desktop/sun.awt=ALL-UNNAMED \
  --add-exports=java.naming/com.sun.jndi.ldap=ALL-UNNAMED \
  --add-opens=java.base/java.lang=ALL-UNNAMED \
  --add-opens=java.base/java.lang.invoke=ALL-UNNAMED \
  --add-opens=java.base/java.lang.reflect=ALL-UNNAMED \
  --add-opens=java.base/java.io=ALL-UNNAMED \
  --add-opens=java.base/java.security=ALL-UNNAMED \
  --add-opens=java.base/java.util=ALL-UNNAMED \
  --add-opens=java.base/java.util.concurrent=ALL-UNNAMED \
  --add-opens=java.management/javax.management=ALL-UNNAMED \
  --add-opens=java.naming/javax.naming=ALL-UNNAMED \
  --add-exports=java.base/sun.nio.ch=ALL-UNNAMED \
  --add-exports=jdk.unsupported/sun.misc=ALL-UNNAMED \
  --add-exports=jdk.unsupported/sun.reflect=ALL-UNNAMED \
  --add-modules=java.se \
  -Djboss.bind.address.management=localhost \
  -Djboss.as.management.blocking.timeout=9999999 \
  -Daghu.automatic.timers.enable=true \
  -Djboss.mail.server.host=smtp.gmail.com \
  -Djboss.mail.server.port=587 \
  -Djboss.bind.address=0.0.0.0