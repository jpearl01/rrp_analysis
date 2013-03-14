Clustering HPV types from HPV sequencing in papilloma biopsies
========================================================

This is an R Markdown document. Markdown is a simple formatting syntax for authoring web pages (click the **MD** toolbar button for help on Markdown).

For every sample two primers, PGMY11 and GP5, were used to pull sequence out.  Each sequence was aligned to 5 different reference sequences, using the fasta v36.5a program:

```
fasta36 -H -E 1 -n -Q -m 9 all_PGMY_050312_seqs.fasta all_references.fasta
```

This aligned each of the query (sample) sequences to each of the references and output a series of these records:

```
Query: all_PGMY_050312_seqs.fasta
  1>>>1528_GP5_C09 - 396 nt
Library: all_references.fasta
    39453 residues in     5 sequences

    39453 residues in     5 sequences
Statistics: (shuffled [23]) MLE statistics: Lambda= 0.1061;  K=0.00221
 statistics sampled from 5 (5) to 23 sequences
Algorithm: FASTA (3.7 Nov 2010) [optimized]
Parameters: +5/-4 matrix (5:-4), open/ext: -12/-4
 ktup: 6, E-join: 0.25 (0.7), E-opt: 0.05 (0.5), width:  16
 Scan time:  0.240

The best scores are:                                      opt bits E(5)  %_id  %_sim   bs  alen  an0  ax0  pn0  px0  an1  ax1 pn1 px1 gapq gapl  fs 
HPV11 Human papillomavirus type 11 (HPV-11), c (7931) [f] 1796 288.4 2.3e-80	0.986 0.995 1796  367   22  387    1  396 6791 7157    1 7931   1   0   0
HPV6b Human papillomavirus type 6b (HPV-6b), c (7902) [f] 1386 225.7 1.8e-61	0.863 0.872 1386  366   23  387    1  396 6807 7172    1 7902   1   0   0
HPV16 Human papillomavirus type 16 (), complet (7905) [f]  876 147.6 5.8e-38	0.715 0.723  876  372   23  387    1  396 6668 7036    1 7905   7   3   0
HPV18 Human papillomavirus type 18 (HPV-18), c (7857) [f]  771 131.5   4e-33	0.706 0.713  771  327   61  387    1  396 6689 7014    1 7857   0   1   0
HPV45 Human papillomavirus type 45 (HPV-45), c (7858) [f]  735 126.0 1.8e-31	0.667 0.672  735  372   23  387    1  396 6647 7018    1 7858   7   0   0
HPV16 Human papillomavirus type 16 (), complet (7905) [r]   73 24.7    0.55	0.727 0.727  100   44  359  317  396    1 3780 3823    1 7905   1   0   0
+-                                                          81 25.9    0.24	0.537 0.577   81  123  125   13  396    1 3576 3696    1 7905  10   2   0
HPV6b Human papillomavirus type 6b (HPV-6b), c (7902) [r]   69 24.1    0.82	0.667 0.667   72   36  192  157  396    1 7269 7304    1 7902   0   0   0
```


When you click the **Knit HTML** button a web page will be generated that includes both content as well as the output of any embedded R code chunks within the document.


```r
# Load up the data from the alignments
gp5_primer_samples_perc_id_only <- read.delim("P:/o_drive/Homes/epowell/RRP/HPV Typing/gp5_primer_samples_perc_id_only.tsv")
PGMY11_primer_samples_perc_id_only <- read.delim("P:/o_drive/Homes/epowell/RRP/HPV Typing/PGMY11_primer_samples_perc_id_only.tsv")
```


Now that the data has been read in. We will cluster. 
There are two primers used in analysis, pg5 and pgmy11.  Each has their own file which needs to be loaded and then clustered separately. The results of each primer was used to confirm the presenceof each organism via two different methodologies.***check with evan***


```r
require(mclust)
```

```
## Loading required package: mclust
```

```
## Package 'mclust' version 4.0
```

```r
mclust_gp5 <- Mclust(gp5_primer_samples_perc_id_only[2:6])
summary(mclust_gp5)
```

```
## ----------------------------------------------------
## Gaussian finite mixture model fitted by EM algorithm 
## ----------------------------------------------------
## 
## Mclust VVV (ellipsoidal, varying volume, shape, and orientation) model with 5 components:
## 
##  log.likelihood   n  df  BIC
##            3276 193 104 6005
## 
## Clustering table:
##  1  2  3  4  5 
## 28 40 54 57 14
```

```r
mclust_pgmy11 <- Mclust(PGMY11_primer_samples_perc_id_only[2:6])
summary(mclust_pgmy11)
```

```
## ----------------------------------------------------
## Gaussian finite mixture model fitted by EM algorithm 
## ----------------------------------------------------
## 
## Mclust VEV (ellipsoidal, equal shape) model with 4 components:
## 
##  log.likelihood   n df  BIC
##            3846 200 71 7316
## 
## Clustering table:
##  1  2  3  4 
## 71 17 64 48
```


