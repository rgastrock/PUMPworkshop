 #What are we looking at?
 #what is the console,script, environment & plot window. 
 # What is '>' mean?
 
 
 # R is a super powerful calculator. Using these operators, you can do almost anything you would want:
 
 2 + 2
 2 - 2
 2/2
 2*2
 
 #But what if you want to save the answer?  You need to make a ?variable?, there is a special way to do that in R
 
 X <- 2+2      # X is getting '2 + 2' 
 # now if you look in the environment, you will see it listed there
 # Maybe you have more than 1 number you want to store in a variable
 
 X <- c(1,2,3,4)  # The 'c' combines all the numbers in the bracket into the variable X
 #notice that because we used the same letter for our variable we?ve actually overwritten the previous value. 
 X <- 2+2
 Y <- c(1,2,3,4)
 #When you use the 'c' command you are creating a special variable, that is called a vector as it contains multiple elements of the same type.  
 Z <- c(1:4, "A","B")
 #You may notice that R has made all of the values in this vector a character.  This is because all the elements of a vector must be the same, so if you want to keep the elements in the format they came from you need to do something a little different. 
 Z <- list(1:4,"A","B")
 Z <- list(numbers = c(1:4), letters = c( 'a','b','c','d'))
 #Here we added names to the vectors so that we can pick them out of our list easier
 Num <- Z$numbers
 Letters <- Z$letters
 #using the $ we are able to pull specific named vectors/columns from our list. 
 Data <- data.frame(Num, Letters)
 #Here we put our named list into a data.frame.  This is Rs favourite data format and is the easiest to use going forward. 
 
 #Now that you know how to make a data.frame from data in R.  Most of the time we actually load data in from an excel spreadsheet or something similar.  You will want to make sure your files end in a .csv (comma separated values)  this is the easiest and cleanest format to read into R. 
 
 #directories are a big deal in R.  You will want to keep yourself organized and follow a common format. 
 
 help("read.csv")
 data<-read.csv("data/PUMPdata.csv", header = TRUE)
 # we are assigning the data to the variable 'data'.
 # we are finding the spreadsheet in the data folder and its called PUMPdata.csv
 # we know that this file has column names, and we want to keep those as the names of the columns so we include the argument ?header = TRUE?
 
 
 #its always good to look at your data and make sure it looks right
 head(data)
 #Shows us the top 10 rows of data
 str(data)
 #shows us each variable and its 'type'
 #If you notice a variable is not the type it should be (its numeric but should be a factor), you can manually change that. 
 
 data$PreVocab<- as.numeric(data$PreVocab)
 data$Student.ID<- as.character(data$Student.ID)
 data$Group<- as.factor(data$Group)
 data$Gender<- as.factor(data$Gender)
 str(data)
 
 
 
 ##Now to actually look at the data and get some descriptive statistics
 
 #Here we are asking for the mean of the prevocab variable, and we are saying if there are any missing values remove them. 
 PVM<- mean(data$PreVocab, na.rm = TRUE)
 
 #Maybe you want the means of a certain gender only
 PreVMf<- mean(data$PreVocab[data$Gender == 1], na.rm = TRUE)
 PreVMf # we need to call this again to actually see the value since we assigned it to a mean. 
 print(PreVMm<- mean(data$PreVocab[data$Gender == 2], na.rm = TRUE))
 #Here we just wrapped the function 'print' around our mean function, to get R to show us the answer, while also storing in the variable. 
 
 #But a mean is not good enough! We want to see the data. R is great at plotting and you can make lots of nice graphs really easy. 
 
 hist(data$PreVocab[data$Gender == 2], col = "Blue", xlim = c(0,20), ylim = c(0,10), main = "PreVocab Scores", xlab = "Score")
 #Here we plotted the prevocab scores for the males. 
 #We are telling the histogram function to use blue for the bars, and set the x and y lim to 0,20 and 0,10 respectively.  While adding a title ?PreVocab Scores? and a label to the X-axis ?Scores?
 
 hist(data$PreVocab[data$Gender == 1], add = TRUE, col = "Green")
 #Now we added the prevocab scores for the females in green.  The 'add = TRUE' argument ensures this histogram is added to the previous plot. 
 
 
 #Its nice to see all the data, but sometimes seeing the group averages can be very helpful. Previously we learned how to get the means of specific groups, so lets do that again. 
 PostVMf<- mean(data$PostVocab[data$Gender == 1], na.rm = TRUE)
 PostVMm<- mean(data$PostVocab[data$Gender == 2], na.rm = TRUE)
 
 plot(x = c(1,1,2,2), y = c(PreVMf,PreVMm, PostVMf,PostVMm), type = "p", col = c("Green","Blue","Green","Blue" ), main = "Vocab Scores", xlab = "Time of Test", ylab = "Average Score",ylim= c(10,20), xlim = c(.5,2.5), axes = FALSE)
 #Here we plot each of the four averages we just calculated and we color coded them based on their gender.  
 #The 'axes = FALSE' argument removes the X & Y axis so we can make them ourselves. 
 axis(2, at = c(10, 12, 14, 16, 18,20), cex.axis = 1.25,
      las = 2)
 axis(1, at = c(1, 2), labels = c("Pre", "Post"), cex.axis = 1.25)
 #Then we added some nice axes labels. 
 
 
 #we added a legend to make it easier to tell the colors apart
 legend(
   .5,
   18,
   legend = c("females", "males"),
   col = c("Green","Blue"),
   lty = c(1),
   lwd = c(2),
   bty = 'n',
   cex = 1.25
 )
 
 
 
 #We could even add lines to connect the pre and post vocab scores for each gender
 lines(x = c(1,2), y = c(PreVMf,PostVMf), col = "Green")
 lines(x = c(1,2), y = c(PreVMm,PostVMm), col = "Blue")
 
 
 #if you want to save the plot you have a few options.
 #the easiest, is to save it from the plot window within R. But sometimes you make a lot of plots and want to save them as you go, so you can use this simple code.
 #Note, however, that this needs to go before you make the plot
 png(filename = "fig/Vocab Scores.png", width = 500, height = 500, units = "px", bg = 'transparent')
 plot(x = c(1,1,2,2), y = c(PreVMf,PreVMm, PostVMf,PostVMm), type = "p", col = c("Green","Blue","Green","Blue" ), main = "Vocab Scores", xlab = "Time of Test", ylab = "Average Score",ylim= c(10,20), xlim = c(.5,2.5), axes = FALSE)
 #Here we plot each of the four averages we just calculated and we color coded them based on their gender.  
 #The 'axes = FALSE' argument removes the X & Y axis so we can make them ourselves. 
 axis(2, at = c(10, 12, 14, 16, 18,20), cex.axis = 1.25,
      las = 2)
 axis(1, at = c(1, 2), labels = c("Pre", "Post"), cex.axis = 1.25)
 #Then we added some nice axes labels. 
 
 
 #we added a legend to make it easier to tell the colors apart
 legend(
    .5,
    18,
    legend = c("females", "males"),
    col = c("Green","Blue"),
    lty = c(1),
    lwd = c(2),
    bty = 'n',
    cex = 1.25
 )
 
 
 
 #We could even add lines to connect the pre and post vocab scores for each gender
 lines(x = c(1,2), y = c(PreVMf,PostVMf), col = "Green")
 lines(x = c(1,2), y = c(PreVMm,PostVMm), col = "Blue")
 #the above line needs to be run before any plotting code is run.  This sets up the empty file for R to write the plot to. 
 dev.off()
 #Then you run this code to tell R that you are done plotting and it can close the file. 
 
 #Maybe you want to make a new data.frame of only the Pre & Post vocab scores and none of the other test scores.  
 
 datanew<-data[,c(-5,-7)]
 #Here we are telling R to give us all the columns from the dataframe 'data' except for column 5 and 7. 
 
 #Now we can save this new data.frame to a csv file for future use. 
 write.csv(datanew, file = "data/Vocab Scores.csv", quote = FALSE, row.names = FALSE)
 #The quote = FALSE and row.names = FALSE arguments are for formatting the data.frame so it looks clean when it?s exported to a csv.
 #by adding the data/ before the filename, we are able to put that new csv file right into our data folder. 
 