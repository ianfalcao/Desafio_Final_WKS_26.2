-- Criação do Banco de Dados
CREATE SCHEMA clinica_care;

-- Criação das Tabelas (DDL)
CREATE TABLE PLANO_SAUDE ( -- Criação da tabela referente ao plano de saúde
  id_plano INT AUTO_INCREMENT PRIMARY KEY,
  nome_plano VARCHAR(100) NOT NULL,
  registro_ans VARCHAR(20) UNIQUE,
  cnpj_operadora VARCHAR(20) UNIQUE,
  telefone_suporte VARCHAR(20),
  cobertura_tipo VARCHAR(50),
  validade_contrato DATE,
  ativo TINYINT(1) DEFAULT 1
);

CREATE TABLE PACIENTE ( -- Criação da tabela dos pacientes
  id_paciente INT AUTO_INCREMENT PRIMARY KEY,
  cpf VARCHAR(14) UNIQUE NOT NULL,
  nome_completo VARCHAR(150) NOT NULL,
  data_nascimento DATE NOT NULL,
  genero VARCHAR(20),
  endereco VARCHAR(255),
  telefone VARCHAR(20),
  email VARCHAR(100),
  data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
  id_plano INT,
  FOREIGN KEY (id_plano) REFERENCES PLANO_SAUDE(id_plano) ON DELETE SET NULL
);

CREATE TABLE MEDICO ( -- Criação da tabela dos médicos
  id_medico INT AUTO_INCREMENT PRIMARY KEY,
  crm VARCHAR(20) UNIQUE NOT NULL,
  uf_crm VARCHAR(2) NOT NULL,
  nome_completo VARCHAR(150) NOT NULL,
  telefone VARCHAR(20),
  email VARCHAR(100),
  data_contratacao DATE,
  ativo TINYINT(1) DEFAULT 1
);

CREATE TABLE ESPECIALIDADE ( -- Criação da tabela das especialidades médicas
  id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
  nome_especialidade VARCHAR(100) NOT NULL,
  codigo_amb VARCHAR(20),
  descricao TEXT,
  tempo_medio_consulta INT,
  valor_base DECIMAL(10,2) NOT NULL,
  requer_preparo TINYINT(1) DEFAULT 0,
  ativa TINYINT(1) DEFAULT 1
);

CREATE TABLE DISPONIBILIDADE ( -- Criação da tabela referente a dispobilidade para consultas
  id_disponibilidade INT AUTO_INCREMENT PRIMARY KEY,
  turno VARCHAR(20),
  dia_semana VARCHAR(20),
  horario_inicio TIME,
  horario_fim TIME,
  duracao_slot INT,
  sala_atendimento VARCHAR(20),
  ativo TINYINT(1) DEFAULT 1
);

CREATE TABLE CONSULTA ( -- Criação da tabela de consultas para monitoramento
  id_consulta INT AUTO_INCREMENT PRIMARY KEY,
  data_hora DATETIME NOT NULL,
  status VARCHAR(30) NOT NULL, -- Agendada, Realizada, Cancelada, Faltou
  valor_final DECIMAL(10,2) NOT NULL,
  observacoes_agendamento TEXT,
  motivo_consulta TEXT,
  sala_atendimento VARCHAR(20),
  altura_paciente_cm INT,
  id_paciente INT NOT NULL,
  id_medico INT NOT NULL,
  id_disponibilidade INT,
  FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente),
  FOREIGN KEY (id_medico) REFERENCES MEDICO(id_medico),
  FOREIGN KEY (id_disponibilidade) REFERENCES DISPONIBILIDADE(id_disponibilidade)
);

CREATE TABLE PRONTUARIO_ELETRONICO ( -- Criação da tabela dos prontuários eletrônicos 
  id_prontuario INT AUTO_INCREMENT PRIMARY KEY,
  data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
  queixa_principal TEXT,
  diagnostico TEXT,
  prescricao_medica TEXT,
  exames_solicitados TEXT,
  retorno_necessario TINYINT(1) DEFAULT 0,
  historico_familiar TEXT,
  atestado_dias INT,
  id_consulta INT UNIQUE NOT NULL,
  FOREIGN KEY (id_consulta) REFERENCES CONSULTA(id_consulta)
);

CREATE TABLE PAGAMENTO ( -- Criação da tabela para monitoramento de pagamentos
  id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
  valor_pago DECIMAL(10,2) NOT NULL,
  data_pagamento DATETIME,
  metodo_pagamento VARCHAR(30), -- Dinheiro, Cartao, Pix
  status_pagamento VARCHAR(30) NOT NULL, -- Pago, Pendente, Cancelado
  desconto_aplicado DECIMAL(10,2) DEFAULT 0.00,
  codigo_transacao VARCHAR(100),
  numero_nota_fiscal VARCHAR(50),
  id_consulta INT UNIQUE NOT NULL,
  FOREIGN KEY (id_consulta) REFERENCES CONSULTA(id_consulta)
);

-- INSERÇÃO DE DADOS (DML)
INSERT INTO PLANO_SAUDE (nome_plano, registro_ans, cnpj_operadora, telefone_suporte, cobertura_tipo, validade_contrato) VALUES
('Particular', NULL, NULL, '(83) 3000-0000', 'Completa', '2030-12-31'),
('Unimed', '326305', '02812345000101', '(83) 3218-7000', 'Nacional', '2028-05-20'),
('Bradesco Saúde', '005711', '92682038000199', '0800-701-2700', 'Executivo', '2027-11-15'),
('Amil Health', '326309', '29309128000144', '0800-021-2545', 'Estadual', '2026-09-30');

INSERT INTO PACIENTE (cpf, nome_completo, data_nascimento, genero, endereco, telefone, email, id_plano) VALUES 
('111.222.333-01', 'Lucas Andrade', '1988-04-12', 'M', 'Rua das Flores, 10, Tambaú', '(83) 98888-1111', 'lucas@email.com', 1),
('222.333.444-02', 'Maria Alice Fernandes', '1995-08-23', 'F', 'Av. Epitácio Pessoa, 500, Manaíra', '(83) 98777-2222', 'maria@email.com', 2),
('333.444.555-03', 'Carlos Eduardo Lima', '1972-11-05', 'M', 'Rua Bancário Sérgio Guerra, 45', '(83) 98666-3333', 'carlos@email.com', 3),
('444.555.666-04', 'Juliana Paes Costa', '2001-02-18', 'F', 'Av. Cabo Branco, 1200', '(83) 98555-4444', 'juliana@email.com', 2),
('555.666.777-05', 'Roberto Carlos Silva', '1960-06-30', 'M', 'Rua Nego, 300, Tambaú', '(83) 98444-5555', 'roberto@email.com', 4),
('666.777.888-06', 'Fernanda Montenegro', '1955-01-15', 'F', 'Rua das Acácias, 88', '(83) 98333-6666', 'fernanda@email.com', 1),
('777.888.999-07', 'Gabriel Lucas Araujo', '1998-10-10', 'M', 'Av. Esperança, 400, Bessa', '(83) 98222-7777', 'gabriel@email.com', 2),
('888.999.000-08', 'Beatriz Souza', '2003-12-01', 'F', 'Rua João Maurício, 150', '(83) 98111-8888', 'beatriz@email.com', 3),
('999.000.111-09', 'Rodrigo Santoro', '1980-07-22', 'M', 'Av. Almirante Tamandaré, 70', '(83) 98000-9999', 'rodrigo@email.com', 1),
('000.111.222-10', 'Camila Pitanga', '1990-03-09', 'F', 'Rua Josefa Taveira, 900, Mangabeira', '(83) 97999-0000', 'camila@email.com', 4),
('123.456.789-11', 'Thiago Lacerda', '1985-09-14', 'M', 'Rua Maciel Pinheiro, 20', '(83) 97888-1122', 'thiago@email.com', 2),
('987.654.321-12', 'Paolla Oliveira', '1992-05-04', 'F', 'Av. Pedro II, 1100, Torre', '(83) 97777-2233', 'paolla@email.com', 3);

INSERT INTO MEDICO (crm, uf_crm, nome_completo, telefone, email, data_contratacao) VALUES
('12345', 'PB', 'Dr. Roberto Kalil', '(83) 99111-1000', 'kalil@clinicacare.com', '2018-01-15'),
('23456', 'PB', 'Dra. Ana Beatriz', '(83) 99222-2000', 'anabeatriz@clinicacare.com', '2019-03-10'),
('34567', 'PB', 'Dr. Paulo Muzy', '(83) 99333-3000', 'muzy@clinicacare.com', '2020-06-01'),
('45678', 'PB', 'Dra. Nise Yamaguchi', '(83) 99444-4000', 'nise@clinicacare.com', '2021-09-20');

INSERT INTO ESPECIALIDADE (nome_especialidade, codigo_amb, descricao, tempo_medio_consulta, valor_base) VALUES
('Cardiologia', '30101001', 'Consulta em cardiologia geral e exames preventivos', 30, 300.00),
('Dermatologia', '30101002', 'Cuidados de pele, dermatite e estética médica', 20, 250.00),
('Ortopedia', '30101003', 'Tratamento articular, ósseo e lesões esportivas', 30, 280.00),
('Pediatria', '30101004', 'Acompanhamento do desenvolvimento infantil', 40, 220.00);

INSERT INTO DISPONIBILIDADE (turno, dia_semana, horario_inicio, horario_fim, duracao_slot, sala_atendimento) VALUES
('Manhã', 'Segunda-feira', '08:00:00', '12:00:00', 30, 'Sala 101'),
('Tarde', 'Terça-feira', '14:00:00', '18:00:00', 30, 'Sala 102'),
('Manhã', 'Quarta-feira', '08:00:00', '12:00:00', 30, 'Sala 103'),
('Tarde', 'Quinta-feira', '14:00:00', '18:00:00', 30, 'Sala 104');

INSERT INTO CONSULTA (data_hora, status, valor_final, motivo_consulta, sala_atendimento, id_paciente, id_medico, id_disponibilidade) VALUES
('2026-08-01 08:00:00', 'Realizada', 300.00, 'Checkup cardiovascular', 'Sala 101', 1, 1, 1),
('2026-08-01 09:00:00', 'Realizada', 250.00, 'Consulta dermatológica de rotina', 'Sala 102', 2, 2, 2),
('2026-08-02 14:00:00', 'Cancelada', 280.00, 'Dor no joelho direito', 'Sala 103', 3, 3, 3),
('2026-08-02 15:00:00', 'Faltou', 220.00, 'Consulta pediátrica preventiva', 'Sala 104', 4, 4, 4),
('2026-08-03 10:00:00', 'Realizada', 300.00, 'Hipertensão arterial', 'Sala 101', 5, 1, 1),
('2026-08-03 11:00:00', 'Realizada', 250.00, 'Alineamento de manchas na pele', 'Sala 102', 6, 2, 2),
('2026-08-04 08:30:00', 'Realizada', 280.00, 'Entorse no tornozelo', 'Sala 103', 7, 3, 3),
('2026-08-04 09:30:00', 'Realizada', 220.00, 'Vacinação e puericultura', 'Sala 104', 8, 4, 4),
('2026-08-05 14:30:00', 'Faltou', 300.00, 'Avaliação eletrocardiograma', 'Sala 101', 9, 1, 1),
('2026-08-05 15:30:00', 'Realizada', 250.00, 'Tratamento de acne', 'Sala 102', 10, 2, 2),
('2026-08-06 16:00:00', 'Realizada', 280.00, 'Dor lombar aguda', 'Sala 103', 11, 3, 3),
('2026-08-06 17:00:00', 'Realizada', 220.00, 'Acompanhamento de peso infantil', 'Sala 104', 12, 4, 4);

INSERT INTO PRONTUARIO_ELETRONICO (queixa_principal, diagnostico, prescricao_medica, exames_solicitados, id_consulta) VALUES
('Palpitação leve ao praticar exercícios', 'Arritmia benigna', 'Atenolol 25mg', 'Ecocardiograma', 1),
('Aparecimento de pintas nas costas', 'Nevo melanocítico', 'Protetor solar FPS 60', 'Dermatoscopia', 2),
('Pressão alta persistente em casa', 'Hipertensão Estágio 1', 'Losartana 50mg', 'MAPA 24 horas', 5),
('Alergia cutânea e vermelhidão', 'Dermatite de contato', 'Creme com corticosteroide', 'Teste alérgico', 6),
('Torção durante partida de futebol', 'Entorse grau 1', 'Anti-inflamatório e compressa gelada', 'Raio-X do Tornozelo', 7),
('Febre baixa há dois dias', 'Resfriado comum', 'Paracetamol gotas', 'Observação clínica', 8),
('Acne severa em região facial', 'Acne inflamatória grau 2', 'Sabonete de ácido salicílico', 'Exames hormonais', 10),
('Dor intensa na coluna lombar', 'Lombociatalgia', 'Relaxante muscular', 'Ressonância Magnética', 11),
('Acompanhamento de ganho de peso', 'Desenvolvimento adequado', 'Suplementação de Vitamina D', 'Nenhum', 12);

INSERT INTO PAGAMENTO (valor_pago, data_pagamento, metodo_pagamento, status_pagamento, id_consulta) VALUES
(300.00, '2026-08-01 08:30:00', 'Pix', 'Pago', 1),
(250.00, '2026-08-01 09:30:00', 'Cartão', 'Pago', 2),
(0.00, NULL, NULL, 'Cancelado', 3),
(0.00, NULL, NULL, 'Pendente', 4),
(300.00, '2026-08-03 10:30:00', 'Dinheiro', 'Pago', 5),
(250.00, '2026-08-03 11:30:00', 'Pix', 'Pago', 6),
(280.00, '2026-08-04 09:00:00', 'Cartão', 'Pago', 7),
(220.00, '2026-08-04 10:00:00', 'Pix', 'Pago', 8),
(0.00, NULL, NULL, 'Pendente', 9),
(250.00, '2026-08-05 16:00:00', 'Cartão', 'Pago', 10),
(280.00, '2026-08-06 16:30:00', 'Pix', 'Pago', 11),
(220.00, '2026-08-06 17:30:00', 'Dinheiro', 'Pago', 12);

UPDATE CONSULTA SET status = 'Realizada' WHERE id_consulta = 4; -- Alteração no status do paciente de ID 4; ( de Faltou para Realizada)
UPDATE PAGAMENTO SET status_pagamento = 'Pago', valor_pago = 220.00, metodo_pagamento = 'Pix', data_pagamento = NOW() WHERE id_consulta = 4; -- Alteração no status de pagamento do paciente de ID 4; (de Pendente para Pago)
UPDATE PAGAMENTO SET desconto_aplicado = 30.00, valor_pago = 270.00 WHERE id_consulta = 1; -- Aplicado desconto no pagamento do paciente de ID 1; (valor da consulta : R$300,00, para R$270,00)



-- Consultas e Análises (DQL)

-- DQL 1: Faturamento Total e Média do Valor de Pagamento por Método
SELECT 
    metodo_pagamento, 
    COUNT(*) AS qtd_transacoes, 
    SUM(valor_pago) AS total_faturado, 
    AVG(valor_pago) AS media_valor
FROM PAGAMENTO
WHERE status_pagamento = 'Pago'
GROUP BY metodo_pagamento;

-- DQL 2: Total de Consultas e Valor Faturado por Médico
SELECT 
    m.nome_completo AS nome_medico, 
    COUNT(c.id_consulta) AS total_consultas,
    SUM(c.valor_final) AS receita_gerada
FROM MEDICO m
JOIN CONSULTA c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nome_completo;

-- DQL 3: Quantidade de Pacientes Cadastrados por Plano de Saúde
SELECT 
    ps.nome_plano, 
    COUNT(p.id_paciente) AS total_pacientes
FROM PLANO_SAUDE ps
LEFT JOIN PACIENTE p ON ps.id_plano = p.id_plano
GROUP BY ps.id_plano, ps.nome_plano;

-- DQL 4: Contagem de Status de Consultas (Realizadas, Canceladas, Faltas)
SELECT 
    status, 
    COUNT(*) AS total_consultas,
    MIN(valor_final) AS menor_valor,
    MAX(valor_final) AS maior_valor
FROM CONSULTA
GROUP BY status;

-- CONSULTAS COM JOIN --

-- DQL 5: Lista Completa de Consultas com Paciente, Médico e Plano
SELECT 
    c.id_consulta,
    c.data_hora,
    p.nome_completo AS nome_paciente,
    ps.nome_plano,
    m.nome_completo AS nome_medico,
    c.status
FROM CONSULTA c
INNER JOIN PACIENTE p ON c.id_paciente = p.id_paciente
LEFT JOIN PLANO_SAUDE ps ON p.id_plano = ps.id_plano
INNER JOIN MEDICO m ON c.id_medico = m.id_medico;

-- DQL 6: Histórico de Prontuários com Diagnóstico e Prescrição por Paciente
SELECT 
    p.nome_completo AS paciente,
    c.data_hora,
    pr.queixa_principal,
    pr.diagnostico,
    pr.prescricao_medica
FROM PRONTUARIO_ELETRONICO pr
INNER JOIN CONSULTA c ON pr.id_consulta = c.id_consulta
INNER JOIN PACIENTE p ON c.id_paciente = p.id_paciente;

-- DQL 7: Relatório Financeiro Detalhado de Consultas e Status do Pagamento
SELECT 
    c.id_consulta,
    p.nome_completo AS paciente,
    c.valor_final AS valor_consulta,
    pg.valor_pago,
    pg.metodo_pagamento,
    pg.status_pagamento
FROM CONSULTA c
INNER JOIN PACIENTE p ON c.id_paciente = p.id_paciente
LEFT JOIN PAGAMENTO pg ON c.id_consulta = pg.id_consulta;

-- DQL 8: Informativo dos Medicos e o Total de Atendimentos
SELECT 
    m.nome_completo AS medico,
    COUNT(c.id_consulta) AS total_atendimentos
FROM MEDICO m
LEFT JOIN CONSULTA c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nome_completo;
