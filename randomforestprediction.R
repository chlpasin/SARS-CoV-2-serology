library(ranger)
###################### Necessary inputs: random forest model + probability threshold + newdata
load("ABCORA2.3.RFranger.RData")
mx1_rf<-0.3845776
newdata<-read.table("newdata.txt",header=TRUE)
###################### newdata has to be of the following format
# each line correspond to a patient
# columns should included the following measurements: 
# IgG S1, IgG S2, IgG RBD, IgG N, IgG HKU1, 
# IgA S1, IgA S2, IgA RBD, IgA N, IgA HKU1, 
# IgM S1, IgM S2, IgM RBD, IgM N, IgM HKU1
# with names: "IgG_S1_LFS", "IgG_S2_LFS", "IgG_RBD_FLS", "IgG_NP_LFS", "IgG_HKU_LFS" ..., "IgM_HKU_LFS"
# no other columns
# measures of the Igs are log10(Fold over empty)

##### THIS LINE ESTIMATES THE PROBABILITY OF BEING POSITIVE FOR EACH OF THE SAMPLE 
pred_rf<-predict(rf,newdata)
predict_rf_proba <- as.vector(pred_rf$predictions[,2])

##### THIS LINE DETERMINES IF A SAMPLE IS SEROPOSITIVE OR NOT (the proba of being positive has to 
##### be higher than mx1_rf)
prediction_rf <- as.factor(ifelse(predict_rf_proba>mx1_rf,"Positive","Negative"))

#### prediction_rf can be added to the dataset
newdata$serostatus<-prediction_rf

