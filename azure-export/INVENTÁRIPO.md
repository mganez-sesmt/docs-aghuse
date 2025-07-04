# **APLICAÇÕES**
- **Ambiente de Treinamento**
  - [treinamentoaghuse.saude.mt.gov.br](http://treinamentoaghuse.saude.mt.gov.br)
  - 10.15.1.218
- **Ambiente de Homologação**
  - [homologacaoaghuse.saude.mt.gov.br](http://homologacaoaghuse.saude.mt.gov.br)
  - 10.15.1.232
- **Ambiente de Desenvolvimento**
  - 10.15.1.244
- **Ambiente de Produção**
  - [aghuse.saude.mt.gov.br](http://aghuse.saude.mt.gov.br)
  - **Aplicações**
    - 10.15.1.201 - Hostname: aghuprod01
    - 10.15.1.202 - Hostname: aghuprod02
    - 10.15.1.203 - Hostname: aghuprod03
    - 10.15.1.204 - Hostname: aghuprod04
    - 10.15.1.211 - Hostname: aghuprod05
    - 10.15.1.212 - Hostname: aghuprod06
    - 10.15.1.213 - Hostname: aghuprod07
    - 10.15.1.214 - Hostname: aghuprod08
    - 10.15.1.16 - Hostname: aghuprod09
    - 10.15.1.17 - Hostname: aghuprod10
    - 10.15.1.18 - Hostname: aghuprod11
    - 10.15.1.19 - Hostname: aghuprod12
  - **LoadBalance**
    - 10.15.1.242
    - **PARA PRODUÇÃO:** Foi configurado sendo 02 pools (pool A = aghuprod01, aghuprod02, aghuprod03, aghuprod04 | pool B = aghuprod05, aghuprod06, aghuprod07, aghuprod08).
Instalado o certificado digital para SSL através do certbot e o VIP no Firewall (200.252.205.231).
    - **Configurado os domínios:**
      - [aghuse.saude.mt.gov.br](https://aghuse.saude.mt.gov.br) - URL de Produção com HTTPS
      - [homologacaoaghuse.saude.mt.gov.br](http://homologacaoaghuse.saude.mt.gov.br) - URL de Homologação com HTTP
      - [treinamentoaghuse.saude.mt.gov.br](http://treinamentoaghuse.saude.mt.gov.br) - URL de treinamento com HTTP

## **BANCO DE DADOS**
- **Ambiente de Treinamento**
  - 10.15.1.32\agh
  - Usuario: aghu_treina 
  - Senha: trkhaw#833147
  - Arquivo: \\\10.15.1.142\sti$\CODMSIS\AGHUSE\Credenciais\store_t.jceks

- **Ambiente de Homologação**
  - 10.15.1.229\agh
  - Usuario: aghu_hml 
  - Senha: hmltjh974125
  - Arquivo: \\\10.15.1.142\sti$\CODMSIS\AGHUSE\Credenciais\store_h.jceks

- **Ambiente de Desenvolvimento**
  - 10.15.1.21\agh
  - Usuario: aghu_dev 
  - Senha: dtgjes#768359
  - Arquivo: \\\\10.15.1.142\sti$\CODMSIS\AGHUSE\Credenciais\store_g.jceks

- **Ambiente de Produção**
  - 10.15.1.243\agh (PostgreSQL 15.5)
  - Usuario: aghu_prod
  - Senha: prdskt@183520
  - 10.15.1.236 - Desativada

- **PGBouncer**
  - 10.15.1.216

## **BARRAMENTOS**
- **Active Directory - AD**
  - 10.15.1.155
- **Cadsus**
  - 10.15.1.241 - Desativada
- **CUPS**
  - 10.15.1.240:631
- **SMTP RELAY**
  - 10.15.1.237

## **AUTOMAÇÃO**
- **AGENTE LINUX**
  - 10.15.1.231