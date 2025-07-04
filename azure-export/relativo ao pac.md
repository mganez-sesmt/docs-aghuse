## 1
Módulo: `aghu-dao`
Classe: `br.gov.mec.aghu.compras.dao.AutorizacaoFornecedorPedidosQueryBuilder`

### Método: `addProjectionList()` Linhas (65-83).
Justificativa: para poder utilizar os comandos de Order que são frutos logo a baixo é necessário que os campos setados pela projection estejam agrupados.
**DE**

``` java
private void addProjectionList() {
	ProjectionList projection = Projections.projectionList()
				.add(Projections.property(AFE + ScoAutorizacaoFornecedorPedido.Fields.ID_NUM.toString()), AutorizacaoFornPedidosVO.Fields.NUMERO_AFP.toString())
				.add(Projections.property(AFE + ScoAutorizacaoFornecedorPedido.Fields.ID_AFN_NUMERO.toString()), AutorizacaoFornPedidosVO.Fields.NUMERO_AFN.toString())
				.add(Projections.property(AFE + ScoAutorizacaoFornecedorPedido.Fields.DT_ENVIO_FORNECEDOR.toString()), AutorizacaoFornPedidosVO.Fields.DT_ENVIO_FORNECEDOR.toString())
				.add(Projections.property(AFE + ScoAutorizacaoFornecedorPedido.Fields.IND_PUBLICADO.toString()), AutorizacaoFornPedidosVO.Fields.IND_PUBLICADO.toString())
				.add(Projections.property(AFE + ScoAutorizacaoFornecedorPedido.Fields.DT_PUBLICACAO.toString()), AutorizacaoFornPedidosVO.Fields.DT_PUBLICACAO.toString())
				.add(Projections.property(AFN + ScoAutorizacaoForn.Fields.PFR_LCT_NUMERO.toString()), AutorizacaoFornPedidosVO.Fields.NUMERO_PAC.toString())
				.add(Projections.property(AFN + ScoAutorizacaoForn.Fields.NRO_COMPLEMENTO.toString()), AutorizacaoFornPedidosVO.Fields.NUM_COMPLEMENTO_AF.toString())
				.add(Projections.property(PFO + ScoPropostaFornecedor.Fields.FORNECEDOR.toString()), AutorizacaoFornPedidosVO.Fields.FORNECEDOR.toString())
				.add(Projections.property(FRN + ScoFornecedor.Fields.NUMERO.toString()), AutorizacaoFornPedidosVO.Fields.NUM_FORNECEDOR.toString())
				.add(Projections.property(FRN + ScoFornecedor.Fields.RAZAO_SOCIAL.toString()), AutorizacaoFornPedidosVO.Fields.RAZAO_SOCIAL_FORNECEDOR.toString())
				.add(Projections.property(FRN + ScoFornecedor.Fields.CGC.toString()), AutorizacaoFornPedidosVO.Fields.CGC.toString())
				.add(Projections.property(FRN + ScoFornecedor.Fields.CPF.toString()), AutorizacaoFornPedidosVO.Fields.CPF.toString())
				.add(Projections.property(FRN + ScoFornecedor.Fields.DOCUMENTACAO_EM_DIA.toString()), AutorizacaoFornPedidosVO.Fields.DOCUMENTACAO_EM_DIA.toString())
				.add(Projections.property("PEFG." + RapPessoasFisicas.Fields.NOME.toString()), AutorizacaoFornPedidosVO.Fields.NOME_GESTOR.toString())
				.add(Projections.property("PEFR." + RapPessoasFisicas.Fields.NOME.toString()), AutorizacaoFornPedidosVO.Fields.NOME_SERVIDOR.toString());
		
		criteria.setProjection(projection);
	}
```

**PARA**

``` java
private void addProjectionList() {
	ProjectionList projection = Projections.projectionList()
				.add(Projections.groupProperty(AFE + ScoAutorizacaoFornecedorPedido.Fields.ID_NUM.toString()), AutorizacaoFornPedidosVO.Fields.NUMERO_AFP.toString())
				.add(Projections.groupProperty(AFE + ScoAutorizacaoFornecedorPedido.Fields.ID_AFN_NUMERO.toString()), AutorizacaoFornPedidosVO.Fields.NUMERO_AFN.toString())
				.add(Projections.groupProperty(AFE + ScoAutorizacaoFornecedorPedido.Fields.DT_ENVIO_FORNECEDOR.toString()), AutorizacaoFornPedidosVO.Fields.DT_ENVIO_FORNECEDOR.toString())
				.add(Projections.groupProperty(AFE + ScoAutorizacaoFornecedorPedido.Fields.IND_PUBLICADO.toString()), AutorizacaoFornPedidosVO.Fields.IND_PUBLICADO.toString())
				.add(Projections.groupProperty(AFE + ScoAutorizacaoFornecedorPedido.Fields.DT_PUBLICACAO.toString()), AutorizacaoFornPedidosVO.Fields.DT_PUBLICACAO.toString())
				.add(Projections.groupProperty(AFN + ScoAutorizacaoForn.Fields.PFR_LCT_NUMERO.toString()), AutorizacaoFornPedidosVO.Fields.NUMERO_PAC.toString())
				.add(Projections.groupProperty(AFN + ScoAutorizacaoForn.Fields.NRO_COMPLEMENTO.toString()), AutorizacaoFornPedidosVO.Fields.NUM_COMPLEMENTO_AF.toString())
				.add(Projections.groupProperty(PFO + ScoPropostaFornecedor.Fields.FORNECEDOR.toString()), AutorizacaoFornPedidosVO.Fields.FORNECEDOR.toString())
				.add(Projections.groupProperty(FRN + ScoFornecedor.Fields.NUMERO.toString()), AutorizacaoFornPedidosVO.Fields.NUM_FORNECEDOR.toString())
				.add(Projections.groupProperty(FRN + ScoFornecedor.Fields.RAZAO_SOCIAL.toString()), AutorizacaoFornPedidosVO.Fields.RAZAO_SOCIAL_FORNECEDOR.toString())
				.add(Projections.groupProperty(FRN + ScoFornecedor.Fields.CGC.toString()), AutorizacaoFornPedidosVO.Fields.CGC.toString())
				.add(Projections.groupProperty(FRN + ScoFornecedor.Fields.CPF.toString()), AutorizacaoFornPedidosVO.Fields.CPF.toString())
				.add(Projections.groupProperty(FRN + ScoFornecedor.Fields.DOCUMENTACAO_EM_DIA.toString()), AutorizacaoFornPedidosVO.Fields.DOCUMENTACAO_EM_DIA.toString())
				.add(Projections.groupProperty("PEFG." + RapPessoasFisicas.Fields.NOME.toString()), AutorizacaoFornPedidosVO.Fields.NOME_GESTOR.toString())
				.add(Projections.groupProperty("PEFR." + RapPessoasFisicas.Fields.NOME.toString()), AutorizacaoFornPedidosVO.Fields.NOME_SERVIDOR.toString());
		
		criteria.setProjection(projection);
	}
```
### Método: `doBuild()` Linhas (225-236)
Justificativa: a forma implementada está errada, é necessário realizar uma negação.
**DE**

``` java
@Override
protected void doBuild(DetachedCriteria criteria) {
	this.criteria = criteria;
	createAlias();
	addProjectionList();
	addRestrictions();
	if (isCount) {
		addOrder();
	}
	setResultTransformer();
	
}
```

**PARA**

``` java
@Override
protected void doBuild(DetachedCriteria criteria) {
	this.criteria = criteria;
	createAlias();
	addProjectionList();
	addRestrictions();
	if (!isCount) {
		addOrder();
	}
	setResultTransformer();
	
}
```

## 2
Módulo: `aghu-dao`
Classe: `br.gov.mec.aghu.compras.dao.FornecedoresComEntregasPendentesProgEntrQueryBuilder`
### Método`listarParcelasItemPendente()` Linhas (33-82,33-85)
Justificativa:  A função proposta não funciona no PostgreSQL do Servidor.
**DE**

``` java
... 
String projectionAtrasoDias =  isOracle() ? "(TRUNC(SYSDATE) - TRUNC(this_.DT_PREV_ENTREGA)) AS atrasoDias"
				: "(DATE_TRUNC('DAY', CURRENT_DATE) - DATE_TRUNC('DAY', this_.DT_PREV_ENTREGA)) AS atrasoDias";
...
``` 
**PARA**
``` java
...
String projectionAtrasoDias =  isOracle() ? "(TRUNC(SYSDATE) - TRUNC(this_.DT_PREV_ENTREGA)) AS atrasoDias"
				: "EXTRACT(DAY FROM (CURRENT_DATE - this_.DT_PREV_ENTREGA))::INTEGER AS atrasoDias";
		//		: "(DATE_TRUNC('DAY', CURRENT_DATE) - DATE_TRUNC('DAY', this_.DT_PREV_ENTREGA)) AS atrasoDias";
...
```

## 3
Módulo: aghu-dao
Classe: `br.gov.mec.aghu.compras.dao.FornecedoresComEntregasPendentesQueryBuilder`
### Método `montarCriteriaListarFornecedoresComEntregasPendentesComMesmoCGC()` Linhas (61-118,61-129)
Justificativa: O método arcaico utilizado era legado e usa regras de negócios não mais vigentes, principalmente pela queda do CGC e uso pleno do CNPJ. Além de usar SQL explicito ao invés de Criteria.
**DE**

``` java
...
Integer tamCGC = filtro.getFornecedorVO().getCgc().toString().length();	
			String cgc = filtro.getFornecedorVO().getCgc().toString().substring(0, (tamCGC >8 ? 8: tamCGC));
			
			if(isOracle()) {
				criteria.add(Restrictions.sqlRestriction("SUBSTR("+ScoFornecedor.Fields.CGC.toString()+",0,8) = " + cgc));
			}else {
				criteria.add(Restrictions.sqlRestriction("CAST(SUBSTRING(CAST("+ScoFornecedor.Fields.CGC.toString()+" AS VARCHAR),1,8) AS INTEGER) = " + cgc));
			}
...
```

**PARA**

``` java
...
//Integer tamCGC = filtro.getFornecedorVO().getCgc().toString().length();	
			//String cgc = filtro.getFornecedorVO().getCgc().toString().substring(0, (tamCGC >8 ? 8: tamCGC));
			
			if(filtro.getFornecedor() != null && filtro.getFornecedor().getCgcCpf() != null){
				criteria.createAlias(AFNPONTO + ScoAutorizacaoForn.Fields.SCO_FORNECEDOR.toString(), "FORN", JoinType.LEFT_OUTER_JOIN);
				criteria.add(Restrictions.eq("FORN." + ScoFornecedor.Fields.CGC.toString(), filtro.getFornecedor().getCgcCpf()));
			}
			//if(isOracle()) {
			//	criteria.add(Restrictions.sqlRestriction("SUBSTR("+ScoFornecedor.Fields.CGC.toString()+",0,8) = " + cgc));
			//}else {
			//	criteria.add(Restrictions.sqlRestriction("CAST(SUBSTRING(CAST("+ScoFornecedor.Fields.CGC.toString()+" AS VARCHAR),1,8) AS INTEGER) = " + cgc));
			//}
...
```
## 4
Módulo: `aghu-dao`
Classe: `br.gov.mec.aghu.compras.dao.ScoAutorizacaoFornDAO`
### Método `adicionarRestricaoFornecedor()` Linhas (1529-1554,1544-1567)
Justificativa: Postgresql não aceitou o tipo String, dessa forma necessário utilizar o mais gneérico do SQL TEXT.
**DE**

``` java
private void adicionarRestricaoFornecedor(DetachedCriteria criteria, FornecedorVO fornecedorVO){
		if (fornecedorVO != null) {			
			String cnpjRaiz;
			if (fornecedorVO.getCpfCnpj() != null) {
				if(fornecedorVO.getCpfCnpj().length() > 7){
					cnpjRaiz = fornecedorVO.getCpfCnpj().substring(0, 7);
				}else{
					cnpjRaiz = StringUtils.EMPTY;
				}

				if (StringUtils.isNotBlank(cnpjRaiz)){
					if (isOracle()){
					   criteria.add(Restrictions.sqlRestriction("substr(to_char(coalesce(frn4_." + ScoFornecedor.Fields.CGC.toString() + ", frn4_." + ScoFornecedor.Fields.CPF.toString() + ")), 0, 7) = '" + cnpjRaiz + "' "));
					} else {
					   criteria.add(Restrictions.sqlRestriction("substring(cast(coalesce(frn4_." + ScoFornecedor.Fields.CGC.toString() + ", frn4_." + ScoFornecedor.Fields.CPF.toString() + ") as string), 0, 8) = '" + cnpjRaiz + "' "));
					}
				}
				else {
					criteria.add(Restrictions.eq("AFN." + ScoAutorizacaoForn.Fields.PFR_FRN_NUMERO.toString(), fornecedorVO.getNumero()));
				}
			}
			else {
			   criteria.add(Restrictions.eq("AFN." + ScoAutorizacaoForn.Fields.PFR_FRN_NUMERO.toString(), fornecedorVO.getNumero()));
			}
		}
	}
```

**PARA**

``` java
private void adicionarRestricaoFornecedor(DetachedCriteria criteria, FornecedorVO fornecedorVO){
	if (fornecedorVO != null) {			
		String cnpjRaiz;
		if (fornecedorVO.getCpfCnpj() != null) {
			if(fornecedorVO.getCpfCnpj().length() > 7){
				cnpjRaiz = fornecedorVO.getCpfCnpj().substring(0, 7);
			}else{
				cnpjRaiz = StringUtils.EMPTY;
			}

			if (StringUtils.isNotBlank(cnpjRaiz)){
				if (isOracle()){
				   criteria.add(Restrictions.sqlRestriction("substr(to_char(coalesce(frn4_." + ScoFornecedor.Fields.CGC.toString() + ", frn4_." + ScoFornecedor.Fields.CPF.toString() + ")), 0, 7) = '" + cnpjRaiz + "' "));
				} else {
				   criteria.add(Restrictions.sqlRestriction("substring(cast(coalesce(frn4_." + ScoFornecedor.Fields.CGC.toString() + ", frn4_." + ScoFornecedor.Fields.CPF.toString() + ") as TEXT), 0, 8) = '" + cnpjRaiz + "' "));
				}
			} else {
				criteria.add(Restrictions.eq("AFN." + ScoAutorizacaoForn.Fields.PFR_FRN_NUMERO.toString(), fornecedorVO.getNumero()));
			}
		} else {
		   criteria.add(Restrictions.eq("AFN." + ScoAutorizacaoForn.Fields.PFR_FRN_NUMERO.toString(), fornecedorVO.getNumero()));
		}
	}
}
```
## 5 
Módulo: `aghu-dao` 

Classe: `br.gov.mec.aghu.compras.dao.ScoAutorizacaoFornecedorPedidoDAO`

### Função`getPesquisarAutorizacaoAoAcessarTela` Linha (942-983,942-995)
Justificativa: O método não funciona em PostgreSql.
**DE**

``` java
private Query getPesquisarAutorizacaoAoAcessarTela(boolean count) {
		StringBuilder hql = new StringBuilder(800);
		if (count) {
			hql.append("select count(*) ");
		} else {
			hql.append(
					"select new br.gov.mec.aghu.compras.vo.AutorizacaoFornPedidosVO(afn.propostaFornecedor.id.lctNumero, afn.nroComplemento"
					+ ", afe.id.numero, afe.indPublicado, afe.id.afnNumero, afe.dtEnvioFornecedor, afe.dtPublicacao"
					+ ", pfo.id.frnNumero, frn.numero, frn.razaoSocial , frn.cgc , frn.cpf"
					+ ", pefg.nome, pefr.nome)");
		}
		
		hql.append(" from ");
		hql.append(" ScoAutorizacaoFornecedorPedido as afe ");
		hql.append(" inner join afe.").append(ScoAutorizacaoFornecedorPedido.Fields.SCO_AUTORIZACAO_FORN.toString()).append(" as afn ");
		hql.append(" inner join afn.").append(ScoAutorizacaoForn.Fields.PROPOSTA_FORNECEDOR.toString()).append(" as pfo ");
		hql.append(" inner join pfo.").append(ScoPropostaFornecedor.Fields.FORNECEDOR.toString()).append(" as frn ");
		hql.append(" left outer join afn.").append(ScoAutorizacaoForn.Fields.SERVIDOR_GESTOR.toString()).append(" as seg ");
		hql.append(" left outer join seg.").append(RapServidores.Fields.PESSOA_FISICA.toString()).append(" as pefg ");
		hql.append(" left outer join seg.").append(RapServidores.Fields.PESSOA_FISICA.toString()).append(" as pefr ");
		hql.append(" where ");
		hql.append(" afe.id.afnNumero = afn.numero and afe.indPublicado is null and afe.id.afnNumero||afe.id.numero  in ");
			hql.append(" (");
			hql.append(" select peiaf.scoAfPedido.id.afnNumero || peiaf.scoAfPedido.id.numero from ScoProgEntregaItemAutorizacaoFornecimento as peiaf");
			hql.append(" where ");
			hql.append(" peiaf.scoAfPedido.id.afnNumero = afe.id.afnNumero and peiaf.scoAfPedido.id.numero = afe.id.numero and peiaf.indAssinatura  ||'' = 'S' ");
			hql.append(" and peiaf.indEnvioFornecedor ||'' = 'N' ");
			hql.append(" and peiaf.indImpressa        ||'' = 'N' and peiaf.indCancelada ||'' = 'N' and peiaf.indTramiteInterno ||'' = 'N' ");
			hql.append(" and (peiaf.indEmpenhada      ||'' = 'S' or peiaf.indEmpenhada  ||'' = 'P' or peiaf.jstCodigo is not null) AND peiaf.dtEntrega is null ");
			hql.append(") ");
		hql.append(" and ");
		hql.append("  afn.numero not in ");
			hql.append("  (select afn.numero from ScoProgrCodAcessoForn as pca, ScoAutorizacaoForn as afn ");
			hql.append(" where ");
			hql.append(" afn.numero = afe.id.afnNumero and pca.scoFornecedor.numero = afn.propostaFornecedor.id.frnNumero and pca.dtEnvioFornecedor is not null) ");
		
		if (!count) {
			hql.append(" order by 1,2,3 ");
		}
		Query query = this.createHibernateQuery(hql.toString());
		return query;
	}
```

**PARA**

``` java
private Query getPesquisarAutorizacaoAoAcessarTela(boolean count) {
		StringBuilder hql = new StringBuilder(800);
		if (count) {
			hql.append("select count(*) ");
		} else {
			hql.append(
					"select new br.gov.mec.aghu.compras.vo.AutorizacaoFornPedidosVO(afn.propostaFornecedor.id.lctNumero, afn.nroComplemento"
					+ ", afe.id.numero, afe.indPublicado, afe.id.afnNumero, afe.dtEnvioFornecedor, afe.dtPublicacao"
					+ ", pfo.id.frnNumero, frn.numero, frn.razaoSocial , frn.cgc , frn.cpf"
					+ ", pefg.nome, pefr.nome)");
		}
		
		hql.append(" from ");
		hql.append(" ScoAutorizacaoFornecedorPedido as afe ");
		hql.append(" inner join afe.").append(ScoAutorizacaoFornecedorPedido.Fields.SCO_AUTORIZACAO_FORN.toString()).append(" as afn ");
		hql.append(" inner join afn.").append(ScoAutorizacaoForn.Fields.PROPOSTA_FORNECEDOR.toString()).append(" as pfo ");
		hql.append(" inner join pfo.").append(ScoPropostaFornecedor.Fields.FORNECEDOR.toString()).append(" as frn ");
		hql.append(" left outer join afn.").append(ScoAutorizacaoForn.Fields.SERVIDOR_GESTOR.toString()).append(" as seg ");
		hql.append(" left outer join seg.").append(RapServidores.Fields.PESSOA_FISICA.toString()).append(" as pefg ");
		hql.append(" left outer join seg.").append(RapServidores.Fields.PESSOA_FISICA.toString()).append(" as pefr ");
		hql.append(" where ");
		if(isOracle){
			hql.append(" afe.id.afnNumero = afn.numero and afe.indPublicado is null and afe.id.afnNumero||afe.id.numero  in ");
		}else{
			hql.append(" afe.id.afnNumero = afn.numero and afe.indPublicado is null and (afe.id.afnNumero, afe.id.numero)  in ");
		}
			hql.append(" (");
			if(isOracle){
				hql.append(" select peiaf.scoAfPedido.id.afnNumero || peiaf.scoAfPedido.id.numero from ScoProgEntregaItemAutorizacaoFornecimento as peiaf");
			}else{				
				hql.append(" select peiaf.scoAfPedido.id.afnNumero , peiaf.scoAfPedido.id.numero from ScoProgEntregaItemAutorizacaoFornecimento as peiaf");
			}
			hql.append(" where ");
			hql.append(" peiaf.scoAfPedido.id.afnNumero = afe.id.afnNumero and peiaf.scoAfPedido.id.numero = afe.id.numero and peiaf.indAssinatura  ||'' = 'S' ");
			hql.append(" and peiaf.indEnvioFornecedor ||'' = 'N' ");
			hql.append(" and peiaf.indImpressa        ||'' = 'N' and peiaf.indCancelada ||'' = 'N' and peiaf.indTramiteInterno ||'' = 'N' ");
			hql.append(" and (peiaf.indEmpenhada      ||'' = 'S' or peiaf.indEmpenhada  ||'' = 'P' or peiaf.jstCodigo is not null) AND peiaf.dtEntrega is null ");
			hql.append(") ");
		hql.append(" and ");
		if(isOracle){
			hql.append("  afn.numero not in ");
		}else{
			hql.append("  (afn.numero) not in ");
		}
			hql.append("  (select afn.numero from ScoProgrCodAcessoForn as pca, ScoAutorizacaoForn as afn ");
			hql.append(" where ");
			hql.append(" afn.numero = afe.id.afnNumero and pca.scoFornecedor.numero = afn.propostaFornecedor.id.frnNumero and pca.dtEnvioFornecedor is not null) ");
		
		if (!count) {
			hql.append(" order by 1,2,3 ");
		}
		Query query = this.createHibernateQuery(hql.toString());
		return query;
	}
```

## 6
Módulo: `aghu-dao`

Classe: `br.gov.mec.aghu.estoque.dao.SceDocumentoFiscalEntradaDAO`

### Função `montarCriteriaNroNFSuggestion` Linhas (1350-1366,1350-1385)
Justificativa: Informação levantada pelo Marciano, Não exatamente a PAC, mas por mexer com notas fiscais é importante a correção.
**DE**

``` java
private DetachedCriteria montarCriteriaNroNFSuggestion(String parametro){
		DetachedCriteria criteria = DetachedCriteria.forClass(SceDocumentoFiscalEntrada.class, "DFE");
		criteria.createAlias("DFE."+SceDocumentoFiscalEntrada.Fields.FORNECEDOR.toString(), "FRN",JoinType.INNER_JOIN);
		if (StringUtils.isNotBlank(parametro)) {
			if(CoreUtil.isNumeroLong(parametro)){
				criteria.add(Restrictions.eq(SceDocumentoFiscalEntrada.Fields.NUMERO.toString(), Long.parseLong(parametro)));				
			}
		}
		
		DetachedCriteria subquery = DetachedCriteria.forClass(SceEntrSaidSemLicitacao.class,"ESL");		
		subquery.add(Restrictions.eqProperty("ESL." + SceEntrSaidSemLicitacao.Fields.DFE_SEQ , "DFE." + SceDocumentoFiscalEntrada.Fields.SEQ));
		subquery.setProjection(Projections.property("ESL." + SceEntrSaidSemLicitacao.Fields.SEQ.toString()));
		criteria.add(Subqueries.exists(subquery));
		
		
		return criteria;
	}
```

**PARA**

``` java
private DetachedCriteria montarCriteriaNroNFSuggestion(String parametro){
		DetachedCriteria criteria = DetachedCriteria.forClass(SceDocumentoFiscalEntrada.class, "DFE");
		criteria.createAlias("DFE."+SceDocumentoFiscalEntrada.Fields.FORNECEDOR.toString(), "FRN",JoinType.INNER_JOIN);
		if (StringUtils.isNotBlank(parametro)) {
			if(CoreUtil.isNumeroLong(parametro)){
				criteria.add(Restrictions.eq(SceDocumentoFiscalEntrada.Fields.NUMERO.toString(), Long.parseLong(parametro)));				
			}
		}
		
		DetachedCriteria subquery = DetachedCriteria.forClass(SceEntrSaidSemLicitacao.class,"ESL");

		// (1A) Correção CHATGPT
		// (ESL.dfe_seq = DFE.seq)
		Criterion atribuida = Restrictions.eqProperty(
			"ESL." + SceEntrSaidSemLicitacao.Fields.DFE_SEQ,
			"DFE." + SceDocumentoFiscalEntrada.Fields.SEQ
		);
		// (ESL.dfe_seq IS NULL)
		Criterion naoAtribuida = Restrictions.isNull(
			"ESL." + SceEntrSaidSemLicitacao.Fields.DFE_SEQ
		);
		// (atribuição ou disponível)
		subquery.add(Restrictions.or(atribuida, naoAtribuida));
		// seleciona qualquer registro que atenda
		subquery.setProjection(Projections.property("ESL." + SceEntrSaidSemLicitacao.Fields.SEQ.toString()));
		// critério principal recebe EXISTS (subquery)
		criteria.add(Subqueries.exists(subquery));
		//subquery.add(Restrictions.eqProperty("ESL." + SceEntrSaidSemLicitacao.Fields.DFE_SEQ , "DFE." + SceDocumentoFiscalEntrada.Fields.SEQ));
		// (1A)

		subquery.setProjection(Projections.property("ESL." + SceEntrSaidSemLicitacao.Fields.SEQ.toString()));
		criteria.add(Subqueries.exists(subquery));
		
		
		return criteria;
	}
```
## 7
Módulo: `aghu-dao`

Classe: `br.gov.mec.aghu.estoque.dao.SceE660IncFornDAO`
### Função obterNcmCFOP Linhas (574-611,574-619)
Justificativa: correção dos SQL explicíto. Adicionado SQL PostgreSql.
**DE**

``` java
public String obterNcmCFOP(Integer frnNumero,  Integer dfeNumero, String dfeSerie, boolean flagNcm, boolean executarSubCriteria) {
		DetachedCriteria criteria = DetachedCriteria.forClass(SceE660IncForn.class, "E660");

		criteria.add(Restrictions.eq("E660." + SceE660IncForn.Fields.CODFOR.toString(), frnNumero));
		criteria.add(Restrictions.eq("E660." + SceE660IncForn.Fields.NUMNFI.toString(), dfeNumero));
		criteria.add(Restrictions.eq("E660." + SceE660IncForn.Fields.CODSNF.toString(), dfeSerie));

		if (flagNcm){

			if (executarSubCriteria) {
				DetachedCriteria subQuery = DetachedCriteria.forClass(CtbNcmTributo.class, "NCM");
				subQuery.add(Restrictions.sqlRestriction("NCM_.CODIGO = TO_NUMBER(TRIM(this_.CLAFIS))"));
				subQuery.setProjection(Projections.property("NCM." + CtbNcmTributo.Fields.CODIGO.toString()));
				criteria.add(Subqueries.notExists(subQuery));
			}

			criteria.setProjection(Projections.distinct(Projections.projectionList()
					.add(Projections.property("E660." + SceE660IncForn.Fields.CLAFIS.toString()))));
		} else {
			if (executarSubCriteria) {
				DetachedCriteria subQuery = DetachedCriteria.forClass(SceCfop.class, "CFOP");
				subQuery.add(Restrictions.sqlRestriction("CFOP_.CODIGO = TO_NUMBER(TRIM(this_.CODCLF))"));
				subQuery.setProjection(Projections.property("CFOP." + SceCfop.Fields.CODIGO.toString()));
				criteria.add(Subqueries.notExists(subQuery));
			}

			criteria.setProjection(Projections.distinct(Projections.projectionList()
					.add(Projections.property("E660." + SceE660IncForn.Fields.CODCLF.toString()))));
		}

		List<String> retorno = executeCriteria(criteria);

		if (CollectionUtils.isNotEmpty(retorno)) {
			return StringUtils.join(retorno, ", ");
		} else {
			return null;
		}
	}
```

**PARA**
``` java
public String obterNcmCFOP(Integer frnNumero,  Integer dfeNumero, String dfeSerie, boolean flagNcm, boolean executarSubCriteria) {
		DetachedCriteria criteria = DetachedCriteria.forClass(SceE660IncForn.class, "E660");

		criteria.add(Restrictions.eq("E660." + SceE660IncForn.Fields.CODFOR.toString(), frnNumero));
		criteria.add(Restrictions.eq("E660." + SceE660IncForn.Fields.NUMNFI.toString(), dfeNumero));
		criteria.add(Restrictions.eq("E660." + SceE660IncForn.Fields.CODSNF.toString(), dfeSerie));

		if (flagNcm){

			if (executarSubCriteria) {
				DetachedCriteria subQuery = DetachedCriteria.forClass(CtbNcmTributo.class, "NCM");
				if(isOracle()){
					subQuery.add(Restrictions.sqlRestriction("NCM_.CODIGO = TO_NUMBER(TRIM(this_.CLAFIS))"));
				}else{
					subQuery.add(Restrictions.sqlRestriction("NCM_.CODIGO = (TRIM(this_.CLAFIS)::numeric)"));
				}
				subQuery.setProjection(Projections.property("NCM." + CtbNcmTributo.Fields.CODIGO.toString()));
				criteria.add(Subqueries.notExists(subQuery));
			}

			criteria.setProjection(Projections.distinct(Projections.projectionList()
					.add(Projections.property("E660." + SceE660IncForn.Fields.CLAFIS.toString()))));
		} else {
			if (executarSubCriteria) {
				DetachedCriteria subQuery = DetachedCriteria.forClass(SceCfop.class, "CFOP");
				if(isOracle()){
					subQuery.add(Restrictions.sqlRestriction("CFOP_.CODIGO = TO_NUMBER(TRIM(this_.CODCLF))"));
				}else{
					subQuery.add(Restrictions.sqlRestriction("CFOP_.CODIGO = (TRIM(this_.CODCLF)::numeric)"));
				}
				subQuery.setProjection(Projections.property("CFOP." + SceCfop.Fields.CODIGO.toString()));
				criteria.add(Subqueries.notExists(subQuery));
			}

			criteria.setProjection(Projections.distinct(Projections.projectionList()
					.add(Projections.property("E660." + SceE660IncForn.Fields.CODCLF.toString()))));
		}

		List<String> retorno = executeCriteria(criteria);

		if (CollectionUtils.isNotEmpty(retorno)) {
			return StringUtils.join(retorno, ", ");
		} else {
			return null;
		}
	}
```
## 8
Módulo: `aghu-dao`

Classe: `br.gov.mec.aghu.estoque.dao.SceItemNotaPreRecebimentoDAO`
### Função `obterAFsComMaterial` Linhas (77-145,81-153)
Justificativa: A correção é tanto ligada por regra de negócio arcaica, atualização de SQL. Atualmente não se usa mais CGC, talvez seja parte do sistema legado do HCPA, ou de coisas ainda mais antigas. CGC agora é o CNPJ desde 1998.
**DE**
``` java
public List<AutorizacaoFornecedorMaterialVO> obterAFsComMaterial(Integer codigoMaterialHospital, Integer codigoFornecedor, Boolean assinatura) {
		
		DetachedCriteria criteria = DetachedCriteria.forClass(ScoFaseSolicitacao.class, "FSC");
		
		StringBuilder somatorio = new StringBuilder(500);
		somatorio.append(" SUM(pea2_.QTDE - COALESCE(pea2_.QTDE_ENTREGUE,0) - COALESCE( "
				+ "        (select SUM(QUANTIDADE) from AGH.SCE_ITEM_NOTA_PRE_RECEBIMENTO IPR "
				+ "        where IPR.IAF_AFN_NUMERO = iaf1_.AFN_NUMERO and IPR.IAF_NUMERO = iaf1_.NUMERO  and IPR.IND_SITUACAO = 'G'),0)) saldoAF ");
		
		ProjectionList projList = Projections.projectionList();
		projList.add(Projections.property(AFN + ScoAutorizacaoForn.Fields.DT_GERACAO.toString()), "dtGeracaoAFN");
		projList.add(Projections.property(AFN + ScoAutorizacaoForn.Fields.NUMERO.toString()), "numeroAFN");
		projList.add(Projections.property(IAF + ScoItemAutorizacaoForn.Fields.NUMERO.toString()), "numeroIAF");
		projList.add(Projections.property(IAF + ScoItemAutorizacaoForn.Fields.FATOR_CONVERSAO_FORM.toString()), "fatorConversaoFornIAF");
		projList.add(Projections.sqlProjection(somatorio.toString(), new String [] {"saldoAF"}, new Type[] {new BigDecimalType()}));
		projList.add(Projections.groupProperty(AFN + ScoAutorizacaoForn.Fields.DT_GERACAO.toString()));
		projList.add(Projections.groupProperty(AFN + ScoAutorizacaoForn.Fields.NUMERO.toString()));
		projList.add(Projections.groupProperty(IAF + ScoItemAutorizacaoForn.Fields.NUMERO.toString()));
		projList.add(Projections.groupProperty(IAF + ScoItemAutorizacaoForn.Fields.FATOR_CONVERSAO_FORM.toString()));
		
		criteria.setProjection(projList);
		
		criteria.createAlias("FSC."+ScoFaseSolicitacao.Fields.SCO_ITENS_AUTORIZACAO_FORN.toString(), "IAF", JoinType.INNER_JOIN);
		criteria.createAlias(IAF+ScoItemAutorizacaoForn.Fields.PROG_ENTREGAS.toString(), "PEA", JoinType.INNER_JOIN);
		criteria.createAlias(IAF+ScoItemAutorizacaoForn.Fields.AUTORIZACAO_FORN.toString(), "AFN", JoinType.INNER_JOIN);
		criteria.createAlias("FSC."+ScoFaseSolicitacao.Fields.SOLICITACAO_COMPRAS.toString(), "SLC", JoinType.INNER_JOIN);
		criteria.createAlias(AFN+ScoAutorizacaoForn.Fields.SCO_FORNECEDOR.toString(), "FRN1", JoinType.INNER_JOIN);

		if (codigoFornecedor != null) {
			String restricaoFornecedor;
			if(isOracle()){
				restricaoFornecedor = "lpad(frn1x5_.cgc,8) in (select lpad(FRN2.cgc,8) from agh.sco_fornecedores FRN2 where FRN2.NUMERO = "+codigoFornecedor+")";
			}else{
				restricaoFornecedor = "lpad(cast(frn1x5_.cgc as varchar),8) in (select lpad(cast(FRN2.cgc as varchar),8) from agh.sco_fornecedores FRN2 where FRN2.NUMERO = "+codigoFornecedor+")";	
			}
			
			criteria.add(Restrictions.sqlRestriction(restricaoFornecedor));
		}
		
		List<DominioSituacaoAutorizacaoFornecedor> listaDominioSituacaoAutorizacaoFornecedor = new ArrayList<DominioSituacaoAutorizacaoFornecedor>();
		listaDominioSituacaoAutorizacaoFornecedor.add(DominioSituacaoAutorizacaoFornecedor.AE);
		listaDominioSituacaoAutorizacaoFornecedor.add(DominioSituacaoAutorizacaoFornecedor.PA);
		
		criteria.add(Restrictions.in(IAF+ScoItemAutorizacaoForn.Fields.IND_SITUACAO.toString(), listaDominioSituacaoAutorizacaoFornecedor));
		criteria.add(Restrictions.eq("PEA."+ScoProgEntregaItemAutorizacaoFornecimento.Fields.IND_PLANEJAMENTO.toString(), Boolean.TRUE));
		
		if (assinatura != null && assinatura.equals(Boolean.TRUE)) {
			criteria.add(Restrictions.eq("PEA."+ScoProgEntregaItemAutorizacaoFornecimento.Fields.IND_ASSINATURA.toString(), Boolean.TRUE));
		}
		
		criteria.add(Restrictions.eq("PEA."+ScoProgEntregaItemAutorizacaoFornecimento.Fields.IND_CANCELADA.toString(), Boolean.FALSE));		
		
		StringBuilder restricao = new StringBuilder(500);
		restricao.append(" ((COALESCE(pea2_.QTDE_ENTREGUE,0) + COALESCE( "
				+ "       (select SUM(QUANTIDADE) from AGH.SCE_ITEM_NOTA_PRE_RECEBIMENTO IPR "
				+ "        where IPR.IAF_AFN_NUMERO = iaf1_.AFN_NUMERO and IPR.IAF_NUMERO = iaf1_.NUMERO and IPR.IND_SITUACAO = 'G'),0) "
				+ "        ) < pea2_.QTDE) ");
		criteria.add(Restrictions.sqlRestriction(restricao.toString()));
		
		if (codigoMaterialHospital != null) {
			criteria.add(Restrictions.eq("SLC."+ScoSolicitacaoDeCompra.Fields.MAT_CODIGO.toString(), codigoMaterialHospital));
		}
		
		criteria.addOrder(Order.asc(AFN +ScoAutorizacaoForn.Fields.DT_GERACAO.toString()));
				
		criteria.setResultTransformer(Transformers.aliasToBean(AutorizacaoFornecedorMaterialVO.class));
		
		return executeCriteria(criteria);
	}
```
**PARA**
``` java
public List<AutorizacaoFornecedorMaterialVO> obterAFsComMaterial(Integer codigoMaterialHospital, Integer codigoFornecedor, Boolean assinatura) {
		
		DetachedCriteria criteria = DetachedCriteria.forClass(ScoFaseSolicitacao.class, "FSC");
		
		StringBuilder somatorio = new StringBuilder(500);
		somatorio.append(" SUM(pea2_.QTDE - COALESCE(pea2_.QTDE_ENTREGUE,0) - COALESCE( "
				+ "        (select SUM(QUANTIDADE) from AGH.SCE_ITEM_NOTA_PRE_RECEBIMENTO IPR "
				+ "        where IPR.IAF_AFN_NUMERO = iaf1_.AFN_NUMERO and IPR.IAF_NUMERO = iaf1_.NUMERO  and IPR.IND_SITUACAO = 'G'),0)) saldoAF ");
		
		ProjectionList projList = Projections.projectionList();
		projList.add(Projections.property(AFN + ScoAutorizacaoForn.Fields.DT_GERACAO.toString()), "dtGeracaoAFN");
		projList.add(Projections.property(AFN + ScoAutorizacaoForn.Fields.NUMERO.toString()), "numeroAFN");
		projList.add(Projections.property(IAF + ScoItemAutorizacaoForn.Fields.NUMERO.toString()), "numeroIAF");
		projList.add(Projections.property(IAF + ScoItemAutorizacaoForn.Fields.FATOR_CONVERSAO_FORM.toString()), "fatorConversaoFornIAF");
		projList.add(Projections.sqlProjection(somatorio.toString(), new String [] {"saldoAF"}, new Type[] {new BigDecimalType()}));
		projList.add(Projections.groupProperty(AFN + ScoAutorizacaoForn.Fields.DT_GERACAO.toString()));
		projList.add(Projections.groupProperty(AFN + ScoAutorizacaoForn.Fields.NUMERO.toString()));
		projList.add(Projections.groupProperty(IAF + ScoItemAutorizacaoForn.Fields.NUMERO.toString()));
		projList.add(Projections.groupProperty(IAF + ScoItemAutorizacaoForn.Fields.FATOR_CONVERSAO_FORM.toString()));
		
		criteria.setProjection(projList);
		
		criteria.createAlias("FSC."+ScoFaseSolicitacao.Fields.SCO_ITENS_AUTORIZACAO_FORN.toString(), "IAF", JoinType.INNER_JOIN);
		criteria.createAlias(IAF+ScoItemAutorizacaoForn.Fields.PROG_ENTREGAS.toString(), "PEA", JoinType.INNER_JOIN);
		criteria.createAlias(IAF+ScoItemAutorizacaoForn.Fields.AUTORIZACAO_FORN.toString(), "AFN", JoinType.INNER_JOIN);
		criteria.createAlias("FSC."+ScoFaseSolicitacao.Fields.SOLICITACAO_COMPRAS.toString(), "SLC", JoinType.INNER_JOIN);
		criteria.createAlias(AFN+ScoAutorizacaoForn.Fields.SCO_FORNECEDOR.toString(), "FRN1", JoinType.INNER_JOIN);

		if (codigoFornecedor != null) {
			String restricaoFornecedor;
			if(isOracle()){
				restricaoFornecedor = "lpad(frn1x5_.cgc,8) in (select lpad(FRN2.cgc,8) from agh.sco_fornecedores FRN2 where FRN2.NUMERO = "+codigoFornecedor+")";
			}else{
				restricaoFornecedor = "lpad(cast(frn1x5_.cgc as varchar),8) in (select lpad(cast(FRN2.cgc as varchar),8) from agh.sco_fornecedores FRN2 where FRN2.NUMERO = "+codigoFornecedor+")";	
			}
			//criteria.add(Restrictions.sqlRestriction(restricaoFornecedor));
		}
		if (codigoFornecedor != null) { 
			criteria.add(Restrictions.eq(
				"AFN."+ScoAutorizacaoForn.Fields.PFR_FRN_NUMERO.toString()
				, codigoFornecedor
			));
		}
		List<DominioSituacaoAutorizacaoFornecedor> listaDominioSituacaoAutorizacaoFornecedor = new ArrayList<DominioSituacaoAutorizacaoFornecedor>();
		listaDominioSituacaoAutorizacaoFornecedor.add(DominioSituacaoAutorizacaoFornecedor.AE);
		listaDominioSituacaoAutorizacaoFornecedor.add(DominioSituacaoAutorizacaoFornecedor.PA);
		
		criteria.add(Restrictions.in(IAF+ScoItemAutorizacaoForn.Fields.IND_SITUACAO.toString(), listaDominioSituacaoAutorizacaoFornecedor));
		criteria.add(Restrictions.eq("PEA."+ScoProgEntregaItemAutorizacaoFornecimento.Fields.IND_PLANEJAMENTO.toString(), Boolean.TRUE));
		
		if (assinatura != null && assinatura.equals(Boolean.TRUE)) {
			criteria.add(Restrictions.eq("PEA."+ScoProgEntregaItemAutorizacaoFornecimento.Fields.IND_ASSINATURA.toString(), Boolean.TRUE));
		}
		
		criteria.add(Restrictions.eq("PEA."+ScoProgEntregaItemAutorizacaoFornecimento.Fields.IND_CANCELADA.toString(), Boolean.FALSE));		
		
		StringBuilder restricao = new StringBuilder(500);
		restricao.append(" ((COALESCE(pea2_.QTDE_ENTREGUE,0) + COALESCE( "
				+ "       (select SUM(QUANTIDADE) from AGH.SCE_ITEM_NOTA_PRE_RECEBIMENTO IPR "
				+ "        where IPR.IAF_AFN_NUMERO = iaf1_.AFN_NUMERO and IPR.IAF_NUMERO = iaf1_.NUMERO and IPR.IND_SITUACAO = 'G'),0) "
				+ "        ) < pea2_.QTDE) ");
		criteria.add(Restrictions.sqlRestriction(restricao.toString()));
		
		if (codigoMaterialHospital != null) {
			criteria.add(Restrictions.eq("SLC."+ScoSolicitacaoDeCompra.Fields.MAT_CODIGO.toString(), codigoMaterialHospital));
		}
		
		criteria.addOrder(Order.asc(AFN +ScoAutorizacaoForn.Fields.DT_GERACAO.toString()));
				
		criteria.setResultTransformer(Transformers.aliasToBean(AutorizacaoFornecedorMaterialVO.class));
		
		return executeCriteria(criteria);
	}
``` 
## 9
Módulo: `aghu-dao`

Classe: `br.gov.mec.aghu.financeiro.dao.CtbClassifFinanN1DAO`
### Função `montarNivelUm` linhas (28-40,28-39)
Justificativa: Não se pode colocar Order sem projeção, e não se deve utilizar Order com chamadas Count.
**DE**

``` java
private DetachedCriteria montarNivelUm(String param) {
		DetachedCriteria criteria = DetachedCriteria.forClass(CtbClassifFinanN1.class);

		if (StringUtils.isNotBlank(param)) {
			if(CoreUtil.isNumeroByte(param.trim())){
				criteria.add(Restrictions.eq(CtbClassifFinanN1.Fields.CODIGO.toString(), Short.parseShort(param.trim()))); 
			}else {				
				criteria.add(Restrictions.ilike(CtbClassifFinanN1.Fields.DESCRICAO.toString(), param.trim(), MatchMode.ANYWHERE));
			}
		}
		criteria.addOrder(Order.asc(CtbClassifFinanN1.Fields.DESCRICAO.toString()));
		return criteria;
	}
```

**PARA**

``` java
private DetachedCriteria montarNivelUm(String param) {
		DetachedCriteria criteria = DetachedCriteria.forClass(CtbClassifFinanN1.class);

		if (StringUtils.isNotBlank(param)) {
			if(CoreUtil.isNumeroByte(param.trim())){
				criteria.add(Restrictions.eq(CtbClassifFinanN1.Fields.CODIGO.toString(), Short.parseShort(param.trim()))); 
			}else {				
				criteria.add(Restrictions.ilike(CtbClassifFinanN1.Fields.DESCRICAO.toString(), param.trim(), MatchMode.ANYWHERE));
			}
		}
		return criteria;
	}
```
### Função `montarProjectionSubNaturezasVO` Linhas (42-48,41-48)
Justificativa: Para poder utilizar o Order é necessário que se faça grupo das projeções, nesse é quando se faz isso é onde deve ser implementada o Order
**DE**
``` java
private DetachedCriteria montarProjectionSubNaturezasVO(DetachedCriteria criteria) {
		criteria.setProjection(Projections.projectionList()
			.add(Projections.property(CtbClassifFinanN1.Fields.CODIGO.toString()), SubNaturezasVO.Fields.CODIGO_FN1.toString())
			.add(Projections.property(CtbClassifFinanN1.Fields.DESCRICAO.toString()), SubNaturezasVO.Fields.DESCRICAO_FN1.toString())
		);
		return criteria;
	}
```
**PARA**

```java
private DetachedCriteria montarProjectionSubNaturezasVO(DetachedCriteria criteria) {
		criteria.setProjection(Projections.projectionList()
			.add(Projections.groupProperty(CtbClassifFinanN1.Fields.CODIGO.toString()), SubNaturezasVO.Fields.CODIGO_FN1.toString())
			.add(Projections.groupProperty(CtbClassifFinanN1.Fields.DESCRICAO.toString()), SubNaturezasVO.Fields.DESCRICAO_FN1.toString())
		);
		criteria.addOrder(Order.asc(CtbClassifFinanN1.Fields.DESCRICAO.toString()));
		return criteria;
	}
```

## 10
Módulo: `aghu-dao`

Classe: `br.gov.mec.aghu.financeiro.dao.CtbClassifFinanN2DAO`
(Semelhante ao caso anterior)
### Função `montarNivelDois` Linhas (31-47,31-46)
Justificativa: Não se pode colocar Order sem projeção, e não se deve utilizar Order com chamadas Count.
**DE**

``` java
private DetachedCriteria montarNivelDois(String param, Short codNivel1) {
		DetachedCriteria criteria = DetachedCriteria.forClass(CtbClassifFinanN1.class, FN1);
		criteria.createAlias(FN1_PONTO+CtbClassifFinanN1.Fields.CTB_CLASSIF_FINAN_N2S.toString(), FN2, JoinType.INNER_JOIN);

		if (StringUtils.isNotBlank(param)) {
			if(CoreUtil.isNumeroByte(param.trim())){
				criteria.add(Restrictions.eq(FN2_PONTO+CtbClassifFinanN2.Fields.ID_COD.toString(), Short.parseShort(param.trim()))); 
			}else {				
				criteria.add(Restrictions.ilike(FN2_PONTO+CtbClassifFinanN2.Fields.DESCRICAO.toString(), param.trim(), MatchMode.ANYWHERE));
			}
		}
		if(codNivel1 != null) {			
			criteria.add(Restrictions.eq(FN2_PONTO+CtbClassifFinanN2.Fields.ID_COD_FN1.toString(), codNivel1));
		}
		criteria.addOrder(Order.asc(FN2_PONTO+CtbClassifFinanN2.Fields.DESCRICAO.toString()));
		return criteria;
	}
```

**PARA**
 
``` java
private DetachedCriteria montarNivelDois(String param, Short codNivel1) {
		DetachedCriteria criteria = DetachedCriteria.forClass(CtbClassifFinanN1.class, FN1);
		criteria.createAlias(FN1_PONTO+CtbClassifFinanN1.Fields.CTB_CLASSIF_FINAN_N2S.toString(), FN2, JoinType.INNER_JOIN);

		if (StringUtils.isNotBlank(param)) {
			if(CoreUtil.isNumeroByte(param.trim())){
				criteria.add(Restrictions.eq(FN2_PONTO+CtbClassifFinanN2.Fields.ID_COD.toString(), Short.parseShort(param.trim()))); 
			}else {				
				criteria.add(Restrictions.ilike(FN2_PONTO+CtbClassifFinanN2.Fields.DESCRICAO.toString(), param.trim(), MatchMode.ANYWHERE));
			}
		}
		if(codNivel1 != null) {			
			criteria.add(Restrictions.eq(FN2_PONTO+CtbClassifFinanN2.Fields.ID_COD_FN1.toString(), codNivel1));
		}
		return criteria;
	}
```


### Função `montarProjectionSubNaturezasVO` Linhas (49-57,48-57)
Justificativa: Para poder utilizar o Order é necessário que se faça grupo das projeções, nesse é quando se faz isso é onde deve ser implementada o Order 

**DE**
``` java
private DetachedCriteria montarProjectionSubNaturezasVO(DetachedCriteria criteria) {
		criteria.setProjection(Projections.projectionList()
			.add(Projections.property("FN1."+CtbClassifFinanN1.Fields.CODIGO.toString()), SubNaturezasVO.Fields.CODIGO_FN1.toString())
			.add(Projections.property("FN1."+CtbClassifFinanN1.Fields.DESCRICAO.toString()), SubNaturezasVO.Fields.DESCRICAO_FN1.toString())
			.add(Projections.property("FN2."+CtbClassifFinanN2.Fields.ID_COD.toString()), SubNaturezasVO.Fields.CODIGO_FN2.toString())
			.add(Projections.property("FN2."+CtbClassifFinanN2.Fields.DESCRICAO.toString()), SubNaturezasVO.Fields.DESCRICAO_FN2.toString())
		);
		return criteria;
	}
```
**PARA**
```
private DetachedCriteria montarProjectionSubNaturezasVO(DetachedCriteria criteria) {
		criteria.setProjection(Projections.projectionList()
			.add(Projections.groupProperty("FN1."+CtbClassifFinanN1.Fields.CODIGO.toString()), SubNaturezasVO.Fields.CODIGO_FN1.toString())
			.add(Projections.groupProperty("FN1."+CtbClassifFinanN1.Fields.DESCRICAO.toString()), SubNaturezasVO.Fields.DESCRICAO_FN1.toString())
			.add(Projections.groupProperty("FN2."+CtbClassifFinanN2.Fields.ID_COD.toString()), SubNaturezasVO.Fields.CODIGO_FN2.toString())
			.add(Projections.groupProperty("FN2."+CtbClassifFinanN2.Fields.DESCRICAO.toString()), SubNaturezasVO.Fields.DESCRICAO_FN2.toString())
		);
		criteria.addOrder(Order.asc(FN2_PONTO+CtbClassifFinanN2.Fields.DESCRICAO.toString()));
		return criteria;
	}
```
## 11
Módulo: `aghu-dao`

Classe: `br.gov.mec.aghu.financeiro.dao.CtbClassifFinanN3DAO`
### montarProjectionSubNaturezasVO() Linhas (76-86,76-86)
Justificativa: Simplesmente está errada. Possivelmente erro de digitação, ou CRTL+C e CRTL+V.
**DE**

```java
private DetachedCriteria montarProjectionSubNaturezasVO(DetachedCriteria criteria) {
		criteria.setProjection(Projections.projectionList()
			.add(Projections.property(FN1_PONTO+CtbClassifFinanN1.Fields.CODIGO.toString()), SubNaturezasVO.Fields.CODIGO_FN1.toString())
			.add(Projections.property(FN1_PONTO+CtbClassifFinanN1.Fields.DESCRICAO.toString()), SubNaturezasVO.Fields.DESCRICAO_FN1.toString())
			.add(Projections.property(FN2_PONTO+CtbClassifFinanN2.Fields.ID_COD.toString()), SubNaturezasVO.Fields.CODIGO_FN2.toString())
			.add(Projections.property(FN2_PONTO+CtbClassifFinanN2.Fields.DESCRICAO.toString()), SubNaturezasVO.Fields.DESCRICAO_FN2.toString())
			.add(Projections.property(FN3_PONTO+CtbClassifFinanN2.Fields.ID_COD.toString()), SubNaturezasVO.Fields.CODIGO_FN3.toString())
			.add(Projections.property(FN3_PONTO+CtbClassifFinanN2.Fields.DESCRICAO.toString()), SubNaturezasVO.Fields.DESCRICAO_FN3.toString())
		);
		return criteria;
	}
```


**PARA**

``` java
private DetachedCriteria montarProjectionSubNaturezasVO(DetachedCriteria criteria) {
		criteria.setProjection(Projections.projectionList()
			.add(Projections.property(FN1_PONTO+CtbClassifFinanN1.Fields.CODIGO.toString()), SubNaturezasVO.Fields.CODIGO_FN1.toString())
			.add(Projections.property(FN1_PONTO+CtbClassifFinanN1.Fields.DESCRICAO.toString()), SubNaturezasVO.Fields.DESCRICAO_FN1.toString())
			.add(Projections.property(FN2_PONTO+CtbClassifFinanN2.Fields.ID_COD.toString()), SubNaturezasVO.Fields.CODIGO_FN2.toString())
			.add(Projections.property(FN2_PONTO+CtbClassifFinanN2.Fields.DESCRICAO.toString()), SubNaturezasVO.Fields.DESCRICAO_FN2.toString())
			.add(Projections.property(FN3_PONTO+CtbClassifFinanN3.Fields.ID_COD.toString()), SubNaturezasVO.Fields.CODIGO_FN3.toString())
			.add(Projections.property(FN3_PONTO+CtbClassifFinanN3.Fields.DESCRICAO.toString()), SubNaturezasVO.Fields.DESCRICAO_FN3.toString())
		);
		return criteria;
	}
```
## 12
Módulo: `aghu-orcamento`

Classe: `br.gov.mec.aghu.orcamento.cadastrosbasicos.business.NaturezaRN`
### Método `processaUpdateRelacionaNatureza` Linhas (384-406,391-437)
Justificativa: A lógica está certa, entretanto está puxando informações erradas na utilização do DAO, assim por não utilizar as chaves certas o retorno ou falha ou retorna nulo. isso pelo funções internas `.getCodigo` e `.getGnpCodigo`
**DE**
``` java
private void processaUpdateRelacionaNatureza(NaturezaVO item, NaturezaVO itemSelecionado,final RapServidores servidorLogado, final Date dataAtual, final Integer gndCodigo) {
		CtbRelacionaNatureza ctbRelacionaNatureza = ctbRelacionaNaturezaDAO.obterPorChavePrimaria(new CtbRelacionaNaturezaId(gndCodigo, item.getNatureza()));
		if(ctbRelacionaNatureza != null) {
			ctbRelacionaNatureza.setIndModuloCusto(item.getIndModuloCusto());
			ctbRelacionaNatureza.setContaContabil(item.getNroContrato());
			ctbRelacionaNatureza.setServidorAlteracao(servidorLogado);
			ctbRelacionaNatureza.setAlteradoEm(new Date());
			ctbRelacionaNatureza.setNtpGnpCodigo(new BigDecimal(item.getGrupoSiafiSB().getCodigo()));
			ctbRelacionaNatureza.setNtpCodigo(item.getCodNatureza().byteValue());
			ctbRelacionaNaturezaDAO.atualizar(ctbRelacionaNatureza);
		}else {
			ctbRelacionaNatureza = new CtbRelacionaNatureza();
			ctbRelacionaNatureza.setId(new CtbRelacionaNaturezaId(Integer.valueOf(item.getGrupoNatureza().getCodigo()), item.getNatureza()));
			ctbRelacionaNatureza.setNtpGnpTabCodigo(new BigDecimal(item.getTipoAberturaPlano().getCodigo()));
			ctbRelacionaNatureza.setNtpGnpCodigo(new BigDecimal(item.getGrupoSiafiSB().getCodigo()));
			ctbRelacionaNatureza.setNtpCodigo(item.getCodNatureza().byteValue());
			ctbRelacionaNatureza.setIndModuloCusto(item.getIndModuloCusto());
			ctbRelacionaNatureza.setContaContabil(item.getNroContrato());
			ctbRelacionaNatureza.setServidor(servidorLogado);
			ctbRelacionaNatureza.setCriadoEm(dataAtual);
			ctbRelacionaNaturezaDAO.persistir(ctbRelacionaNatureza);
		}
	}
```

**PARA**


``` java
private void processaUpdateRelacionaNatureza(
			NaturezaVO item
			, NaturezaVO itemSelecionado
			, final RapServidores servidorLogado
			, final Date dataAtual
			, final Integer gndCodigo
	) {
		LOG.info("-> processaUpdateRelacionaNatureza(\nitem="
				+(item == null ? "null ": item.toTexto())
				+"\n, itemSelecionado="
				+(itemSelecionado==null? "null" : itemSelecionado.toTexto())
				+"\n, gndCodigo="+gndCodigo
				+")"
		);
		LOG.info("-- gndCodigo="+gndCodigo);
		LOG.info("-- item.getNatureza()="+item.getNatureza());
		CtbRelacionaNatureza ctbRelacionaNatureza = ctbRelacionaNaturezaDAO.obterPorChavePrimaria(new CtbRelacionaNaturezaId(gndCodigo, item.getNatureza()));
		LOG.info("-- ctbRelacionaNatureza="+ctbRelacionaNatureza);
		if(ctbRelacionaNatureza!=null) LOG.info("-- ctbRelacionaNatureza="+ctbRelacionaNatureza.toTexto());
		if(ctbRelacionaNatureza != null) {
			ctbRelacionaNatureza.setIndModuloCusto(item.getIndModuloCusto());
			ctbRelacionaNatureza.setContaContabil(item.getNroContrato());
			ctbRelacionaNatureza.setServidorAlteracao(servidorLogado);
			ctbRelacionaNatureza.setAlteradoEm(new Date());
			ctbRelacionaNatureza.setNtpGnpCodigo(new BigDecimal(item.getGrupoSiafiSB().getGnpCodigo()));
			ctbRelacionaNatureza.setNtpCodigo(item.getCodNatureza().byteValue());
			LOG.info("-- atualizar("+ctbRelacionaNatureza.toTexto()+")");
			ctbRelacionaNaturezaDAO.atualizar(ctbRelacionaNatureza);
		}else {
			ctbRelacionaNatureza = new CtbRelacionaNatureza();
			ctbRelacionaNatureza.setId(new CtbRelacionaNaturezaId(
				Integer.valueOf(item.getGrupoNatureza().getCodigo())
				, item.getNatureza()
			));
			LOG.info("-- Integer.valueOf(item.getGrupoNatureza().getCodigo())="+Integer.valueOf(item.getGrupoNatureza().getCodigo()));
			ctbRelacionaNatureza.setNtpGnpTabCodigo(new BigDecimal(item.getTipoAberturaPlano().getCodigo()));
			ctbRelacionaNatureza.setNtpGnpCodigo(new BigDecimal(item.getGrupoSiafiSB().getGnpCodigo()));
			ctbRelacionaNatureza.setNtpCodigo(item.getCodNatureza().byteValue());
			ctbRelacionaNatureza.setIndModuloCusto(item.getIndModuloCusto());
			ctbRelacionaNatureza.setContaContabil(item.getNroContrato());
			ctbRelacionaNatureza.setServidor(servidorLogado);
			ctbRelacionaNatureza.setCriadoEm(dataAtual);
			LOG.info("-- persistir("+ctbRelacionaNatureza.toTexto()+")");
			ctbRelacionaNaturezaDAO.persistir(ctbRelacionaNatureza);
		}
		LOG.info("<- processaUpdateRelacionaNatureza() void.");
	}
```

### Método `processarUpdateNaturezaPlano` Linhas (408-429,439-469)
Justificativa: Como o caso anterior problemas com as chaves utilizadas.
**DE**


``` java
private void processarUpdateNaturezaPlano(NaturezaVO item, NaturezaVO itemSelecionado,final RapServidores servidorLogado, final Date dataAtual) {
		CtbNaturezaPlanoId ctbNaturezaPlanoId = new CtbNaturezaPlanoId();
		ctbNaturezaPlanoId.setGnpTabCodigo(item.getTipoAberturaPlano().getCodigo());
		Integer gnpCodigo = Integer.valueOf(StringUtils.getDigits(item.getGrupoSiafiSB().getCodigo()));
		ctbNaturezaPlanoId.setGnpCodigo(gnpCodigo);
		ctbNaturezaPlanoId.setCodigo(item.getCodNatureza());
		
		CtbNaturezaPlano naturezaPlano = ctbNaturezaPlanoDAO.obterPorChavePrimaria(ctbNaturezaPlanoId);
		if(naturezaPlano != null) {
			naturezaPlano.setDescricao(item.getNtdDescricaoSiafi());
			naturezaPlano.setAlteradoEm(dataAtual);
			naturezaPlano.setRapServidorAlteracao(servidorLogado);
			ctbNaturezaPlanoDAO.atualizar(naturezaPlano);
		}else {
			CtbNaturezaPlano ctbNaturezaPlano = new CtbNaturezaPlano();
			ctbNaturezaPlano.setId(ctbNaturezaPlanoId);
			ctbNaturezaPlano.setDescricao(item.getNtdDescricaoSiafi());
			ctbNaturezaPlano.setCriadoEm(dataAtual);
			ctbNaturezaPlano.setRapServidores(servidorLogado);
			ctbNaturezaPlanoDAO.persistir(ctbNaturezaPlano);
		}
	}
```

**PARA**


``` java
private void processarUpdateNaturezaPlano(NaturezaVO item, NaturezaVO itemSelecionado,final RapServidores servidorLogado, final Date dataAtual) {
		LOG.info("-> processarUpdateNaturezaPlano(\nitem="+(item == null ? "null": item.toTexto())+"\n, itemSelecionado="+(itemSelecionado==null? "null" : itemSelecionado.toTexto())+")");		
		CtbNaturezaPlanoId ctbNaturezaPlanoId = new CtbNaturezaPlanoId();
		ctbNaturezaPlanoId.setGnpTabCodigo(item.getTipoAberturaPlano().getCodigo());
		//Integer gnpCodigo = Integer.valueOf(StringUtils.getDigits(item.getCodigo()));
		ctbNaturezaPlanoId.setGnpCodigo(Integer.valueOf(item.getGrupoSiafiSB().getGnpCodigo()));
		ctbNaturezaPlanoId.setCodigo(item.getCodNatureza());
		LOG.info("-- ctbNaturezaPlanoId="+ctbNaturezaPlanoId);
		if(ctbNaturezaPlanoId != null) LOG.info("-- ctbNaturezaPlanoId="+ctbNaturezaPlanoId.toTexto());
		
		CtbNaturezaPlano naturezaPlano = ctbNaturezaPlanoDAO.obterPorChavePrimaria(ctbNaturezaPlanoId);
		LOG.info("-- naturezaPlano="+naturezaPlano);
		if (naturezaPlano != null) LOG.info("-- naturezaPlano="+naturezaPlano.toTexto());

		if(naturezaPlano != null) {
			naturezaPlano.setDescricao(item.getNtdDescricaoSiafi());
			naturezaPlano.setAlteradoEm(dataAtual);
			naturezaPlano.setRapServidorAlteracao(servidorLogado);
			LOG.info("-- atualizar("+naturezaPlano.toTexto()+")");
			ctbNaturezaPlanoDAO.atualizar(naturezaPlano);
		}else {
			CtbNaturezaPlano ctbNaturezaPlano = new CtbNaturezaPlano();
			ctbNaturezaPlano.setId(ctbNaturezaPlanoId);
			ctbNaturezaPlano.setDescricao(item.getNtdDescricaoSiafi());
			ctbNaturezaPlano.setCriadoEm(dataAtual);
			ctbNaturezaPlano.setRapServidores(servidorLogado);
			LOG.info("-- persistir("+ctbNaturezaPlano.toTexto()+"): "+ctbNaturezaPlano.toTexto());
			ctbNaturezaPlanoDAO.persistir(ctbNaturezaPlano);
		}
		LOG.info("<- processarUpdateNaturezaPlano() void.");
	}
```

## 13
Módulo: `aghu-vo`

Classe: `br.gov.mec.aghu.orcamento.cadastrosbasicos.vo.CtbSubnaturezaPlanoVO`
### Função getCheckAutoRelacionar() Linhas (447-449,447-449)
Justificativa: Várias chamadas pede esse valor, entretanto por não ser um model, fica mais difícil de realizar o controle por depender de como quem chama sem refatorar muitos lugares. O erro é de valor nulo.
**DE**
``` java
public Boolean getCheckAutoRelacionar() {
		return checkAutoRelacionar;
	}
```
**PARA**
``` java
public Boolean getCheckAutoRelacionar() {
		return (checkAutoRelacionar == null ? Boolean.FALSE : checkAutoRelacionar); // isso não sei se está certo, mas ateh VOs precisam de valor padrao.
	}
```

## 14
Módulo: `aghu-dao`

Classe: `br.gov.mec.aghu.compras.dao.ScoSolicitacoesDeComprasDAO`
### Função countLoteSolicitacaoCompras Linhas (1597-1599,1608-1364)
Justificativa: Existe a possibilidade de ser uma característica do PostgreSQL mas não identificou uma explicação. A contagem igual a zero não resulta em zero mas resulta em nula.

**DE**
``` java
	public Long countLoteSolicitacaoCompras(PesqLoteSolCompVO filtroPesquisa, RapServidores servidorLogado, List<FccCentroCustos> listaCCRetornoParam1, List<Integer> listaCCRetornoParam2, FccCentroCustos ccFipe) {
		return executeCriteriaCount(this.obterCriteriaLoteSolicitacaoCompras(filtroPesquisa, servidorLogado, false, false, true, false, true, true, listaCCRetornoParam1, listaCCRetornoParam2, ccFipe));
	}

```
**PARA**
``` java
public Long countLoteSolicitacaoCompras(
		PesqLoteSolCompVO filtroPesquisa
		, RapServidores servidorLogado
		, List<FccCentroCustos> listaCCRetornoParam1
		, List<Integer> listaCCRetornoParam2
		, FccCentroCustos ccFipe
	) {
		try {
			Long retorno = executeCriteriaCount(this.obterCriteriaLoteSolicitacaoCompras(
				filtroPesquisa
				, servidorLogado
				, false
				, false
				, true
				, false
				, true
				, true
				, listaCCRetornoParam1
				, listaCCRetornoParam2
				, ccFipe
			));
			if(retorno == null) retorno = 0L;
			return retorno;
		} catch (Exception e) {
			return 0L;
		}
	}
```

## 15
Módulo: `aghu-entidades`

Classe: `br.gov.mec.aghu.model.ScoItemAutorizacaoForn`

Justificativa geral: A questão aqui é que uma lista de propriedades que são utilizadas no processo de associação estão sendo requisitadas, mas todas estas estão no modo LAZY, mas são chamados de imediato, então a melhor forma demonstrou colocar no Eager, visto que não é uma lista, apenas uma ligação ManyToOne.
### Funções getMarcaComercial Linha (248-252)
**DE**
``` java
@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MCM_CODIGO", referencedColumnName = "CODIGO")
	public ScoMarcaComercial getMarcaComercial() {
		return marcaComercial;
	}
```
**PARA**
``` java
@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "MCM_CODIGO", referencedColumnName = "CODIGO")
	public ScoMarcaComercial getMarcaComercial() {
		return marcaComercial;
	}

```
### Funções getMarcaComercial Linha (339-345)
**DE**
``` java
@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns( {
		@JoinColumn(name = "SER_MATRICULA_ESTORNO", referencedColumnName = "MATRICULA"),
		@JoinColumn(name = "SER_VIN_CODIGO_ESTORNO", referencedColumnName = "VIN_CODIGO") })
	public RapServidores getServidorEstorno() {
		return servidorEstorno;
	}
```
**PARA**
``` java
@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumns( {
		@JoinColumn(name = "SER_MATRICULA_ESTORNO", referencedColumnName = "MATRICULA"),
		@JoinColumn(name = "SER_VIN_CODIGO_ESTORNO", referencedColumnName = "VIN_CODIGO") })
	public RapServidores getServidorEstorno() {
		return servidorEstorno;
	}
```

### Funções getUnidadeMedidaLinha (351-355)
**DE**
``` java
@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "UMD_CODIGO", referencedColumnName = "CODIGO")
	public ScoUnidadeMedida getUnidadeMedida() {
		return unidadeMedida;
	}
```
**PARA**
``` java
@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "UMD_CODIGO", referencedColumnName = "CODIGO")
	public ScoUnidadeMedida getUnidadeMedida() {
		return unidadeMedida;
	}
```


### Funções getUmdCodigoForn (362-367)
**DE**
``` java
@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "UMD_CODIGO_FORN", referencedColumnName = "CODIGO")
	public ScoUnidadeMedida getUmdCodigoForn() {
		return this.umdCodigoForn;
	}
```
**PARA**
``` java
@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "UMD_CODIGO_FORN", referencedColumnName = "CODIGO")
	public ScoUnidadeMedida getUmdCodigoForn() {
		return this.umdCodigoForn;
	}
```

### Funções getAutorizacoesForn (401-405)
**DE**
``` java
@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="AFN_NUMERO",  insertable=false, updatable=false, nullable=false)
	public ScoAutorizacaoForn getAutorizacoesForn() {
		return autorizacoesForn;
	}
```
**PARA**
``` java
@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="AFN_NUMERO",  insertable=false, updatable=false, nullable=false)
	public ScoAutorizacaoForn getAutorizacoesForn() {
		return autorizacoesForn;
	}
```

### Funções getItemPropostaFornecedor (412-420)
**DE**
``` java
@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumns({
		@JoinColumn(name="IPF_NUMERO", referencedColumnName="NUMERO"),
		@JoinColumn(name="IPF_PFR_FRN_NUMERO", referencedColumnName="PFR_FRN_NUMERO"),
		@JoinColumn(name="IPF_PFR_LCT_NUMERO", referencedColumnName="PFR_LCT_NUMERO")
		})
	public ScoItemPropostaFornecedor getItemPropostaFornecedor() {
		return itemPropostaFornecedor;
	}
```
**PARA**
``` java
@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumns({
		@JoinColumn(name="IPF_NUMERO", referencedColumnName="NUMERO"),
		@JoinColumn(name="IPF_PFR_FRN_NUMERO", referencedColumnName="PFR_FRN_NUMERO"),
		@JoinColumn(name="IPF_PFR_LCT_NUMERO", referencedColumnName="PFR_LCT_NUMERO")
		})
	public ScoItemPropostaFornecedor getItemPropostaFornecedor() {
		return itemPropostaFornecedor;
	}
```


### Funções getNomeComercial (427-433)
**DE**
``` java
@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumns({
		@JoinColumn(name="NC_MCM_CODIGO", referencedColumnName="MCM_CODIGO"),
		@JoinColumn(name="NC_NUMERO", referencedColumnName="NUMERO")})
	public ScoNomeComercial getNomeComercial() {
		return nomeComercial;
	}
```
**PARA**
``` java
@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumns({
		@JoinColumn(name="NC_MCM_CODIGO", referencedColumnName="MCM_CODIGO"),
		@JoinColumn(name="NC_NUMERO", referencedColumnName="NUMERO")})
	public ScoNomeComercial getNomeComercial() {
		return nomeComercial;
	}
```


### Funções getServidor (439-445)
**DE**
``` java
@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns( {
		@JoinColumn(name = "SER_MATRICULA", referencedColumnName = "MATRICULA"),
		@JoinColumn(name = "SER_VIN_CODIGO", referencedColumnName = "VIN_CODIGO") })
	public RapServidores getServidor() {
		return servidor;
	}
```
**PARA**
``` java
@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumns( {
		@JoinColumn(name = "SER_MATRICULA", referencedColumnName = "MATRICULA"),
		@JoinColumn(name = "SER_VIN_CODIGO", referencedColumnName = "VIN_CODIGO") })
	public RapServidores getServidor() {
		return servidor;
	}
```


### Funções getModeloComercial (481-487)
**DE**
``` java
@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "MOM_MCM_CODIGO", referencedColumnName = "MCM_CODIGO"),
			@JoinColumn(name = "MOM_SEQP", referencedColumnName = "SEQP") })
	public ScoMarcaModelo getModeloComercial() {
		return modeloComercial;
	}
```
**PARA**
``` java
@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumns({
			@JoinColumn(name = "MOM_MCM_CODIGO", referencedColumnName = "MCM_CODIGO"),
			@JoinColumn(name = "MOM_SEQP", referencedColumnName = "SEQP") })
	public ScoMarcaModelo getModeloComercial() {
		return modeloComercial;
	}
```



### Funções getScoFornecedor (710-719)
**DE**
``` java
@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumns({
		@JoinColumn(name="IPF_PFR_FRN_NUMERO", referencedColumnName="NUMERO", insertable = false, updatable = false)})
	public ScoFornecedor getScoFornecedor() {
		return scoFornecedor;
	}
```
**PARA**
``` java
@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumns({
		@JoinColumn(name="IPF_PFR_FRN_NUMERO", referencedColumnName="NUMERO", insertable = false, updatable = false)})
	public ScoFornecedor getScoFornecedor() {
		return scoFornecedor;
	}
```




