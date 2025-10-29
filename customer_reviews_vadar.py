import pandas as pd
import mysql.connector
import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer

# downloading vader lexicon for sentiment analysis
nltk.download('vader_lexicon')
def fetch_data_from_mysql():
    # creating connection to mysql database
    conn = mysql.connector.connect(
        host="localhost",         
        user="root",              
        password="Shindemo.5101", 
        database="CRM_Data_Project"      
    )
    
    # query to get review data
    query = "SELECT ReviewID, CustomerID, ProductID, ReviewDate, Rating, ReviewText FROM customer_reviews"
    df = pd.read_sql(query, conn)
    conn.close()
    return df


customer_reviews_df = fetch_data_from_mysql()

# initializing sentiment analyzer
sia = SentimentIntensityAnalyzer()

# function to calculate sentiment score for each review
def calculate_sentiment(review):
    # getting sentiment scores (positive, negative, neutral, compound)
    sentiment = sia.polarity_scores(review)
    # returning compound score (-1 to 1, negative to positive)
    return sentiment['compound']

# categorizing sentiment based on score and rating
def categorize_sentiment(score, rating):
    if score > 0.05:  # positive sentiment score
        if rating >= 4:
            return 'Positive'  # high rating + positive sentiment
        elif rating == 3:
            return 'Mixed Positive'  # medium rating + positive sentiment
        else:
            return 'Mixed Negative'  # low rating but positive sentiment
    elif score < -0.05:  # negative sentiment score
        if rating <= 2:
            return 'Negative'  # low rating + negative sentiment
        elif rating == 3:
            return 'Mixed Negative'  # medium rating + negative sentiment
        else:
            return 'Mixed Positive'  # high rating but negative sentiment
    else:  # neutral sentiment score
        if rating >= 4:
            return 'Positive'  # high rating means positive
        elif rating <= 2:
            return 'Negative'  # low rating means negative
        else:
            return 'Neutral'  # medium rating + neutral sentiment

# putting sentiment score into buckets
def sentiment_bucket(score):
    if score >= 0.5:
        return '0.5 to 1.0'  # very positive
    elif 0.0 <= score < 0.5:
        return '0.0 to 0.49'  # slightly positive
    elif -0.5 <= score < 0.0:
        return '-0.49 to 0.0'  # slightly negative
    else:
        return '-1.0 to -0.5'  # very negative

# helper function to apply sentiment categorization to each row
def apply_sentiment_category(row):
    return categorize_sentiment(row['SentimentScore'], row['Rating'])

# applying sentiment analysis to all reviews
customer_reviews_df['SentimentScore'] = customer_reviews_df['ReviewText'].apply(calculate_sentiment)
customer_reviews_df['SentimentCategory'] = customer_reviews_df.apply(apply_sentiment_category, axis=1)
customer_reviews_df['SentimentBucket'] = customer_reviews_df['SentimentScore'].apply(sentiment_bucket)

# displaying first few rows to check results
print(customer_reviews_df.head())

# saving results to csv file
customer_reviews_df.to_csv('fact_customer_reviews_with_sentiment.csv', index=False)
