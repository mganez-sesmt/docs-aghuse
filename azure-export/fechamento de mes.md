### Correções feitas para que isso fosse possível
#### Banco de dados

```
ALTER TABLE agh.sce_estq_gerais ADD CONSTRAINT sce_estq_gerais_pkey PRIMARY KEY (mat_codigo, dt_competencia, frn_numero)INSERT INTO agh.sce_estq_gerais (
    version,
    valor_consignado,
    valor,
    umd_codigo,
    sub_classif_abc,
    residuo,
    qtde_consignada,
    qtde,
    mat_codigo,
    frn_numero,
    emp_id,
    dt_competencia,
    custo_medio_ponderado,
    classif_abc
)
SELECT 
    version, 
    valor_consignado,
    valor,
    umd_codigo,
    sub_classif_abc,
    residuo,
    qtde_consignada,
    qtde,
    mat_codigo,
    frn_numero,
    21,  -- Alterando emp_id para 21, para incluir a Santa casa
    dt_competencia,
    custo_medio_ponderado,
    classif_abc
FROM agh.sce_estq_gerais
WHERE emp_id = 1;
```
Para adicionar a Santa Casa como uma empresa no estoque geral.


E foi necessário derrubar (drop) e aplicar a constatint `sce_estq_gerais_pkey` para adicionar o número da empresa nela.
`ALTER TABLE agh.sce_estq_gerais DROP CONSTRAINT sce_estq_gerais_pkey;`
`ALTER TABLE agh.sce_estq_gerais ADD CONSTRAINT sce_estq_gerais_pkey UNIQUE (mat_codigo,dt_competencia,emp_id,frn_numero);`

Como o alinhamento é mensal e não possui visão anual, o ultimo alinhamento manual foi da seguinte forma.
```a
INSERT INTO agh.sce_estq_gerais (
    version, valor_consignado, valor, umd_codigo,
    sub_classif_abc, residuo, qtde_consignada,
    qtde, mat_codigo, frn_numero, emp_id,
    dt_competencia, custo_medio_ponderado,
    classif_abc
)
SELECT 
    version, valor_consignado, valor, 
    umd_codigo, sub_classif_abc, residuo,
    qtde_consignada, qtde, mat_codigo, frn_numero, emp_id,
    '2025-03-01 00:00:00.000' AS dt_competencia,  -- Alterando a data de competência
    custo_medio_ponderado, classif_abc
FROM agh.sce_estq_gerais
WHERE dt_competencia = '2013-02-01 00:00:00.000'
AND emp_id = 21;


INSERT INTO agh.sce_estq_gerais (
    version, valor_consignado, valor, umd_codigo,
    sub_classif_abc, residuo, qtde_consignada,
    qtde, mat_codigo, frn_numero, emp_id,
    dt_competencia, custo_medio_ponderado,
    classif_abc
)
SELECT 
     version, valor_consignado, valor, 
    umd_codigo, sub_classif_abc, residuo,
    qtde_consignada, qtde, mat_codigo, frn_numero, emp_id,
    '2025-03-01 00:00:00.000' AS dt_competencia,  -- Alterando a data de competência
    custo_medio_ponderado,
    classif_abc
FROM agh.sce_estq_gerais
WHERE dt_competencia = '2013-09-01 00:00:00.000'
AND emp_id = 1;
```
# Como é executado?
Após ter implementado os temporizadores, vemos como é executado o agendamento automático de fechamento de mês.
O processo agendado referente a esse projeto é identificável no banco de dados na coluna `nome_processo` por `aghu.aghu-timerservice.FechamentoEstoqueMensalMultiEmpresaTimer`.
Dessa forma o fechamento será executado quando o agendamento expirar.
Infelizmente não previsão de uma implementação via tela para realizar essa função.

# O que ele fará?
## Confere data
A função verificará se está em momento adequado para executar tal função, entretanto seu escopo de visão se limita em um ano, então dissincronia maior que esse tempo limitará ao mês atual independente do ano. 
## Envia relatório via e-mail
O sistema utilizará o email padrão do sistema para poder comunicar as partes interessadas. **Atualmente em falha, mas segue sem problemas.**
## Etapas
1. INICIO FECHAMENTO MENSAL			
1. BLOQUEIO MOVIMENTO MATERIAIS			
1. GRAVAÇÃO SCE_HIST_ESTQ_ALMOXS	
1. GRAVAÇÃO SCE_HIST_ESTQ_ALMOX_MVTOS	
1. GRAVAÇÃO SCE_ESTQ_GERAIS	
1. LIMPEZA SCE_ESTQ_ALMOX_MVTOS		
1. INICIALIZAÇÃO NOVA COMPETÊNCIA 
1. CÁLCULO PONTO DE PEDIDO		
1. CÁLCULO CLASSIFICAÇÃO ABC		
1. FIM FECHAMENTO MENSAL 

Cada etapas pode ser melhor visualizada na classe `ExecutarFechamentoEstoqueMensalRN` do pacote `br.gov.mec.aghu.estoque.business`.