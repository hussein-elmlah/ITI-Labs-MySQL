create database mysql_labs;

use mysql_labs;

create table _level (
	id int auto_increment primary key,
	lev_name varchar(50) not null
);

create table student (
	id int auto_increment primary key,
    stu_name varchar(50) not null,
    email varchar(50) unique,
    phone varchar(20),
    level_id int,
    foreign key (level_id) references _level(id) on delete cascade
);

create table _subject (
	id int auto_increment primary key,
	sub_name  varchar(50) not null,
    sub_desc varchar(255),
    max_score int
);

create table exam (
	id int auto_increment primary key,
	exam_date datetime not null
);

create table stu_subjects (
	stu_id int,
	sub_id int,
    foreign key (stu_id) references student(id) on delete cascade,
    foreign key (sub_id) references _subject(id) on delete cascade
);

create table stu_grades (
	stu_id int,
	sub_id int,
    exam_id int,
    grade int,
    foreign key (stu_id) references student(id) on delete cascade,
    foreign key (sub_id) references _subject(id) on delete cascade,
    foreign key (exam_id) references exam(id) on delete cascade
);

-- ============== created the database schema ==============

insert into _level (lev_name) values
('one'),
('two'),
('three');

insert into student (stu_name, email, phone, level_id) values
('ahmed', 'ahmed@example.com', '123456789', 1),
('ali', 'ali@example.com', '987654321', 2),
('taha', 'amira@example.com', '456789123', 3);

insert into _subject (sub_name, sub_desc, max_score) values
('oop', 'oop description', 100),
('db', 'db description', 100),
('english', 'english description', 100);

insert into exam (exam_date) values
('2024-01-15 08:00:00'),
('2024-02-10 08:00:00'),
('2024-03-05 08:00:00');

insert into stu_subjects (stu_id, sub_id) values
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(3, 3);

insert into stu_grades (stu_id, sub_id, exam_id, grade) values
(1, 1, 1, 40),
(1, 2, 1, 70),
(2, 2, 1, 80),
(3, 1, 1, 90),
(3, 3, 1, 101);

alter table student
add column gender enum('male', 'female');

alter table student
add column dob datetime;

-- Add foreign key constraints with delete cascade option
alter table student
add constraint fk_student_stu_id foreign key (level_id) references _level(id) on delete cascade;

alter table stu_subjects
add constraint fk_stu_subjects_stu_id foreign key (stu_id) references student(id) on delete cascade;

alter table stu_subjects
add constraint fk_stu_subjects_sub_id foreign key (sub_id) references _subject(id) on delete cascade;

alter table stu_grades
add constraint fk_stu_grades_stu_id foreign key (stu_id) references student(id) on delete cascade;

alter table stu_grades
add constraint fk_stu_grades_sub_id foreign key (sub_id) references _subject(id) on delete cascade;

alter table stu_grades
add constraint fk_stu_grades_exam_id foreign key (exam_id) references exam(id) on delete cascade;

-- Display students’ names that begin with A
select stu_name
from student
where stu_name like 'a%';

insert into student (stu_name, email, phone, level_id, gender, dob) values
('yunus', 'yunus@example.com', '123456782', 2 , 'male', '1991-10-02'),
('yusuf', 'yusuf@example.com', '987654323', 2, 'male', '1990-09-01');
-- Display male students who are born before 1991-10-01
select stu_name
from student
where gender = 'male' and dob < '1991-10-01';
select * from student;

-- Delete students whose score is lower than 50 in a particular subject exam
delete s
from student s
inner join (
    select s.id
    from student s join stu_grades g on s.id = g.stu_id
    where g.sub_id = (select id from _subject where sub_name = 'oop') 
    and g.grade < 50
) as subquery on s.id = subquery.id;

-- Delete students whose score is lower than 50 in a particular subject exam
DELETE FROM student
WHERE id IN (
    SELECT s.id
    FROM student s
    JOIN stu_grades g ON s.id = g.stu_id
    WHERE g.grade < 50
    AND g.sub_id = (SELECT id FROM _subject WHERE sub_name = 'oop')
);




-- Write a query to get the student with the 3rd highest score in the database
select s.stu_name
from student s
join stu_grades g on s.id = g.stu_id
order by g.grade desc
limit 1 offset 2;
