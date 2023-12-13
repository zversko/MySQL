/*
	Задача № 1
	Создайте таблицу с мобильными телефонами, 
	используя графический интерфейс. 
	Заполните БД данными (поля и наполнение см. в презентации).
*/

CREATE DATABASE Mobile_Phone;

USE Mobile_Phone;

CREATE TABLE Mob_Phone (id INTEGER AUTO_INCREMENT PRIMARY KEY, 
	product_name VARCHAR(20) NOT NULL, 
	manufacturer VARCHAR(20) NOT NULL,
	product_count INTEGER NOT NULL,
	price INTEGER NOT NULL);
	
INSERT INTO Mob_Phone (product_name, manufacturer, product_count, price) 
	VALUES ('iPhone X', 'Apple', 3, 76000);
INSERT INTO Mob_Phone (product_name, manufacturer, product_count, price)
	VALUES ('iPhone 8', 'Apple', 2, 51000);
INSERT INTO Mob_Phone (product_name, manufacturer, product_count, price)
	VALUES ('Galaxy S9', 'Samsung', 2, 56000);
INSERT INTO Mob_Phone (product_name, manufacturer, product_count, price)
	VALUES ('Galaxy S8', 'Samsung', 1, 41000);
INSERT INTO Mob_Phone (product_name, manufacturer, product_count, price)
	VALUES ('P20 Pro', 'Huawei', 5, 36000);
	
SELECT id, product_name, manufacturer, product_count, price FROM Mob_Phone;

/*
	Задача № 2
	Выведите название, производителя и цену для товаров, 
	количество которых превышает 2.
*/

SELECT product_name, manufacturer, price FROM Mob_Phone WHERE product_count > 2;

/*
	Задача № 3
	Выведите весь ассортимент товаров марки “Samsung”.
*/

SELECT id, product_name, manufacturer, product_count, price FROM Mob_Phone
	WHERE manufacturer = 'Samsung';
	
/*
	Задача № 4
	С помощью регулярных выражений найти:
	Товары, в которых есть упоминание "Iphone"
	Товары, в которых есть упоминание "Samsung"
	Товары, в которых есть ЦИФРЫ
	Товары, в которых есть ЦИФРА "8"
*/

SELECT * FROM Mob_Phone WHERE product_name REGEXP 'Phone';

SELECT * FROM Mob_Phone WHERE concat(product_name, manufacturer) REGEXP 'Samsung';

SELECT * FROM Mob_Phone WHERE concat(product_name, manufacturer) REGEXP '[0-9]';

SELECT * FROM Mob_Phone WHERE concat(product_name, manufacturer) REGEXP '[8]';