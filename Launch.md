# CLI
## Maven
Lembrando que para executar os comandos do Maven é necessário que esteja em uma pasta que tenha o pom.xml

## .m2/settings.xml
Arquivos de confiugração para se colocar na pasta .m2

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
