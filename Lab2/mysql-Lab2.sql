-- 1. display the number of males and females.
select gender, count(*) as count
from student
group by gender;

-- 2. display the repeated first names and their counts if higher than 2.
select stu_name, count(*) as name_count
from student
group by stu_name
having count(*) > 2;

-- 3. create a view for student names with their subject's names which will study.
create view student_subjects_view as
select s.stu_name, sub.sub_name
from student s
join stu_subjects ss on s.id = ss.stu_id
join _subject sub on ss.sub_id = sub.id;

-- 4. create a view for students’ names, their score and subject name.
create view student_scores_view as
select s.stu_name, sub.sub_name, g.grade
from student s
join stu_grades g on s.id = g.stu_id
join _subject sub on g.sub_id = sub.id;

-- 5. create a view for all subjects with their max score.
create view subject_max_score_view as
select sub_name, max_score
from _subject;

-- 6. display the date of exam as the following: day 'month name' year.
select date_format(exam_date, '%d %b %Y') as formatted_exam_date
from exam;

-- 7. display the name of students with their rounded score in each exam.
select s.stu_name, round(g.grade) as rounded_score
from student s
join stu_grades g on s.id = g.stu_id;

-- 8. display the name of students with the year of birthdate.
select stu_name, year(dob) as birth_year
from student;

