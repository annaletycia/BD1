CREATE SEQUENCE Equipe_seq;

CREATE TABLE Equipe (
  idEquipe INTEGER CHECK (idEquipe > 0) NOT NULL DEFAULT NEXTVAL ('Equipe_seq'),
  nomeEquipe VARCHAR(50) NOT NULL,
  paisEquipe VARCHAR(50) NOT NULL,
  titulosEquipe INTEGER CHECK (titulosEquipe >= 0) NOT NULL,
  PRIMARY KEY(idEquipe)
);


CREATE SEQUENCE Circuito_seq;

CREATE TABLE Circuito (
  idCircuito INTEGER CHECK (idCircuito > 0) NOT NULL DEFAULT NEXTVAL ('Circuito_seq'),
  nomeCircuito VARCHAR(50) NULL,
  localCircuito VARCHAR(50) NULL,
  PRIMARY KEY(idCircuito)
);


CREATE SEQUENCE Pessoa_seq;

CREATE TABLE Pessoa (
  idPessoa INTEGER CHECK (idPessoa > 0) NOT NULL DEFAULT NEXTVAL ('Pessoa_seq'),
  nomePessoa VARCHAR(50) NULL,
  tipoPessoa CHAR NULL,
  Equipe_idEquipe INTEGER CHECK (Equipe_idEquipe > 0) NOT NULL,
  PRIMARY KEY(idPessoa)
 ,
  FOREIGN KEY(Equipe_idEquipe)
    REFERENCES Equipe(idEquipe)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Pessoa_FKIndex1 ON Pessoa(Equipe_idEquipe);


CREATE TABLE Piloto (
  Pessoa_idPessoa INTEGER CHECK (Pessoa_idPessoa > 0) NOT NULL,
  titulosPiloto INTEGER CHECK (titulosPiloto >= 0) NOT NULL,
  pontuacaoPiloto INTEGER CHECK (pontuacaoPiloto >= 0) NOT NULL,
  PRIMARY KEY(Pessoa_idPessoa)
 ,
  FOREIGN KEY(Pessoa_idPessoa)
    REFERENCES Pessoa(idPessoa)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Piloto_FKIndex1 ON Piloto(Pessoa_idPessoa);


CREATE SEQUENCE Corrida_seq;

CREATE TABLE Corrida (
  idCorrida INTEGER CHECK (idCorrida > 0) NOT NULL DEFAULT NEXTVAL ('Corrida_seq'),
  dataCorrida DATE NULL,
  categoriaCorrida VARCHAR(50) NULL,
  voltasCorrida INTEGER CHECK (voltasCorrida >= 0) NULL,
  Circuito_idCircuito INTEGER CHECK (Circuito_idCircuito > 0) NOT NULL,
  PRIMARY KEY(idCorrida)
 ,
  FOREIGN KEY(Circuito_idCircuito)
    REFERENCES Circuito(idCircuito)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Corrida_FKIndex1 ON Corrida(Circuito_idCircuito);


CREATE TABLE Mecanico (
  Pessoa_idPessoa INTEGER CHECK (Pessoa_idPessoa > 0) NOT NULL,
  especialidade VARCHAR(50) NOT NULL,
  Mecanico_Sup_idPessoa INTEGER CHECK (Mecanico_Sup_idPessoa > 0) NOT NULL,
  PRIMARY KEY(Pessoa_idPessoa)
 ,
  FOREIGN KEY(Pessoa_idPessoa)
    REFERENCES Pessoa(idPessoa)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Mecanico_Sup_idPessoa)
    REFERENCES Mecanico(Pessoa_idPessoa)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Mecanico_FKIndex1 ON Mecanico(Pessoa_idPessoa);
CREATE INDEX Mecanico_FKIndex2 ON Mecanico(Mecanico_Sup_idPessoa);


CREATE TABLE Participacao (
  Piloto_Pessoa_idPessoa INTEGER CHECK (Piloto_Pessoa_idPessoa > 0) NOT NULL,
  Corrida_idCorrida INTEGER CHECK (Corrida_idCorrida > 0) NOT NULL,
  voltasParticipacao INTEGER CHECK (voltasParticipacao >= 0) NOT NULL,
  tempoParticipacao TIME(6) NOT NULL,
  PRIMARY KEY(Piloto_Pessoa_idPessoa, Corrida_idCorrida)
 ,
  FOREIGN KEY(Corrida_idCorrida)
    REFERENCES Corrida(idCorrida)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Piloto_Pessoa_idPessoa)
    REFERENCES Piloto(Pessoa_idPessoa)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE INDEX Piloto_has_Corrida_FKIndex2 ON Participacao(Corrida_idCorrida);
CREATE INDEX Participacao_FKIndex2 ON Participacao(Piloto_Pessoa_idPessoa);
