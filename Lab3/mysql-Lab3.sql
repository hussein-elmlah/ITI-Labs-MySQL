-- 1. Create hello world function which take a name and return welcome message to user using his name.
delimiter $

create function hello_world(name varchar(50))
returns varchar(100)
begin
    return concat('Welcome, ', name, '!');
end;
$

delimiter ;

-- 2. Create multiply function which take two number and return the multiply of them.
delimiter $

create function multiply(a int, b int)
returns int
begin
    return a * b;
end;
$

delimiter ;

-- 3. Create function which takes student id and exam id and return score the student in exam.
delimiter $

create function get_student_exam_score(student_id int, exam_id int)
returns int
begin
    declare score int;
    select grade into score
    from stu_grades
    where stu_id = student_id and exam_id = exam_id;
    return score;
end;
$

delimiter ;

-- 4. Create function which take subject name and return the max grade for subject.
delimiter $

create function get_max_grade_for_subject(subject_name varchar(50))
returns int
begin
    declare max_grade int;
    select max_score into max_grade
    from _subject
    where sub_name = subject_name;
    return max_grade;
end;
$

delimiter ;

-- 5. Create Table called deleted_students which will hold the deleted students’ info (same columns as in student tables)
delimiter ;

create table deleted_students like student;

-- 6. Create trigger to save the deleted student from Student table to deleted_students.
delimiter $

create trigger save_deleted_student
after delete on student
for each row
begin
    insert into deleted_students values (old.id, old.stu_name, old.email, old.phone, old.level_id);
end;
$

delimiter ;

-- 7. Create trigger to save the newly added students to student table to backup_students
delimiter ;

create table backup_students like student;

delimiter $

create trigger save_new_student
after insert on student
for each row
begin
    insert into backup_students values (new.id, new.stu_name, new.email, new.phone, new.level_id);
end;
$

delimiter ;

