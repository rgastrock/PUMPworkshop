data<-read.csv('data/PUMPdata.csv', header = TRUE)

data$PreVocab<- as.numeric(data$PreVocab)
data$Student.ID<- as.character(data$Student.ID)
data$Group<- as.factor(data$Group)
data$Gender<- as.factor(data$Gender)

PVM<- mean(data$PreVocab, na.rm = TRUE)
hist(data$PreVocab)
