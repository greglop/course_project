## 1- Merges the training and the test sets to create one data set

setwd("~/R/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")
features <- read.table("features.txt")
labels <- read.table("activity_labels.txt")
x_train <- read.table("train/x_train.txt")
y_train <- read.table("train/y_train.txt")
x_test <- read.table("test/x_test.txt")
y_test <- read.table("test/y_test.txt")
colnames(x_test) <- features$V2
x_test2 <- cbind(y_test$V1,x_test)
colnames(x_train) <- features$V2
x_train2 <- cbind(y_train$V1,x_train)
names(x_test2)[1] <- "labels"
names(x_train2)[1] <- "labels"
x_all <- rbind(x_test2,x_train2)

## 2- Extracts only the measurements on the mean and standard deviation for each measurement
## Solo voy a hacer un subset, buscar la forma de filtrar por contenido en el titulo

TF <- grepl("labels|mean|std", colnames(x_all))
meanstd_x_all <- subset(x_all, select=TF)

## 3- Uses descriptive activity names to name the activities in the data set
## usar for i= 1:6 , replace u otro


for (i in 1:length(meanstd_x_all[,1])){
  
  if (meanstd_x_all[i,1] == 1) {
    meanstd_x_all[i,1] = as.character(labels[1,2])
  }
  if (meanstd_x_all[i,1] == 2) {
    meanstd_x_all[i,1] = as.character(labels[2,2])
  }
  if (meanstd_x_all[i,1] == 3) {
    meanstd_x_all[i,1] = as.character(labels[3,2])
  }
  if (meanstd_x_all[i,1] == 4) {
    meanstd_x_all[i,1] = as.character(labels[4,2])
  }
  if (meanstd_x_all[i,1] == 5) {
    meanstd_x_all[i,1] = as.character(labels[5,2])
  }
  if (meanstd_x_all[i,1] == 6) {
    meanstd_x_all[i,1] = as.character(labels[6,2])
  }
  else {
    "ERROR IN ACTIVITY"
  }
}
  
## 4- Appropriately labels the data set with descriptive variable names
## usar grepl , replace los nombres mas descriptivos, de acuerdo a los nombre del file: features_info.txt
## mejor usar el codebook para describir el detalle, o un poco de ambos
##FALTA HACER ESTE PASO PARA CAMBIAR LA VARIALBLE DEL PROXIMO PUNTO
library(plyr)
library(dplyr)



## 5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
## subset por actividad y calcular average de cada columna y colocar en una tabla nueva con un loop

by_labels <- arrange(meanstd_x_all, labels)
tidy_data <- ddply(by_labels, .(labels), numcolwise(mean))
write.table(tidy_data, "~/R/tidy_data.txt", sep="\t", row.names = FALSE)
