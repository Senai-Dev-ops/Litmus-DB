/*Criação da DATABASE de Backup*/

CREATE DATABASE BKP_USUARIO;

use BKP_USUARIO;

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
