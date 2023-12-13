/*
	Задача № 1
	Создайте представление, в которое попадет информация о пользователях 
    (имя, фамилия, город и пол), которые не старше 20 лет.
*/

SELECT 
	CONCAT(u.firstname, ' ', u.lastname) AS 'Пользователь', 
	p.hometown, 
	p.gender,
	p.birthday 
FROM users u
JOIN profiles p ON u.id = p.user_id
WHERE TIMESTAMPDIFF(YEAR, p.birthday, CURDATE()) < 20;

SELECT * FROM v_user_not_old_20_years; 

/*
	Задача № 2
	Найдите кол-во, отправленных сообщений каждым пользователем 
    и выведите ранжированный список пользователь, указав указать 
    имя и фамилию пользователя, количество отправленных сообщений 
    и место в рейтинге (первое место у пользователя с максимальным 
    количеством сообщений) . (используйте DENSE_RANK)
*/

SELECT
	DENSE_RANK() OVER (ORDER BY COUNT(m.id) DESC) AS rank_body,
	CONCAT(u.firstname, ' ', u.lastname) AS 'Пользователь',
	COUNT(m.id) AS 'Кол-во сообщ.'
FROM messages m
RIGHT JOIN users u ON u.id = m.from_user_id 
GROUP BY m.from_user_id
ORDER BY rank_body;

-- с помощью подзапроса

SELECT
	DENSE_RANK() OVER (ORDER BY 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) DESC) AS rank_body, 
	firstname, 
	lastname, 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS 'Кол-во сообщ.'
FROM users;

/*
	Задача № 3
	Выберите все сообщения, отсортируйте сообщения по возрастанию 
    даты отправления (created_at) и найдите разницу дат отправления 
    между соседними сообщениями, получившегося списка. 
    (используйте LEAD или LAG)
*/

SELECT 
	m.id,
	m.created_at,
	TIMEDIFF(lag(m.created_at) OVER(ORDER BY m.created_at), m.created_at) AS 'Разница до',
	TIMEDIFF(m.created_at, lead(m.created_at) OVER(ORDER BY m.created_at)) AS 'Разница после'
FROM messages m 
ORDER BY m.created_at;

