CREATE TABLE FirstSitting AS
SELECT "CycleAppliedIn(UGonly)",UCASCoursecode,UUN,SubjectDescription,QualificationDescription,Min(YearObtained), GradeSingle,Count(*) AS COUNT
FROM RawData
GROUP BY "CycleAppliedIn(UGonly)",UCASCoursecode,UUN,SubjectDescription,QualificationDescription