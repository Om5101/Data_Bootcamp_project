USE CRM_Data_Project;

-- cleaning and fixing engagement data table

SELECT 
    EngagementID,  -- engagement id number
    ContentID,  -- content id number
	CampaignID,  -- campaign id number
    ProductID,  -- product id number
    UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType,  -- fixing socialmedia to social media and making all capital letters
FROM 
    engagement_data  -- from engagement data table
WHERE 
    ContentType != 'Newsletter';  -- removing newsletter content because we dont need it
