library(ggplot2)

Catch_comp_in<-read.csv("C:/Users/Jason.Cope/Documents/Github/REBS-2025/docs/Pre_assessment/plots/Catch_comps.csv")
#write.csv(Catch_comp_in,"C:/Users/Jason.Cope/Documents/Github/REBS-2025/docs/Pre_assessment/plots/Catch_comps.csv")
Catch_comp_in_CA<-subset(Catch_comp_in,State=="CA")
Catch_comp_in_OR<-subset(Catch_comp_in,State=="OR")
Catch_comp_in_WA<-subset(Catch_comp_in,State=="WA")
Catch_comp_in_All<-subset(Catch_comp_in,State=="All")

ggplot(Catch_comp_in_CA,aes(Year,Landings,color=as.factor(Assessment)))+
  geom_line(aes(linetype=as.factor(Assessment)))+
  scale_color_manual(values=c("#CC6666", "black"))+
  facet_wrap(vars(Fishery))+
  labs(color="Assessment year",linetype="Assessment year")+
  ylab("CA Landings")+
  theme_bw()+
  theme(legend.position="bottom")

ggplot(Catch_comp_in_OR,aes(Year,Landings,color=as.factor(Assessment)))+
  geom_line(aes(linetype=as.factor(Assessment)))+
  scale_color_manual(values=c("#CC6666", "black"))+
  facet_wrap(vars(Fishery))+
  labs(color="Assessment year",linetype="Assessment year")+
  ylab("OR Landings")+
  theme_bw()+
  theme(legend.position="bottom")

ggplot(Catch_comp_in_WA,aes(Year,Landings,color=as.factor(Assessment)))+
  geom_line(aes(linetype=as.factor(Assessment)))+
  scale_color_manual(values=c("#CC6666", "black"))+
  facet_wrap(vars(Fishery))+
  labs(color="Assessment year",linetype="Assessment year")+
  ylab("WA Landings")+
  theme_bw()+
  theme(legend.position="bottom")

ggplot(Catch_comp_in_All,aes(Year,Landings,color=as.factor(Assessment)))+
  geom_line(aes(linetype=as.factor(Assessment)))+
  scale_color_manual(values=c("#CC6666", "black"))+
  facet_wrap(vars(Fishery))+
  labs(color="Assessment year",linetype="Assessment year")+
  ylab("All Landings")+
  theme_bw()+
  theme(legend.position="bottom")



##############
#### Neff ####
##############
Neff_in<-read.csv("C:/Users/Jason.Cope/Documents/Github/REBS-2025/docs/Pre_assessment/plots/Neff_inputs.csv")
write.csv(Neff_in,"C:/Users/Jason.Cope/Documents/Github/REBS-2025/docs/Pre_assessment/plots/Neff_inputs.csv")
Neff_in.FD<-subset(Neff_in,Type=="FD")
Neff_in.FD.2025<-subset(Neff_in.FD,Assessment=="2025")
Neff_in.FD.2013<-subset(Neff_in.FD,Assessment=="2013")
Neff_in.FI<-subset(Neff_in,Type=="FI")
Neff_in.FI.2013<-subset(Neff_in.FI,Assessment=="2013")
Neff_in.FI.2025<-subset(Neff_in.FI,Assessment=="2025")



ggplot(Neff_in.FD.2025,aes(as.numeric(Year),as.numeric(Neff),color=as.factor(Sex),fill=as.factor(Sex)))+
  geom_bar(stat = "identity")+
  facet_wrap(vars(Fleet))+
  ylab("Input Effective Sample Size")+
  xlab("Year")+
  theme_bw()+
  theme(legend.position="bottom")+
  labs(color="Sex",fill="Sex")+
  scale_fill_manual(values=c("orange","black"))+
  scale_colour_manual(values=c("orange","black"))+
  geom_point(data=Neff_in.FD.2013,aes(as.numeric(Year),as.numeric(Neff)),col="blue")
  

ggplot(Neff_in.FI.2025,aes(as.numeric(Year),as.numeric(Neff),fill=as.factor(Sex)))+
  #geom_bar(stat = "identity")+
  geom_col()+
  facet_wrap(vars(Fleet))+
  ylab("Input Effective Sample Size")+
  xlab("Year")+
  theme_bw()+
  theme(legend.position="bottom")+
  labs(color="Sex",fill="Sex")+
  scale_fill_manual(values=c("orange","orange"))+
  scale_colour_manual(values=c("orange","orange"))+
  geom_point(data=Neff_in.FI.2013,aes(as.numeric(Year),as.numeric(Neff)),col="blue")





####################
##Compare Indices ##
####################

Indices_comp_in<-read.csv("C:/Users/Jason.Cope/Documents/Github/REBS-2025/docs/Pre_assessment/plots/Indices_comp.csv")
#write.csv(Indices_comp_in,"C:/Users/Jason.Cope/Documents/Github/REBS-2025/docs/Pre_assessment/plots/Indices_comp.csv")
Indices_comp_in_WCGBTS<-subset(Indices_comp_in,Survey=="WCGBTS")
Indices_comp_in_NWFSC<-subset(Indices_comp_in,Survey=="NWFSC_slope")
Indices_comp_in_AFSC_slope<-subset(Indices_comp_in,Survey=="AFSC_slope")
Indices_comp_in_Tri<-subset(Indices_comp_in,Survey=="Triennial")

#WCGBTS
ggplot(Indices_comp_in_WCGBTS,aes(as.numeric(Year),as.numeric(Index),color=as.factor(Type)))+
  geom_point(position=position_dodge(width=0.5))+
  geom_errorbar(aes(ymin=exp(log(as.numeric(Index))-as.numeric(SD_log)*1.96), 
                    ymax=exp(log(as.numeric(Index))+as.numeric(SD_log)*1.96)),
                position=position_dodge(width=0.5))+
  ylim(0,3000)+
  xlab("Year")+
  ylab("WCGBTS Index value")+
  theme_bw()+
  theme(legend.position="bottom")+
  labs(color="Survey model")
  
#NWFSC slope
ggplot(Indices_comp_in_NWFSC,aes(as.numeric(Year),as.numeric(Index),color=as.factor(Type)))+
  geom_point(position=position_dodge(width=0.5))+
  geom_errorbar(aes(ymin=exp(log(as.numeric(Index))-as.numeric(SD_log)*1.96), 
                    ymax=exp(log(as.numeric(Index))+as.numeric(SD_log)*1.96)),
                position=position_dodge(width=0.5))+
  ylim(0,9000)+
  xlab("Year")+
  ylab("NWFSC slope Index value")+
  theme_bw()+
  theme(legend.position="bottom")+
  labs(color="Survey model")+
  scale_x_discrete(breaks=c(1999:2002),labels=c("1999","2000","2001","2002"))

#AFSC slope
ggplot(Indices_comp_in_AFSC_slope,aes(as.numeric(Year),as.numeric(Index),color=as.factor(Type)))+
  geom_point(position=position_dodge(width=0.5))+
  geom_errorbar(aes(ymin=exp(log(as.numeric(Index))-as.numeric(SD_log)*1.96), 
                    ymax=exp(log(as.numeric(Index))+as.numeric(SD_log)*1.96)),
                position=position_dodge(width=0.5))+
  ylim(0,3000)+
  xlab("Year")+
  ylab("AFSC slope Index value")+
  theme_bw()+
  theme(legend.position="bottom")+
  labs(color="Survey model")

#Triennial
ggplot(Indices_comp_in_Tri,aes(as.numeric(Year),as.numeric(Index),color=as.factor(Type)))+
  geom_point(position=position_dodge(width=0.5))+
  geom_errorbar(aes(ymin=exp(log(as.numeric(Index))-as.numeric(SD_log)*1.96), 
                    ymax=exp(log(as.numeric(Index))+as.numeric(SD_log)*1.96)),
                position=position_dodge(width=0.5))+
  ylim(0,2000)+
  xlab("Year")+
  ylab("Triennial Index value")+
  theme_bw()+
  theme(legend.position="bottom")+
  labs(color="Survey model")

#Z-score plot
ggplot(Indices_comp_in,aes(as.numeric(Year),as.numeric(Zscore),color=as.factor(Type)))+
    geom_line()+
    facet_wrap(vars(Survey))+
    labs(color="Model",linetype="Model")+
    ylab("Z-score index")+
    xlab("Year")+
    theme_bw()+
    theme(legend.position="bottom")


  
ggplot(Indices_comp_in,aes(as.numeric(Year),as.numeric(SD_log),color=as.factor(Type)))+
  geom_point(position=position_dodge(width=0.5))+
  facet_wrap(vars(Survey))+
  labs(color="Model")+
  ylab("Standard deviation in log space")+
  xlab("Year")+
  theme_bw()+
  theme(legend.position="bottom")
