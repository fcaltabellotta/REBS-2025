library(ggplot2)

AE.dat<-read.csv("C:/Users/Jason.Cope/Documents/Current Action/Assessments/Rougheye_blackspotted_2025/assessment inputs/Age exchanges/Ageing error data input/AE_matrices.csv")

ggplot(AE.dat,aes(True_Age,Exp_Age,col=Ageing.Error))+
  geom_abline(slope=1,intercept=0,col="black",lwd=1.1)+
geom_line(aes(linetype=Ageing.Error),lwd=1.25)+
  xlab("True age")+
  ylab("Expected age")+
  guides(col=guide_legend(title="Reader ageing error"),linetype=guide_legend(title="Reader ageing error"))

ggplot(AE.dat,aes(True_Age,SD,col=Ageing.Error))+
  geom_line(aes(linetype=Ageing.Error),lwd=1.25)+
  xlab("True age")+
  ylab("Standard Deviation")+
  guides(col=guide_legend(title="Reader ageing error"),linetype=guide_legend(title="Reader ageing error"))

