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

#Show catches by fleet


####################
##Compare Indices ##
####################

Indices_comp_in<-read.csv("C:/Users/Jason.Cope/Documents/Github/REBS-2025/docs/Pre_assessment/plots/Indices_comp.csv")
Indices_comp_in_WCGBTS<-subset(Indices_comp_in,Survey=="WCGBTS")
Indices_comp_in_NWFSC<-subset(Indices_comp_in,Survey=="NWFSC_slope")
Indices_comp_in_WCGBTS<-subset(Indices_comp_in,Survey=="WCGBTS")
Indices_comp_in_WCGBTS<-subset(Indices_comp_in,Survey=="WCGBTS")

ggplot(Indices_comp_in_WCGBTS,aes(as.numeric(Year),as.numeric(Index),color=as.factor(Type)))+
  geom_point()
  
ggplot(Indices_comp_in_NWFSC,aes(as.numeric(Year),as.numeric(Index),color=as.factor(Type)))+
  geom_point(position=position_dodge(width=0.5))+
  ylim(0,3000)


ggplot(Indices_comp_in,aes(as.numeric(Year),as.numeric(Index),color=as.factor(Type)))+
  geom_point()+
#  scale_color_manual(values=c("#CC6666", "black"))+
  facet_wrap(vars(Survey))

    labs(color="Assessment year",linetype="Assessment year")+
  ylab("All Landings")+
  theme_bw()+
  theme(legend.position="bottom")
