# Por que precisamos?
- O AGHUse emite relatórios, entre outras coisas, para as partes interessadas. Portanto, no cumprimento dessa funcionalidade ele utiliza um e-mail próprio para enviar as informações, Sendo elas PDFs ou senha de APIs 
- O AGHUse para dar a entrada inicial no estoque é necessário que o fornecedor envie para o sistema a nota fiscal, arquivo xml, dos materiais a serem entregues. Dessa forma o AGHUse responderá com aceitação ou rejeição.

# Configurando o Wildlfy
Para que o servidor possa fazer a comunicação externa é necessário configurar o launch do wildfly, adicionando os argumentos
`-Djboss.mail.server.host=smtp.gmail.com -Djboss.mail.server.port=587` 
# Configurando o e-mail
O e-mail escolhido para execução desse processo é o `naorespondaaghuse@ses.mt.gov.br`, este e-mail está encarregado por ser utilizado pelo sistema e nele está atribuído as principais atribuições do e-mail do sistema.
## Autenticação de dois fatores :exclamation:
Para habilitar a função a seguir é necessário que o e-mail tenha a autenticação em dois fatores. Imagem exemplo de como deve ficar a página de segurança da conta.
![image.png](/.attachments/image-d690781e-c57a-482b-8873-af15f99a00a2.png)
É de extrema importância verificar que o ícone verde está presente para demonstrar que a autenticação por dois fatores está ativa. 
Atualmente a autenticação por dois fatores do `naorespondaaghuse@ses.mt.gov.br` está associada ao servidor Mateus Goulart.

## Senhas de aplicativo:exclamation:
### Habilite a função
Para habilitar a senha de aplicativo é necessário ir na página de permitir aplicativos menos seguros. **Ative a opção.**
![image.png](/.attachments/image-0dad192b-8929-4490-bfe0-f88cc177fea8.png)
:link: Pode ser encontrada por meio desse link: https://myaccount.google.com/lesssecureapps
### Gere uma senha de aplicativo.
Para gerar uma senha você pode acesar a página seguindo o link a seguir:
:link: https://myaccount.google.com/apppasswords
Você também pode chegar na página, após acessar as configurações de autenticação de dois fatores clicando nesse card abaixo, sendo a última opção da página.
![image.png](/.attachments/image-7121f9e4-c1ef-4970-bd8d-0c28e386d2d3.png)
A página deve se apresentar de maneira semelhante ao seguir:
![image.png](/.attachments/image-a3c6c9f2-f8e0-4b4c-a258-5d2095b7e2af.png)
Espera-se que a lista de chaves esteja vazia pois acabou-se de criar. O nome da chave não interfere na funcionalidade da chave, pois não é usado no login. **Entretanto** será usado para monitoramento do comportamento da chave, por parte de quem administra o e-mail ou coisa semelhante.
Ao criar a chave anote a chave em outro lugar, pois ela **não ficará visível** após a exibição por meio desse processo, caso a perca será necessário apagar e criar de novo. Sendo que apagar é apenas uma medida de segurança em caso de vazamento. Ela se denominará **senha de aplicativo** e se apresentará na seguinte formatação `xxxx xxxx xxxx xxxx`, observe que esta senha sempre será apresentada como uma senha alfabética minúscula de 16 caracteres. Na maioria dos casos o espaço é opcional e ignorado, mas por convenção utilize sem espaço.
Para exemplificação desse documento será usado como senha de aplicativo exemplo `abcdefghijklmnopqr`.

# Configurando em arquivo de configuração
No momento que for executado o launch: `3 - CONFIGURAR SERVIDOR` ele irá ler o arquivo `app_semt.properties`, ou qualquer outro arquivo que esteja apontado como o `envfilter` no momento do launch, consultável pelo Eclipse.
Desse modo ele irá fazer a substituição de chave valor. Espera-se que no interior desse arquivo tenha uma configuração de e-mail semelhante a esta:
```
mail.host=smtp.gmail.com
mail.port=587
#mail.ssl=
mail.user=naorespondaaghuse@ses.mt.gov.br
mail.password=abcdefghijklmnopqr
mail.starttls=true
```

Para fins informativos esse processo executa uma transcrição no arquivo encontrado em 
`aghu > aghu-ear > src> main > config-outside > modules > br > gov > mec > aghu > configuration > main > properties > app-paramters.properties` no momento que esse launch é feito, hoje ele possui originalmente essa aparência (linhas 45-54):

```
############################# HOST DO SERVIDOR DE EMAIL ##########################################

#HCPA
mail_session_host=@mail.host@
mail_session_port=@mail.port@
mail_session_ssl=@mail.ssl@
mail_session_user=@mail.user@
mail_session_password=@mail.password@
mail_session_starttls=@mail.starttls@
##################################################################################################
```
Padrão de `mail.ssl` é `false`. E por enquanto não é usado.
# Configurando em arquivo de execução :warning:
Esse método é contra indicado pois estamos mexendo em ambiente quente e qualquer falha dá espaço a interrupções.
Quando executado o arquivo de configuração (tópico anterior). ele sobrescreve algumas informações nos arquivos utilizados pelo Wildfly. Na raiz do Wildfly é possível encontrar o arquivo seguindo o seguinte caminho:
`modules > br > gov > mec > configuration > main > properties > app-parameters.properties`
As informações referentes ao e-mail devem se encontrar nas linhas 45-54

```
############################# HOST DO SERVIDOR DE EMAIL ##########################################

#HCPA
mail_session_host=smtp.gmail.com
mail_session_port=587
mail_session_ssl=false
mail_session_user=naorespondaaghuse@ses.mt.gov.br
mail_session_password=abcdefghijklmnopqr
mail_session_starttls=true
##################################################################################################
```


# Informações de suporte
https://redmine-aghuse.hcpa.ufrgs.br/issues/223087?tab=history

# Todas as afirmações são segundo a realidade de hoje.
## Data: 2025-04-02
## Autor: Mateus Goulart 