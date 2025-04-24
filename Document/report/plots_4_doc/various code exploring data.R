#Cumulative curve of ages
vec.ages<-as.numeric(readClipboard())
cum_curve_bins<-as.numeric(names(table(vec.ages)))
cum_curve<-cumsum(table(vec.ages))/length(vec.ages)
plot(cum_curve_bins,cum_curve*100,xlab="age bin",ylab="cumulative %")
abline(h=95,v=80,col="red")


#Pivot table
library(pivottabler)
library(openxlsx)

load("C:/Users/Jason.Cope/Documents/Current Action/Assessments/Rougheye_blackspotted_2025/assessment inputs/PacFIN/PacFIN.BSPR--REYE--UDW1.bds.22.Apr.2025.RData")

qhpvt(subset(bds.pacfin,AGENCY_CODE=="O"),rows="SAMPLE_YEAR",columns="FINAL_FISH_AGE_IN_YEARS","n()")


pt <- PivotTable$new()
pt$addData(bds.pacfin)
pt$addColumnDataGroups("FINAL_FISH_AGE_IN_YEARS")
pt$addColumnDataGroups("AGENCY_CODE")
pt$addRowDataGroups("SAMPLE_YEAR")
pt$defineCalculation(calculationName="TotalAges", summariseExpression="n()")
pt$evaluatePivot()

wb <- createWorkbook(creator = Sys.getenv("USERNAME"))
addWorksheet(wb, "Data")
pt$writeToExcelWorksheet(wb=wb, wsName="Ages_by_year_agency", 
                         topRowNumber=1, leftMostColumnNumber=1, applyStyles=FALSE)
saveWorkbook(wb, file="C:/Users/Jason.Cope/Documents/Current Action/Assessments/Rougheye_blackspotted_2025/assessment inputs/PacFIN/AgesPVT.xlsx", overwrite = TRUE)
