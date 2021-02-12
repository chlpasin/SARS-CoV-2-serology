###################### Necessary inputs: random forest model + probability threshold + newdata
load("ABCORA2.2.RFranger.RData")
mx1_rf<-0.387874

###################### newdata has to be of the following format
# each line correspond to a patient
# columns have to be in the following order: 
# IgG S1, IgG S2, IgG RBD, IgG N, IgA S1, IgA S2, IgA RBD, IgA N, IgM S1, IgM S2, IgM RBD, IgM N
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

