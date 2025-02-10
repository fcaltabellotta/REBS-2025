library(ggplot2)
library(dplyr)
library(viridis)

####################
#Length, weight and age data
Lt_Wt_Age<-read.csv("C:/Users/Jason.Cope/Documents/Current Action/Assessments/Rougheye_blackspotted_2025/assessment inputs/Lt_Wt_Age.csv")

#Length-weight relationship

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

#Natural mortality
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
age_comps_agg_peak<-age_comps_agg[21:length(age_comps_agg)]

lm(log(age_comps_agg_peak)~as.numeric(names(log(age_comps_agg_peak))))
