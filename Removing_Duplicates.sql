USE CRM_Data_Project;

-- finding duplicate records in customer journey

WITH DuplicateRecords AS (
    SELECT 
        JourneyID,  -- journey id number
        CustomerID,  -- customer id
        ProductID,  -- product id
        VisitDate,  -- date of visit
        Stage,  -- which stage customer is at
        Action,  -- what action customer took
        Duration,  -- how long it took
        -- numbering rows to find duplicates
        ROW_NUMBER() OVER (
            -- grouping by these columns to check duplicates
            PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action  
            -- ordering by journey id
            ORDER BY JourneyID  
        ) AS row_num  -- row number to identify duplicates
    FROM 
        customer_journey  -- from customer journey table
)

-- getting duplicates only
    
SELECT *
FROM DuplicateRecords
-- WHERE row_num > 1  -- uncomment this to see only duplicates
ORDER BY JourneyID

-- final query to clean the data and remove duplicates
    
SELECT 
    JourneyID,  -- journey id
    CustomerID,  -- customer id
    ProductID,  -- product id
    VisitDate,  -- visit date
    Stage,  -- stage name in uppercase
    Action,  -- action taken
    COALESCE(Duration, avg_duration) AS Duration  -- replacing null durations with average duration for that date
FROM 
    (
        -- subquery to process data
        SELECT 
            JourneyID,  -- journey id
            CustomerID,  -- customer id
            ProductID,  -- product id
            VisitDate,  -- visit date
            UPPER(Stage) AS Stage,  -- making stage uppercase for consistency
            Action,  -- action taken
            Duration,  -- duration value
            AVG(Duration) OVER (PARTITION BY VisitDate) AS avg_duration,  -- calculating average duration per date
            ROW_NUMBER() OVER (
                PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action  -- grouping to find duplicates
                ORDER BY JourneyID  -- ordering to keep first record
            ) AS row_num  -- row number to identify first occurrence
        FROM 
            customer_journey  -- from customer journey table
    ) AS subquery  -- naming subquery
WHERE 
    row_num = 1;  -- keeping only first occurrence of duplicates
