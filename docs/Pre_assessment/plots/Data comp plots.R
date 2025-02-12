library(ggplot2)

Catch_comp_in<-read.csv("C:/Users/Jason.Cope/Documents/Github/REBS-2025/docs/Pre_assessment/plots/Catch_comps.csv")
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
