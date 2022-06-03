/* Privilégios ao usuário backend */
GRANT CREATE, DELETE, INSERT, SELECT, UPDATE ON * . * TO 'backend'@'%';
FLUSH PRIVILEGES;

/*Criação da DATABASE de usuarios*/

CREATE DATABASE usuario;

use usuario;

/* Criando Tabela Usuarios*/

CREATE TABLE usuarios (
idUsuario INT NOT NULL auto_increment primary key,
nome VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL UNIQUE,
senha VARCHAR(150) NOT NULL,
CPF CHAR(14) NOT NULL UNIQUE,
ADM boolean NOT NULL,
DATANASC date NOT NULL
);

/* Criação da tabela Maquinas */

CREATE TABLE Maquinas (
id INTEGER NOT NULL auto_increment ,
rotacao INTEGER NOT NULL,
temperatura INTEGER NOT NULL,
avanco INTEGER NOT NULL,
datahora VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
);
