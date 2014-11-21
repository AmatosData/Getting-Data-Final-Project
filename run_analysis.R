# Script to create a tidy data of information obtained from wearable devices
# Prepared by Amilcar Matos Moreno
# Master Script 


################################ Test Files  ###############################################################

setwd("/Users/Amilcar/Desktop/DataScience/datasciencecoursera/Getting and Cleaning data/UCI HAR Dataset")

setwd("./test")
path<- dir()

# To read the X test file.
varsubject<- read.table(path[3], header=FALSE)
SSdata<-data.frame(varsubject)

#Assign variable names to the columns of the New Data Frame
feapath<- "/Users/Amilcar/Desktop/DataScience/datasciencecoursera/Getting and Cleaning data/UCI HAR Dataset/features.txt"
features<- read.table(feapath, header=FALSE)
onlynames<-features$V2

colnames(SSdata)<- onlynames


# Add the subject var and Y test data
for (i in c(2,4)) {
   print(path[i])
    newvar <-read.table(path[i],header=FALSE,sep="")
  SSdata<- data.frame(SSdata, newvar)
  colnames(SSdata)[length(SSdata)]<-path[i]
}




##########################################################################

setwd("/Users/Amilcar/Desktop/DataScience/datasciencecoursera/Getting and Cleaning data/UCI HAR Dataset/test/Inertial Signals")
path2<- dir()


for (i in 1:length(path2)) {
  print(path2[i])
  newvar <-read.table(path2[i],header=FALSE)
  col<- length(SSdata)
  SSdata<- data.frame(SSdata, newvar)
  

      for (j in 1:length(newvar)){
        col2<- col + j
        subpath<-path2[i]
        colnames(SSdata)[col2]<- sprintf("%s%s",subpath,j)
        
      }
  
}

############################# Train Files  #########################################################


setwd("/Users/Amilcar/Desktop/DataScience/datasciencecoursera/Getting and Cleaning data/UCI HAR Dataset")

##########################################################
setwd("./train")
path<- dir()

# To read the X train file.
varsubject.train<- read.table(path[3], header=FALSE)
SSdata.train<-data.frame(varsubject.train)

#Assign variable names to the columns of the New Data Frame
feapath<- "/Users/Amilcar/Desktop/DataScience/datasciencecoursera/Getting and Cleaning data/UCI HAR Dataset/features.txt"
features<- read.table(feapath, header=FALSE)
onlynames<-features$V2

colnames(SSdata.train)<- onlynames


# Add the subject var and Y test data
for (i in c(2,4)) {
  print(path[i])
  newvar <-read.table(path[i],header=FALSE,sep="")
  SSdata.train<- data.frame(SSdata.train, newvar)
  colnames(SSdata.train)[length(SSdata.train)]<-path[i]
}




###########################################################

setwd("/Users/Amilcar/Desktop/DataScience/datasciencecoursera/Getting and Cleaning data/UCI HAR Dataset/train/Inertial Signals")
path2<- dir()


for (i in 1:length(path2)) {
  print(path2[i])
  newvar <-read.table(path2[i],header=FALSE)
  col<- length(SSdata.train)
  SSdata.train<- data.frame(SSdata.train, newvar)
  
  
  for (j in 1:length(newvar)){
    col2<- col + j
    subpath<-path2[i]
    colnames(SSdata.train)[col2]<- sprintf("%s%s",subpath,j)
    
  }
  
}

################################### Step#1 Merge both Datasets ##############################################

colnames(SSdata.train)[562:1715]<-colnames(SSdata)[562:1715]   #Assign same variable names to both datasets
SSdata.complete<- rbind(SSdata, SSdata.train)    

################################### Step#2  Extract only the mean ans Sd of each measurements ###############

onlynames<- colnames(SSdata.complete)
subsetmean<- grep("mean", onlynames)
subsetSd<- grep("std",onlynames)


####### Dataset with the subject, Activity variable and Mean and Std for each measurement
SSdata.comp.sample<- data.frame(SSdata.complete$subject_test.txt, SSdata.complete$y_test.txt, SSdata.complete[subsetmean],SSdata.complete[subsetSd])


################################ Step#3 Assign label to the Activity variable  ###########################
SSdata.comp.sample$SSdata.complete.y_test.txt<- factor(SSdata.comp.sample$SSdata.complete.y_test.txt, levels=c(1,2,3,4,5,6), labels=c("Walking","Walking Upstairs","Walking Downstairs","Sitting","Standing","Laying"))


############################### Step#4 Label the datset with appropriate variable names ##################

colnames(SSdata.comp.sample)[1]<- "Subject.Number"
colnames(SSdata.comp.sample)[2]<- "Activity"

############################## Step#5 ############################################################

 sapply(split(SSdata.comp.sample, SSdata.comp.sample),mean)

SSdata.comp.sample<- SSdata.comp.sample[order(SSdata.comp.sample$Activity,SSdata.comp.sample$Subject.Number),]


##### Falta sacar las medias de los subgrupos



for (j in 1:30) {
                  subject<- subset(SSdata.comp.sample,SSdata.comp.sample$Subject.Number==j,)
                  scalar<- tapply(subject[,3],subject$Activity, FUN=mean)
                  subject.number<-c(j,j,j,j,j,j)
                  tidy.SSdata<-data.frame(subject.number,levels(SSdata.comp.sample$Activity),scalar)
                  
                  for (i in 4:81){
                                  scalar<- tapply(subject[,i],subject$Activity, FUN=mean)
                                  tidy.SSdata<- data.frame(tidy.SSdata,scalar)
                                  assign(paste0("subject",j),tidy.SSdata)
                                  
                                  
                  }
  
}
# To merge the new data with the means and of each activity per subject
tidy.data.comp<-rbind(subject1,subject2,subject3,subject4,subject5,subject6,subject7,subject8,subject9,subject10,subject11,subject12,subject13,subject14,subject15,subject16,subject17,subject18,subject19,subject20,subject21,subject22,subject23,subject24,subject25,subject26,subject27,subject28,subject29,subject30)

# extract the same variable names from SSdata original data
names(tidy.data.comp)<-names(SSdata.comp.sample)

# Convert the tidy dataset created into a text file to be share or store as backup
write.table(tidy.data.comp,file="tidy_data",row.names=FALSE)







