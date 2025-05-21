library(ggplot2)
library(dplyr)
library(viridis)
library(reshape2)

#Length, weight and age data
Lt_Wt_Age<-read.csv("C:/Users/Jason.Cope/Documents/Current Action/Assessments/Rougheye_blackspotted_2025/assessment inputs/Lt_Wt_Age.csv")
Lt_Wt_Age<-read.csv("C:/Users/Jason.Cope/Documents/Current Action/Assessments/Rougheye_blackspotted_2025/assessment inputs/Lt_Wt_Age_42425.csv")

#############################
#Length-weight relationship #
#############################

ggplot(Lt_Wt_Age[!is.na(Lt_Wt_Age$Sex),],aes(x=as.numeric(Length),y=as.numeric(Weight),color=Source))+
  geom_point()+
  facet_wrap(vars(Sex))+
  xlab("Length (cm)")+
  ylab("Weight (kg)")+
  stat_smooth(method = 'nls', 
              formula = y ~ a*x^b, 
              se = FALSE, 
              method.args = list(start   = list(a = 0.00001, b = 3), 
                                 control = list(minFactor = 1/ 8192, 
                                                maxiter = 100)))


sex_names<-unique(Lt_Wt_Age$Sex)[!is.na(unique(Lt_Wt_Age$Sex))] #Pull sex names
Lt_Wt_Age_Sex_coeffs<-matrix(NA,3,3) #set coeff matrix
rownames(Lt_Wt_Age_Sex_coeffs)<-sex_names
colnames(Lt_Wt_Age_Sex_coeffs)<-c("a","b","N")
for(i in 1:length(sex_names))
  {
    Lt_Wt_Age_Sex<-subset(Lt_Wt_Age,Sex==sex_names[i])
    LtWt.lm<-lm(log(as.numeric(Lt_Wt_Age_Sex$Weight))~log(as.numeric(Lt_Wt_Age_Sex$Length)))
    Lt_Wt_Age_Sex_coeffs[i,]<-c(exp(LtWt.lm$coefficients[1]),LtWt.lm$coefficients[2],length(LtWt.lm$residuals))
  }

Lt_Wt_Age_Sex_coeffs

#Make female and male lt-wt figures
ex_Lt_Wt_list<-list()
for(i in 1:2)
  {
    ex_Lt_Wt_list[[i]]<-data.frame(Lt.in=seq(0,80,1),Wt.in=Lt_Wt_Age_Sex_coeffs[i+1,1]*seq(0,80,1)^Lt_Wt_Age_Sex_coeffs[i+1,2],Sex=sex_names[i+1])
  }
ex_Lt_Wt_est<-bind_rows(ex_Lt_Wt_list, .id = "column_label")

ggplot(ex_Lt_Wt_est,aes(Lt.in,Wt.in,color=Sex))+
  geom_line(aes(linetype=Sex),lwd=2)+
  annotate("text",x=20,y=8,label=paste0("Female: a=",round(Lt_Wt_Age_Sex_coeffs[2,1],8),"; b=",round(Lt_Wt_Age_Sex_coeffs[2,2],2)))+
  annotate("text",x=20,y=7.5,label=paste0("Male: a=",round(Lt_Wt_Age_Sex_coeffs[3,1],7),"; b=",round(Lt_Wt_Age_Sex_coeffs[3,2],2)))

#######################

#######################
### Age and growth ###
#######################
N_ages<-rowSums(table(Lt_Wt_Age[,3:4])) #sample sizes

ggplot(Lt_Wt_Age[!is.na(Lt_Wt_Age$Sex),],aes(x=as.numeric(Age),y=as.numeric(Length),color=Source))+
  geom_point()+
  facet_wrap(vars(Sex))+
  xlab("Age (years)")+
  ylab("Length (cm)")+
  stat_smooth(method = 'nls', 
            formula = y ~ Linf*(1-exp(-k*(x-t0))), 
            se = FALSE, 
            method.args = list(start   = list(Linf = 55 , k = 0.1, t0=0), 
                               control = list(minFactor = 1/ 8192, 
                                              maxiter = 100)))+
  geom_text(data = data.frame(Length = c(100,100,100),Weight=c(NA,NA,NA), Sex=c("F","M","U"), Age = c(80,80,80),Source=("All"),
                              label = c(paste0("N=",N_ages[1]), paste0("N=",N_ages[2]),paste0("N=",N_ages[3]))),
                              aes(label = label),color="black")
  

N_ages<-rowSums(table(Lt_Wt_Age[,3:4])) #Total age and length sample sizes

##Calculate CV plot by sex##
Lt_Age_Sex<-Lt_Wt_Age[,c(1,3,4)]
Lt_Age_Sex_MF<-Lt_Age_Sex[Lt_Age_Sex$Sex!="U",]

#Calculate mean and sds by sex
LtAge_mean<-Lt_Age_Sex_MF %>% group_by(Age,Sex) %>% summarize(ltvar = mean(as.numeric(Length),na.rm=TRUE))
LtAge_mean<-LtAge_mean[-c(265:267),]
LtAge_sd<-Lt_Age_Sex_MF %>% group_by(Age,Sex) %>% summarize(ltvar = sd(as.numeric(Length),na.rm=TRUE))
LtAge_sd<-LtAge_sd[-c(265:267),]

#calculate samples by sex
Lt_Age_Sex_F<-subset(Lt_Age_Sex_MF,Sex=="F")
Lt_Age_Sex_F<-Lt_Age_Sex_F[!is.na(Lt_Age_Sex_F$Age),]
Lt_Age_Sex_M<-subset(Lt_Age_Sex_MF,Sex=="M")
Lt_Age_Sex_M<-Lt_Age_Sex_M[!is.na(Lt_Age_Sex_M$Age),]
write.csv(rbind(Lt_Age_Sex_F,Lt_Age_Sex_M),"C:/Users/Jason.Cope/Documents/Current Action/Assessments/Rougheye_blackspotted_2025/assessment inputs/F_M_Age_Lt.csv")

LtAge_nums_F<-colSums(table(Lt_Age_Sex_F))
LtAge_nums_M<-colSums(table(Lt_Age_Sex_M))
LtAge_nums_FM<-rbind(t(LtAge_nums_F),t(LtAge_nums_M))
colnames(LtAge_nums_FM)<-"N"
#LtAge_nums_FM<-colSums(table(Lt_Age_Sex_MF))


#Calculate CVs by sex
LtAge_mean_sortsex<-LtAge_mean[order(LtAge_mean$Sex),]
LtAge_sd_sortsex<-LtAge_sd[order(LtAge_mean$Sex),]
LtAge_CV<-data.frame(Age=LtAge_mean_sortsex$Age,Sex=LtAge_mean_sortsex$Sex,CV=(LtAge_sd_sortsex$ltvar/LtAge_mean_sortsex$ltvar),N=LtAge_nums_FM)
#LtAge_CV<-cbind(LtAge_CV,LtAge_nums_FM)
#colnames(LtAge_CV)<-c("Age","Sex","CV","N")

ggplot(LtAge_CV,aes(Age,CV))+
  geom_point(aes(size=N),shape=21,fill="white",stroke=2)+
  facet_wrap(vars(Sex))+
  geom_smooth(method = "loess")
  

#####################
# Natural mortality #
#####################

M_vec<-c(0.03,0.035,0.042,0.05,0.055)
age_vec<-0:200
age_list<-list()
for(i in 1:length(M_vec))
{
  age_list[[i]]<-data.frame(Ages=age_vec,Pop_prop=exp(-M_vec[i]*age_vec),M_val=as.character(M_vec[i]))
}

age_mat<-bind_rows(age_list, .id = "column_label")

M_pts<-data.frame(Age_M=5.4/M_vec,Pop_prop_M=0.004517)

ggplot(data=age_mat,aes(Ages,Pop_prop,color=M_val))+
  geom_line(lwd=1.25)+
  scale_color_viridis(discrete=TRUE)+
  geom_point(data=M_pts,inherit.aes=FALSE,aes(Age_M,Pop_prop_M),size=3.5,color="black")+
  geom_point(data=M_pts,inherit.aes=FALSE,aes(Age_M,Pop_prop_M),size=3,color=viridis(5))

age.peak<-21
age.cut<-100
age_comps_agg<-melt(table(Lt_Wt_Age$Age,Lt_Wt_Age$Sex))
colnames(age_comps_agg)<-c("Ages","Sex","Freq")
age_comps_agg<-age_comps_agg[age_comps_agg$Freq>0,]
age_comps_agg<-age_comps_agg[age_comps_agg$Sex!="U",]
age_comps_agg.df<-data.frame(age_comps_agg,Freq_ln=log(age_comps_agg$Freq))
age_comps_agg_peak<-age_comps_agg[age_comps_agg$Age>age.peak&age_comps_agg$Age<=age.cut,]
age_comps_agg_peak.df<-data.frame(age_comps_agg_peak,Freq_ln=log(age_comps_agg_peak$Freq))


#Report Z value
age_comps_agg.df.F<-subset(age_comps_agg_peak.df,Sex=="F")
cc_lm.F<-lm(age_comps_agg.df.F$Freq_ln~age_comps_agg.df.F$Age)
cc_lm.F$coefficients[2]

age_comps_agg.df.M<-subset(age_comps_agg_peak.df,Sex=="M")
cc_lm.M<-lm(age_comps_agg.df.M$Freq_ln~age_comps_agg.df.M$Age)
cc_lm.M$coefficients[2]


#Make Z plot
ggplot(age_comps_agg.df,aes(Ages,Freq_ln))+
  geom_point()+
  ylab("Log frequency")+
  geom_point(data=age_comps_agg_peak.df,aes(Ages,Freq_ln),color="red")+
  geom_smooth(method = "lm",data=age_comps_agg_peak.df)+
  facet_wrap(vars(Sex))+
  annotate("text",x=100,y=5.4,label=paste0("Peak age = ",age.peak),size=5)+
  geom_text(data = data.frame(Ages = c(100,100),Sex=c("F","M"),Freq=c(NA,NA), Freq_ln = c(5,5),
                            label = c(paste0("Z = ",round(cc_lm.F$coefficients[2],3)),paste0("Z = ",round(cc_lm.M$coefficients[2],3)))),
                            aes(label = label),color="black",size=5)

#Both sexes combined
age_comps_agg<-table(Lt_Wt_Age$Age)
age_comps_agg.df<-data.frame(Ages=as.numeric(names(age_comps_agg)),Freq=as.numeric(age_comps_agg),Freq_ln=log(as.numeric(age_comps_agg)))
age_comps_agg_peak<-age_comps_agg[21:length(age_comps_agg)]
age_comps_agg_peak.df<-data.frame(Ages=as.numeric(names(age_comps_agg_peak)),Freq=as.numeric(age_comps_agg_peak),Freq_ln=log(as.numeric(age_comps_agg_peak)))

ggplot(age_comps_agg.df,aes(Ages,Freq_ln))+
  geom_point()+
  ylab("Log frequency")+
geom_point(data=age_comps_agg_peak.df,aes(Ages,Freq_ln),color="red")+
  geom_smooth(method = "lm",data=age_comps_agg_peak.df)+
  annotate("text",x=100,y=5.4,label=paste0("Peak age = 21"),size=5)+
  annotate("text",x=100,y=5,label=paste0("Z = -0.04172"),size=5)


