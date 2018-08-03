CREATE TABLE BestGrade AS
SELECT "CycleAppliedIn(UGonly)",UCASCoursecode,UUN,SubjectDescription,QualificationDescription,Min(GradeSingle),Count(*) AS COUNT
FROM RawData
WHERE substr(AcademicYearCode,1,4) - substr(YearObtained,1,4) <=3
GROUP BY "CycleAppliedIn(UGonly)",UCASCoursecode,UUN,SubjectDescription,QualificationDescription
