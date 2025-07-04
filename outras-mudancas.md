

# 1. 
**Caso:** Exames por situação, é preferencial que apenas os exames da empresa seja exibidos no caso de nada serem colocados na tela "Exames por Situação"

**Classe:** br.gov.mec.aghu.exames.dao.VAelExamesSolicitacaoDAO

**Observações:** utiliza a view V_AEL_EXAMES_SOLICITACAO, então é necessário editar a view para poder adicionar o campo de interesse.


Atualmente
``` java
    @SuppressWarnings("unchecked")
	public List<VAelExamesSolicitacao> pesquisaExameSolicitacao(String descricao, AghUnidadesFuncionais unidadeExecutora) {
		
		DetachedCriteria criteria = DetachedCriteria.forClass(VAelExamesSolicitacao.class);
		if (unidadeExecutora != null) {
			criteria.add(Restrictions.eq(VAelExamesSolicitacao.Fields.UNF_SEQ.toString(), unidadeExecutora.getSeq().intValue()));
		}
		if (descricao != null && !descricao.isEmpty()){
			criteria.add(Restrictions.or(Restrictions.like(VAelExamesSolicitacao.Fields.DESCRICAO_USUAL_EXAME.toString(), descricao.toUpperCase(), MatchMode.ANYWHERE),
					                     Restrictions.like(VAelExamesSolicitacao.Fields.DESCRICAO_EXAME.toString(), descricao.toUpperCase(), MatchMode.ANYWHERE),
					                     Restrictions.like(VAelExamesSolicitacao.Fields.SIGLA.toString(), descricao.toUpperCase(), MatchMode.ANYWHERE)));
		}
		
		List<VAelExamesSolicitacao> result = null;
		
		result = executeCriteria(criteria);
		
		return result;
	}
```
Posteriomente?
``` java
???
```