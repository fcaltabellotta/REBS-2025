#Cumulative curve of ages
vec.ages<-as.numeric(readClipboard())
cum_curve_bins<-as.numeric(names(table(vec.ages)))
cum_curve<-cumsum(table(vec.ages))/length(vec.ages)
plot(cum_curve_bins,cum_curve*100,xlab="age bin",ylab="cumulative %")
abline(h=95,v=80,col="red")


#Pivot table
library(pivottabler)
library(openxlsx)

load("C:/Users/Jason.Cope/Documents/Current Action/Assessments/Rougheye_blackspotted_2025/assessment inputs/PacFIN/2025-04-24/PacFIN.BSPR--REYE--UDW1.bds.24.Apr.2025.RData")

qhpvt(subset(bds.pacfin,AGENCY_CODE=="O"),rows="SAMPLE_YEAR",columns="FINAL_FISH_AGE_IN_YEARS","n()")


pt <- PivotTable$new()
pt$addData(bds.pacfin)
pt$addColumnDataGroups("AGENCY_CODE")
pt$addColumnDataGroups("FINAL_FISH_AGE_IN_YEARS")
pt$addRowDataGroups("SAMPLE_YEAR")
pt$defineCalculation(calculationName="TotalAges", summariseExpression="n()")
pt$evaluatePivot()

wb <- createWorkbook(creator = Sys.getenv("USERNAME"))
addWorksheet(wb, "Ages_by_year_agency")
pt$writeToExcelWorksheet(wb=wb, wsName="Ages_by_year_agency", 
                         topRowNumber=1, leftMostColumnNumber=1, applyStyles=FALSE)
saveWorkbook(wb, file="C:/Users/Jason.Cope/Documents/Current Action/Assessments/Rougheye_blackspotted_2025/assessment inputs/PacFIN/2025-04-24/AgesPVT.xlsx", overwrite = TRUE)

bds.pacfin.ages<-bds.pacfin[!is.na(bds.pacfin$FINAL_FISH_AGE_IN_YEARS),]

pt <- PivotTable$new()
pt$addData(bds.pacfin.ages)
pt$addColumnDataGroups("agedby1")
pt$addColumnDataGroups("FINAL_FISH_AGE_IN_YEARS")
pt$addRowDataGroups("AGENCY_CODE")
pt$addRowDataGroups("SAMPLE_YEAR")
pt$defineCalculation(calculationName="TotalAges", summariseExpression="n()")
pt$evaluatePivot()

wb <- createWorkbook(creator = Sys.getenv("USERNAME"))
addWorksheet(wb, "Ages_by_year_reader")
pt$writeToExcelWorksheet(wb=wb, wsName="Ages_by_year_reader", 
                         topRowNumber=1, leftMostColumnNumber=1, applyStyles=FALSE)
saveWorkbook(wb, file="C:/Users/Jason.Cope/Documents/Current Action/Assessments/Rougheye_blackspotted_2025/assessment inputs/PacFIN/2025-04-24/Ages_Reader_PVT.xlsx", overwrite = TRUE)


#
write.csv(bds.pacfin.ages[,c(61,87:89,93:95)],"C:/Users/Jason.Cope/Documents/Current Action/Assessments/Rougheye_blackspotted_2025/assessment inputs/Age exchanges/pacfin_reads.csv")

#Get lengths, weights and ages from final PacFIN pull
bds.pacfin<-bds.pacfin[bds.pacfin$FISH_WEIGHT_UNITS!="P"|is.na(bds.pacfin$FISH_WEIGHT_UNITS),]
#bds.pacfin[bds.pacfin$FISH_LENGTH_UNITS=="MM",]<-bds.pacfin[bds.pacfin$FISH_LENGTH_UNITS=="MM",45]/10

bds.pacfin.ltwtage<-bds.pacfin[,c(45,48,49,61,68)]
bds.pacfin.ltwtage[which(bds.pacfin.ltwtage$FISH_LENGTH_UNITS=="MM"),1]<-bds.pacfin.ltwtage[which(bds.pacfin.ltwtage$FISH_LENGTH_UNITS=="MM"),1]/10
bds.pacfin.ltwtage[,2]<-bds.pacfin.ltwtage[,2]/1000
write.csv(bds.pacfin.ltwtage,"C:/Users/Jason.Cope/Documents/Current Action/Assessments/Rougheye_blackspotted_2025/assessment inputs/pacfin_bds_42425_ltwtage.csv")
