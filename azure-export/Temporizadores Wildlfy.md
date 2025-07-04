Temporizadores do Wildlfy é uma funcionalidade oferecida pelo Wildlfy que disponibiliza o agendamento de execuções de funções.

#Como é ativado, nesse sistema?
Ao levantar o servidor Wildlfy é necessário passar com o tal argumento.
` -Daghu.automatic.timers.enable=true `
Ou pode executar manualmente suas funções na página encontrada pelo caminho: Outros Módulso -> Configuração -> Sistema -> Processos Agendados


##O que isso faz?


Ao utilizar EJB, possui 

A Classe `InicializacaoTimers` encontrada no pacote `br.gov.mec.aghu.timerservice`. Possui um inicializador no método `init()`. Devido sua anotação EJB `@Startup` que inicializa a classe de forma que ao levantar o Wildfy essa classe será executada. Já a anotação `@PostConstruct` associado ao método `init()`, isso especifica que o método será executado após as injeções de dependências necessárias.

##O que o `init()` faz?
Esse método irá fazer consultas na tabela associada aos agendamentos para inicializar quais atividades devem ser preparada de acordo com o proposto lá. 

##Que tabela de agendamento?
A tabela `agh.agh_processo_agenda` possui as informações para que seja marcado os agendamentos.
- seq:
Número sequencial.
- nome_processo:
 Esse campo aponta para onde ele deve estar para ser executado. Ele aponta para as classes presentes dentro do módulo `aghu-timersevice`, possuem a nomenclatura comuns entre eles sempre começando com `aghu.aghu-timerservice.` seguidos do nome da classe que aponta para o timer especifico. Exemplo `aghu.aghu-timerservice.AtualizaTabelaCertificaoTimer` que se encontra no pacote `br.gov.mec.aghu.timerservice.certificacaodigital`. Portanto ao ver um esse nome é capaz rastrear o que cada agendamento irá fazer.
- descricao: 
Descrição breve sobre.
- ind_situacao:
Esse campo só aceita dois valores caracteres: `A` para Ativo; `I` para Inativo.
- expressao:
Campo para indicar quando o agendamento, será formatado compondo seis números inteiros separados por espaço da seguinte forma `"%d %d %d %d %d %d"`. Esses números são de acordo com a seguinte ordem: segundo; minuto; hora (no formato 24); número do dia do mês; número do mês; número dia da semana (1 para domingo, 7 para sábado).
- persistente:
Esse campo só aceita dois valores caracteres: `S` para Sim; `N` para Não. Isso influencia se o campo `expressao` será atualizado.
- emp_id:
Um número associado a empresa.
- nro_tentativa_autoagendamento:
Número de vezes que tentará realizar o agendamento.
- tempo_entre_autoagendadamento:
Tempo me minutos para tentar novamente.