#Calling libraries
library('tidyverse')
library('skimr')

#Loading the data
df1<- read_csv("C:/Users/Sudanagunta Aakash/OneDrive/Documents/Cyclist_data/Data/Analysis/202401-divvy-tripdata.csv")
df2<- read_csv("C:/Users/Sudanagunta Aakash/OneDrive/Documents/Cyclist_data/Data/Analysis/202402-divvy-tripdata.csv")
df3<- read_csv("C:/Users/Sudanagunta Aakash/OneDrive/Documents/Cyclist_data/Data/Analysis/202403-divvy-tripdata.csv")
df4<- read_csv("C:/Users/Sudanagunta Aakash/OneDrive/Documents/Cyclist_data/Data/Analysis/202404-divvy-tripdata.csv")
df5<- read_csv("C:/Users/Sudanagunta Aakash/OneDrive/Documents/Cyclist_data/Data/Analysis/202405-divvy-tripdata.csv")
df6<- read_csv("C:/Users/Sudanagunta Aakash/OneDrive/Documents/Cyclist_data/Data/Analysis/202406-divvy-tripdata.csv")
df7<- read_csv("C:/Users/Sudanagunta Aakash/OneDrive/Documents/Cyclist_data/Data/Analysis/202407-divvy-tripdata.csv")

#Data_Info
colnames(df1)
colnames(df2)
colnames(df3)
colnames(df4)
colnames(df5)
colnames(df6)
colnames(df7)

#combining the 7 dataframes into 1
rides_data <- bind_rows(df1,df2,df3,df4,df5,df6,df7)

# Determine the Trip Duration, Hour and WeekDay
rides_data$date <- as.Date(rides_data$started_at) #The default format is yyyy-mm-dd
rides_data$month <- format(as.Date(rides_data$date), "%m")
rides_data$day <- format(as.Date(rides_data$date), "%d")
rides_data$day_of_week <- format(as.Date(rides_data$date), "%A")
rides_data$trip_length<- difftime(rides_data$ended_at,rides_data$started_at)

#Rides_data Info
is.factor(rides_data$trip_length)
rides_data$trip_length <- as.numeric(as.character(rides_data$trip_length))
is.numeric(rides_data$trip_length)

#Removing unnecessary columns
reduced_data<-rides_data
reduced_data <- reduced_data %>% select(-start_station_name, -end_station_name)
reduced_data<-reduced_data %>% select(-start_station_id,-end_station_id)
#reduced_data<-select(reduced_data,-ride_id)
reduced_data<-select(reduced_data,-day,-month)
reduced_data <- select(reduced_data,-start_lat,-start_lng,-end_lat,-end_lng)

#Descriptive Analysis
mean(reduced_data$trip_length)
median(reduced_data$trip_length)
max(reduced_data$trip_length)
min(reduced_data$trip_length)
range(reduced_data$trip_length)

#Converting Into minutes
reduced_data$trip_length<-reduced_data$trip_length/60
# Subset the dataframe to only include rows with trip_length > 0
reduced_data <- reduced_data[reduced_data$trip_length > 0, ]
summary(reduced_data$trip_length)

#Aggregation
aggregate(reduced_data$trip_length~reduced_data$member_casual,FUN = mean)
aggregate(reduced_data$trip_length~reduced_data$member_casual,FUN = median)
aggregate(reduced_data$trip_length~reduced_data$member_casual,FUN = min)
aggregate(reduced_data$trip_length~reduced_data$member_casual,FUN = max)

#Comparing with respect to type of membership & day_of_the_week
aggregate(reduced_data$trip_length~reduced_data$member_casual+reduced_data$day_of_week,FUN = mean)

data_analysis <- reduced_data %>% group_by(ride_id,member_casual) %>%  
  summarize(total_sum=round(sum(trip_length),digits = 2),total_rides=n()) %>% 
  arrange(-total_rides)

visual<-reduced_data %>%  mutate(weekday = wday(started_at, label = TRUE))
visual<- visual %>% group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n(),average_duration = mean(trip_length)) %>% 
  arrange(member_casual, weekday)
ggplot(visual,aes(x = weekday, y = number_of_rides, fill = member_casual)) + geom_col(position = "dodge") +
  labs(title = "Number of Rides by Weekday and Member Type",
       x = "Weekday",
       y = "Number of Rides") +
  theme_minimal() +scale_y_continuous(labels = scales::comma) 

ggplot(visual,aes(x = weekday, y = average_duration, fill = member_casual)) + geom_col(position = "dodge") +
  labs(title = "Average Duration by Weekday and Member Type",
       x = "Weekday",
       y = "Number of Rides") +
  theme_minimal() +scale_y_continuous(labels = scales::comma) 

count<-aggregate(reduced_data$trip_length~reduced_data$member_casual+reduced_data$day_of_week,FUN = mean)
write.csv(count, file = 'avg_ride_length.csv')
