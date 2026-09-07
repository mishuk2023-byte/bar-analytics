create table reviews (
ID serial primary key,
Comment_date date,
Comment_text text,
Gender varchar(20),
Rate int,
Category varchar(50)
)