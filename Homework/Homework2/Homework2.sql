/*
	Задача № 1
	Используя операторы языка SQL, создайте таблицу “sales”. 
    Заполните ее данными (см. презентацию слайд 28).
*/

DROP DATABASE Shop_Base;

CREATE DATABASE Shop_Base;

USE Shop_Base;

CREATE TABLE sales (id INTEGER AUTO_INCREMENT PRIMARY KEY, 
	order_date DATE NOT NULL, 
	count_product INTEGER NOT NULL);
	
INSERT INTO sales (order_date, count_product)
	VALUES ('2022-01-01', 156);
INSERT INTO sales (order_date, count_product)
	VALUES ('2022-01-02', 180);
INSERT INTO sales (order_date, count_product)
	VALUES ('2022-01-03', 21);
INSERT INTO sales (order_date, count_product)
	VALUES ('2022-01-04', 124);
INSERT INTO sales (order_date, count_product)
	VALUES ('2022-01-05', 341);
	
SELECT id, order_date, count_product FROM sales;

/*
	Задача № 2
	Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва:
        меньше 100 - Маленький заказ
        от 100 до 300 - Средний заказ
        больше 300 - Большой заказ
*/

SELECT
    id AS 'id заказа',
    count_product AS 'Количество',
    CASE
        WHEN count_product < 100 THEN 'Маленький заказ'
        WHEN count_product between 100 AND 300 THEN 'Средний заказ'
        WHEN count_product > 300 THEN 'Большой заказ'
    END AS 'Тип заказа'
FROM sales;

/*
	Задача № 3
	Используя операторы языка SQL, создайте таблицу “orders”, 
    заполните ее значениями (см. презентацию слайд 29). Выберите все заказы. 
    В зависимости от поля order_status выведите столбец full_order_status:
        OPEN – «Order is in open state» ;
        CLOSED - «Order is closed»;
        CANCELLED - «Order is cancelled»
*/

CREATE TABLE orders (id INTEGER AUTO_INCREMENT PRIMARY KEY, 
	employee_id VARCHAR(4) NOT NULL, 
	amount DECIMAL(6,2) NOT NULL,
    -- использовал DECIMAL, т.к. в бухгалтерии нужна точность
    order_status VARCHAR(10) NOT NULL);

INSERT INTO orders (employee_id, amount, order_status)
	VALUES ('e03', 15.00, 'OPEN');
INSERT INTO orders (employee_id, amount, order_status)
	VALUES ('e01', 25.50, 'OPEN');
INSERT INTO orders (employee_id, amount, order_status)
	VALUES ('e05', 100.70, 'CLOSED');
INSERT INTO orders (employee_id, amount, order_status)
	VALUES ('e02', 22.18, 'OPEN');
INSERT INTO orders (employee_id, amount, order_status)
	VALUES ('e04', 9.50, 'CANCELLED');
	
SELECT id, employee_id, amount, order_status FROM orders;

SELECT
    id,
    CASE order_status
        WHEN 'OPEN' THEN 'Order is in open state'
        WHEN 'CLOSED' THEN 'Order is closed'
        WHEN 'CANCELLED' THEN 'Order is cancelled'
    END AS 'full_order_status'
FROM orders;

/*
	Задача № 4
	Чем NULL отличается от 0?

	Ответ:
	0 - это число, а NULL - это пустота(отсутствие данных).
*/