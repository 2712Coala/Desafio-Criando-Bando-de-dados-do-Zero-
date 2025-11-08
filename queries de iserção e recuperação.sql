-- Iserção e Recuperação --

-- 🧍 Inserindo Locadores
USE gestao;
INSERT INTO Locadores (nome, CPF, CNPJ, endereco, telefone, email)
VALUES
('Maria', '12346789011', '56001002000101', 'Rua Silva de Prata 29, Carangola - Cidade das Flores', '1125863040', NULL),
('Zagros Fundo Imobiliario', NULL, '56002002000102', 'Rua Alameda 289, Centro - Cidade das Flores', '2125863041', NULL),
('Ricardo', '45678913000', '56003003000103', 'Avenida Alameda Vinha 1009, Centro - Cidade das Flores', '7125863042', NULL),
('Americas Fundo Imobiliario', NULL, '56004004000104', 'Rua Laranjeiras 861, Centro - Cidade das Flores', '1125863043', NULL),
('Roberta', '98745631000', '56005005000105', 'Avenida Koller 19, Centro - Cidade das Flores', '8525863044', NULL),
('Newporte Fundo Imobiliario', NULL, '56006006000106', 'Rua Alameda das Flores 28, Centro - Cidade das Flores - Paran', '4125863044', NULL);

-- Inserindo condomínio
INSERT INTO Condominio (nome, CNPJ, endereco, telefone, email)
VALUES 
('Condomínio Jardim Azul', '12345678000101', 'Av. Santo Amaro, 45, Centro, São Paulo', '1122223333', NULL),
('Condomínio Vila Matilde', '12345678000102', 'Av. Brasil, 1000, Botafogo, Rio de Janeiro', '2122224444', NULL),
('Condomínio Salvador', '12345678000103', 'Rua do Pitu, 300, Pitu, Salvador', '7122225555', NULL),
('Condomínio Rio de Janeiro', '12345678000104', 'Av. Nações Unidas, 1000, Vila Olímpia, São Paulo', '1122226666', NULL),
('Condomínio Santo Amaro', '12345678000199', 'Av. Campos do Jordão, 300, Centro, Fortaleza', '8522227777', NULL),
('Condomínio Jardim Penha', '12345678000105', 'Av. Paraná, 45, Centro, Curitiba', '4122228888', NULL);

-- Inserindo administradora
INSERT INTO Administradora (nome, CNPJ, endereco, telefone, email)
VALUES 
('AdmPredial', '98765432000188', 'Rua Central, 100, Centro, São Paulo', '1133334444',null),
('Inova administradora', '98765432000187', 'Rua Santos Dumont, 150, Botafogo, Rio de Janeiro', '2133335555',null),
('Siekas administradora', '98765432000186', 'Rua Cantos das águas, 65, Centro, Salvador', '7133336666',null),
('Loggi administradora', '98765432000185', 'Avenida Tomas Lopes, 65, Romano, São Paulo','1133337777',null),
('Total administradora', '98765432000185', 'Avenida Fortaleza, 80, Centro, Fortaleza', '11333388888',null),
('MOB administrodora', '98765432000183', 'Rua Monsernhor Francisco de Paula, 385, Praca Lindomar - Curitiba', '1133334444',null);

select * from administradora;

-- Criando um contrato
INSERT INTO Contratos (idLocador, idAdministradora, idCondominio, dataInicio, dataFim, valorAluguel, valorCondominio, valorIptu, statusContrato)
VALUES
(1, 1, 1, '2025-01-01', '2025-12-31', 2500.00, 350.00, 150.00, 'ativo'),
(2, 2, 2, '2025-02-01', NULL, 4800.00, 600.00, 400.00, 'ativo'),
(3, 1, 3, '2024-07-01', '2025-06-30', 3000.00, 500.00, 200.00, 'ativo'),
(4, NULL, 4, '2025-03-15', NULL, 2200.00, 300.00, 180.00, 'ativo'),
(5, 2, 5, '2025-04-01', '2026-03-31', 2700.00, 400.00, 250.00, 'ativo'),
(6, 1, 6, '2025-01-15', '2026-01-14', 3200.00, 420.00, 220.00, 'ativo');

select * from contratos;

-- Registrando pagamento de aluguel

INSERT INTO Pagamentos (idContrato, categoria, valor, metodoPagamento, statusPagamento)
VALUES
(1, 'aluguel', 2500.00, 'Pix', 'pago'),
(1, 'condominio', 350.00, 'Pix', 'pago'),
(1, 'iptu', 150.00, 'Pix', 'pago'),

(2, 'aluguel', 4800.00, 'Boleto', 'pendente'),
(2, 'condominio', 600.00, 'Boleto', 'pendente'),
(2, 'iptu', 400.00, 'Boleto', 'pendente'),

(3, 'aluguel', 3000.00, 'Transferência', 'pago'),
(3, 'condominio', 500.00, 'Transferência', 'pago'),

(4, 'aluguel', 2200.00, 'Dinheiro', 'pago'),
(5, 'aluguel', 2700.00, 'Pix', 'pendente');

select * From pagamentos; 

-- Recuperação Contratos Ativos

SELECT c.idContrato, l.nome AS Locador, co.nome AS Condominio,
       c.valorAluguel, c.dataInicio, c.dataFim
FROM Contratos c
JOIN Locadores l ON c.idLocador = l.idLocador
JOIN Condominio co ON c.idCondominio = co.idCondominio
WHERE c.statusContrato = 'ativo';

-- Recuperação Pagamentos

SELECT p.idPagamento, c.idContrato, l.nome AS Locador, p.categoria, p.valor, p.statusPagamento
FROM Pagamentos p
JOIN Contratos c ON p.idContrato = c.idContrato
JOIN Locadores l ON c.idLocador = l.idLocador
WHERE p.statusPagamento = 'pendente';   

-- Recuperação Total pago por contrato

SELECT idContrato, SUM(valor) AS totalPago
FROM Pagamentos
WHERE statusPagamento = 'pago'
GROUP BY idContrato;
