library(ggplot2)
library(forcats)
library(dplyr)

lnR0_in<-read.csv(here("Document/report/plots_4_doc/lnR0_species.csv"))

lnR0_in %>%
mutate(Species = factor(Species, levels=c("Cowcod","Yelloweye","Squarespot","REBS_2013","Aurora","REBS_2025",
                                          "Sunset/Vermilion","Blackgill","Darkblotched","Gopher/Black&Yellow",
                                          "Canary","Blue/Deacon","Bocaccio","Pacific Ocean Perch","Shortspine thornyhead",
                                          "Splitnose","Greenstriped","Widow","Longspine thornyhead")
  )) %>%
  ggplot(aes(x=Species, y=lnR0)) +
  geom_segment( aes(xend=Species, yend=0)) +
  geom_point(aes(col=Depth),size=4) +
  theme_bw() +
  coord_flip() +
  xlab("")

#  theme(legend.position="none")

