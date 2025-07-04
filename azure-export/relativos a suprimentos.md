## Outros requisitos:
Cada unidade que fará o uso de recebimento de Nota Fiscal Eletrônica (NFE), precisará de um e-mail diferente, para que as notas fiscais não se misturem.

# Alterações realizadas relativas ao funcionamento do módulo de suprimentos.

**Função:** Leitura da Nota Fiscal Eletrônica

**Operação**: Mudanças no método de autenticação, sincronização e modo de operação da leitura de e-mail.

**Justificativa**: O método antigo não possui mais a capacidade de se autenticar no Google.

# `aghu-estoque/src/java/main/ br.gov.mec.aghu.estoque.businesss.LeituraNotaFiscalEletronicaRN.java`
## DE (linhas 91-105)

``` java
/*
 * Configura as propriedades da CONTA DE E-MAIL
 */
final Properties props = new Properties();
// props.put("mail.debug", true);
props.put("mail.host", host);
props.put("mail.store.protocol", protocol);

logStage("6. É GMAIL? "+ StringUtils.contains(host, "gmail"));
if (StringUtils.contains(host, "gmail")) {
	// Testes GMAIL
	props.put("mail.pop3s.auth", true);
	props.put("mail.pop3s.port", port);
	logStage("6.1 ENCONTROU PARAMETROS PARA GMAIL");
}
```

## PARA (linhas 91-106)

``` java
/*
 * Configura as propriedades da CONTA DE E-MAIL
 */
final Properties props = new Properties();
// props.put("mail.debug", true);
props.put("mail.pop3.host", host);
//props.put("mail.store.protocol", protocol);

logStage("6. É GMAIL? "+ StringUtils.contains(host, "gmail"));
if (StringUtils.contains(host, "gmail")) {
	// Testes GMAIL
	props.put("mail.pop3s.auth", true);
	props.put("mail.pop3s.starttls.enable", true);
	props.put("mail.pop3s.port", port);
	logStage("6.1 ENCONTROU PARAMETROS PARA GMAIL");
}
```

## FIM
# `aghu-estoque/src/java/main/ br.gov.mec.aghu.estoque.business.NfeProcessaEmailRN.java`
## DE (linhas 128-148)

``` java
public void processa(String username, String password, int port, Properties props, String extensaoArquivoNFE) throws ApplicationBusinessException, MessagingException {
	Store store = null;
	Folder folder = null;
	logStage("01. INSTÂNCIANDO SESSÃO...");
	if (this.session == null) {
		this.session = Session.getInstance(props);
	}
	logStage("02. SESSÃO INICIADA: " + this.session.getProperties());
	try {
		store = session.getStore();
		// this.session.setDebug(true);
		logStage("03. Store: " + session.getStore());

		store.connect(null, port, username, password);
		folder = store.getFolder("INBOX");
		folder.open(Folder.READ_WRITE);
		logStage("04. FOLDER: " + folder);

		logStage("05. CHAMANDO METODO READ MESSAGES...");
		readMessages(folder, extensaoArquivoNFE);
	} catch (Exception e) {
...
```

## PARA (linhas 128-148)

``` java
public void processa(String username, String password, int port, Properties props, String extensaoArquivoNFE) throws ApplicationBusinessException, MessagingException {
	Store store = null;
	Folder folder = null;
	logStage("01. INSTÂNCIANDO SESSÃO...");
	if (this.session == null) {
		this.session = Session.getDefaultInstance(props);
	}
	logStage("02. SESSÃO INICIADA: " + this.session.getProperties());
	try {
		store = session.getStore("pop3s");
		// this.session.setDebug(true);
		logStage("03. Store: " + store);

		store.connect("pop.gmail.com", username, password);
		folder = store.getFolder("INBOX");
		folder.open(Folder.READ_WRITE);
		logStage("04. FOLDER: " + folder);

		logStage("05. CHAMANDO METODO READ MESSAGES...");
		readMessages(folder, extensaoArquivoNFE);
	} catch (Exception e) {
...
```
## FIM


## DE (linhas 568-617)
### Justificativa: A biblioteca importada não está conseguindo ler o campo de versão, e o funcionamento posterior funcionou ignorando a versão. Atualmente se usa nota v4 somente, então o risco de problema é baixo.
``` java
private boolean processarNotaEletronicaFiscal(byte[] bytes, DadosEmailNfeVO emailNfeVO) throws BaseException, MessagingException, ParseException {
	boolean importado = false;
	try { 
		TNfeProc notaV2 = unmarshalNotaV2(bytes);
		if (notaV2 != null && notaV2.getNFe() != null) {
			// Se importou sem erros, testa se a nota importada é realmente v2
			if (notaV2.getNFe().getInfNFe().getVersao().charAt(0) == '2') {
				return  doImportaV2(notaV2, bytes, emailNfeVO);
			}	
		}
	} catch (JAXBException e) {
		LOG.warn("ERRO AO IMPORTAR NOTA FISCAL ERRO PARSER XML " + e.toString());
		emailNfeVO.setMessage(e.toString());
		emailNfeVO.setAnexoEmail(new AnexoEmail(emailNfeVO.getFileName(), bytes, DominioMimeType.XML.getContentType()));
		importado = false;
	}
	
	try {
		br.inf.portalfiscal.nfe3.TNfeProc notaV3 = unmarshalNotaV3(bytes);
		if (notaV3 != null && notaV3.getNFe() != null) {
			// Se importou sem erros, testa se a nota importada é realmente v3
			if (notaV3.getNFe().getInfNFe().getVersao().charAt(0) == '3') {
				return doImportaV3(notaV3, bytes, emailNfeVO);
			}	
		}
	}catch (JAXBException e) {
		emailNfeVO.setMessage(e.toString());
		emailNfeVO.setAnexoEmail(new AnexoEmail(emailNfeVO.getFileName(), bytes, DominioMimeType.XML.getContentType()));
		importado = false;
	}
	
	try {
		br.inf.portalfiscal.nfe4_150.procNFe.TNfeProc notaV4 = unmarshalNotaV4(bytes);
		br.inf.portalfiscal.nfe4_150.procNFe.TIpi notaIpiV4 = unmarshalNotaTIPIV4(bytes);
		if (notaV4 != null && notaV4.getNFe() != null) {
			// Se importou sem erros, testa se a nota importada é realmente v4
			if (notaV4.getNFe().getInfNFe().getVersao().charAt(0) == '4') {
				return doImportaV4(notaV4, bytes, notaIpiV4, emailNfeVO);
			}	
		}else {
			//Após todas as tentativas em todas as verões retorna que houve erro pois não existe mais fluxo
			LOG.warn("não fez o parse do xml, nota inválida.");
		}
		return importado;
	}catch (JAXBException e) {
		emailNfeVO.setMessage(e.toString());
		emailNfeVO.setAnexoEmail(new AnexoEmail(emailNfeVO.getFileName(), bytes, DominioMimeType.XML.getContentType()));
		return importado;
	}
}
```

## PARA (linhas 569-619)

``` java
private boolean processarNotaEletronicaFiscal(byte[] bytes, DadosEmailNfeVO emailNfeVO) throws BaseException, MessagingException, ParseException {
	boolean importado = false;
	/*/
	try { 
		TNfeProc notaV2 = unmarshalNotaV2(bytes);
		if (notaV2 != null && notaV2.getNFe() != null) {
			// Se importou sem erros, testa se a nota importada é realmente v2
			if (notaV2.getNFe().getInfNFe().getVersao().charAt(0) == '2') {
				return  doImportaV2(notaV2, bytes, emailNfeVO);
			}	
		}
	} catch (JAXBException e) {
		LOG.warn("ERRO AO IMPORTAR NOTA FISCAL ERRO PARSER XML " + e.toString());
		emailNfeVO.setMessage(e.toString());
		emailNfeVO.setAnexoEmail(new AnexoEmail(emailNfeVO.getFileName(), bytes, DominioMimeType.XML.getContentType()));
		importado = false;
	}
	
	try {
		br.inf.portalfiscal.nfe3.TNfeProc notaV3 = unmarshalNotaV3(bytes);
		if (notaV3 != null && notaV3.getNFe() != null) {
			// Se importou sem erros, testa se a nota importada é realmente v3
			if (notaV3.getNFe().getInfNFe().getVersao().charAt(0) == '3') {
				return doImportaV3(notaV3, bytes, emailNfeVO);
			}	
		}
	}catch (JAXBException e) {
		emailNfeVO.setMessage(e.toString());
		emailNfeVO.setAnexoEmail(new AnexoEmail(emailNfeVO.getFileName(), bytes, DominioMimeType.XML.getContentType()));
		importado = false;
	}
	/*/
	try {
		br.inf.portalfiscal.nfe4_150.procNFe.TNfeProc notaV4 = unmarshalNotaV4(bytes);
		br.inf.portalfiscal.nfe4_150.procNFe.TIpi notaIpiV4 = unmarshalNotaTIPIV4(bytes);
		if (notaV4 != null && notaV4.getNFe() != null) {
			// Se importou sem erros, testa se a nota importada é realmente v4
			//if (notaV4.getNFe().getInfNFe().getVersao().charAt(0) == '4') {
				return doImportaV4(notaV4, bytes, notaIpiV4, emailNfeVO);
			//}	
		}else {
			//Após todas as tentativas em todas as verões retorna que houve erro pois não existe mais fluxo
			LOG.warn("não fez o parse do xml, nota inválida.");
		}
		return importado;
	}catch (JAXBException e) {
		emailNfeVO.setMessage(e.toString());
		emailNfeVO.setAnexoEmail(new AnexoEmail(emailNfeVO.getFileName(), bytes, DominioMimeType.XML.getContentType()));
		return importado;
	}
}
```

## FIM

# `aghu-web/src/main/java/ br.gov.mec.aghu.estoque.action.CadastroNotaFiscalFornecedorController.java`
## DE (linha 769)
`if(desabilitaVerificacaoSapiens()) {`
## PARA (linha 769)
`if(!desabilitaVerificacaoSapiens()) {`
## FIM
# `aghu-estoque/src/main/java/ br.gov.mec.aghu.estoque.business.CadastroNotaFiscalFornecedorController.java`
## DE (linha 333)
`if(desabilitaVerificacaoSapiens()) {`
## PARA (linha 333)
`if(!desabilitaVerificacaoSapiens()) {`
## FIM
# `aghu-estoque/src/main/java/ br.gov.mec.aghu.estoque.business.SceDocumentoFiscalEntradaRN.java`
## DE (linha 111)
`if(desabilitaVerificacaoSapiens()) {`
## PARA (linha 111)
`if(!desabilitaVerificacaoSapiens()) {`
## DE (linha 159)
`if(desabilitaVerificacaoSapiens()) {`
## PARA (linha 159)
`if(!desabilitaVerificacaoSapiens()) {`
## FIM

**Função:** Transferência entre almoxarifado

**Operação**: Registro de mudança

**Justificativa**: O método antigo está implementado errado.

# `aghu-estoque/src/main/java/ br.gov.mec.aghu.estoque.business.SceTransferenciaRN.java`
## DE (linha 125)
`transferencia.setIndImpresso("NA");`
## PARA (linha 125)
`transferencia.setIndImpresso("N");`
## FIM
