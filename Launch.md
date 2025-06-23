# CLI
## Maven
Lembrando que para executar os comandos do Maven é necessário que esteja em uma pasta que tenha o pom.xml

## .m2/settings.xml
Arquivos de confiugração do 
``` xml
<settingsxmlns="http://maven.apache.org/SETTINGS/1.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
    https://maven.apache.org/xsd/settings-1.0.0.xsd">
    <servers>
    <!-- Se o Nexus exigir autenticação (Nahho eh necessahrio, mas eh bom deixar evidente)-->
        <server>
            <id>nexus-hcpa</id>
            <username>seu-usuario</username>
            <password>sua-senha</password>
        </server>
    </servers>
    <mirrors>
    <!-- Configurar o Nexus como espelho (opcional, mas recomendado para evitar falhas) -->
        <mirror>
            <id>nexus-mirror</id>
            <name>Nexus HCPA Mirror</name>
            <url>http://nexus.hcpa.edu.br/repository/maven-public/</url>
            <mirrorOf>*</mirrorOf><!-- Espelha todos os repositohrios -->
        </mirror>
    </mirrors>
    <profiles>
        <profile>
            <id>nexus-profile</id>
            <repositories>
                <repository>
                    <id>nexus-hcpa</id>
                    <name>Nexus HCPA</name>
                    <url>http://nexus.hcpa.edu.br/repository/maven-public/</url>
                    <releases>
                        <enabled>true</enabled>
                    </releases>
                    <snapshots>
                        <enabled>true</enabled>
                    </snapshots>
                </repository>
            </repositories>
        </profile>
    </profiles>
    <activeProfiles>
        <activeProfile>nexus-profile</activeProfile>
    </activeProfiles>
```

## Launcher de Entidades 1.
`{basedir}/aghu-entidades/`

` mvn install -X --activate-profiles=PMD "-Dmaven.wagon.http.ssl.allowall=true" "-Dmaven.wagon.http.ssl.insecure=true" "-Dpmd.skip=true" `

## Launcher de AGHU 2.
`{basedir}/aghu/`

`mvn install --activate-profiles=PMD "-Dmaven.wagon.http.ssl.allowall=true" "-Dmaven.wagon.http.ssl.insecure=true" "-Dpmd.skip=true" "-Dmaven.test.skip=true"`

## Configurar Servidor 3.

## Levantar o Servidor Wildfly 4.
Basta executar o start-wildfly, tendo o JBOSS_HOME configurado corretamente.

## Deploy 5.
