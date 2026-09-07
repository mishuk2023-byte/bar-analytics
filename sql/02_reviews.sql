-- 2) Анализ отзывов

-- 1. Общий профиль лояльности
-- 1.1 средний рейтинг по всей базе
-- select Round(avg(rate),2) as avg_rate
-- from reviews

-- 1.2 Доля негативных отзывов против положиельных (вариант с подзапросом)
-- Select Round((select count(rate)
-- 		from reviews
-- 		where rate in(1,2))*100.0 / count(rate),2) as negative, Round((select count(rate)
-- 															from reviews
-- 															where rate=3)*100.0/count(rate),2) as neutral, Round((select count(rate)
-- 																										from reviews
-- 																										where rate in (4,5))*100.0/count(rate),2) as positive

-- from reviews

-- вариант с case
-- select Round(sum(case when rate in (1,2) then 1 else 0 end)*100.0/count(rate),2), 
-- 		Round(sum(case when rate=3 then 1 else 0 end)*100.0/count(rate),2),
-- 		Round(sum(case when rate in (4,5) then 1 else 0 end)*100.0/count(rate),2)
-- from reviews


-- 1.3 Медианный рейнтинг по всей базе
-- select Round(avg(rate),2) as avg_rate, percentile_disc(0.5) within group(order by rate) as median
-- from reviews

-- 2.Сегментация по темам
-- 2.1 Самый низкий, высокий рейтинг по категориям (по среднему)
-- Select category, Round(avg(rate),2) as avg_rate
-- from reviews
-- group by category
-- order by Round(avg(rate),2) desc
-- limit 1

-- 2.2 Самая негативная категория
-- select category, count(rate),sum(case when rate in (1,2) then 1 else 0 end), 
-- 		round(sum(case when rate in (1, 2) then 1 else 0 end) * 100.0 / count(rate), 2)
-- from reviews
-- group by category
-- order by sum(case when rate in (1,2) then 1 else 0 end) desc
-- limit 2

-- 2.3 Топ три худших категорий
-- select category, count(rate) as count_rate
-- from reviews
-- where rate=1
-- group by category
-- order by count(rate) desc
-- limit 3

-- 2.4 Топ 3 лучших категорий
-- select category, count(rate) as count_rate
-- from reviews
-- where rate=5
-- group by category
-- order by count(rate) desc
-- limit 3

-- 3. Сегментация по полу
-- 3.1 средний рейтинг мужчин/женщин
-- select gender, Round(avg(rate),2) as avg_rate, percentile_disc(0.5) within group(order by rate) as median
-- from reviews
-- where gender <> 'Не известно'
-- group by gender

-- 3.2 Доля негатива по полу
-- select gender, count(rate) as rate_count, sum(case when rate in(1,2) then 1 else 0 end) as sum_negative, 
-- 				Round(sum(case when rate in(1,2) then 1 else 0 end)*100.0 / count(rate),2) as negative_part
-- from reviews
-- where gender <> 'Не известно'
-- group by gender

-- 3.3 Жалобы по полу
-- select category, sum(case when rate in(1,2) then 1 else 0 end) as sum_negative
-- from reviews
-- where gender='м'
-- group by category
-- order by  sum(case when rate in(1,2) then 1 else 0 end) desc
-- limit 3

-- select category, count(gender) as gender_count
-- from reviews
-- where gender <> 'Не известно' and gender='ж'
-- group by category
-- order by count(gender) desc
-- limit 3

-- 4. Временная динамика
-- 4.1 Средний рейтинг по годам
-- select Extract(year from comment_date), Round(avg(rate),2) as avg_rate, 
-- 					percentile_disc(0.5) within group(order by rate) as median
-- from reviews
-- group by Extract(year from comment_date)

-- 4.2 Активность аудитории по годам
-- select Extract(year from comment_date), count(rate) as rate_count
-- from reviews
-- group by Extract(year from comment_date)
-- order by  Extract(year from comment_date)

-- 4.3 Изменчивость структуры жалоб со временем
-- select category, Extract(year from comment_date) as year
-- from reviews
-- where rate in(1,2)
-- group by category, Extract(year from comment_date)
-- order by  Extract(year from comment_date)

-- 4.4 Наличие сезонности
-- select Extract(month from comment_date) as month, Round(avg(rate),2),
-- 					sum(case when rate in(1,2) then 1 else 0 end) as sum_negative
-- from reviews
-- group by  Extract(month from comment_date)
-- Order by Extract(month from comment_date)
