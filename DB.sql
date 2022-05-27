/* Comandos mais usados*/
select * from BKP_USUARIO.LOG_USUARIO;

USE usuario;

SELECT * FROM usuarios;

DESC usuarios;



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

/* Inserção de dados */

INSERT INTO usuarios VALUES(1,'TESTE','TESTE@IG.COM','123','12345678112',True,'1999-09-10');
INSERT INTO usuarios VALUES(2,'TESTE2','TESTE2@IG.COM','123','12345622912',False,'1998-08-11');
INSERT INTO usuarios VALUES(3,'TESTE3','TESTE3@IG.COM','123','12345633912',False,'1997-07-12');
INSERT INTO usuarios VALUES(4,'TESTE4','TESTE4@IG.COM','123','12345644912',True,'1996-06-13');
INSERT INTO usuarios VALUES(5,'TESTE5','TESTE5@IG.COM','123','12345655912',False,'1995-05-14');


/*Criação da DATABASE de Backup*/

CREATE DATABASE BKP_USUARIO;

use BKP_USUARIO;

/*Criando a tabela de LOG do usuário*/

CREATE TABLE LOG_USUARIO(
idBackup INT PRIMARY KEY auto_increment,
idUsuario INT,
nome_anterior VARCHAR(50),
nome_atual VARCHAR(50),
email_anterior VARCHAR(50),
email_atual VARCHAR(50),
senha_anterior VARCHAR(150),
senha_atual VARCHAR(150),
CPF_anterior CHAR(14),
CPF_atual CHAR(14),
ADM_anterior boolean,
ADM_atual boolean,
DATANASC_anterior date,
DATANASC_atual date,
Data_de_modificacao DATETIME,
USUARIO VARCHAR(30),
EVENTO CHAR(1)
);

/* Criando Triggers */

USE usuario;


 /* Trigger de Update */

DELIMITER $
CREATE TRIGGER tr_update
AFTER UPDATE ON usuarios
for each row
begin

       INSERT INTO BKP_USUARIO.LOG_USUARIO VALUES(NULL,OLD.idUsuario,OLD.nome,NEW.nome,OLD.email,
       NEW.email,OLD.senha,NEW.senha,OLD.CPF,NEW.CPF,OLD.ADM,NEW.ADM,OLD.DATANASC,NEW.DATANASC,
       now(), current_user(), 'U');
end
$

DELIMITER ;


/* DADO PARA TESTAR TRIGGER DE UPDATE */

UPDATE usuarios  SET nome ='TESTE01' WHERE idUsuario = '1';


 /* Trigger de Insert */

DELIMITER $
CREATE TRIGGER tr_insert
AFTER INSERT ON usuarios
for each row
begin

       INSERT INTO BKP_USUARIO.LOG_USUARIO VALUES(NULL,NEW.idUsuario,NULL,NEW.nome,NULL,
       NEW.email,NULL,NEW.senha,NULL,NEW.CPF,NULL,NEW.ADM,NULL,NEW.DATANASC,
       now(), current_user(), 'I');
end
$

DELIMITER ;

/* DADO PARA TESTAR TRIGGER DE INSERT */

INSERT INTO usuarios VALUES(7,'TESTE7','TESTE7@IG.COM','123','17745655912',False,'2000-01-22');




 /* Trigger Delete */

DELIMITER $
CREATE TRIGGER tr_delete
BEFORE DELETE ON usuarios
for each row
begin

       INSERT INTO BKP_USUARIO.LOG_USUARIO VALUES(NULL,OLD.idUsuario,OLD.nome,NULL,OLD.email,
       NULL,OLD.senha,NULL,OLD.CPF,NULL,OLD.ADM,NULL,OLD.DATANASC,NULL,
       now(), current_user(), 'D');
end
$
DELIMITER ;


/* DADOS PARA TESTAR TRIGGER DE DELETE */

DELETE FROM usuarios WHERE idUsuario='3';


/* Selects para uma melhor visualização do que cada trigger alterou/deletou/inseriu*/
		   
/* Select da Trigger Update */
SELECT nome_anterior,nome_atual, email_anterior,email_atual,senha_anterior, senha_atual,CPF_anterior, CPF_atual, ADM_anterior, ADM_atual,
 DATANASC_anterior, DATANASC_atual,Data_de_modificacao, USUARIO, EVENTO
FROM BKP_USUARIO.LOG_USUARIO
WHERE EVENTO = 'U';

/*Select da Trigger Delete */
SELECT nome_anterior, email_anterior, senha_anterior, CPF_anterior, ADM_anterior, DATANASC_anterior, Data_de_modificacao, USUARIO, EVENTO
FROM BKP_USUARIO.LOG_USUARIO
WHERE EVENTO = 'D';

/* Select da Trigger Insert */
SELECT nome_atual, email_atual, senha_atual, CPF_atual, ADM_atual , DATANASC_atual, Data_de_modificacao, USUARIO, EVENTO
FROM BKP_USUARIO.LOG_USUARIO
WHERE EVENTO = 'I';



/* Criação da tabela Maquinas */

USE usuario;

CREATE TABLE IF NOT EXISTS Maquinas(
id INTEGER NOT NULL auto_increment ,
rotacao INTEGER NOT NULL,
temperatura INTEGER NOT NULL,
avanco INTEGER NOT NULL,
datahora VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
);

INSERT INTO Maquinas VALUES(1,10,28,12,NOW());

SELECT * FROM Maquinas;

/* Criação de Usuario BACKEND */

CREATE USER 'backend'@'%' IDENTIFIED BY 'senai@115';
GRANT CREATE, DELETE, INSERT, SELECT, UPDATE ON * . * TO 'backend'@'%';
FLUSH PRIVILEGES;


