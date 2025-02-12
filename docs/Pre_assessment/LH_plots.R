library(ggplot2)
library(dplyr)
library(viridis)

#Length, weight and age data
Lt_Wt_Age<-read.csv("C:/Users/Jason.Cope/Documents/Current Action/Assessments/Rougheye_blackspotted_2025/assessment inputs/Lt_Wt_Age.csv")

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
  

N_ages<-rowSums(table(Lt_Wt_Age[,3:4])) #sample sizes

LtAge_mean<-Lt_Wt_Age[,c(1,4)] %>% group_by(Age) %>% summarize(ltvar = mean(as.numeric(Length),na.rm=TRUE))
LtAge_sd<-Lt_Wt_Age[,c(1,4)] %>% group_by(Age) %>% summarize(ltvar = sd(as.numeric(Length),na.rm=TRUE))
LtAge_nums<-colSums(table(Lt_Wt_Age[,c(1,4)]))
LtAge_CV<-cbind(LtAge_mean[,1],(LtAge_sd/LtAge_mean)[,2])[-143,]
LtAge_CV<-cbind(LtAge_CV,LtAge_nums)
colnames(LtAge_CV)<-c("Age","CV","N")

ggplot(LtAge_CV,aes(Age,CV))+
  geom_point(aes(size=N),shape=21,color="blue",fill="white")

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


age_comps_agg<-table(Lt_Wt_Age$Age)
age_comps_agg.df<-data.frame(Ages=as.numeric(names(age_comps_agg)),Freq=as.numeric(age_comps_agg),Freq_ln=log(as.numeric(age_comps_agg)))
age_comps_agg_peak<-age_comps_agg[21:length(age_comps_agg)]
age_comps_agg_peak.df<-data.frame(Ages=as.numeric(names(age_comps_agg_peak)),Freq=as.numeric(age_comps_agg_peak),Freq_ln=log(as.numeric(age_comps_agg_peak)))
cc_lm<-lm(log(age_comps_agg_peak)~as.numeric(names(log(age_comps_agg_peak))))

ggplot(age_comps_agg.df,aes(Ages,Freq_ln))+
  geom_point()+
  ylab("Log frequency")+
geom_point(data=age_comps_agg_peak.df,aes(Ages,Freq_ln),color="red")+
  geom_smooth(method = "lm",data=age_comps_agg_peak.df)+
  annotate("text",x=100,y=5.4,label=paste0("Peak age = 21"),size=5)+
  annotate("text",x=100,y=5,label=paste0("Z = -0.04172"),size=5)

  
#Report Z value
cc_lm$coefficients[2]
