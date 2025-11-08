-- Desafio: Criação do Banco de Dados do Zero - Cenário Controle de Gestão de Contratos Imobiliários

-- Tabela de Locadores
CREATE TABLE Locadores (
  idLocador INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  CPF CHAR(11),
  CNPJ CHAR(14),
  endereco VARCHAR(100),
  telefone CHAR(11),
  email VARCHAR(100)
);

-- Tabela de Administradoras

CREATE TABLE Administradora (
  idAdministradora INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  CNPJ CHAR(14),
  endereco VARCHAR(100),
  telefone CHAR(11),
  email VARCHAR(100)
);

-- Tabela de Condomínios
CREATE TABLE Condominio (
  idCondominio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  CNPJ CHAR(14),
  endereco VARCHAR(100),
  telefone CHAR(11),
  email VARCHAR(100)
);

-- Tabela de Contratos
CREATE TABLE Contratos (
  idContrato INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  idLocador INT NOT NULL,
  idAdministradora INT,
  idCondominio INT,
  dataInicio DATE NOT NULL,
  dataFim DATE,
  valorAluguel DECIMAL(10,2),
  valorCondominio DECIMAL(10,2),
  valorIptu DECIMAL(10,2),
  statusContrato ENUM('ativo', 'inativo', 'encerrado') DEFAULT 'ativo',
  FOREIGN KEY (idLocador) REFERENCES Locadores(idLocador),
  FOREIGN KEY (idAdministradora) REFERENCES Administradora(idAdministradora),
  FOREIGN KEY (idCondominio) REFERENCES Condominio(idCondominio)
);

-- Tabela de Pagamentos
CREATE TABLE Pagamentos (
  idPagamento INT AUTO_INCREMENT PRIMARY KEY,
  idContrato INT NOT NULL,
  categoria ENUM('aluguel','condominio','iptu','contas de consumo') NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  dataPagamento DATETIME DEFAULT NOW(),
  metodoPagamento VARCHAR(50),
  statusPagamento ENUM('pendente', 'pago', 'atrasado') DEFAULT 'pendente',
  FOREIGN KEY (idContrato) REFERENCES Contratos(idContrato)
);
