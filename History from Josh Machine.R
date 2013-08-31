# start of HPV typing categorizing---------------------------------
PGMY11_primer_samples_perc_id_only <- read.delim("P:/o_drive/Homes/epowell/RRP/HPV Typing/PGMY11_primer_samples_perc_id_only.tsv")

library(mclust)

gpMclust<-Mclust(gp5_)
gp5_primer_samples_perc_id_only
list
ls
gp5_primer_samples_perc_id_only <- read.delim("P:/o_drive/Homes/epowell/RRP/HPV Typing/gp5_primer_samples_perc_id_only.tsv")

gp_Mclust<-Mclust(gp5_primer_samples_perc_id_only[2:6])
summary(gp_Mclust)
gp_Mclust
Mclust(gp5_primer_samples_perc_id_only[2:6])
Mclust(gp5_primer_samples_perc_id_only[2:3])
Mclust(gp5_primer_samples_perc_id_only[,2:6])
image(gp5_primer_samples_perc_id_only[,2:6])
gp5_primer_samples_perc_id_only?
;
?gp5_primer_samples_perc_id_only
rstudio::viewData(PGMY11_primer_samples_perc_id_only)
gp_matrix<-data.matrix(gp5_primer_samples_perc_id_only[,2:6], rownames.force=NA)
fix(gp_Mclust)
rstudio::viewData(gp_matrix)
rstudio::viewData(gp5_primer_samples_perc_id_only)
rstudio::viewData(gp_matrix)
image(gp_matrix)
persp(gp_matrix)
persp(gp_matrix, expand=.2)
rstudio::viewData(gp5_primer_samples_perc_id_only)
summary(gp_Mclust)
gp_Mclust.modelName
fMclust<-Mclust(faithful)
summary(fMclust)
unload(Mclust)
install.packages("mclust")
library(mclust)
summary(fMclust)
fMclust<-Mclust(faithful)
summary(fMclust)
install.packages("mclust")
gp_Mclust<-gp5_primer_samples_perc_id_only
summary(gp_Mclust)
gp_Mclust<-Mclust(gp5_primer_samples_perc_id_only)
library(mclust)
gp_Mclust<-Mclust(gp5_primer_samples_perc_id_only)
summary(gp_Mclust)
plot(gp_Mclust)
gp_Mclust<-Mclust(gp5_primer_samples_perc_id_only[,2:6])
summary(gp_Mclust)
plot(gp_Mclust)
gp_16_11_only_Mclust<-Mclust(gp5_primer_samples_perc_id_only[,2:3])
summary(gp_16_11_only_Mclust)
plot(gp_16_11_only_Mclust)
gp_16_11_only_Mclust
names(gp_16_11_only_Mclust)
gp_16_11_only_Mclust.modelName
gp_16_11_only_Mclust$modelName
gp_16_11_only_Mclust$parameters
gp_16_11_only_Mclust$uncertainty
plot(gp_16_11_only_Mclust$uncertainty)
summary(gp_Mclust)
install.packages("bayesclust")
library(bayesclust)
??bayesclust
names(gp_Mclust)
gp_Mclust$classification
c(gp_Mclust$classification,gp5_primer_samples_perc_id_only[,1])
viewdata(c(gp_Mclust$classification,gp5_primer_samples_perc_id_only[,1]))
rstudio::viewdata(c(gp_Mclust$classification,gp5_primer_samples_perc_id_only[,1]))
rstudio:viewdata(c(gp_Mclust$classification,gp5_primer_samples_perc_id_only[,1]))
??rstuio
??rstudio
rstudio::viewData(c(gp_Mclust$classification,gp5_primer_samples_perc_id_only[,1]))
rstudio::viewData(c(gp_Mclust$classification,gp5_primer_samples_perc_id_only[,1]))
rstudio:viewdata(cbind(gp_Mclust$classification,gp5_primer_samples_perc_id_only[,1]))
rstudio::viewData(cbind(gp_Mclust$classification,gp5_primer_samples_perc_id_only[,1]))
install.packages("knitr")
Mclust?
;
?Mclust
rstudio::viewData(cbind(gp_Mclust$classification,gp_Mclust$z))
gp_Mclust$d
gp_Mclust$G
gp_Mclust$bic
gp_Mclust$loglik
gp_Mclust$df
summary(gp_Mclust, parameters=TRUE)
plot(hclust(gp5_primer_samples_perc_id_only[,2:6]))
?dist
grep(pattern="honeye.",x=c("none", "honeye.", "honeyer", "honeye66"), ignore.case=TRUE, value=TRUE)
grep(pattern="honeye.",x=c("none", "honeye.", "honeyer", "honeye66"), ignore.case=TRUE, value=FALSE)
gsub(pattern="honeye.",x=c("none", "honeye.", "honeyer", "honeye66"), replacement="dontknow", ignore.case=TRUE)
gsub(pattern="honeye[^6]+",x=c("none", "honeye.", "honeyer", "honeye66"), replacement="dontknow", ignore.case=TRUE)
gsub(pattern="honeye[^7]+",x=c("none", "honeye.", "honeyer", "honeye66"), replacement="dontknow", ignore.case=TRUE)
library(mclust)
#Load up the data from the alignments
data<-read.table("P:\\o_drive\\Homes\\epowell\\RRP\\all_against_all_matrix_ggsearch", header=TRUE, sep=" ")
data
gp5_primer_samples_perc_id_only <- read.delim("P:/o_drive/Homes/epowell/RRP/HPV Typing/gp5_primer_samples_perc_id_only.tsv")
PGMY11_primer_samples_perc_id_only <- read.delim("P:/o_drive/Homes/epowell/RRP/HPV Typing/PGMY11_primer_samples_perc_id_only.tsv")
Mclust(gp5_primer_samples_perc_id_only[,2:6])
summary(Mclust(gp5_primer_samples_perc_id_only[2:6]))
Mclust(gp5_primer_samples_perc_id_only[,2:6],G=5)
Mclust(gp5_primer_samples_perc_id_only[,2:6],G=4)

plot(Mclust(gp5_primer_samples_perc_id_only[2:6]))
mclust_gp5 <- Mclust(gp5_primer_samples_perc_id_only[2:6])
summary(mclust_gp5)
mclust_pgmy11<-Mclust(PGMY11_primer_samples_perc_id_only[2:6])
summary(mclust_pgmy11)
gp5_BIC <- mclustBIC(gp5_primer_samples_perc_id_only)
summary(gp5_BIC, data = gp5_primer_samples_perc_id_only)
plot(gp5_BIC, legendArgs = list(x = 'topleft'))
c(gp_Mclust$classification,gp5_primer_samples_perc_id_only[,1])
gp_Mclust$classification
c(gp_Mclust$classification,gp5_primer_samples_perc_id_only[,1])
c(gp_Mclust$classification,gp5_primer_samples_perc_id_only[,1])
cbind(gp_Mclust$classification,gp5_primer_samples_perc_id_only[,1])

results <- cbind(gp_Mclust$classification,gp5_primer_samples_perc_id_only[,1])

summary(mclust_pgmy11)
plot(mclust_pgmy11, legendArgs = list(x = 'topleft'))
summary(gp5_BIC, data = gp5_primer_samples_perc_id_only)
summary(gp_Mclust)
summary(gp5_BIC, data = gp5_primer_samples_perc_id_only)
gp5_BIC <- mclustBIC(gp5_primer_samples_perc_id_only[2:6])
```
gp5_primer_samples_perc_id_only[2:6]
summary(gp5_BIC, data = gp5_primer_samples_perc_id_only)
pgmy_BIC <- mclustBIC(PGMY11_primer_samples_perc_id_only[2:6])
summary(pgmy_BIC, data = PGMY11_primer_samples_perc_id_only)
summary(pgmy_BIC)
summary(mclust_pgmy11)
plot(mclust_pgmy11)

