-- Общая таблица
with reviews2 as (
select id, extract(year from comment_date)::int as year, comment_text, gender, rate, category
from reviews
)
-- 4) Анализ комбинированных показателей
-- 1. Изменение выручки и рейтинга по годам
-- select ptab.year, ptab.revenue, ptab.revenue - lag(ptab.revenue) over (order by ptab.year) as diff_rev, 
-- Round(avg(rev2.rate),2), Round(avg(rev2.rate),2)-lag(Round(avg(rev2.rate),2)) over (order by ptab.year) as diff_rate
-- from pl as ptab left join reviews2 as rev2 on ptab.year=rev2.year
-- group by ptab.year, ptab.revenue
-- order by ptab.year 

-- 2. Поиск причинно-следственных связей
-- 2.1 На что жаловались в худший год (по прибыли)
-- select rev2.year, rev2.category, Sum(case when rev2.rate in(1,2) then 1 else 0 end) as bad_rate
-- from pl as ptab left join reviews2 as rev2 on ptab.year=rev2.year
-- where ptab.net_profit = (select min(net_profit)
-- 								from pl)
-- group by rev2.year, rev2.category
-- having Sum(case when rev2.rate in(1,2) then 1 else 0 end)<>0
-- order by Sum(case when rev2.rate in(1,2) then 1 else 0 end) desc

-- 2.1 Что хвалили в лудший год (по прибыли)
-- select rev2.year, rev2.category, Sum(case when rev2.rate in(4,5) then 1 else 0 end) as good_rate
-- from pl as ptab left join reviews2 as rev2 on ptab.year=rev2.year
-- where ptab.net_profit = (select max(net_profit)
-- 								from pl)
-- group by rev2.year, rev2.category
-- having Sum(case when rev2.rate in(4,5) then 1 else 0 end)<>0 
-- order by Sum(case when rev2.rate in(4,5) then 1 else 0 end) desc
