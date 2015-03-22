#
# train_model.R
#
library(caret)

pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}


load("model_rf.rdata")
raw_data<-read.csv("pml-testing.csv")
columns=c(160,8:11,37:49,60:68,84:86,102)
test_cases=raw_data[columns]
answers<-predict(model_rf, test_cases )
pml_write_files(answers)

print(answers)