# Básico
Configure as variáveis de ambiente. Diretório do java, `%JAVA_HOME%`, diretório do maven, `%MAVEN_HOME%`, e diretório do wildfly `%JBOSS_HOME%`.
Já no Path, coloque as referências para a pasta bin de cada uma.


# CLI
## Maven
Lembrando que para executar os comandos do Maven é necessário que esteja em uma pasta que tenha o pom.xml

## .m2/settings.xml
Arquivos de confiugração para se colocar na pasta .m2

## Launcher de Entidades 1.
`{basedir}/aghu-entidades/`

`mvn install --activate-profiles=PMD "-Dmaven.wagon.http.ssl.allowall=true" "-Dmaven.wagon.http.ssl.insecure=true" "-Dpmd.skip=true" `

## Launcher de AGHU 2.
`{basedir}/aghu/`

`mvn install --activate-profiles=PMD "-Dmaven.wagon.http.ssl.allowall=true" "-Dmaven.wagon.http.ssl.insecure=true" "-Dpmd.skip=true" "-Dmaven.test.skip=true"`

## Configurar Servidor 3.
O configura-servidor.bat faz as configurações do wildfly, basta apontar qual pasta você quer que o configure como exemplo abaixo
``` shell
configura-servidor.bat "C:\develop\aghuse\aghu\aghu-ear"
```
O pré requisito é apontar no `%ENV_FILTER%` e o `%JBOSS_HOME%`.

## Levantar o Servidor Wildfly 4.
Basta executar o start-wildfly, tendo o JBOSS_HOME configurado corretamente.

## Deploy 5.
``` shell
cd .../aghu/aghu-ear/
```

``` shell
mvn wildfly:deploy -U "-Dmaven.wagon.http.ssl.allowall=true" "-Dmaven.wagon.http.ssl.insecure=true"
```

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
## Modo Serviço no Windows
### Habilitando o modo de serviço
Copie a pasta service

`%JBOSS_HOME%\docs\contrib\scripts\service`

Para a pasta 

`%JBOSS_HOME%\bin\`

### Ativando o modo de serviço
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
Caso isso não funcione você pode setar uma variável de ambiente para sobrepor. Lembrando que a variável de ambiente, em nível de sistema, JAVA_OPTS.

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


## Login nas VMs
sesmt:sesmt

### Banco
`ssh sesmt@10.15.232.10 -p 22890`

### Aplicação
`ssh sesmt@10.15.232.13 -p 22890`

### Dica
Para sair da conexão CRTL+D.

### Configuração no Linux
Nota NÂO Adicione as variáveis de ambiente, existe uma série de problemas relacionados a permissão e mesmo que ele tenha a autorização para a leitura e coisas no mesmmo sentido, ele irá reclamar que não enxerga ou coisas parecidas. Para isso faça as configurações diretamente no arquivo standalone.cong
``` sh
export JBOSS_HOME="home/sesmt/Documentos/develop/wildfly"
export JAVA_HOME="usr/lib/jvm/java-17-openjdk-amd64"
export ENV_FILTER="home/sesmt/arquivos/app_sesmt.properties"
export JAVA_OPTS="-Xms5G -Xmx5G -XX:MetaspaceSize=99M -XX:MaxMetaspaceSize=999m"
```

1. Vá para o root.
``` sh
sudo su
```

2. Vá para a home do bash
``` sh
cd $HOME
```


3. Abra o arquivo de configuração do bash, para adicionar as variáveis de ambiente mandatórias.
``` sh
nano .bashrc
```

4. Configure o standalone.conf para executar as configurações do standalone.sh
    1. Edite na linha JBOSS_JAVA_SIZING
    ``` conf
    JBOSS_JAVA_SIZING="-Xms5G -Xmx5G -XX:MetaspaceSize=99M -XX:MaxMetaspaceSize=999m"
    ```
    2. Adicione o local da JAVA_HOME
    ``` conf
    JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
    ```

6. Inicialização 
Localizado em `$JAVA_BOSS/bin`

``` sh
./standalone.sh -c standalone-full.xml
```

Caso tenha algum problema associado ao standalone-full.xml, observe as informações dele presente no arquivo na pasta `$JBOSS_HOME/standalone/configuration`