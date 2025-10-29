USE CRM_Data_Project;

-- cleaning and fixing engagement data table

SELECT 
    EngagementID,  -- engagement id number
    ContentID,  -- content id number
	CampaignID,  -- campaign id number
    ProductID,  -- product id number
    UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType,  -- fixing socialmedia to social media and making all capital letters
    LEFT(ViewsClicksCombined, LOCATE('-', ViewsClicksCombined) - 1) AS Views,  -- getting views from combined column (before the dash)
    RIGHT(ViewsClicksCombined, LENGTH(ViewsClicksCombined) - LOCATE('-', ViewsClicksCombined)) AS Clicks,  -- getting clicks from combined column (after the dash)
    Likes,  -- number of likes
    -- formatting date to dd.mm.yyyy format
    DATE_FORMAT(EngagementDate, '%d.%m.%Y') AS EngagementDate  -- converting date to dd.mm.yyyy format
FROM 
    engagement_data  -- from engagement data table
WHERE 
    ContentType != 'Newsletter';  -- removing newsletter content because we dont need it