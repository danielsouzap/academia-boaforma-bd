-- =====================================================================
-- PROJETO FINAL - MODELAGEM DE BANCO DE DADOS
-- Tema: Sistema de Gerenciamento da Academia BoaForma
-- Arquivo 02: Insercao dos dados de teste (DML)
-- =====================================================================
-- DML = Data Manipulation Language (linguagem de manipulacao de dados).
-- Comandos que mexem nos DADOS: INSERT, UPDATE, DELETE.
-- Obs: todos os nomes, CPFs e telefones abaixo sao inventados.
-- Rodar DEPOIS do arquivo 01.
-- =====================================================================

USE academia_boaforma;

-- ---------------------------------------------------------------------
-- PLANOS
-- (nao precisa colocar o id porque ele e AUTO_INCREMENT)
-- ---------------------------------------------------------------------
INSERT INTO plano (nome, descricao, valor_mensal, duracao_meses) VALUES
('Mensal',     'Acesso livre a musculacao',                    119.90, 1),
('Trimestral', 'Musculacao + 1 modalidade',                    109.90, 3),
('Semestral',  'Musculacao + todas as modalidades',             99.90, 6),
('Anual',      'Acesso total a academia + avaliacao fisica',    89.90, 12);

-- ---------------------------------------------------------------------
-- INSTRUTORES
-- ---------------------------------------------------------------------
INSERT INTO instrutor (nome, cpf, cref, telefone, email, salario, data_admissao) VALUES
('Carlos Eduardo Lima',   '101.202.303-01', '012345-G/RJ', '(21) 98811-1001', 'carlos.lima@boaforma.com',   3500.00, '2021-03-01'),
('Fernanda Souza Alves',  '101.202.303-02', '023456-G/RJ', '(21) 98811-1002', 'fernanda.alves@boaforma.com', 3200.00, '2022-07-15'),
('Ricardo Mendes',        '101.202.303-03', '034567-G/RJ', '(21) 98811-1003', 'ricardo.mendes@boaforma.com', 2800.00, '2023-02-10'),
('Juliana Rocha Costa',   '101.202.303-04', '045678-G/RJ', '(21) 98811-1004', 'juliana.costa@boaforma.com',  3000.00, '2023-09-01'),
('Thiago Pereira Nunes',  '101.202.303-05', '056789-G/RJ', '(21) 98811-1005', 'thiago.nunes@boaforma.com',   2600.00, '2025-01-20');

-- ---------------------------------------------------------------------
-- MODALIDADES
-- ---------------------------------------------------------------------
INSERT INTO modalidade (nome, descricao) VALUES
('Musculação', 'Treino com pesos e aparelhos, horario livre'),
('Spinning',   'Aula de bicicleta ergometrica com musica'),
('Pilates',    'Exercicios de forca, postura e alongamento'),
('Yoga',       'Posturas, respiracao e relaxamento'),
('Funcional',  'Circuito com exercicios usando o peso do corpo'),
('Zumba',      'Aula de danca aerobica');

-- ---------------------------------------------------------------------
-- TURMAS
-- (Musculacao nao tem turma porque e horario livre)
-- A turma 3 (Pilates) tem so 3 vagas, vamos usar ela pra testar o trigger
-- ---------------------------------------------------------------------
INSERT INTO turma (dia_semana, horario, vagas, id_modalidade, id_instrutor) VALUES
('Segunda', '07:00:00', 10, 2, 2),   -- 1 Spinning  - Fernanda
('Quarta',  '07:00:00', 10, 2, 2),   -- 2 Spinning  - Fernanda
('Terça',   '18:00:00',  3, 3, 4),   -- 3 Pilates   - Juliana
('Quinta',  '18:00:00',  8, 4, 4),   -- 4 Yoga      - Juliana
('Segunda', '19:00:00', 12, 5, 3),   -- 5 Funcional - Ricardo
('Sexta',   '19:00:00', 15, 6, 5),   -- 6 Zumba     - Thiago
('Sábado',  '09:00:00', 12, 5, 3),   -- 7 Funcional - Ricardo
('Quarta',  '20:00:00', 15, 6, 5);   -- 8 Zumba     - Thiago

-- ---------------------------------------------------------------------
-- ALUNOS
-- ---------------------------------------------------------------------
INSERT INTO aluno (nome, cpf, data_nascimento, sexo, telefone, email, rua, numero, bairro, cidade, data_matricula, situacao, id_plano) VALUES
('Ana Beatriz Santos',       '201.302.403-01', '2001-04-12', 'F', '(21) 99701-0001', 'ana.santos@gmail.com',      'Rua Conde de Bonfim',     '450',  'Tijuca',            'Rio de Janeiro',  '2025-02-10', 'ATIVO',   4),
('Bruno Henrique Oliveira',  '201.302.403-02', '1998-09-23', 'M', '(21) 99701-0002', 'bruno.oliveira@hotmail.com','Rua Moreira Cesar',       '120',  'Icaraí',            'Niterói',         '2026-08-01', 'ATIVO',   1),
('Camila Ferreira Gomes',    '201.302.403-03', '2003-01-30', 'F', '(21) 99701-0003', 'camila.gomes@gmail.com',    'Rua Dias da Cruz',        '88',   'Méier',             'Rio de Janeiro',  '2026-05-05', 'ATIVO',   3),
('Diego Martins Ribeiro',    '201.302.403-04', '1995-11-02', 'M', '(21) 99701-0004', 'diego.ribeiro@yahoo.com',   'Rua Dr. Alfredo Backer',  '1500', 'Alcântara',         'São Gonçalo',     '2026-07-14', 'ATIVO',   2),
('Eduarda Lima Barbosa',     '201.302.403-05', '2005-06-18', 'F', '(21) 99701-0005', 'duda.barbosa@gmail.com',    'Rua Barata Ribeiro',      '300',  'Copacabana',        'Rio de Janeiro',  '2026-09-03', 'ATIVO',   1),
('Felipe Araújo Cardoso',    '201.302.403-06', '1990-03-07', 'M', '(21) 99701-0006', 'felipe.cardoso@outlook.com','Rua da Conceição',        '15',   'Centro',            'Niterói',         '2025-11-20', 'ATIVO',   4),
('Gabriela Nascimento Reis', '201.302.403-07', '1999-12-25', 'F', '(21) 99701-0007', 'gabi.reis@gmail.com',       'Rua Haddock Lobo',        '210',  'Tijuca',            'Rio de Janeiro',  '2026-03-01', 'ATIVO',   3),
('Henrique Costa Moreira',   '201.302.403-08', '1987-08-14', 'M', '(21) 99701-0008', 'henrique.moreira@gmail.com','Av. Presidente Kennedy',  '900',  'Centro',            'Duque de Caxias', '2026-06-10', 'INATIVO', 2),
('Isabela Teixeira Pinto',   '201.302.403-09', '2002-02-09', 'F', '(21) 99701-0009', 'isa.pinto@gmail.com',       'Rua Voluntários da Pátria','45',  'Botafogo',          'Rio de Janeiro',  '2026-10-01', 'ATIVO',   1),
('João Pedro Almeida',       '201.302.403-10', '2004-07-21', 'M', '(21) 99701-0010', 'jp.almeida@gmail.com',      'Rua Silva Rabelo',        '33',   'Méier',             'Rio de Janeiro',  '2026-01-15', 'ATIVO',   4),
('Larissa Monteiro Dias',    '201.302.403-11', '1993-05-30', 'F', '(21) 99701-0011', 'larissa.dias@hotmail.com',  'Rua Gavião Peixoto',      '70',   'Icaraí',            'Niterói',         '2026-08-20', 'ATIVO',   2),
('Marcos Vinícius Rocha',    '201.302.403-12', '2000-10-11', 'M', '(21) 99701-0012', 'marcos.rocha@gmail.com',    'Rua Feliciano Sodré',     '210',  'Centro',            'São Gonçalo',     '2026-04-02', 'INATIVO', 1),
('Mariana Cavalcanti',       '201.302.403-13', '1997-03-16', 'F', '(21) 99701-0013', 'mari.cavalcanti@gmail.com', 'Av. Nossa Senhora de Copacabana', '1020', 'Copacabana', 'Rio de Janeiro',  '2026-06-01', 'ATIVO',   3),
('Rafael Souza Batista',     '201.302.403-14', '1985-12-03', 'M', '(21) 99701-0014', 'rafael.batista@gmail.com',  'Rua São Francisco Xavier','500',  'Tijuca',            'Rio de Janeiro',  '2025-08-08', 'ATIVO',   4),
('Vitória Gonçalves Freitas','201.302.403-15', '2006-09-09', 'F', '(21) 99701-0015', 'vitoria.freitas@gmail.com', 'Rua Alfa',                '12',   'Jardim Primavera',  'Duque de Caxias', '2026-10-20', 'ATIVO',   1);

-- ---------------------------------------------------------------------
-- ALUNO_TURMA (quem esta inscrito em qual turma)
-- A turma 3 (Pilates, 3 vagas) ja fica lotada aqui
-- ---------------------------------------------------------------------
INSERT INTO aluno_turma (id_aluno, id_turma, data_inscricao) VALUES
(1, 3, '2026-02-01'), (3, 3, '2026-05-10'), (7, 3, '2026-03-05'),
(1, 4, '2026-02-01'), (13, 4, '2026-06-03'), (11, 4, '2026-08-25'),
(2, 1, '2026-08-02'), (4, 1, '2026-07-15'), (6, 1, '2026-01-10'), (10, 1, '2026-01-20'),
(4, 2, '2026-07-15'), (14, 2, '2025-08-10'),
(2, 5, '2026-08-02'), (5, 5, '2026-09-05'), (10, 5, '2026-02-01'), (14, 5, '2025-09-01'),
(5, 6, '2026-09-05'), (9, 6, '2026-10-02'), (11, 6, '2026-08-25'), (13, 6, '2026-06-03'), (15, 6, '2026-10-21'),
(6, 7, '2026-01-10'), (10, 7, '2026-02-01'),
(9, 8, '2026-10-02'), (3, 8, '2026-05-10');

-- ---------------------------------------------------------------------
-- PAGAMENTOS (agosto a novembro de 2026)
-- Valor = valor mensal do plano do aluno
-- Alguns alunos ainda nao pagaram novembro (pra gente achar os pendentes)
-- A aluna 15 (Vitoria) ainda nao pagou nenhuma vez
-- ---------------------------------------------------------------------
INSERT INTO pagamento (data_pagamento, mes_referencia, valor, forma_pagamento, id_aluno) VALUES
-- Ana (plano anual)
('2026-08-05', '2026-08', 89.90, 'PIX', 1),
('2026-09-05', '2026-09', 89.90, 'PIX', 1),
('2026-10-05', '2026-10', 89.90, 'PIX', 1),
('2026-11-04', '2026-11', 89.90, 'PIX', 1),
-- Bruno (mensal) - nao pagou novembro
('2026-08-01', '2026-08', 119.90, 'CARTAO DE CREDITO', 2),
('2026-09-02', '2026-09', 119.90, 'CARTAO DE CREDITO', 2),
('2026-10-01', '2026-10', 119.90, 'CARTAO DE CREDITO', 2),
-- Camila (semestral)
('2026-08-10', '2026-08', 99.90, 'CARTAO DE DEBITO', 3),
('2026-09-10', '2026-09', 99.90, 'CARTAO DE DEBITO', 3),
('2026-10-09', '2026-10', 99.90, 'CARTAO DE DEBITO', 3),
('2026-11-06', '2026-11', 99.90, 'CARTAO DE DEBITO', 3),
-- Diego (trimestral) - nao pagou novembro
('2026-08-14', '2026-08', 109.90, 'PIX', 4),
('2026-09-14', '2026-09', 109.90, 'PIX', 4),
('2026-10-14', '2026-10', 109.90, 'PIX', 4),
-- Eduarda (mensal, entrou em setembro)
('2026-09-03', '2026-09', 119.90, 'DINHEIRO', 5),
('2026-10-03', '2026-10', 119.90, 'DINHEIRO', 5),
('2026-11-03', '2026-11', 119.90, 'DINHEIRO', 5),
-- Felipe (anual)
('2026-08-20', '2026-08', 89.90, 'CARTAO DE CREDITO', 6),
('2026-09-20', '2026-09', 89.90, 'CARTAO DE CREDITO', 6),
('2026-10-20', '2026-10', 89.90, 'CARTAO DE CREDITO', 6),
('2026-11-02', '2026-11', 89.90, 'CARTAO DE CREDITO', 6),
-- Gabriela (semestral) - nao pagou novembro
('2026-08-01', '2026-08', 99.90, 'PIX', 7),
('2026-09-01', '2026-09', 99.90, 'PIX', 7),
('2026-10-01', '2026-10', 99.90, 'PIX', 7),
-- Henrique (trimestral) - so pagou agosto e depois ficou INATIVO
('2026-08-10', '2026-08', 109.90, 'DINHEIRO', 8),
-- Isabela (mensal, entrou em outubro)
('2026-10-01', '2026-10', 119.90, 'PIX', 9),
('2026-11-01', '2026-11', 119.90, 'PIX', 9),
-- Joao Pedro (anual)
('2026-08-15', '2026-08', 89.90, 'CARTAO DE DEBITO', 10),
('2026-09-15', '2026-09', 89.90, 'CARTAO DE DEBITO', 10),
('2026-10-15', '2026-10', 89.90, 'CARTAO DE DEBITO', 10),
('2026-11-05', '2026-11', 89.90, 'CARTAO DE DEBITO', 10),
-- Larissa (trimestral)
('2026-08-20', '2026-08', 109.90, 'PIX', 11),
('2026-09-20', '2026-09', 109.90, 'PIX', 11),
('2026-10-20', '2026-10', 109.90, 'PIX', 11),
('2026-11-07', '2026-11', 109.90, 'PIX', 11),
-- Marcos (mensal) - so pagou agosto e depois ficou INATIVO
('2026-08-02', '2026-08', 119.90, 'CARTAO DE CREDITO', 12),
-- Mariana (semestral) - nao pagou novembro
('2026-08-01', '2026-08', 99.90, 'CARTAO DE CREDITO', 13),
('2026-09-01', '2026-09', 99.90, 'CARTAO DE CREDITO', 13),
('2026-10-01', '2026-10', 99.90, 'CARTAO DE CREDITO', 13),
-- Rafael (anual)
('2026-08-08', '2026-08', 89.90, 'PIX', 14),
('2026-09-08', '2026-09', 89.90, 'PIX', 14),
('2026-10-08', '2026-10', 89.90, 'PIX', 14),
('2026-11-06', '2026-11', 89.90, 'PIX', 14);

-- ---------------------------------------------------------------------
-- EXERCICIOS
-- ---------------------------------------------------------------------
INSERT INTO exercicio (nome, grupo_muscular) VALUES
('Supino reto',                  'Peito'),
('Crucifixo',                    'Peito'),
('Puxada frontal',               'Costas'),
('Remada baixa',                 'Costas'),
('Agachamento livre',            'Pernas'),
('Leg press 45',                 'Pernas'),
('Cadeira extensora',            'Pernas'),
('Desenvolvimento com halteres', 'Ombros'),
('Elevação lateral',             'Ombros'),
('Rosca direta',                 'Bíceps'),
('Tríceps pulley',               'Tríceps'),
('Abdominal supra',              'Abdômen'),
('Prancha',                      'Abdômen'),
('Stiff',                        'Pernas');

-- ---------------------------------------------------------------------
-- FICHAS DE TREINO
-- ---------------------------------------------------------------------
INSERT INTO ficha_treino (data_criacao, objetivo, id_aluno, id_instrutor) VALUES
('2026-08-02', 'Hipertrofia',            1,  1),
('2026-08-03', 'Emagrecimento',          2,  1),
('2026-08-10', 'Condicionamento físico', 3,  3),
('2026-09-01', 'Hipertrofia',            6,  1),
('2026-09-15', 'Ganho de força',         10, 5),
('2026-08-22', 'Emagrecimento',          11, 3),
('2026-10-05', 'Hipertrofia',            14, 1);

-- ---------------------------------------------------------------------
-- FICHA_EXERCICIO (quais exercicios tem em cada ficha)
-- carga NULL = exercicio sem peso (ex: abdominal)
-- ---------------------------------------------------------------------
INSERT INTO ficha_exercicio (id_ficha, id_exercicio, series, repeticoes, carga_kg) VALUES
(1, 1, 4, 10, 40.0), (1, 3, 4, 10, 45.0), (1, 5, 4, 12, 50.0), (1, 10, 3, 12, 12.0), (1, 11, 3, 12, 20.0),
(2, 6, 3, 15, 80.0), (2, 7, 3, 15, 25.0), (2, 12, 3, 20, NULL), (2, 9, 3, 15, 6.0),
(3, 5, 3, 12, 30.0), (3, 4, 3, 12, 35.0), (3, 8, 3, 12, 10.0), (3, 12, 3, 20, NULL),
(4, 1, 4, 8, 60.0), (4, 2, 3, 12, 14.0), (4, 3, 4, 8, 60.0), (4, 8, 4, 10, 18.0), (4, 14, 4, 10, 40.0),
(5, 5, 5, 5, 80.0), (5, 1, 5, 5, 70.0), (5, 4, 5, 6, 60.0), (5, 14, 4, 8, 50.0),
(6, 6, 3, 15, 100.0), (6, 7, 3, 15, 30.0), (6, 3, 3, 15, 30.0), (6, 12, 3, 20, NULL),
(7, 1, 4, 10, 50.0), (7, 2, 3, 12, 16.0), (7, 10, 3, 10, 14.0), (7, 11, 3, 12, 25.0), (7, 5, 4, 10, 60.0);

-- ---------------------------------------------------------------------
-- FREQUENCIA (entradas na catraca do fim de outubro e comeco de novembro)
-- ---------------------------------------------------------------------
INSERT INTO frequencia (data_entrada, hora_entrada, id_aluno) VALUES
('2026-10-26', '06:45:00', 1),  ('2026-10-26', '07:10:00', 2),  ('2026-10-26', '18:30:00', 3),
('2026-10-26', '19:05:00', 10), ('2026-10-27', '06:50:00', 1),  ('2026-10-27', '12:15:00', 6),
('2026-10-27', '18:00:00', 7),  ('2026-10-28', '07:00:00', 4),  ('2026-10-28', '19:40:00', 9),
('2026-10-28', '20:00:00', 3),  ('2026-10-29', '06:40:00', 1),  ('2026-10-29', '17:55:00', 13),
('2026-10-29', '18:10:00', 11), ('2026-10-30', '19:00:00', 5),  ('2026-10-30', '19:02:00', 11),
('2026-10-31', '08:50:00', 6),  ('2026-10-31', '09:00:00', 10),
('2026-11-02', '06:45:00', 1),  ('2026-11-02', '06:55:00', 2),  ('2026-11-02', '18:50:00', 14),
('2026-11-02', '19:00:00', 5),  ('2026-11-03', '06:50:00', 1),  ('2026-11-03', '17:50:00', 3),
('2026-11-03', '18:00:00', 7),  ('2026-11-03', '12:30:00', 6),  ('2026-11-04', '06:58:00', 4),
('2026-11-04', '07:00:00', 14), ('2026-11-04', '19:55:00', 9),  ('2026-11-05', '06:45:00', 1),
('2026-11-05', '18:05:00', 13), ('2026-11-05', '18:00:00', 11), ('2026-11-06', '19:00:00', 15),
('2026-11-06', '19:10:00', 5),  ('2026-11-06', '12:20:00', 6),  ('2026-11-07', '08:55:00', 10),
('2026-11-07', '09:05:00', 6),  ('2026-11-07', '10:30:00', 14);

-- Conferindo quantos registros ficaram em cada tabela
SELECT 'plano' AS tabela, COUNT(*) AS qtd FROM plano
UNION ALL SELECT 'aluno', COUNT(*) FROM aluno
UNION ALL SELECT 'instrutor', COUNT(*) FROM instrutor
UNION ALL SELECT 'modalidade', COUNT(*) FROM modalidade
UNION ALL SELECT 'turma', COUNT(*) FROM turma
UNION ALL SELECT 'aluno_turma', COUNT(*) FROM aluno_turma
UNION ALL SELECT 'pagamento', COUNT(*) FROM pagamento
UNION ALL SELECT 'ficha_treino', COUNT(*) FROM ficha_treino
UNION ALL SELECT 'exercicio', COUNT(*) FROM exercicio
UNION ALL SELECT 'ficha_exercicio', COUNT(*) FROM ficha_exercicio
UNION ALL SELECT 'frequencia', COUNT(*) FROM frequencia;
