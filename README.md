# cyclist_data_analysis
## Google Data Analytics

##### Project Intro:
Cyclistic is a successful bike-share offering program which has grown to a fleet of 5824 bicycles which can be geotracked and locked into network of 692 stations across chicago in 2016.
    Based on the marketing strategy, customers approached to this program in three plans: Single-ride passes or full-day passes, and annual memberships and are known as casual riders and Cyclistic Members respectively.
    Finance analysts concluded that annual membership would add more profit margin towards the program than the casual membership which made Moreno, the Director of Marketing and Manager determined to look for patterns so that memberships could be converted to annual.

Six steps in the analysis Phase:
ASK --> PREPARE --> PROCESS --> Analyze --> SHARE --> ASK:
## Problem statement: How do annual and casual riders use Cyclistic bikes differently
##### Ask Phase: 
From the question, Identifying how riders utilizing the program and plans would be key approach. I read the two categories differently in regards to the type of day vs no of rides on that day and type of day vs average duration of ride. These patterns identified helps us understand customers choices and find a productive way in benefit of organization and customers.
##### Prepare Phase: 
With the available historic data, I chose last 7 months of data to understand how the customers choice are and bring necessary insights. This data came from a reliable, original, current and cited data satifying the ROCCC rule of data integrity. Download the data of last 7 months and stored them for analysis.
##### Process Phase: 
In this phase, I chose RStudio as a tool for the analysis.
1. changing the time stamp to default yyyy-mm-dd format
2. Extracting month, day of week from date
3. Finding the difference of start and end date to determine trip duration
4. Conerting into proper numeric for analysis and divide by 60 to reduce the value ranges.
5. Removing unnecessary columns like riders_id, start and end stations along with their IDs [from 19 to 9 columns]
6. Check for duplicate values and remove them.
##### Analyze Phase:
I thought of chose to decide tows with empty fields but when I looked at the data I found most of that data are related to electric bikes. Removing this data could potentially creat biasing. As we are looking for the patterns in customers, empty rows in station could didn't create any issue. Insstead of removing the rows, I decided to remove the columns.
1. Determined mean, max,median, min and range to determine the how data is varying.
2. Removed data with trip duration values <= 0, It would have been better to consider trip duration values > 1 but I thought it might create some biasing and so didn't choose to go for it.
##### Share Phase:
Made plots between weekday vs No of rides and weekday vs average duration in histogram plot and observed the trends between casual and annual members.
##### Act phase:
From the graph, dervived insights are:
1. Average Duration time of casual members is almost double than the annual members. Considering this plots, we could conclude casual members utilize 
the bikes more longer than the members.
2. While the no of rides for a member is significantly higher than casual but both the catergories where going hand in hand in weekends.

These insights helps in providing how differently the categories respond differently with respect to the duration and rides count.

      





