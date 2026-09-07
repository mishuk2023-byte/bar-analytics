with clean as (
    select distinct on (comment_text) *
    from reviews
    order by comment_text, comment_date
),
with_dup as (
    select extract(year from comment_date) as year,
           round(avg(rate), 2) as avg_with_dupes
    from reviews
    group by extract(year from comment_date)
),
no_dup as (
    select extract(year from comment_date) as year,
           round(avg(rate), 2) as avg_clean
    from clean
    group by extract(year from comment_date)
)
select w.year,
       w.avg_with_dupes,
       n.avg_clean,
       round(w.avg_with_dupes - n.avg_clean, 2) as diff
from with_dup w
join no_dup n on n.year = w.year
order by w.year

