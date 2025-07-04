**<ins>Cadastro de Empresas</ins>**
**Classes/Arquivos**: cadastrarEmpresa.xhtml
**de** <f:selectItems var="item" itemLabel="#{item.nome()}" itemValue="#{item.nome()}" 
**para** <f:selectItems var="item" itemLabel="#{item.getDescricao()}" itemValue="#{item.getCodigo()}"
DominioUF
**Métodos**: obterDominio
Foi alterada a linha de if(enumOp.isEmpty())  para if(!enumOp.isEmpty()) 
**Justificativa**: O método a ser invocado estava incorreto, em lugar de invocar item.getDescricao estava sendo chamado item\.name.

**<ins>[1117,1211]  Integração de Validação de Empresa Criada</ins>**
**Classes/Arquivos**: 
\- pesquisarEmpresa.xhtml (Adição de botão Ativar/Inativar empresa)
\- EmpresaPaginatorController
\- ICascaFacade, CascaFacade
\- EmpresaON
\- UsuarioON
\- PerfisUsuariosDAO
**Métodos**: 
\- ativarInativar [Novo]
\- ativarInativarEmpresa
\- ativarEmpresa
\- inativarEmpresa
\- obterPerfilUsuarioPorEmpresa
**Justificativa**: 
Hoje a validação da empresa é feita via script direto no banco
 \- Alteração do Cadastro de Empresa
 \- Criação dos métodos e functions necessários para validação da empresa.
Critérios:
Validação por perfil de usuário propriamente: Quando o tipo de usuário for **SU - Super Usuário**

**<ins>[1206]  Criar os parâmetros da empresa recém-criada, no momento de sua ativação</ins>**
**Classes/Arquivos**: 
\- AghParametrosDAO
\- iParametroSistemaFacade
\- parametroSistemaON
**Métodos**: 
\- obterTodosParametrosPorQqEmpresa(Integer empId) [Novo]
\- gerarParametrosDeEmpresa(empId,usuarioLogado)
\- copiarTodosParametrosDeEmpresa
**Justificativa**: 
Criar os parâmetros da empresa recém-criada, no momento de sua ativação
Atualmente isso é feito por meio de script direto no banco de dados

**<ins>[501] Dar Alta</ins>**
**Classes/Arquivos**: ValidaInternacaoRN
**Métodos**: ValidaInternacaoRN.atualizaAltaConta [Alterado]
**Justificativa**: 
Para absorver a alta direta. Esta alteração será liberada mediante uma solicitação via **SIGADOC**, pois a causa da liberação da alta direta é um procedimento extra em relação ao fluxo normal, mas não incomum, das práticas no ambiente hospitalar. Por vias normais, essa mesma alta deve ser feita por intermédio de autorização médica ou no mais extremo dos casos pelo setor de faturamento dos procedimentos médico-hospitalares [Encerramento e prévia da conta].
E para tal modificação foi criado o parâmetro **P_AGHU_ALTA_ADM_DIRETA**, que deverá ser ativada após confirmação de recebimento e autorização do documento via SIGADOC

**<ins>[[346] Peso, Altura, IMC não atualiza](http://srv-az-devops.ses.int/DefaultCollection/AGHUse/_workitems/edit/346)</ins>**
**Classes/Arquivos**: 
\- MpmParamCalculoPrescricaoDAO
\- IPrescricaoMedicaFacade 
\- PrescricaoMedicaFacade
\- PesoAlturaImcRN
\- PesoAlturaImcController
\- ControlePacienteFacade
**Métodos**: 
\- MpmParamCalculoPrescricaoDAO.obterParamCalculoPrescricoesSituacao [Novo]
\- IPrescricaoMedicaFacade.obterParamCalculoPrescricoesAtivo [Novo]
\- PrescricaoMedicaFacade.obterParamCalculoPrescricoesAtivo [Novo]
\- PesoAlturaImcRN.carregarPesoAlturaImc2 [Copiado/Novo]
\- PesoAlturaImcController.carregarPesoAlturaImc2 [Copiado/Novo]
\- PesoAlturaImcController.iniciar [Alterado]
\- IControlePacienteFacade.carregarPesoAlturaImc2 [Novo]
\- ControlePacienteFacade.carregarPesoAlturaImc2 [Copiado/Novo]
**Justificativa**: 
Os dados de Peso, Altura e IMC aparecem nas telas do sistema como **"N/A"**

**<ins>[596]  listar planos e convenios em agendamento de cirurgia</ins>**
**Classes/Arquivos**: FatConvenioSaudePlanoDAO
**Métodos**: pesquisarConvenioSaudePlanos [Alterado]
**Justificativa**: Usuário solicitante: viniciuscebalho
Caminho: cirurgias PDT -> Agendar Cirurgias
Cenário: listar planos e convenios
Resultado obtido: listagem completa de planos ativos e inativos
Resultado esperado: listagem apenas de itens ativos

**<ins>[107]  Bug na consulta de Prescrição Eletrônica</ins>**
**Classes/Arquivos**: pesquisarPacientesParaDispensacaoList.xhtml
**Métodos**: null
**Justificativa**: Erro na seleção das farmácias na lista
Solução: retirar o atributo render da tag titular da Farmácia que estava atrapalhando construção da lista de farmácia para seleção. Onde ocorria o erro com descrição 25A. Foi preciso alterar o código fonte da xhtml da farmácia e realizar um novo Builder.

**<ins>[144]  Erro ao Aprazar/Checar</ins>** Corrigido e verificado na versão 13.225
**Classes/Arquivos**: ListarPrescricoesAprazamentoChecagemController
**Métodos**: onRowSelect [Alterado]
**Justificativa**: Usuário solicitante: viniciuscebalho
Caminho: Lista Paciente Enf → Aprazar Checar
Cenário: Listagem de paciente e ação de aprazar
Resultado obtido: Erro imediado ao acessar tela de aprazamento
Resultado esperado: Acessar tela e realizar aprazamento
Solução: Conversão do tipo de data no método supracitado

**<ins>[199]  Erro tirar relatório para indicadores</ins>**
**Classes/Arquivos**: BuscarMovimentosPacsEmergQueryBuilder
**Métodos**: projecaoUnion2 [Alterado]
**Justificativa**: Usuário solicitante: gvasconcelos 
Caminho: emergência -> Relatórios para indicadores 
Cenário: tentativa de tirada de relatório
Resultado obtido: tion: ERROR: UNION types timestamp without time zone and text cannot be matched
Resultado esperado: Retirar o relatório 
Solução: Inclusão de cast nas linhas da montagem do código SQL

**<ins>[326]  Erro Cadastro de pacientes seleção Deficiência</ins>**
**Classes/Arquivos**: AipDeficienciaDAO
**Métodos**: pesquisarDeficienciaAtivaCount [Alterado]
**Justificativa**: Pesquisar pacientes - incluir paciente - deficiência
Resultado esperado - Que as tabelas de Ocupação e Deficiência estejam preenchidas. 
Solução: Comentou-se a linha de Order by

**<ins>[529]  Erro Cadastro de pacientes seleção Deficiência</ins>**
**Classes/Arquivos**: AghEquipesDAO
**Métodos**: obterCriteriaEquipesPorSeqOuNome [Alterado]
**Justificativa**: Usuário solicitante: Marcianoloiola
Caminho: Ambulatório => Relatório => eventuais => Grade Programação
Cenário: Obter a visualização da impressão dos agendamento das grades por equipe.
Resultado obtido: tion: ERROR: column "this_.nome" must appear in the GROUP BY clause or be used in an aggregate function
Resultado esperado: visualizar a impressão das grades de agendamento por equipe conforme no ambiente teste da bahia
Solução: Comentou-se a linha de Order by

**<ins>[1249]  Alteração de rotina para Relatório de Faturamento por convênios</ins>**
**Classes/Arquivos**: 
\- FatConvenioSaudeDAO
**Métodos**: 
\- obterListaConvenioSaude [Modificado]
**Justificativa**: 
Não aparecem os convênios para seleção na tela de Faturamento por Procedimento (Corrigido)
Solução: Para tal, foi criado o parâmetro **P_CONVENIOS_EXCLUSIVOS**, para limitar os convênios​ na seleção de convênio do Relatório de Faturamento por Procedimento
Inserida a condição do parâmetro suplacitado no método FatConvenioSaudeDAO.obterListaConvenioSaude

**<ins>[1313] Ordenação das competências por [mês, ano]</ins>**
**Classes/Arquivos:**
\- FatCompetenciaDAO
**Métodos:**
\- listarFatCompetencia [Modificado]
\- getCriteriaListarCompetencia2 [Novo]
**Justificativa:**
Ordenação das competências por [mês, ano]
Tela: Atualizar Competências
Faturamento -> Cadastros -> Atualizar Competência

**<ins>[1401] Erro ao selecionar no módulo de gêneros alimentícios, na seleção do Fabricante</ins>**
**Classes/Arquivos:**
\- ScoMarcaComercialDAO
**Métodos:**
\- pesquisarMarcasComerciaisAtivas [Modificado]
**Justificativa:**
Problema na identificação do agh como esquema padrão









