/* Hi Matt,
your SQL includes GradeSingle in the select statement but not in the group by statement, which is what causes the error...
the basic rule is that the group by statement has to include everything from the select statement that is not a measure, 
where measures are things like count(), min(), sum() etc*/
CREATE TABLE FirstSitting AS
SELECT "CycleAppliedIn(UGonly)",UCASCoursecode,UUN,SubjectDescription,QualificationDescription,Min(YearObtained), GradeSingle,Count(*) AS COUNT
FROM RawData
GROUP BY "CycleAppliedIn(UGonly)",UCASCoursecode,UUN,SubjectDescription,QualificationDescription
/* To fix this you can either... 
add ,GradeSingle to the end of the Group By statement to return a list of the earliest year in which each different grade 
was obtained for any particular subject/qualification:*/
CREATE TABLE FirstSitting AS
SELECT "CycleAppliedIn(UGonly)",UCASCoursecode,UUN,SubjectDescription,QualificationDescription,Min(YearObtained), GradeSingle,Count(*) AS COUNT
FROM RawData
GROUP BY "CycleAppliedIn(UGonly)",UCASCoursecode,UUN,SubjectDescription,QualificationDescription, GradeSingle
/* or remove , GradeSingle from the select statement to return a list of the earliest year in which each subject/qualifcation was sat, 
regardless of whether that is the highest grade obtained: */
CREATE TABLE FirstSitting AS
SELECT "CycleAppliedIn(UGonly)",UCASCoursecode,UUN,SubjectDescription,QualificationDescription,Min(YearObtained),Count(*) AS COUNT
FROM RawData
GROUP BY "CycleAppliedIn(UGonly)",UCASCoursecode,UUN,SubjectDescription,QualificationDescription
/* if you want to return the grade from the first sit, that could be done various ways - I'd use a ranking like this (but my ranking 
uses standard sql - think MSSQL works the same eg http://beginner-sql-tutorial.com/mssql-rank-function.htm)*/
CREATE TABLE FirstSitting AS
SELECT "CycleAppliedIn(UGonly)",UCASCoursecode,UUN,SubjectDescription,QualificationDescription,YearObtained,GradeSingle,Rank() over(partition by "CycleAppliedIn(UGonly)",UCASCoursecode,UUN,SubjectDescription,QualificationDescription order by YearObtained) as RANKING,Count(*) AS COUNT
FROM RawData
GROUP BY "CycleAppliedIn(UGonly)",UCASCoursecode,UUN,SubjectDescription,QualificationDescription, GradeSingle
Having RANKING = 1
