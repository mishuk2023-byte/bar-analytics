-- 1) Разведка данных

-- 1. Количество дубликатов
-- select count(comment_text)-Count(distinct comment_text) as dublicate
-- from reviews

-- 2. Процентное соотношение по оценкам
-- select rate, round((count(rate)*100.0)/ (select count(rate) from reviews),2) as procent
-- from reviews
-- group by rate

-- 3. Количество отзывов по категориям (уникальных)
-- select category, count(distinct comment_text) as dis_comm
-- from reviews
-- group by category

-- 4. Выбранный период (временной разброс)
-- select min(comment_date) as min_date, max(comment_date) as max_date
-- from reviews