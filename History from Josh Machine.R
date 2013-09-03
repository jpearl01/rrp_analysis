# start of HPV typing categorizing---------------------------------
PGMY11_primer_samples_perc_id_only <- read.delim("P:/o_drive/Homes/epowell/RRP/HPV Typing/PGMY11_primer_samples_perc_id_only.tsv")
gp5_primer_samples_perc_id_only <- read.delim("P:/o_drive/Homes/epowell/RRP/HPV Typing/gp5_primer_samples_perc_id_only.tsv")
data<-read.table("P:\\o_drive\\Homes\\epowell\\RRP\\all_against_all_matrix_ggsearch", header=TRUE, sep=" ")# all against all but not sure what to do with it

require(mclust)
require(devtools)
require(data.table)

pgmy11.fasta  <- data.table(PGMY11_primer_samples_perc_id_only, key = "rrpNum") 
gp5.fasta  <- data.table(gp5_primer_samples_perc_id_only, key = "rrpNum") 


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


