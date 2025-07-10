# Install required packages
install.packages("devtools")
library(devtools)
devtools::install_github("mbannert/panelaggregation")
install.packages('dsBaseClient', repos=c(getOption('repos'), 'https://cran.obiba.org'))
install.packages("DSOpal")
