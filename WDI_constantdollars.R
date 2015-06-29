# This code downloads foreign direct investment (BX.KLT.DINV.CD.WD) and external debt stocks (DT.DOD.DECT.CD), which are given by the World Bank's World Development Indicators, in current dollar terms.

# It uses the GDP deflator for the U.S. (NY.GDP.DEFL.ZS) to convert these values into constant dollars, base year 2005.

# It can be used to convert any indicators from WDI from current to constant dollars, by replacing the indicators in the WDI command as well as the newvars name vector.

library('WDI')
remove(list=ls())

dat <- WDI(indicator=c('BX.KLT.DINV.CD.WD','DT.DOD.DECT.CD', 'NY.GDP.DEFL.ZS'),country='all', start = 1980, end=2013)
head(dat)

us = dat$NY.GDP.DEFL.ZS[dat$country=="United States"]
vars = names(dat[4:5])
newvars = c('fdi','dod')

for (i in unique(dat$country)) {
  
  for (j in 1:length(names(dat[4:5]))) {
    
    dat[dat$country==i,newvars[j]] <- dat[dat$country==i,vars[j]]*100/us
    
    message(j,i)
    
  }
}

table(dat$dod,exclude=NULL) # look at how many NAs there are for dod, for instance (make sure that these are also instances where the original variable has NAs)


  
  
  
  
