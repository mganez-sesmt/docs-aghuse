# standalone-full.xml 
## Banco 
``` sh
${env.DATASOURCE_URL}
${env.DB_POOLSIZE_MIN:5}
${env.DB_POOLSIZE_MAX:20}
${env.DB_USER}
${env.DB_PWD}
```
# app-parameters.properties
``` sh 
## LDAP/AD - login importação
sd_server_address=${env.SD_SERVER_ADDRESS}=10.15.1.155
sd_user_dn=${env.SD_USER_DN}=%s@aghuse.int

# ...

## importação opicional
sd_bind_dn=${env.SD_BIND_DN}=teste@aghuse.int
sd_bind_credentials=${env.SD_BIND_CREDENTIALS}=Adm123456
sd_user_context_dn=${env.SD_USER_CONTEXT_DN}=OU=HOSPITAIS,dc=aghuse,dc=int
#...

## Host do servidor de Email
mail_session_host=${env.MAIL_SESSION_HOST:10.247.247.6}=10.15.1.237

#...

################################## SISTEMA DE IMPRESSAO #########################################

#CUPS = true, CLIENTE = false
sistema_impressao_cups=${env.SISTEMA_IMPRESSAO_CUPS:false}
##################################################################################################

#...
####################################### IDENTIFICACAO DE HOST REMOTO #############################

identificar_host_remoto_por_ip=${env.IDENTIFICADOR_HOST_REMOTO_POR_IP:false}

#...

app_context=${env.APP_CONTEXT:aghu}

#...
#não usa
${env.CERTIFICADO_NFE_PASSWORD:12345678}

#...

#genérico homolog/treina
${env.AGHU_DEFAULT_COLOR_THEME:laranja}
```

``` sh 
#não usa
solr_server=${env.SOLR_SERVER}
solr_user=${env.SOLR_USER}
solr_key=${env.SOLR_KEY}


################## SERVICO FILE-SERVICE ####################################################
fs_usuario=${env.FS_USUARIO:file}
fs_key=${env.FS_KEY:f1l3@2017}

############################# BLOQUEIO MULTIPLOS LOGINS ###########################################
bloqueia_multiplos_logins=${env.BLOQUEIA_MULTIPLOS_LOGINS:false}
#?metodo_logout=@bloq.metodo.logout@

################## SERVICO PAGTESOURO-CAMEL ###################################################
pagtesouro_usuario=${env.PAGTESOURO_USUARIO:pagtesouro}
pagtesouro_key=${env.PAGTESOURO_KEY:97o2bN2KIt@hcpa}

################## AGENDAMENTO REMOTO DE EJB TIMERS (CLIENTE) #################################
remote_ejb_server=${env.REMOTE_EJB_SERVER:localhost:8080}
remote_ejb_user=${env.REMOTE_EJB_USER:ejbuser}
remote_ejb_key=${env.REMOTE_EJB_KEY:bN3bG4+bLByHXDUR+C2Ky5LTSvnIkXYq}
pagtesouro_key=${env.PAGTESOURO_KEY:97o2bN2KIt@hcpa}

################## SERVICOS VIDAAS/VALID certificado em nuvem #####################
vidaas_client_id=${env.VIDAAS_CLIENT_ID:a381a072-625c-42f0-902d-920e4c6a1401}
vidaas_client_secret=${env.VIDAAS_CLIENT_SECRET:XcS8R6m7R38e0824}

```

Configurações externas / existe apenas no repositório.
``` xml
<urls>
    <url>file:///${basedir}/src/main/config-outside/defaults/app-params/conf.properties</url>
    <url>file:///${basedir}/src/main/config-outside/defaults/security-realm/conf.properties</url>
    <url>file:///${basedir}/src/main/config-outside/defaults/contingencia/conf.properties</url>
    <url>file:///${basedir}/src/main/config-outside/defaults/security-realm/${dbfilter}.properties</url>
    <!--     Informações sobre senha do banco de dados -->
    <!-- https://apus.hcpa.ufrgs.br/projects/aghu/wiki/Orienta%C3%A7%C3%B5es_sobre_criptografar_senha_do_banco_de_dados_no_Jboss -->
    <url>file:///${basedir}/src/main/config-outside/defaults/datasource/${dbfilter}.properties</url>
    <url>classpath:/datasource.properties</url>
    <url>classpath:/env-conf.properties</url>
</urls>
```

app-params/conf.properties
``` sh
###############################################################################
## Send mail port
mail.port=25
mail.ssl=false
mail.starttls=false
mail.user=
mail.password=

###############################################################################
## Parametros gerais
tema=default
certificadonfe=
logoutunload=true
securecookies=false

###############################################################################
## Sistema de impressao
sistemacups=false

###############################################################################
## Processos Agendados 
executaquartzExames=false

###############################################################################
## Pesquisa fonetica - Lucene
luceneMassIndexerLoadSize=25
luceneMassIndexerThreadCount=3

###############################################################################
## Jasper Reports
jasper-governor-max-pages-enabled=true
jasper-governor-max-pages=5000

###############################################################################
## Dialeto
dialeto=

###############################################################################
## Solr Server
solr-server=aghuse-solr-homolog:8983

###############################################################################
## Bloqueia multiplos logins do mesmo usuario
bloq.mult.login=false
bloq.metodo.logout=websocket

###############################################################################
## AGENDAMENTO REMOTO DE EJB TIMERS (CLIENTE)
remote-ejb-server=localhost:8080
remote-ejb-user=ejbuser
remote-ejb-key=bN3bG4+bLByHXDUR+C2Ky5LTSvnIkXYq

################## SERVICO API INTEGRACAO PESSOAL #############################
api_token_integracao=

################## KEYCLOAK INTEGRATION #######################################
keycloak-url=

```




security-realm/conf.properties
``` sh 
# AghuseApplicationDomain, PesquisaApplicationDomain e AghuseApiApplicationDomain
ejb-security-domain=${env.EJB_SECURITY_DOMAIN:AghuseApplicationDomain}

#Valores possiveis:
#br.gov.mec.aghu.casca.autenticacao.AghuseLdapSecurityRealm
#br.gov.mec.aghu.casca.autenticacao.AghuseApenasNegocialSecurityRealm
#br.gov.mec.aghu.casca.autenticacao.AghuseDbConnectionSecurityRealm
#br.gov.mec.aghu.casca.autenticacao.AghusePesquisaSecurityRealm
#br.gov.mec.aghu.casca.autenticacao.AghusePesquisaApenasNegocialSecurityRealm
security-realm.class=${env.SECURITY_REALM_CLASS:br.gov.mec.aghu.casca.autenticacao.AghuseApenasNegocialSecurityRealm}=br.gov.mec.aghu.casca.autenticacao.AghuseLdapSecurityRealm
security-realm-pesquisa.class=${env.SECURITY_REALM_PESQUISA_CLASS:br.gov.mec.aghu.casca.autenticacao.AghusePesquisaApenasNegocialSecurityRealm}=br.gov.mec.aghu.casca.autenticacao.AghusePesquisaSecurityRealm

# SQL necessario para fazer as validacoes negocial do sistema, valores possiveis: SQL para Oracle ou SQL para Postgres
# validarAutenticacaoNegocial - usuario ativo e com perfils.
	security-realm.validar-autenticacao-api=select t.token from casca.csc_usuarios_api u, casca.csc_tokens_api t where u.login_hcpa = upper(?) and t.seq_usuario = u.seq and t.token = ? and t.data_expiracao &gt;= ? 
	security-realm-validar-auth-externa-pesquisa=select usuario.id, usuario.login, usuario.ATIVO, senha.HASH_SENHA, (select count(*) from casca.CSC_PERFIS_USUARIOS perfilusuario inner join casca.CSC_PERFIL perfil on perfil.id \= perfilusuario.id_perfil  where perfilusuario.id_usuario \= usuario.id and (perfilusuario.dthr_expiracao is null or perfilusuario.dthr_expiracao &gt; sysdate) and perfil.SITUACAO \= 'A') perfilcount       from CASCA.CSC_USUARIO usuario, CASCA.CSC_SENHA senha          where senha.id_usuario \= usuario.id and (upper(login) \= upper(?) OR (upper(email) \= upper(?)))            and senha.DATA_CRIACAO \= (select max(DATA_CRIACAO) from CASCA.CSC_SENHA where id_usuario \= usuario.id)
	security-realm-dominio-local=@hcpa.edu.br


# configuracoes de logon unico #123825
login.sso.servidor.logout=
login.sso.idp.url=
login.sso.issuer=
login.sso.root.return=
login.sso.consumer.url=
login.sso.attribute.consuming.service.index=
login.sso.atributo.usuario=
login.sso.redirecionamento.erro=
```
security-realm/conf.properties
``` sh
## API geracao-service
geracao-service-url=
geracao-service-realm=contingencia-realm
geracao-service-client-id=
geracao-service-client-secret=
```

security-realm/pg.properties
``` sh

security-realm.validar-autenticacao-negocial=${env.SECURITY_REALM_VALIDAR_AUTENTICACAO_NEGOCIAL}
DOCKER "select usuario.id, usuario.login, usuario.ATIVO , (select count(*) from casca.CSC_PERFIS_USUARIOS perfilusuario inner join casca.CSC_PERFIL perfil on perfil.id = perfilusuario.id_perfil where perfilusuario.id_usuario = usuario.id and (perfilusuario.dthr_expiracao is null or perfilusuario.dthr_expiracao > now()) and perfil.SITUACAO = 'A' ) perfilcount from CASCA.CSC_USUARIO usuario where login = upper(?)"

security-realm.verificar-vinculo-servidor=${env.SECURITY_REALM_VERIFICAR_VINCULO_SERVIDOR}
DOCKER "select serv.matricula, serv.vin_codigo, serv.dt_inicio_vinculo, serv.CCT_CODIGO, serv.HTR_CODIGO, serv.OCA_CAR_CODIGO, serv.OCA_CODIGO, vin.IND_SITUACAO, vin.IND_CCUST_LOTACAO, vin.IND_HORARIO, vin.IND_OCUPACAO, vin.NRO_DIAS_ADMISSAO from agh.RAP_SERVIDORES serv inner join agh.RAP_PESSOAS_FISICAS pes on pes.codigo = serv.PES_CODIGO inner join agh.RAP_VINCULOS vin on vin.codigo = serv.vin_codigo where usuario = upper(?) and ( serv.ind_situacao = 'A' or (serv.ind_situacao = 'P' and serv.dt_fim_vinculo >= now()))"


```



Foi adicionado no standalone-full-homolog um trecho em primazia entre seus pares. Na  configuração do jwt-realm
    <property name="xDSG7Wa_FAtSVlMbn0sRdcExIzZW47t1eS8neXH92P8" value="-----BEGIN PUBLIC KEY-----MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApDbgVD2WrzH4Pif+l763tyntH4HR9b2YsfWZfsfkS3GfI9NubRG+6DMgmN6XNqJgaJfNpkYDqU3nDwxvf5Pdx0lqHamCcjzUfJmMevEmV5RC7o+wppIaI2RpaPeS40FD3KixafGSaZDZNSxiJav/HJTu6PI0SmHeh6yVjrjBl3RxEEmtIGcp4ZnPfswEKuAkY6YEE8tNUwjIUdeG0yZopJYhSpWxdXVbkCye+BIBHP9f2FgSMe10x2bRd3zcQCumpbaJ8yJnMV9JxPX40dfLmHiqajqwiCHtgLWA3pD2Aa2YpV9LLPaz+kZBzsl5LJmcI5zapz5IrDxkuirEw+ASCwIDAQAB-----END PUBLIC KEY-----"/>

${env.SECURE_COOKIES}=false

na seção, os toknes são os nomes dado em cada propertie. E no lado direito value, são a identificação no sistema que pode ser visto sendo apresentado com @datasource.url@

``` xml
<configuration>
    <target>
        <filterset id="datasource.params">
            <filter token="datasource.jndi.name" value="${datasource.jndi.name}"/>
            <filter token="datasource.url" value="${datasource.url}"/>
            <filter token="datasource.driver" value="${datasource.driver}"/>
        </fitlerset>
    </target>
</configuration>
```

