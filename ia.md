# Comandos MVN e WildFly: Deploy e Consulta
Para responder suas perguntas sobre deploy no WildFly usando Maven:

# Como ver o que foi feito de deploy
Você pode ver os aplicativos implantados no WildFly de várias maneiras:

## 1. Via console administrativo:
- Acesse http://localhost:9990 (ajuste a porta se necessário)
- Navegue até "Deployments" na barra lateral

## 1. Via CLI do WildFly:

```
/subsystem=deployment-scanner:scan
/deployment=*:read-resource
```

## 1. Via Maven (listar deployments):

```
mvn wildfly:list-deployments
```
# Como fazer deploy de um artefato específico

## Deploy de um arquivo WAR/EAR específico:
```
mvn wildfly:deploy -Dwildfly.deployment.filename=seu-aplicativo.war
```
## Deploy de um módulo específico em um projeto multi-módulo:
```
mvn wildfly:deploy -pl modulo-especifico -am
```
## Deploy apenas do artefato atual (ignorando dependências):
```
mvn wildfly:deploy -Dwildfly.deploy.only=true
```
# Outros comandos úteis
Undeploy:
```
mvn wildfly:undeploy
```
Redeploy (undeploy + deploy):
````
mvn wildfly:redeploy
```
Deploy apenas se o artefato foi modificado:

```
mvn wildfly:deploy-only
```