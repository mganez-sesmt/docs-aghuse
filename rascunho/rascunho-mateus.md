
-- Pacientes fujões.
# Pacientes para finalizar conta.
Evasão CID Z53 / CID Z76 é usado para registrar o contato de uma pessoa com serviços de saúde




-- requisicao de material
Existe um problema para a realização dos requerimento de material.
A consulta de fornecedor é realizada ao selecionar o material requerido, entretanto esta consulta não garante que o fornecedor requerido tenha saldo.
Dessa forma se o primeiro fornecedor listado para aquele almoxarifado e produto tiver saldo vazio, dará problemas de execução. Portanto é necessário desabilitar o fornecedor-produto.
Essa consulta função não poderá se alterada pois é utilizada em outros lugares.  

Para contornar o problema, então, vá em "Manter Estoque Almoxarifado"
Caminho: Suprimentos -> Estoque -> Controle de Estoque -> Manter Estoque Almoxarifado.

Pesquise o material e o almoxarifado em questão. Dessa forma sem mexer nas ordenações a forma apresentada é a forma buscada, portanto veja seu o primeiro tem estoque, caso não tenha o desative. Desative-os até achar um que tenha. 

Resolução de código em lsita para melhoria
Será necessário duplicar e inserir uma restrição maior que 0
`criteria.add(Restrictions.gt(SceEstoqueAlmoxarifado.Fields.QUANTIDADE_DISPONIVEL.toString(), 0));`
Espera-se uma melhoria até lá.

-- resolucoes estoque
ESTOQUE


Grandes problemas relacionados ao xml.




Parâmetros 
P_GRUPOS_RASTREADOS  SCE "1"
P_GR_MAT_ODONTO  SCE  0
P_TMP_ALMOX_NAO_IMPRIMIR_RM_EFET "7, 8"
várias colunas são referenciadas, entretanto nã
o coloquei o referenciamento (visto que dá problema depois de alterar de constraint) 

erro crassio de implemtação: "desabilitaVerificacaoSapiens("

No "tipos de movimento" foi necessário habilitar o checkbox Entrada sem Licitação para o 
{Cod=77,Sigla=RCSAF}

por fim fica possível receber o material sem licitação. em "Recebimento"

forncedor do xml 19423





material.getAlmoxarifado

seq & emp_id


SceReqMaterial : sce_req_materiais
SceMovimentoMaterial : SCE_MOVIMENTO_MATERIAIS

P_AMOLX_UNICO

4+4+6/



Problema Natureza e Natureza de Despesa.
Não é possível cadastrar uma e outra, mas reclama que uma está sem.



Liberar Assinatura
#1
select
	ctbrelacio0_.NTD_CODIGO as NTD_CODI1_1482_0_,
	ctbrelacio0_.NTD_GND_CODIGO as NTD_GND_2_1482_0_,
	ctbrelacio0_.ALTERADO_EM as ALTERADO3_1482_0_,
	ctbrelacio0_.CONTA_CONTABIL as CONTA_CO4_1482_0_,
	ctbrelacio0_.CRIADO_EM as CRIADO_E5_1482_0_,
	ctbrelacio0_.NTP_CODIGO as NTP_CODI8_1482_0_,
	ctbrelacio0_.NTP_GNP_CODIGO as NTP_GNP_9_1482_0_,
	ctbrelacio0_.NTP_GNP_TAB_CODIGO as NTP_GNP10_1482_0_,
	ctbrelacio0_.IND_MODULO_CUSTO as IND_MODU6_1482_0_,
	ctbrelacio0_.NTL_GNL_VPD as NTL_GNL_7_1482_0_,
	ctbrelacio0_.SER_MATRICULA as SER_MAT11_1482_0_,
	ctbrelacio0_.SER_VIN_CODIGO as SER_VIN12_1482_0_,
	ctbrelacio0_.SER_MATRICULA_ALTERADO as SER_MAT13_1482_0_,
	ctbrelacio0_.SER_VIN_CODIGO_ALTERADO as SER_VIN14_1482_0_
from
	AGH.CTB_RELACIONA_NATUREZAS ctbrelacio0_
-- where
--	ctbrelacio0_.NTD_CODIGO =3
--	and ctbrelacio0_.NTD_GND_CODIGO =4

#2
select
	--count(*) as y0_
	*
 from
	AGH.SCO_PROGR_ENTREGA_ITENS_AF this_
where
	this_.IAF_AFN_NUMERO =2
	--and this_.IND_PLANEJAMENTO =?
	--and this_.IND_CANCELADA =?

Ao fazer um cadastro de Natureza, do tipo Despesa. É necessário de antemão ter cadastrado uma
Natureza Despesa, no qual o valor referidso para o códgio gnpd, no qual é o sistema de identificação de números múltiplos sequenciais.
Nesse caso se atentar pois isso não faz a associação automática.
para referenciar um a outro.

CtbTipoFluxo

Problemas.
Uma persistência sem verificar se existe no banco
Chave estrangeira sendo salva  de forma equivocada.

Consulta Geral de AFP ( Autorização de Fornecimento Programda) Apenas aceita com ao menos um campo.
AF n°


# Após Lib. AF Assinatura [fim do video]
	#1
vá para: Suprimentos > Compras > AF > Autoriz Fornecimento > Programação de Entregas > Ordenador - Assinatura
 e assine a AF.
	#2

caso: tenha af pronta mas a nota fiscal não esteja reconhecendo para fazer a leitura de e-mail que faz o pre-recebimento
faça: leitura do email dnv, que fará novamente o pre-recebimento
não funcionou?
faça: vá na af em questão e faça um toggle com Efetivar -> ativar -> efetivar.

-> EstoqueService.importarNotasSiloms()
-> AquisicaoContratosSilomsRN.importarNFESiloms()
-> AquisicaoContratosSilomsRN.gerarScoAutorizacaoForn()
-> AquisicaoContratosSilomsRN.inserirItensAutorizacaoForn(,)
-> AquisicaoContratosSilomsRN.inserirItemNotaPreRecebimento(,) 
-> EstoqueFacade.inserirItemNotaPreRecebimento()




SceItemNotaPreRecebimentoRN.insereRegistroPreRecebimento(,,,)
this.sceItemNotaPreRecebimentoDAO.merge(itemNotaPre)

sem retorno.

	
	
	
	private void listarEntregasPendentes(DetachedCriteria criteria) throws ApplicationBusinessException{
		LOG.info("-> listarEntregasPendentes()");
		LOG.info("-- filtro="+filtro);
		criteria.createAlias(AFNPONTO + ScoAutorizacaoForn.Fields.ITENSAUTORIZACAOFORN.toString(), IAFSEMPONTO, JoinType.LEFT_OUTER_JOIN)
				.createAlias(IAFPONTO + ScoItemAutorizacaoForn.Fields.FASES_SOLICITACAO.toString(), FSC1SEMPONTO, JoinType.LEFT_OUTER_JOIN)
				.createAlias(AFNPONTO + ScoAutorizacaoForn.Fields.SCO_LICITACAO.toString(), LCTSEMPONTO, JoinType.LEFT_OUTER_JOIN)
				.createAlias(IAFPONTO +ScoItemAutorizacaoForn.Fields.SCO_CUM_X_PROG.toString(), "CPE", JoinType.LEFT_OUTER_JOIN)
				.createAlias(FSC1PONTO + ScoFaseSolicitacao.Fields.SOLICITACAO_COMPRAS, SLCSEMPONTO, JoinType.LEFT_OUTER_JOIN)
				.createAlias(SLCPONTO + ScoSolicitacaoDeCompra.Fields.MATERIAL.toString(), MATSEMPONTO, JoinType.LEFT_OUTER_JOIN)
				.createAlias(SLCPONTO + ScoSolicitacaoDeCompra.Fields.FASES_SOLICITACAO.toString(), FSC2SEMPONTO, JoinType.LEFT_OUTER_JOIN);

		criteria.add(Restrictions.eq(FSC2PONTO+ScoFaseSolicitacao.Fields.IND_EXCLUSAO.toString(), DominioSimNao.N.isSim()));
		criteria.add(Restrictions.isNotNull(FSC2PONTO+ScoFaseSolicitacao.Fields.ITL_LCT_NUMERO.toString()));
		
		criteria.add(Restrictions.or(
				Restrictions.eq(AFNPONTO+ScoAutorizacaoForn.Fields.IND_SITUACAO.toString(), DominioSituacaoAutorizacaoFornecimento.AE), 
				Restrictions.eq(AFNPONTO+ScoAutorizacaoForn.Fields.IND_SITUACAO.toString(), DominioSituacaoAutorizacaoFornecimento.PA)
		));
		criteria.add(Restrictions.or(
				Restrictions.eq(IAFPONTO+ScoItemAutorizacaoForn.Fields.IND_SITUACAO.toString(), DominioSituacaoAutorizacaoFornecimento.AE), 
				Restrictions.eq(IAFPONTO+ScoItemAutorizacaoForn.Fields.IND_SITUACAO.toString(), DominioSituacaoAutorizacaoFornecimento.PA)
		));
		
		criteria.add(Restrictions.eq(FSC1PONTO+ScoFaseSolicitacao.Fields.IND_EXCLUSAO.toString(), DominioSimNao.N.isSim()));
		if(filtro.getFornecedor() != null && filtro.getFornecedor().getCgcCpf() != null){
			criteria.createAlias(AFNPONTO + ScoAutorizacaoForn.Fields.SCO_FORNECEDOR.toString(), "FORN", JoinType.LEFT_OUTER_JOIN);
			criteria.add(Restrictions.eq("FORN." + ScoFornecedor.Fields.CGC.toString(), filtro.getFornecedor().getCgcCpf().toString()));
			
			 
			 
			//			criteria.add(Restrictions.eq("DOC." + SceDocumentoFiscalEntrada.Fields.EMP_ID.toString(), super.getCodEmpresa()));
			 
			//Integer tamCGC = filtro.getFornecedor().getCgcCpf().toString().length();	
			//String cgc = filtro.getFornecedor().getCgcCpf().toString().substring(0, (tamCGC >8 ? 8: tamCGC));
			//String subStringCgc = null;
			/*
			if(isOracle()) {
				criteria.add(Restrictions.sqlRestriction("SUBSTR(FORN8_." + ScoFornecedor.Fields.CGC.toString()+",0,8) = " + cgc));
				subStringCgc = "            substr(forn8_.cgc, 0, 8) = substr(forn2_.cgc, 0, 8)\n";
			}else {
				criteria.add(Restrictions.sqlRestriction("CAST(SUBSTRING(CAST(FORN8_." + ScoFornecedor.Fields.CGC.toString()+" AS VARCHAR),1,8) AS INTEGER) = " + cgc));
				subStringCgc = "            cast(substr(cast(forn8_.cgc as varchar),1,8) as integer) = cast(substr(cast(forn2_.cgc as varchar),1,8) as integer)\n";
			}
			*/
			/*
			criteria.add(Restrictions.sqlRestriction(" exists (\n" +
					"        SELECT\n" +
					"            forn2_.numero\n" +
					"        FROM\n" +
					"            AGH.sco_fornecedores forn2_\n" +
					"            inner join AGH.sce_documento_fiscal_entradas doc9_ ON doc9_.frn_numero = forn2_.numero\n" +
					"        WHERE\n" +
					"			 doc9_.emp_id = " + super.getCodEmpresa() + " AND " +
					subStringCgc +
					"    )"));
			*/
			//criteria.add(Restrictions.eq(AFNPONTO+ScoAutorizacaoForn.Fields.PFR_FRN_NUMERO.toString(), filtro.getFornecedor().getNumero()));
		}
		if(filtro.getAf() != null){
			criteria.add(Restrictions.eq(AFNPONTO+ScoAutorizacaoForn.Fields.PFR_LCT_NUMERO.toString(), filtro.getAf()));
		}
		if(filtro.getCp() != null){
			criteria.add(Restrictions.eq(AFNPONTO+ScoAutorizacaoForn.Fields.NRO_COMPLEMENTO.toString(), filtro.getCp()));
		}
		
		if(filtro.getMaterial() != null && filtro.getMaterial().getCodigo() != null){
			criteria.add(Restrictions.eq(MATPONTO+ScoMaterial.Fields.CODIGO.toString(), filtro.getMaterial().getCodigo()));
		}
		if(filtro.getCum() != null){
			criteria.add(Restrictions.eq(CPE_PONTO+ScoCumXProgrEntrega.Fields.IPS_RMP_SEQ.toString(), filtro.getCum()));
		}

		criteria.setProjection(Projections.distinct(Projections.projectionList()
				.add(Projections.property(AFNPONTO+ScoAutorizacaoForn.Fields.NUMERO.toString()), EntregasPendentesVO.Fields.AFN_NUMERO.toString())
				.add(Projections.property(AFNPONTO+ScoAutorizacaoForn.Fields.PFR_LCT_NUMERO.toString()), EntregasPendentesVO.Fields.PFR_LCT_NUMERO.toString())
				.add(Projections.property(AFNPONTO+ScoAutorizacaoForn.Fields.NRO_COMPLEMENTO.toString()), EntregasPendentesVO.Fields.NUMERO_COMPLEMENTO.toString())
				.add(Projections.property(AFNPONTO+ScoAutorizacaoForn.Fields.IND_SITUACAO.toString()), EntregasPendentesVO.Fields.IND_SITUACAO.toString())
				.add(Projections.property("LCT."+ScoLicitacao.Fields.MLCCODIGO.toString()), EntregasPendentesVO.Fields.MLC_CODIGO.toString())
				.add(Projections.property(AFNPONTO+ScoAutorizacaoForn.Fields.MODALIDADE_EMPENHO.toString()), EntregasPendentesVO.Fields.MODALIDADE_EMPENHO.toString())
				.add(Projections.property(AFNPONTO+ScoAutorizacaoForn.Fields.DT_VENCTO_CONTRATO.toString()), EntregasPendentesVO.Fields.DATA_VENC_CONTRATO.toString())
				.add(Projections.sqlProjection("'Material' as " + EntregasPendentesVO.Fields.TIPO_MATERIAL,
						new String[] {EntregasPendentesVO.Fields.TIPO_MATERIAL.toString()}, new Type[] { StringType.INSTANCE }))
				));
		
		DetachedCriteria subqueryParcelaComSaldoMaterial = obterSubqueryParcelaComSaldoMaterial();
		criteria.add(Subqueries.exists(subqueryParcelaComSaldoMaterial));
		
		criteria.addOrder(Order.asc(ScoAutorizacaoForn.Fields.PFR_LCT_NUMERO.toString()));
		criteria.addOrder(Order.asc(ScoAutorizacaoForn.Fields.NRO_COMPLEMENTO.toString()));
		criteria.addOrder(Order.asc(ScoAutorizacaoForn.Fields.IND_SITUACAO.toString()));

		try {
			criteria.setResultTransformer(new AliasToBeanConstructorResultTransformer(EntregasPendentesVO.class.getConstructor(
					Integer.class
					, Integer.class
					, Short.class
					, DominioSituacaoAutorizacaoFornecimento.class
					, String.class
					, DominioModalidadeEmpenho.class
					, java.util.Date.class
					, String.class)
			));
		} catch (NoSuchMethodException e) {
			throw new ApplicationBusinessException(ApplicationBusinessExceptionCode.OCORREU_O_SEGUINTE_ERRO, e);
		} catch (SecurityException e) {
			throw new ApplicationBusinessException(ApplicationBusinessExceptionCode.OCORREU_O_SEGUINTE_ERRO, e);
		}
		LOG.info("<- listarEntregasPendentes()");
	}
	
	
	Teste de empenho  sco_justificativas
	
SCO - P_MATRICULA_CHEFE_ALMOX	
SCO - P_VINCULO_CHEFE_ALMOX 

ALTER TABLE agh.agh_microcomputadores ADD ser_matricula_alterado int4 NULL;
ALTER TABLE agh.agh_microcomputadores ADD ser_vin_codigo_alterado int2 NULL;
ALTER TABLE agh.agh_microcomputadores 
ADD CONSTRAINT agh_microcomputadores_rap_servidores_fk 
FOREIGN KEY (ser_matricula_alterado,ser_vin_codigo_alterado) 
REFERENCES agh.rap_servidores(matricula,vin_codigo);



parou na confirmação do recebimento
contabilidade > Tributação > * Consultar / Gerar



CREATE TABLE agh.sce_classif_fiscal_mercadorias (
	codigo varchar NOT NULL,
	descricao varchar(500) NULL,
	aliquota varchar(5) NULL,
	grupo varchar(3) NULL,
	"version" int4 DEFAULT 0 NULL,
	CONSTRAINT sce_classif_fiscal_mercadorias_pk PRIMARY KEY (codigo)
);

SEQUENCIA 
TB_NCT_SQ1

SCE - P_GRPO_INSTALACOES

---- ttt

A estrutura para realizar o fechamento manual de estoque.

Como isso seria possível

testar outras forma de entradas
- Forma testada de entrada é ESL
- Eles entram como produto com problema, visto que não foi realizado AF (Autorização de fornecimento)
- Entrão é só ir em com problema e liberar para ficar disponivel.

Verificar aquilo que o Wanderley falou de não  coseguir dar baixa no estoque, mesmo, considerando que eles fizeram isso como


----



Adicionar uma pessoa falsa e um servidor para o usuário AGHU.

Criado o parametro
P_EMAIL_P_FECHAMENTO_MENSAL
sendo utilizado o mesmo de 


P_AGHU_EMAIL_ENVIO
sendo então:
naoresponda@ses.mt.gov.br

+=+=+=+=+=+=

fazer uma conexão de arquivo para o aghu-estoque > src > main > java > br > gov > mec > aghu > estoque > business > NfeProcessaEmailRN.java

Apesar de ser baseado no Email, possui muitos métodos que podem ser utilizados para a adaptação.

ips_rmp_seq



Caso o VSCode-GitHub fique pedindo para escolher por qual conta fazer 
https://github.com/git-ecosystem/git-credential-manager/blob/main/docs/multiple-users.md