
#Change this to your working directory
setwd('/Users/demetri/Desktop/Demetri Analysis New Data/Data')

library(tidyverse) #install these if you don't have them
library(lubridate)


data = list.files()

for(file in data){
  #read in the data
  df <- read_csv(file) %>% 
    mutate(Date = ymd(Date))
  
  # Select out the data and turn it into a matrix
  x <- df %>% 
    select(NTweets) %>% 
    as.matrix()
  
  
  #This part is from qda_ews.  Check their git hub repo
  timeindex <- 1:dim(x)[1]
  
  
  bw <- round(bw.nrd0(timeindex))
  smoother <- ksmooth(timeindex,x,kernel = 'normal', bandwidth = bw, range.x = range(timeindex), x.points = timeindex)
  
  res <- x -smoother$y
  
  df$residuals = res
  
  df$smooth = smoother$y
  

  
  new_file = paste('../Smoothed Data/smoothed',file,sep = '_')
  write_csv(df,new_file)
}
