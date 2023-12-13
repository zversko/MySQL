/*
	Задача № 1
	Подсчитать общее количество лайков, которые получили 
	пользователи младше 12 лет.
*/

SELECT
	COUNT(*) as 'Sum Likes' 
FROM media m 
JOIN likes l ON m.id = l.media_id 
JOIN profiles p ON m.user_id = p.user_id 
WHERE TIMESTAMPDIFF(YEAR, p.birthday, CURDATE()) < 12;

/*
	Задача № 2
	Определить кто больше поставил лайков (всего): мужчины или женщины.
*/
 
SELECT  
	gender AS 'Кто больше поставил лайков',
	COUNT(l.id) AS 'кол-во лайков'
FROM profiles p
JOIN users u ON u.id = p.user_id
JOIN likes l ON u.id = l.user_id
GROUP BY gender LIMIT 1;

/*
	Задача № 3
	Вывести всех пользователей, которые не отправляли сообщения.
*/

SELECT
	u.id,
	CONCAT(u.firstname, ' ', u.lastname) AS 'Пользователь'
FROM users u
LEFT JOIN messages m ON u.id = m.from_user_id  
WHERE m.from_user_id IS NULL;

/*
	Задача № 4
	Пусть задан некоторый пользователь. 
	Из всех друзей этого пользователя найдите человека, который больше всех написал ему сообщений.
*/

SELECT 
	CONCAT(u.firstname, ' ', u.lastname) AS 'Пользователь',
	m.to_user_id AS 'Какому пользователю',
	count(*) AS 'Количество сообщений'
FROM users u 
JOIN messages m ON m.from_user_id = u.id
JOIN friend_requests fr ON fr.target_user_id = m.to_user_id 
WHERE fr.status = 'approved'
GROUP BY u.id, m.to_user_id
ORDER BY count(*) DESC LIMIT 1;
