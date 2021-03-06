# start of HPV typing categorizing---------------------------------
PGMY11_primer_samples_perc_id_only <- read.delim("P:/o_drive/Homes/epowell/RRP/HPV Typing/PGMY11_primer_samples_perc_id_only.tsv")
gp5_primer_samples_perc_id_only <- read.delim("P:/o_drive/Homes/epowell/RRP/HPV Typing/gp5_primer_samples_perc_id_only.tsv")
data<-read.table("P:\\o_drive\\Homes\\epowell\\RRP\\all_against_all_matrix_ggsearch", header=TRUE, sep=" ")# all against all but not sure what to do with it

require(mclust)
require(devtools)
require(data.table)
require(mix)
require(RGoogleDocs)
require(reshape2)

pgmy11.fasta  <- data.table(PGMY11_primer_samples_perc_id_only, key = "rrpNum") 
gp5.fasta  <- data.table(gp5_primer_samples_perc_id_only, key = "rrpNum") 

# Read in fasta data that includes e value

load(file="C:/Users/Farrel/Google Drive/RRPGenetics/all.trim.RData")# I used the excel xlsx spreadsheet produced by Evan
# In a 32 bit version of R I ran require(RODBC); odbcConnectExcel("C:/Users/Farrel/Google Drive/RRPGenetics/HPV_trimmed_results.xlsx")
# then I added a sqlFetch statement on it to extract the data which had extrevely small values
# then I saved to an .RData file
all.trim.dt <- data.table(all.trim)
setkey(all.trim.dt,key=rrpNum)
names(all.trim.dt)
setnames(all.trim.dt, c("rrpNum", "primer", "well", "readlength", "eval.11", "id.11", "eval.6", "id.6", "eval.18", "id.18", "eval.16", "id.16", "eval.45", "id.45", "comments"))
# some e values came in at 0 which does not permit log operations
# will arbitrarily asing them to 1e-230
all.trim.dt[eval.11==0,eval.11:=1e-215 ]
all.trim.dt[,log.eval.11 := -log10(eval.11)]
all.trim.dt[,log.eval.6 := -log10(eval.6)]
all.trim.dt[id.16==max(id.16)|eval.16==min(eval.16),]
# appears as if 1245 rrpNum is clearly HPV 16. Make sure of that and then remove that rrpNum from all subsequent sets and label it as HPV 16
all.trim.dt <- all.trim.dt[!J(1245)]
# remove colums of 16 18 and 45 HPV types
all.trim.dt[,c("eval.18", "id.18", "eval.16", "id.16", "eval.45", "id.45") := NULL]
# explore duplicate samples and see how to bring them to one data point
id.eval.611 <-  all.trim.dt[,list(n = .N, readlength = median(readlength), id.11 = median(id.11), log.eval.11 = median(log.eval.11), id.6 = median(id.6), log.eval.6 = median(log.eval.6)),by=list(rrpNum,primer)] #id.eval.611 means that id percentages and e values from blast from both PGMY11 and GP5  are in the data table.






gp_Mclust<-Mclust(gp5_primer_samples_perc_id_only[2:6])
summary(gp_Mclust)

# Josh tries to visualize the data
# Not sure what this is about
gp_matrix<-data.matrix(gp5_primer_samples_perc_id_only[,2:6], rownames.force=NA)
image(gp_matrix)
persp(gp_matrix)
persp(gp_matrix, expand=.2)
# end of not sure what this is about



names(gp_Mclust)
gp_Mclust$call
gp_Mclust$modelName
gp_Mclust$n
gp_Mclust$d
gp_Mclust$G
gp_Mclust$BIC
gp_Mclust$bic
gp_Mclust$logilik
gp_Mclust$df
gp_Mclust$parameters
gp_Mclust$uncertainty
gp_Mclust$z
gp_Mclust$classification

summary(gp_Mclust, parameters=TRUE)
plot(Mclust(gp5_primer_samples_perc_id_only[2:6]))



mclust_pgmy11<-Mclust(PGMY11_primer_samples_perc_id_only[2:6])
summary(mclust_pgmy11)

names(mclust_pgmy11)
mclust_pgmy11$call
mclust_pgmy11$modelName
mclust_pgmy11$n
mclust_pgmy11$d
mclust_pgmy11$G
mclust_pgmy11$BIC
mclust_pgmy11$bic
mclust_pgmy11$logilik
mclust_pgmy11$df
mclust_pgmy11$parameters
mclust_pgmy11$uncertainty
mclust_pgmy11$z
mclust_pgmy11$classification

summary(mclust_pgmy11, parameters=TRUE)
plot(mclust_pgmy11)


# Check for specimens that were only sequenced by one primer or were duplicates-----------------------

pgmy11.only <- sort(setdiff(PGMY11_primer_samples_perc_id_only$rrpNum, gp5_primer_samples_perc_id_only$rrpNum))#PGMY11 present but not in other group
pgmy11.only
length(pgmy11.only)
gp5.only <- sort(setdiff(gp5_primer_samples_perc_id_only$rrpNum, PGMY11_primer_samples_perc_id_only$rrpNum))#GP5+ present but not in other group
gp5.only
length(gp5.only)

length(intersect(PGMY11_primer_samples_perc_id_only$rrpNum, gp5_primer_samples_perc_id_only$rrpNum))

sum(duplicated(PGMY11_primer_samples_perc_id_only$rrpNum))
sort(PGMY11_primer_samples_perc_id_only$rrpNum[duplicated(PGMY11_primer_samples_perc_id_only$rrpNum)])
sum(duplicated(gp5_primer_samples_perc_id_only$rrpNum))
sort(gp5_primer_samples_perc_id_only$rrpNum[duplicated(gp5_primer_samples_perc_id_only$rrpNum)])

anyDuplicated(gp5_primer_samples_perc_id_only$rrpNum)

# Explore duplicates----------------------

dup.pgmy11  <-  pgmy11.fasta[duplicated(rrpNum), rrpNum]
pgmy11.fasta[rrpNum %in% dup.pgmy11,]

dup.gp5  <-  gp5.fasta[duplicated(rrpNum), rrpNum]
gp5.fasta[rrpNum %in% dup.gp5,]

# run to run variability
# is the run to run percentage identity more similar than chance alone and by how much
# lets compare standard deviation of all PGMY11 for each HPV type and then the sd for same sample from run to run

pgmy11.fasta[,list(std.dev.11 = sd(HPV11_id), std.dev.6 = sd(HPV6b_id), std.dev.18 = sd(HPV18_id), std.dev.16 = sd(HPV16_id), std.dev.45 = sd(HPV45_id))]# standard deviation over all reads
summary(pgmy11.fasta)
runpgmy.sd  <- pgmy11.fasta[rrpNum %in% dup.pgmy11,list(std.dev.11 = sd(HPV11_id), std.dev.6 = sd(HPV6b_id), std.dev.18 = sd(HPV18_id), std.dev.16 = sd(HPV16_id), std.dev.45 = sd(HPV45_id)), by = rrpNum]
runpgmy.sd
summary(runpgmy.sd)

gp5.fasta[,list(std.dev.11 = sd(HPV11_id), std.dev.6 = sd(HPV6b_id), std.dev.18 = sd(HPV18_id), std.dev.16 = sd(HPV16_id), std.dev.45 = sd(HPV45_id))]# standard deviation over all reads
summary(gp5.fasta)
rungp.sd  <- pgmy11.fasta[rrpNum %in% dup.pgmy11,list(std.dev.11 = sd(HPV11_id), std.dev.6 = sd(HPV6b_id), std.dev.18 = sd(HPV18_id), std.dev.16 = sd(HPV16_id), std.dev.45 = sd(HPV45_id)), by = rrpNum]
rungp.sd
summary(rungp.sd)
# conclusion: there is much less variability from run to run of the same sample than across all samples

# converge duplicates into one identity percentage per sample for each primer
# will use median to do it in case we ever see more than two runs per 
pgmy11.singular <- pgmy11.fasta[,list(med.dev.11 = median(HPV11_id), med.dev.6 = median(HPV6b_id), med.dev.18 = median(HPV18_id), med.dev.16 = median(HPV16_id), med.dev.45 = median(HPV45_id)), by=rrpNum]# median identity for each sample over all reads (one or two reads) so that there is only one line per sample
gp5.singular <- gp5.fasta[,list(med.dev.11 = median(HPV11_id), med.dev.6 = median(HPV6b_id), med.dev.18 = median(HPV18_id), med.dev.16 = median(HPV16_id), med.dev.45 = median(HPV45_id)), by=rrpNum]# median identity for each sample over all reads (one or two reads) so that there is only one line per sample
summary(pgmy11.singular)
summary(gp5.singular)
# conclusions The maximum percent identity on HPV 18 and HPV 45 is so low that we can conclude there are none of those in the sample. 
# will rerun the clustering limiting to HPV 11, 6 and 16 only.
# first, pgmy11
mclust_pgmy11<-Mclust(pgmy11.singular[,list(med.dev.11, med.dev.6, med.dev.16)])
summary(mclust_pgmy11)
summary(mclust_pgmy11, parameters=TRUE)
plot(mclust_pgmy11)

# secondly, gp5
mclust_gp5<-Mclust(gp5.singular[,list(med.dev.11, med.dev.6, med.dev.16)])
summary(mclust_gp5)
summary(mclust_gp5, parameters=TRUE)
plot(mclust_gp5)


# Merge gp5 and pgmy data

gp.and.pgmy  <-  merge(pgmy11.singular, gp5.singular, all=FALSE, suffixes=c(".pgmy", ".gp"))# gp.and.pgmy is a merge of all the data into one table but with no missing data.
gp.and.pgmy.na  <-  merge(pgmy11.singular, gp5.singular, all=TRUE, suffixes=c(".pgmy", ".gp"))# gp.and.pgmy.na is same as gp.and.pgmy but including missing data.
gp.and.pgmy.611  <- gp.and.pgmy[,c("med.dev.18.pgmy",  "med.dev.16.pgmy",  "med.dev.45.pgmy",   "med.dev.18.gp",  "med.dev.16.gp",  "med.dev.45.gp"):=NULL] # 6 and 11 only
gp.and.pgmy.611.na  <- gp.and.pgmy.na[,c("med.dev.18.pgmy",  "med.dev.16.pgmy",  "med.dev.45.pgmy",   "med.dev.18.gp",  "med.dev.16.gp",  "med.dev.45.gp"):=NULL] # 6 and 11 only but includes all samples event those with missing variables
gp.and.pgmy.611.impute  <-  data.table(rrpNum = gp.and.pgmy.na[,rrpNum], imputeData(gp.and.pgmy.611.na[,-1,with=FALSE]), key="rrpNum")
gp.and.pgmy.611.na[6:26]
gp.and.pgmy.611.impute[6:26]

# calling it-------------------
# Strategy will be to call definite, HPV 6, definite HPV 11, mixture, poor quality and manually call what appears to be the sole HPV 16. 
# 1) let cluster do pgmy11 and gp5 separately and then see if the clustering can be merged
# 2) let cluster act on the imputed full table
# 3) let cluster act on percentage similarity and on e value from blast and see if they behave similarly


# will rerun the clustering limiting to HPV 11, and 6 only.
# I plan to handle the sole HPV 16 manually
# first, pgmy11
mclust_pgmy11<-Mclust(pgmy11.singular[,list(med.dev.11, med.dev.6)], G=4)# stipulated 4 since left to its own devices it created a 5th group with only 3 specimens in it.
summary(mclust_pgmy11)
summary(mclust_pgmy11, parameters=TRUE)
#plot(mclust_pgmy11)
pgmy11.singular[,classpgmy:=mclust_pgmy11$classification]

# secondly, gp5
mclust_gp5<-Mclust(gp5.singular[,list(med.dev.11, med.dev.6)], G=4, modelNames="VVV" )#highest BIC was 7 clusters which was unmaneagable, 4 clusters on VVV was almost as close
summary(mclust_gp5)
summary(mclust_gp5, parameters=TRUE)
#plot(mclust_gp5)
gp5.singular[,classgp:=mclust_gp5$classification]

# thirdly, cartesian merge of pgmy11 and gp5 data and clustering
pgmy.gp.class  <- merge(pgmy11.singular, gp5.singular, all=TRUE, suffixes=c(".pgmy", ".gp"))# gp.and.pgmy.na is same as gp.and.pgmy but including missing data.

mclust_both.primers<-Mclust(gp.and.pgmy.611.impute[,list(med.dev.11.pgmy,  med.dev.6.pgmy,  med.dev.11.gp,  med.dev.6.gp)], G=4)# minimal BIC increase in going from 4 groups to 5 groups
summary(mclust_both.primers)
summary(mclust_both.primers, parameters=TRUE)
#plot(mclust_both.primers)
pgmy.gp.class[,classimpute:=mclust_both.primers$classification]

# another way of classifying (intuitive)
# 6 or 11, maximum similarity
# mixture 6 and 11 difference is <8%
pgmy.gp.class[med.dev.6.pgmy>med.dev.11.pgmy, intuit.pgmy:=6] #intuit.pgmy is the call based on intuit reading of pgmy scores
pgmy.gp.class[med.dev.6.pgmy<med.dev.11.pgmy, intuit.pgmy:=11] #intuit.pgmy is the call based on intuit reading of pgmy scores
pgmy.gp.class[abs(log(1.01-med.dev.6.pgmy)-log(1.01-med.dev.11.pgmy))<0.9, intuit.pgmy:=611]
pgmy.gp.class[,meaningful.dif.pgmy:=abs(log(1.01-med.dev.6.pgmy)-log(1.01-med.dev.11.pgmy))]
plot(ecdf(pgmy.gp.class[complete.cases(med.dev.6.pgmy),abs(log(1.01-med.dev.6.pgmy)-log(1.01-med.dev.11.pgmy))]))
pgmy.gp.class[med.dev.6.gp>med.dev.11.gp, intuit.gp:=6] #intuit.gp is the call based on intuit reading of pgmy scores
pgmy.gp.class[med.dev.6.gp<med.dev.11.gp, intuit.gp:=11] #intuit.gp is the call based on intuit reading of pgmy scores
pgmy.gp.class[abs(log(1.01-med.dev.6.gp)-log(1.01-med.dev.11.gp))<0.9, intuit.gp:=611]
pgmy.gp.class[,meaningful.dif.gp:=abs(log(1.01-med.dev.6.gp)-log(1.01-med.dev.11.gp))]

#also look at what Evan did
pgmy.e.clust<-Mclust(all.trim.dt[primer=="PGMY11", list(eval.11 = -log10(eval.11), eval.6 = -log10(eval.6))])
summary(pgmy.e.clust)
summary(pgmy.e.clust, parameters=TRUE)
plot(pgmy.e.clust)

# use e value and id percentage
clust.pgmy.id.eval  <-  Mclust(id.eval.611[primer=="PGMY11", list( id.11,  log.eval.11,  id.6,  log.eval.6)]) #stipulated 4 groups since gp5 redenered 4 groups and becomes unmanageable with 5
summary(clust.pgmy.id.eval, parameters=TRUE)
id.eval.611[primer=="PGMY11", class:=clust.pgmy.id.eval$classification]
clust.gp.id.eval  <-  Mclust(id.eval.611[primer=="GP5", list( id.11,  log.eval.11,  id.6,  log.eval.6)])
summary(clust.gp.id.eval, , parameters=TRUE)
id.eval.611[primer=="GP5", class:=clust.gp.id.eval$classification]
id.eval.class <- data.table(dcast(data=id.eval.611, formula=rrpNum~primer, value.var="class"))
setkey(id.eval.class,rrpNum)
setcolorder(id.eval.class,neworder=c("rrpNum", "PGMY11", "GP5"))



#compare the classifications
table(pgmy.gp.class$classpgmy, pgmy.gp.class$classgp)
table(pgmy.gp.class$classpgmy, pgmy.gp.class$classimpute)
table(pgmy.gp.class$classgp, pgmy.gp.class$classimpute)
mclust_pgmy11$parameters$mean
mclust_gp5$parameters$mean
mclust_both.primers$parameters$mean

table(pgmy.gp.class$classpgmy, pgmy.gp.class$intuit.pgmy)
table(pgmy.gp.class$classgp, pgmy.gp.class$intuit.gp)

pgmy.gp.class[classpgmy==3,]
pgmy.gp.class[classgp==2,]

table(id.eval.class$PGMY11, id.eval.class$GP5, useNA="ifany", deparse.level = 2)
# abundantly clear that class 2 and 4 from PGMY11 and 1 and 2 from GP5 go together
# adundantly clear that class 3 from PGMY11 and class 3 from GP5 go together
# class 1 and 5 from PGMY11 and class 4 from GP5 seem to be outliers and we will explore if they are 611 and subject them to linear array
# THE NA will be allocated if confident call in the primer that was not used

# call HPV type based on cluster----------------
id.eval.class[(PGMY11==2|PGMY11==4)&(GP5==1|GP5==2),call:="6"]
id.eval.class[PGMY11==3 & GP5==3,call:="11"]
id.eval.class[PGMY11==1|PGMY11==5|GP5==4,call:="retest"]
id.eval.class[is.na(PGMY11)&(GP5==1|GP5==2), call:="6"]
id.eval.class[is.na(PGMY11)&GP5==3, call:="11"]
id.eval.class[is.na(GP5)&(PGMY11==2|PGMY11==4), call:="6"]
id.eval.class[is.na(GP5)&PGMY11==3, call:="11"]
data.table(rrpNum=1245, call="16", key="rrpNum")
id.eval.class  <- rbind(id.eval.class,data.table(rrpNum=1245, call="16",PGMY11=NA, GP5=NA, key="rrpNum"), use.names=TRUE)
setkey(id.eval.class,rrpNum)
hpv.call <- merge(x=id.eval.class, y=pgmy.gp.class)# merging the call from all the clustering techniques
# hpv.call[,intuit.gp] is simply using the the hightest blast id percentage against pgmy ABI reads using the intuitive technique laid out by Evan
# hpv.call[,intuit.pgmy] is simply using the the hightest blast id percentage against pgmy ABI reads using the intuitive technique laid out by Evan
# hpv.call[,call] is the call made when using Mclust on both the id and the e value of both the gp5 and pgmy11.
table(hpv.call[,call], useNA="ifany")
summary(factor(id.eval.class$call))
table(hpv.call[,intuit.gp],hpv.call[,intuit.pgmy], hpv.call[,call], useNA="ifany", deparse.level = 2)

#let see where thing go asunder
# lets see where e value and id percentage call said retest but both intuit agreed
hpv.call[call=="retest"&intuit.gp==intuit.pgmy,]


# write id and e eval call to the google docs database ALSo inform Evan what to restes
retest  <- hpv.call[call=="retest",rrpNum]#retest are probably 611 but should confirm with linear array
calls.by.ABI.cluster <- hpv.call[,list(rrpNum, call)]#used e value and percent identification to cluster each read and from there make the call
setnames(calls.by.ABI.cluster, c("nucleic.acid.nr", "hpvtype"))
setkey(calls.by.ABI.cluster,nucleic.acid.nr)
save(calls.by.ABI.cluster, file="C:/Users/Farrel/Google Drive/RRPGenetics/calls by ABI cluster.Rdata")