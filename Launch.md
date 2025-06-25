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
`{basedir}/aghu/aghu-ear/`

`mvn wildfly:deploy "-Dmaven.wagon.http.ssl.allowall=true" "-Dmaven.wagon.http.ssl.insecure=true"`

Para realizar o deploy de forma remota é necessário colocar o conteúdo na forma a seguir, no arquivo `{basedir}/aghu/aghu-ear/pom.xml`

``` xml

    <plugin>
        <groupId>org.wildfly.plugins</groupId>
        <artifactId>wildfly-maven-plugin</artifactId>
        <version>4.2.2.Final</version>
        <configuration>
          <hostname>10.15.232.9</hostname>
          <port>9990</port>
          <username>usuario2</username>
          <password>Usu@r105</password> <!-- <secret value="VXN1QHIxMDU=" /> -->
          <filename>${contexto}.ear</filename>
          <skip>false</skip>
        </configuration>
      </plugin>

```


# Wildfly 
## Habilitando o modo de serviço
Copie a pasta service

`%JBOSS_HOME%\docs\contrib\scripts\service`

Para a pasta 

`%JBOSS_HOME%\bin\`

## Ativando o modo de serviço
Na pasta copiada terá esse arquivo a executar.

`service.bat install /config standalone-full.xml /startup`

Esse comando permite a instalação do wildfly como serviço, o primeiro comando define a configuração de standalone que necessita, e segundo define que ele deve ser levantado de forma automática caso seja desligado.

### Comandos de operação
Ao instalar ainda é necessário iniciar.

`service.bat start`

Agora para encerrar ou reiniciar:

`service.bat stop`

`service.bat restart`

Caso tenha tido com algum problema com a instalação, ou tenha esquecido alguma configuração.

`service.bat uninstall`


## Modificações

Trecho a seguir de cache que é estava faltante (não sei qual é o padrão que propoga as modificações na pasta do wildfly.)

``` xml
                <local-cache name="primefaces_cache">
                    <transaction mode="NONE"/>
                    <heap-memory size="1000" size-unit="ENTRIES"/>
                    <expiration interval="120000" lifespan="3600000" max-idle="1800000"/>
                </local-cache>
```

O trecho a seguir é sobre as conexões externas, isso foi permitido livremente para uma gestão otimizada, mas deve ser feito de forma mais restrita em ambietne de produção

``` xml
    <interfaces>
        <interface name="management">
            <inet-address value="${jboss.bind.address.management:0.0.0.0}"/>
        </interface>
        <interface name="public">
            <inet-address value="${jboss.bind.address:0.0.0.0}"/>
        </interface>
        <interface name="unsecure">
            <inet-address value="${jboss.bind.address.unsecure:127.0.0.1}"/>
        </interface>
    </interfaces>
```

Nota: o ip que é colocado, significa a zona de acesso, sendo 0.0.0.0 (público) e 127.0.0.1 (localhost) num mabiente de produção o idela é deixar apenas que a rede interna das VMs possa se comunicar, sendo isso operando de forma eficiente por um sistema automático como o Jenkins.

Trecho de alteração por falta de memória no wildlfy, localizado em `%JBOSS_HOME%\bin\standalone.conf.bat`

Trecho

``` bat
if "x%JBOSS_JAVA_SIZING%" == "x" (
    rem # JVM memory allocation pool parameters - modify as appropriate.
    set "JBOSS_JAVA_SIZING=-Xms5G -Xmx5G -XX:MetaspaceSize=99M -XX:MaxMetaspaceSize=999m"
)
set "JAVA_OPTS=%JBOSS_JAVA_SIZING%"
```


## Login de gerenciador.
Execute o arquivo `add-user.bat` encontrado no `%JBOSS_HOME%\bin` 

O login criado serve para que o pom.xml do aghu-ear, que possui a parte de login do Wildfly. Dessa forma ao executar `mvn wildfly:deploy` o maven poderá executar o deploy se autenticando com o wildfly com esse par de acesso. 

## Observação
Existe a possiblidade de que o wildfly repassado tenha sugeira, ou outras característica antigas, Pode ser necessário limpar.

### Sujeira já com deploy.
Caso você esteja utilizando uma versão que já teve um deploy ativado, o wildfly vai pensar que já tinha coisas entregues, portanto você precisa apagar as referências inexistetnes. Como limpar os temporários. No seu arquivo de configuração pode ter algo como

``` xml
    <deployments>
        <deployment name="aghu.ear" runtime-name="aghu.ear">
            <content sha1="1f01a72c3144822eb258883c5561fb98421c9bcd"/>
        </deployment>
    </deployments>
```

Exclua para que possa fazer seu primeiro deploy.