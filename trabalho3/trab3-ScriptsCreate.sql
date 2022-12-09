CREATE TABLE Usuario (
  id INTEGER CHECK (id > 0) NOT NULL,
  nome VARCHAR(255) NOT NULL,
  senha VARCHAR(45) NOT NULL,
  email VARCHAR(255) NOT NULL,
  telefone VARCHAR(45) NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE Terceiro (
  Usuario_id INTEGER CHECK (Usuario_id > 0) NOT NULL,
  cnpj VARCHAR(45) NOT NULL,
  razaoSocial VARCHAR(45) NOT NULL,
  PRIMARY KEY(Usuario_id),
  FOREIGN KEY(Usuario_id)
    REFERENCES Usuario(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Terceiro_FKIndex1 ON Terceiro(Usuario_id);

CREATE TABLE Endereco (
  Usuario_id INTEGER CHECK (Usuario_id > 0) NOT NULL,
  estado VARCHAR(45) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  cep VARCHAR(45) NOT NULL,
  bairro VARCHAR(45) NOT NULL,
  rua VARCHAR(45) NOT NULL,
  numero INTEGER CHECK (numero > 0) NOT NULL,
  complemento VARCHAR(45) NOT NULL,
  PRIMARY KEY(Usuario_id),
  FOREIGN KEY(Usuario_id)
    REFERENCES Usuario(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Endereco_FKIndex1 ON Endereco(Usuario_id);

CREATE TABLE Cliente (
  Usuario_id INTEGER CHECK (Usuario_id > 0) NOT NULL,
  cpf VARCHAR(45) NOT NULL,
  dataNascimento DATE NOT NULL,
  genero CHAR(1) NOT NULL,
  CNH VARCHAR(45) NOT NULL,
  PRIMARY KEY(Usuario_id),
  FOREIGN KEY(Usuario_id)
    REFERENCES Usuario(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Cliente_FKIndex1 ON Cliente(Usuario_id);

CREATE TABLE Funcionario (
  Usuario_id INTEGER CHECK (Usuario_id > 0) NOT NULL,
  cpf VARCHAR(45) NOT NULL,
  nome VARCHAR(255) NOT NULL,
  dataNascimento DATE  NOT NULL,
  genero CHAR(1) NOT NULL,
  cargo VARCHAR(45) NOT NULL,
  salario DOUBLE PRECISION NOT NULL,
  PRIMARY KEY(Usuario_id),
  FOREIGN KEY(Usuario_id)
    REFERENCES Usuario(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Funcionario_FKIndex1 ON Funcionario(Usuario_id);

CREATE TABLE Fornecedor (
  Usuario_id INTEGER CHECK (Usuario_id > 0) NOT NULL,
  cnpj VARCHAR(45) NOT NULL,
  razaoSocial VARCHAR(45) NOT NULL,
  PRIMARY KEY(Usuario_id),
  FOREIGN KEY(Usuario_id)
    REFERENCES Usuario(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Fornecedor_FKIndex1 ON Fornecedor(Usuario_id);

CREATE SEQUENCE Veiculo_seq;

CREATE TABLE Veiculo (
  id INTEGER CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('Veiculo_seq'),
  Fornecedor_Usuario_id INTEGER CHECK (Fornecedor_Usuario_id > 0) NOT NULL,
  valorPago DOUBLE PRECISION NOT NULL,
  marca VARCHAR(45) NOT NULL,
  dataCompra TIMESTAMP  NOT NULL,
  cor VARCHAR(45) NOT NULL,
  ano INTEGER CHECK (ano > 0) NOT NULL,
  modelo VARCHAR(45) NOT NULL,
  placa VARCHAR(45) NOT NULL,
  situacao VARCHAR(45) NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(Fornecedor_Usuario_id)
    REFERENCES Fornecedor(Usuario_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Veiculo_FKIndex1 ON Veiculo(Fornecedor_Usuario_id);

CREATE SEQUENCE Manutencao_seq;

CREATE TABLE Manutencao (
  id INTEGER CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('Manutencao_seq'),
  Terceiro_Usuario_id INTEGER CHECK (Terceiro_Usuario_id > 0) NOT NULL,
  Veiculo_id INTEGER CHECK (Veiculo_id > 0) NOT NULL,
  dataManutencao DATE NOT NULL,
  valor DOUBLE PRECISION NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(Veiculo_id)
    REFERENCES Veiculo(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Terceiro_Usuario_id)
    REFERENCES Terceiro(Usuario_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Manutencao_FKIndex1 ON Manutencao(Veiculo_id);
CREATE INDEX Manutencao_FKIndex2 ON Manutencao(Terceiro_Usuario_id);

CREATE SEQUENCE Venda_seq;

CREATE TABLE Venda (
  id INTEGER CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('Venda_seq'),
  Terceiro_Usuario_id INTEGER CHECK (Terceiro_Usuario_id > 0) NOT NULL,
  Funcionario_Usuario_id INTEGER CHECK (Funcionario_Usuario_id > 0) NOT NULL,
  Veiculo_id INTEGER CHECK (Veiculo_id > 0) NOT NULL,
  valorVenda DOUBLE PRECISION NULL,
  dataVenda DATE NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(Veiculo_id)
    REFERENCES Veiculo(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Funcionario_Usuario_id)
    REFERENCES Funcionario(Usuario_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Terceiro_Usuario_id)
    REFERENCES Terceiro(Usuario_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Venda_FKIndex1 ON Venda(Veiculo_id);
CREATE INDEX Venda_FKIndex2 ON Venda(Funcionario_Usuario_id);
CREATE INDEX Venda_FKIndex3 ON Venda(Terceiro_Usuario_id);

CREATE SEQUENCE Locacao_seq;

CREATE TABLE Locacao (
  id INTEGER CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('Locacao_seq'),
  Veiculo_id INTEGER CHECK (Veiculo_id > 0) NOT NULL,
  Funcionario_Usuario_id INTEGER CHECK (Funcionario_Usuario_id > 0) NOT NULL,
  Cliente_Usuario_id INTEGER CHECK (Cliente_Usuario_id > 0) NOT NULL,
  dataInicio DATE NOT NULL,
  dataFim DATE NOT NULL,
  valor DOUBLE PRECISION  NOT NULL,
  nivelCombOriginal DOUBLE PRECISION  NOT NULL,
  kmOriginal DOUBLE PRECISION  NOT NULL,
  nivelCombDevolve DOUBLE PRECISION  NULL,
  kmDevolve DOUBLE PRECISION  NULL,
  dataDevolucao DATE NULL,
  juros DOUBLE PRECISION NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(Cliente_Usuario_id)
    REFERENCES Cliente(Usuario_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Funcionario_Usuario_id)
    REFERENCES Funcionario(Usuario_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Veiculo_id)
    REFERENCES Veiculo(id)
      ON DELETE NO action
      ON UPDATE NO ACTION
);

CREATE INDEX Locacao_FKIndex1 ON Locacao(Cliente_Usuario_id);
CREATE INDEX Locacao_FKIndex2 ON Locacao(Funcionario_Usuario_id);
CREATE INDEX Locacao_FKIndex3 ON Locacao(Veiculo_id);

CREATE SEQUENCE Sinistro_seq;

CREATE TABLE Sinistro (
  id INTEGER CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('Sinistro_seq'),
  Locacao_id INTEGER CHECK (Locacao_id > 0) NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  dataSinistro TIMESTAMP(0) NOT NULL,
  tipo VARCHAR(45) NOT NULL,
  dano VARCHAR(45) NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(Locacao_id)
    REFERENCES Locacao(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Sinistro_FKIndex1 ON Sinistro(Locacao_id);


