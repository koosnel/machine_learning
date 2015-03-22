#
# Preliminary.R
#
library(caret)
library(parallel)
library(doParallel)

# Enable multi cores
cl <- makeCluster(detectCores())
registerDoParallel(cl)

# Load training data
raw_data<-read.csv("pml-training.csv")
columns=c(160,8:11,37:49,60:68,84:86,102)
features=raw_data[columns]
inTrain<-createDataPartition(y=features$classe, p=0.2, list=FALSE)
training<-features[inTrain,]

# Use Cross Validation
train_control <- trainControl(method="cv", number=5)

# Random Forest
print("Random Forest")
model_rf<-train(classe ~ ., data=training, method="rf")
save(model_rf, file="prelim_model_rf.rdata")

# Random Forest with Principal Component Analysis
print("RCA")
model_rf_pca<-train(classe ~ ., data=training, method="rf", preProcess="pca")
save(model_rf_pca, file="prelim_model_rf_pca.rdata")

# Boosting
print("Boosting")
model_gbm<-train(classe ~ ., data=training,  trControl=train_control, method="gbm", verbose=FALSE)
save(model_gbm, file="prelim_model_gbm.rdata")