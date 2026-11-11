-- =====================================================================
-- PROJETO FINAL - MODELAGEM DE BANCO DE DADOS
-- Tema: Sistema de Gerenciamento da Academia BoaForma
-- Arquivo 01: Criacao do banco e das tabelas (DDL)
-- =====================================================================
-- DDL = Data Definition Language (linguagem de definicao de dados).
-- Sao os comandos que criam/alteram/apagam a ESTRUTURA do banco:
-- CREATE, ALTER, DROP.
-- =====================================================================

-- Se o banco ja existir, apaga pra comecar do zero (bom pra testar varias vezes)
DROP DATABASE IF EXISTS academia_boaforma;

-- Cria o banco de dados da academia
CREATE DATABASE academia_boaforma
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_general_ci;

-- Fala pro MySQL que daqui pra frente vamos usar esse banco
USE academia_boaforma;

-- ---------------------------------------------------------------------
-- Tabela PLANO
-- Guarda os planos que a academia vende (mensal, trimestral...)
-- ---------------------------------------------------------------------
CREATE TABLE plano (
    id_plano       INT           NOT NULL AUTO_INCREMENT, -- numero gerado sozinho
    nome           VARCHAR(50)   NOT NULL,
    descricao      VARCHAR(200),
    valor_mensal   DECIMAL(8,2)  NOT NULL,                -- 8 digitos, 2 depois da virgula
    duracao_meses  INT           NOT NULL,
    PRIMARY KEY (id_plano)
);

-- ---------------------------------------------------------------------
-- Tabela ALUNO
-- Cada aluno assina UM plano (por isso tem a chave estrangeira id_plano)
-- O endereco ficou em colunas simples: rua, numero, bairro e cidade
-- ---------------------------------------------------------------------
CREATE TABLE aluno (
    id_aluno         INT           NOT NULL AUTO_INCREMENT,
    nome             VARCHAR(100)  NOT NULL,
    cpf              CHAR(14)      NOT NULL,             -- formato 000.000.000-00
    data_nascimento  DATE          NOT NULL,
    sexo             CHAR(1),                            -- 'M' ou 'F'
    telefone         VARCHAR(15),
    email            VARCHAR(100),
    rua              VARCHAR(100),
    numero           VARCHAR(10),
    bairro           VARCHAR(50),
    cidade           VARCHAR(50),
    data_matricula   DATE          NOT NULL,
    situacao         VARCHAR(10)   NOT NULL DEFAULT 'ATIVO', -- ATIVO ou INATIVO
    id_plano         INT           NOT NULL,
    PRIMARY KEY (id_aluno),
    UNIQUE (cpf),                                        -- nao pode ter dois alunos com o mesmo CPF
    FOREIGN KEY (id_plano) REFERENCES plano (id_plano)
);

-- ---------------------------------------------------------------------
-- Tabela INSTRUTOR
-- Os professores da academia. O CREF e o registro do profissional de
-- Educacao Fisica (tipo o CRMV do veterinario no exemplo do zoologico)
-- ---------------------------------------------------------------------
CREATE TABLE instrutor (
    id_instrutor   INT           NOT NULL AUTO_INCREMENT,
    nome           VARCHAR(100)  NOT NULL,
    cpf            CHAR(14)      NOT NULL,
    cref           VARCHAR(20)   NOT NULL,
    telefone       VARCHAR(15),
    email          VARCHAR(100),
    salario        DECIMAL(8,2)  NOT NULL,
    data_admissao  DATE          NOT NULL,
    PRIMARY KEY (id_instrutor),
    UNIQUE (cpf),
    UNIQUE (cref)
);

-- ---------------------------------------------------------------------
-- Tabela MODALIDADE
-- Tipos de aula: musculacao, spinning, pilates, etc.
-- ---------------------------------------------------------------------
CREATE TABLE modalidade (
    id_modalidade  INT           NOT NULL AUTO_INCREMENT,
    nome           VARCHAR(50)   NOT NULL,
    descricao      VARCHAR(200),
    PRIMARY KEY (id_modalidade),
    UNIQUE (nome)
);

-- ---------------------------------------------------------------------
-- Tabela TURMA
-- Uma turma e uma aula de uma modalidade, num dia e horario,
-- dada por um instrutor. Tem um limite de vagas.
-- ---------------------------------------------------------------------
CREATE TABLE turma (
    id_turma       INT          NOT NULL AUTO_INCREMENT,
    dia_semana     VARCHAR(15)  NOT NULL,
    horario        TIME         NOT NULL,
    vagas          INT          NOT NULL,
    id_modalidade  INT          NOT NULL,
    id_instrutor   INT          NOT NULL,
    PRIMARY KEY (id_turma),
    FOREIGN KEY (id_modalidade) REFERENCES modalidade (id_modalidade),
    FOREIGN KEY (id_instrutor)  REFERENCES instrutor (id_instrutor)
);

-- ---------------------------------------------------------------------
-- Tabela ALUNO_TURMA (tabela associativa)
-- Veio do relacionamento N:N "participa" entre ALUNO e TURMA.
-- A chave primaria e composta pelas duas chaves estrangeiras.
-- ---------------------------------------------------------------------
CREATE TABLE aluno_turma (
    id_aluno        INT   NOT NULL,
    id_turma        INT   NOT NULL,
    data_inscricao  DATE  NOT NULL,
    PRIMARY KEY (id_aluno, id_turma),
    FOREIGN KEY (id_aluno) REFERENCES aluno (id_aluno),
    FOREIGN KEY (id_turma) REFERENCES turma (id_turma)
);

-- ---------------------------------------------------------------------
-- Tabela PAGAMENTO
-- Cada pagamento e de um aluno, referente a um mes (ex: '2026-10')
-- ---------------------------------------------------------------------
CREATE TABLE pagamento (
    id_pagamento     INT           NOT NULL AUTO_INCREMENT,
    data_pagamento   DATE          NOT NULL,
    mes_referencia   CHAR(7)       NOT NULL,             -- formato AAAA-MM
    valor            DECIMAL(8,2)  NOT NULL,
    forma_pagamento  VARCHAR(20)   NOT NULL,             -- PIX, DINHEIRO, CARTAO...
    id_aluno         INT           NOT NULL,
    PRIMARY KEY (id_pagamento),
    FOREIGN KEY (id_aluno) REFERENCES aluno (id_aluno)
);

-- ---------------------------------------------------------------------
-- Tabela FICHA_TREINO
-- A ficha que o instrutor monta pro aluno
-- ---------------------------------------------------------------------
CREATE TABLE ficha_treino (
    id_ficha      INT           NOT NULL AUTO_INCREMENT,
    data_criacao  DATE          NOT NULL,
    objetivo      VARCHAR(100)  NOT NULL,
    id_aluno      INT           NOT NULL,
    id_instrutor  INT           NOT NULL,
    PRIMARY KEY (id_ficha),
    FOREIGN KEY (id_aluno)     REFERENCES aluno (id_aluno),
    FOREIGN KEY (id_instrutor) REFERENCES instrutor (id_instrutor)
);

-- ---------------------------------------------------------------------
-- Tabela EXERCICIO
-- Lista de exercicios que podem entrar numa ficha
-- ---------------------------------------------------------------------
CREATE TABLE exercicio (
    id_exercicio    INT          NOT NULL AUTO_INCREMENT,
    nome            VARCHAR(60)  NOT NULL,
    grupo_muscular  VARCHAR(30)  NOT NULL,
    PRIMARY KEY (id_exercicio)
);

-- ---------------------------------------------------------------------
-- Tabela FICHA_EXERCICIO (tabela associativa)
-- Veio do relacionamento N:N "contem" entre FICHA_TREINO e EXERCICIO.
-- Series, repeticoes e carga sao atributos do relacionamento, porque
-- dependem da ficha E do exercicio ao mesmo tempo.
-- ---------------------------------------------------------------------
CREATE TABLE ficha_exercicio (
    id_ficha      INT           NOT NULL,
    id_exercicio  INT           NOT NULL,
    series        INT           NOT NULL,
    repeticoes    INT           NOT NULL,
    carga_kg      DECIMAL(5,1),
    PRIMARY KEY (id_ficha, id_exercicio),
    FOREIGN KEY (id_ficha)     REFERENCES ficha_treino (id_ficha),
    FOREIGN KEY (id_exercicio) REFERENCES exercicio (id_exercicio)
);

-- ---------------------------------------------------------------------
-- Tabela FREQUENCIA
-- Registra cada vez que o aluno passa na catraca
-- ---------------------------------------------------------------------
CREATE TABLE frequencia (
    id_frequencia  INT   NOT NULL AUTO_INCREMENT,
    data_entrada   DATE  NOT NULL,
    hora_entrada   TIME  NOT NULL,
    id_aluno       INT   NOT NULL,
    PRIMARY KEY (id_frequencia),
    FOREIGN KEY (id_aluno) REFERENCES aluno (id_aluno)
);

-- Mostra as tabelas criadas so pra conferir
SHOW TABLES;
