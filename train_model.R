#
# train_model.R
#
library(caret)
library(parallel)
library(doParallel)

cl <- makeCluster(detectCores())
registerDoParallel(cl)

raw_data<-read.csv("pml-training.csv")
columns=c(160,8:11,37:49,60:68,84:86,102)
features=raw_data[columns]
inTrain<-createDataPartition(y=features$classe, p=0.75, list=FALSE)
training<-features[inTrain,]
testing<-features[-inTrain,]

# Important. Save testing data.
save(testing, file="testing.rdata")

# Cross Validatation
train_control <- trainControl(method="cv", number=5)

model_rf<-train(classe ~ ., data=training, method="rf")
save(model_rf, file="model_rf.rdata")