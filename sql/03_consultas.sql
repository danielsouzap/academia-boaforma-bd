-- =====================================================================
-- PROJETO FINAL - MODELAGEM DE BANCO DE DADOS
-- Tema: Sistema de Gerenciamento da Academia BoaForma
-- Arquivo 03: Consultas SQL (basicas, intermediarias e avancadas)
-- =====================================================================
-- DQL = Data Query Language: e o SELECT, que serve pra consultar dados.
-- Rodar DEPOIS dos arquivos 01 e 02.
-- Dica pra apresentacao: no Workbench, clicar na consulta e apertar
-- Ctrl+Enter (ou Cmd+Enter no Mac) pra rodar so ela.
-- =====================================================================

USE academia_boaforma;


-- #####################################################################
-- 4.1 CONSULTAS BASICAS (SELECT e FROM)
-- #####################################################################

-- Consulta 01: mostra TODOS os dados de todos os alunos
-- o * significa "todas as colunas"
SELECT * FROM aluno;

-- Consulta 02: mostra so o nome, telefone e email dos alunos
SELECT nome, telefone, email FROM aluno;

-- Consulta 03: mostra todos os planos da academia
SELECT * FROM plano;

-- Consulta 04: mostra o nome, o CREF e o salario dos instrutores
SELECT nome, cref, salario FROM instrutor;

-- Consulta 05: mostra os exercicios e o grupo muscular de cada um
SELECT nome, grupo_muscular FROM exercicio;


-- #####################################################################
-- 4.2 CONSULTAS INTERMEDIARIAS
-- #####################################################################

-- Consulta 06 (DISTINCT): quais formas de pagamento ja foram usadas?
-- o DISTINCT tira as repeticoes
SELECT DISTINCT forma_pagamento FROM pagamento;

-- Consulta 07 (colunas calculadas com *, +, - e /): quanto custa cada
-- plano no total, o total com a taxa de matricula de 50 reais, o mensal
-- com 10% de desconto e quanto sai por dia (mes de 30 dias)
SELECT nome,
       valor_mensal,
       valor_mensal * duracao_meses           AS valor_total_plano,
       valor_mensal * duracao_meses + 50      AS total_com_matricula,
       ROUND(valor_mensal - (valor_mensal * 0.10), 2) AS mensal_com_desconto,
       ROUND(valor_mensal / 30, 2)            AS valor_por_dia
FROM plano;

-- Consulta 08 (WHERE com operador de comparacao >=):
-- instrutores que ganham 3000 reais ou mais
SELECT nome, salario
FROM instrutor
WHERE salario >= 3000;

-- Consulta 09 (operadores logicos AND, OR e NOT):
-- alunos que NAO estao inativos E moram em Niteroi OU Sao Goncalo
SELECT nome, cidade, situacao
FROM aluno
WHERE NOT situacao = 'INATIVO'
  AND (cidade = 'Niterói' OR cidade = 'São Gonçalo');

-- Consulta 10 (funcoes de agregacao SUM, AVG, MAX, MIN):
-- resumo de todos os pagamentos recebidos
SELECT SUM(valor)           AS total_recebido,
       ROUND(AVG(valor), 2) AS media_por_pagamento,
       MAX(valor)           AS maior_pagamento,
       MIN(valor)           AS menor_pagamento
FROM pagamento;

-- Consulta 11 (COUNT e operador <>): quantos alunos estao ativos?
-- o <> quer dizer "diferente de"
SELECT COUNT(*) AS total_alunos_ativos
FROM aluno
WHERE situacao <> 'INATIVO';

-- Consulta 12 (LIKE): alunos que usam email do gmail
-- o % quer dizer "qualquer coisa antes"
SELECT nome, email
FROM aluno
WHERE email LIKE '%@gmail.com';

-- Consulta 13 (BETWEEN): alunos que nasceram entre 2000 e 2005
SELECT nome, data_nascimento
FROM aluno
WHERE data_nascimento BETWEEN '2000-01-01' AND '2005-12-31';

-- Consulta 14 (IN): exercicios de peito, costas ou ombros
SELECT nome, grupo_muscular
FROM exercicio
WHERE grupo_muscular IN ('Peito', 'Costas', 'Ombros');

-- Consulta 15 (ORDER BY): alunos do mais novo na academia pro mais antigo
-- DESC = decrescente
SELECT nome, data_matricula
FROM aluno
ORDER BY data_matricula DESC;

-- Consulta 16 (GROUP BY): quanto foi recebido em cada forma de pagamento
SELECT forma_pagamento,
       COUNT(*)   AS qtd_pagamentos,
       SUM(valor) AS total
FROM pagamento
GROUP BY forma_pagamento
ORDER BY total DESC;

-- Consulta 17 (GROUP BY + HAVING): planos que tem 4 alunos ou mais
-- o HAVING e tipo um WHERE, so que pra depois do agrupamento
SELECT p.nome AS plano,
       COUNT(a.id_aluno) AS qtd_alunos
FROM plano p
INNER JOIN aluno a ON a.id_plano = p.id_plano
GROUP BY p.id_plano, p.nome
HAVING COUNT(a.id_aluno) >= 4;

-- Consulta 18 (subconsulta): instrutores que ganham mais que a media
-- primeiro o banco calcula a media (consulta de dentro) e depois compara
SELECT nome, salario
FROM instrutor
WHERE salario > (SELECT AVG(salario) FROM instrutor);

-- Consulta 19 (subconsulta com NOT IN): alunos que nunca pagaram nada
SELECT id_aluno, nome, data_matricula
FROM aluno
WHERE id_aluno NOT IN (SELECT id_aluno FROM pagamento);

-- Consulta 20 (INNER JOIN): nome de cada aluno com o plano que ele assinou
SELECT a.nome AS aluno,
       p.nome AS plano,
       p.valor_mensal
FROM aluno a
INNER JOIN plano p ON a.id_plano = p.id_plano
ORDER BY a.nome;

-- Consulta 21 (JOIN com 3 tabelas): grade de horarios das turmas
SELECT t.id_turma,
       m.nome AS modalidade,
       i.nome AS instrutor,
       t.dia_semana,
       t.horario,
       t.vagas
FROM turma t
INNER JOIN modalidade m ON t.id_modalidade = m.id_modalidade
INNER JOIN instrutor  i ON t.id_instrutor  = i.id_instrutor
ORDER BY m.nome, t.dia_semana;

-- Consulta 22 (LEFT JOIN): alunos que ainda NAO tem ficha de treino
-- o LEFT JOIN traz todos os alunos, mesmo os que nao tem ficha (fica NULL)
SELECT a.nome, a.situacao
FROM aluno a
LEFT JOIN ficha_treino f ON a.id_aluno = f.id_aluno
WHERE f.id_ficha IS NULL;

-- Consulta 23 (UNION): lista de todas as pessoas da academia
-- junta o resultado de dois SELECTs com as mesmas colunas
SELECT nome, email, 'Aluno' AS tipo FROM aluno
UNION
SELECT nome, email, 'Instrutor' AS tipo FROM instrutor
ORDER BY nome;

-- Consulta 24 (JOIN com 5 tabelas): ficha de treino completa da aluna Ana
SELECT a.nome  AS aluno,
       i.nome  AS instrutor,
       f.objetivo,
       e.nome  AS exercicio,
       e.grupo_muscular,
       fe.series,
       fe.repeticoes,
       fe.carga_kg
FROM ficha_treino f
INNER JOIN aluno           a  ON f.id_aluno     = a.id_aluno
INNER JOIN instrutor       i  ON f.id_instrutor = i.id_instrutor
INNER JOIN ficha_exercicio fe ON f.id_ficha     = fe.id_ficha
INNER JOIN exercicio       e  ON fe.id_exercicio = e.id_exercicio
WHERE a.nome LIKE 'Ana%';

-- Consulta 25 (LEFT JOIN + GROUP BY + coluna calculada):
-- quantos inscritos cada turma tem e quantas vagas ainda sobram
SELECT t.id_turma,
       m.nome AS modalidade,
       t.dia_semana,
       t.vagas,
       COUNT(at.id_aluno)           AS inscritos,
       t.vagas - COUNT(at.id_aluno) AS vagas_livres
FROM turma t
INNER JOIN modalidade m  ON t.id_modalidade = m.id_modalidade
LEFT JOIN  aluno_turma at ON t.id_turma     = at.id_turma
GROUP BY t.id_turma, m.nome, t.dia_semana, t.vagas
ORDER BY vagas_livres;

-- Consulta 26 (JOIN + WHERE + GROUP BY): quantas vezes cada aluno
-- foi na academia na primeira semana de novembro
SELECT a.nome,
       COUNT(*) AS qtd_entradas
FROM frequencia f
INNER JOIN aluno a ON f.id_aluno = a.id_aluno
WHERE f.data_entrada BETWEEN '2026-11-01' AND '2026-11-07'
GROUP BY a.id_aluno, a.nome
ORDER BY qtd_entradas DESC;


-- #####################################################################
-- 4.3 CONSULTAS AVANCADAS (TRIGGER e STORED PROCEDURE)
-- #####################################################################
-- O DELIMITER muda o "ponto e virgula" que termina o comando pra $$.
-- Precisa disso porque dentro do trigger/procedure tem varios ; e o
-- MySQL acharia que o comando acabou no meio.
-- #####################################################################

-- ---------------------------------------------------------------------
-- TRIGGER 1: trg_pagamento_reativa_aluno
-- Quando entra um pagamento novo, se o aluno estava INATIVO ele volta
-- a ficar ATIVO automaticamente. (AFTER INSERT = depois de inserir)
-- ---------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_pagamento_reativa_aluno;

DELIMITER $$
CREATE TRIGGER trg_pagamento_reativa_aluno
AFTER INSERT ON pagamento
FOR EACH ROW
BEGIN
    -- NEW e a linha que acabou de ser inserida em pagamento
    UPDATE aluno
       SET situacao = 'ATIVO'
     WHERE id_aluno = NEW.id_aluno
       AND situacao = 'INATIVO';
END $$
DELIMITER ;

-- ---------------------------------------------------------------------
-- TRIGGER 2: trg_verifica_vagas
-- Antes de inscrever um aluno numa turma, confere se ainda tem vaga.
-- Se a turma estiver cheia, da erro e NAO deixa inserir.
-- (BEFORE INSERT = antes de inserir)
-- ---------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_verifica_vagas;

DELIMITER $$
CREATE TRIGGER trg_verifica_vagas
BEFORE INSERT ON aluno_turma
FOR EACH ROW
BEGIN
    DECLARE v_inscritos INT;
    DECLARE v_vagas INT;

    -- conta quantos alunos ja estao na turma
    SELECT COUNT(*) INTO v_inscritos
      FROM aluno_turma
     WHERE id_turma = NEW.id_turma;

    -- pega o limite de vagas da turma
    SELECT vagas INTO v_vagas
      FROM turma
     WHERE id_turma = NEW.id_turma;

    -- se ja lotou, gera um erro com mensagem
    IF v_inscritos >= v_vagas THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Turma lotada! Nao ha vagas disponiveis.';
    END IF;
END $$
DELIMITER ;

-- ---------------------------------------------------------------------
-- PROCEDURE 1: sp_cadastrar_aluno
-- Cadastra um aluno novo. A data de matricula e a data de hoje e ele ja
-- entra como ATIVO. Antes confere se o CPF ja existe.
-- ---------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_cadastrar_aluno;

DELIMITER $$
CREATE PROCEDURE sp_cadastrar_aluno(
    IN p_nome        VARCHAR(100),
    IN p_cpf         CHAR(14),
    IN p_nascimento  DATE,
    IN p_sexo        CHAR(1),
    IN p_telefone    VARCHAR(15),
    IN p_email       VARCHAR(100),
    IN p_id_plano    INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM aluno WHERE cpf = p_cpf) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ja existe um aluno com esse CPF.';
    ELSE
        INSERT INTO aluno (nome, cpf, data_nascimento, sexo, telefone, email,
                           data_matricula, situacao, id_plano)
        VALUES (p_nome, p_cpf, p_nascimento, p_sexo, p_telefone, p_email,
                CURDATE(), 'ATIVO', p_id_plano);

        -- mostra o aluno que acabou de ser cadastrado
        -- LAST_INSERT_ID() devolve o id gerado pelo AUTO_INCREMENT
        SELECT * FROM aluno WHERE id_aluno = LAST_INSERT_ID();
    END IF;
END $$
DELIMITER ;

-- ---------------------------------------------------------------------
-- PROCEDURE 2: sp_relatorio_mensal
-- Recebe um mes (ex: '2026-10') e mostra quanto a academia recebeu
-- naquele mes, separado por forma de pagamento.
-- ---------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_relatorio_mensal;

DELIMITER $$
CREATE PROCEDURE sp_relatorio_mensal(IN p_mes CHAR(7))
BEGIN
    SELECT p_mes             AS mes,
           forma_pagamento,
           COUNT(*)          AS qtd_pagamentos,
           SUM(valor)        AS total_recebido
      FROM pagamento
     WHERE mes_referencia = p_mes
     GROUP BY forma_pagamento
     ORDER BY total_recebido DESC;
END $$
DELIMITER ;

-- ---------------------------------------------------------------------
-- PROCEDURE 3: sp_alunos_pendentes
-- Recebe um mes e lista os alunos ATIVOS que ainda nao pagaram aquele mes
-- (serve pra recepcao ligar e cobrar)
-- ---------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_alunos_pendentes;

DELIMITER $$
CREATE PROCEDURE sp_alunos_pendentes(IN p_mes CHAR(7))
BEGIN
    SELECT a.id_aluno,
           a.nome,
           a.telefone,
           p.nome         AS plano,
           p.valor_mensal AS valor_devido
      FROM aluno a
     INNER JOIN plano p ON a.id_plano = p.id_plano
     WHERE a.situacao = 'ATIVO'
       AND a.id_aluno NOT IN (SELECT id_aluno
                                FROM pagamento
                               WHERE mes_referencia = p_mes)
     ORDER BY a.nome;
END $$
DELIMITER ;


-- =====================================================================
-- TESTANDO OS TRIGGERS E AS PROCEDURES
-- =====================================================================

-- Consulta 27 (teste do TRIGGER 1):
-- o Marcos (id 12) esta INATIVO...
SELECT id_aluno, nome, situacao FROM aluno WHERE id_aluno = 12;
-- ...ele paga novembro...
INSERT INTO pagamento (data_pagamento, mes_referencia, valor, forma_pagamento, id_aluno)
VALUES ('2026-11-08', '2026-11', 119.90, 'PIX', 12);
-- ...e o trigger deixa ele ATIVO de novo sozinho
SELECT id_aluno, nome, situacao FROM aluno WHERE id_aluno = 12;

-- Consulta 28 (teste da PROCEDURE 1): cadastrando um aluno novo
CALL sp_cadastrar_aluno('Lucas Andrade Silva', '201.302.403-16', '2003-08-19',
                        'M', '(21) 99701-0016', 'lucas.silva@gmail.com', 2);

-- Consulta 29 (teste da PROCEDURE 2): relatorio de outubro de 2026
CALL sp_relatorio_mensal('2026-10');

-- Consulta 30 (teste da PROCEDURE 3): quem ainda nao pagou novembro
CALL sp_alunos_pendentes('2026-11');

-- Consulta 31 (teste do TRIGGER 2):
-- primeiro olha a turma 3 (Pilates): 3 vagas e 3 inscritos, ta lotada
SELECT t.id_turma, t.vagas, COUNT(at.id_aluno) AS inscritos
FROM turma t
LEFT JOIN aluno_turma at ON t.id_turma = at.id_turma
WHERE t.id_turma = 3
GROUP BY t.id_turma, t.vagas;

-- agora tenta colocar a Eduarda (id 5) no Pilates.
-- ATENCAO: esse comando VAI DAR ERRO DE PROPOSITO!
-- A mensagem esperada e: "Turma lotada! Nao ha vagas disponiveis."
-- (por isso ele ficou por ultimo no arquivo)
INSERT INTO aluno_turma (id_aluno, id_turma, data_inscricao)
VALUES (5, 3, '2026-11-08');
