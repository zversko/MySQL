v/*
	Задача № 1
	Создайте таблицу users_old, аналогичную таблице users. 
    Создайте процедуру, с помощью которой можно переместить 
    любого (одного) пользователя из таблицы users в таблицу 
    users_old. (использование транзакции с выбором commit или 
    rollback – обязательно).
*/

DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

CREATE PROCEDURE transfer_user (
    tr_firstname VARCHAR(50), 
    tr_lastname VARCHAR(50)
)

BEGIN
    START TRANSACTION;
   
        INSERT INTO users_old 
        SELECT * FROM users
   		WHERE users.firstname = tr_firstname AND users.lastname = tr_lastname;
   	
   		DELETE FROM users 
   		WHERE users.firstname = tr_firstname AND users.lastname = tr_lastname;
   	
    COMMIT;
END;

CALL transfer_user ('Jordyn', 'Jerde'); -- В качестве примера

/*
	Задача № 2  
	Создайте хранимую функцию hello(), которая будет возвращать 
    приветствие, в зависимости от текущего времени суток. 
    С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
    с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
    с 18:00 до 00:00 — "Добрый вечер", 
    с 00:00 до 6:00 — "Доброй ночи".
*/

DROP Function hello;

CREATE FUNCTION hello ()
    RETURNS CHAR(50)
    DETERMINISTIC
    begin
	    DECLARE t TIME;
	   	Select CURRENT_TIME() INTO t;
    	IF 
	    	t > '06:00:00' AND t < '12:00:00'
	    	THEN RETURN CONCAT('Доброе утро');
    	ELSEIF
    		t > '12:00:00' AND t < '18:00:00' 
    		THEN RETURN CONCAT('Добрый день');
    	ELSEIF
    		t > '18:00:00' AND t < '23:59:59'
    		THEN RETURN CONCAT('Добрый вечер');
    	ELSEIF
    		t > '00:00:00' AND t < '06:00:00'
    		THEN RETURN CONCAT('Доброй ночи');
    	END IF;
    END;
    
SELECT hello();

/*
	Задача № 3  
	(по желанию)* Создайте таблицу logs типа Archive. 
    Пусть при каждом создании записи в таблицах users, communities 
    и messages в таблицу logs помещается время и дата создания записи, 
    название таблицы, идентификатор первичного ключа.
*/

