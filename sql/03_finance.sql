-- 3) Анализ ОПИУ
-- 1.Базовая динамика
-- 1.1 Изменение выручки по годам
-- select year, revenue, revenue-lag(revenue) over (order by year) as diff,
-- 						Round(((revenue-lag(revenue) over (order by year)) / lag(revenue) over (order by year))*100,2) as diff_procent
-- from pl
-- order by year 

-- 1.2 Изменение чистой прибыли по годам
-- select year, net_profit,net_profit-lag(net_profit) over (order by year) as diff,
-- 						Round(((net_profit-lag(net_profit) over (order by year)) / lag(net_profit) over (order by year))*100,2) as diff_procent
-- from pl
-- order by year 

-- 1.3 Годы где выручка выросла, а прибыль упала
-- with diffs as (
-- 	select year, revenue-lag(revenue) over (order by year) as diff_rev,
-- 			net_profit-lag(net_profit) over (order by year) as diff_prof
-- 	from pl 
-- )
-- select year, diff_rev, diff_prof
-- from diffs
-- where diff_rev>0 and diff_prof<0
-- order by year

-- 2. Рентабельность
-- 2.1 Рентабельность продаж
-- select year, Round(((revenue-operation_expense)/revenue)*100,2) as profitabiliy
-- from pl
-- order by year

-- 2.2 Рентабельность прибыли (ЧП)
-- select year, Round(net_profit/revenue *100,2) as profitability_prof
-- from pl
-- order by year 

-- 3. Структура расходов
-- 3.1 Доля операционных расходов в выручке по годам 
-- select year, Round(operation_expense/revenue*100,2) part_operation_expense
-- from pl
-- order by year

-- 3.2 Соотношение прочих доходов и расходов
-- select year, Round((other_income/other_expenses)*100,2) as income_expenses
-- from pl


