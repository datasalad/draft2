setwd("~/Desktop/draft2/")
library(dplyr)

data <- readRDS("dataraw.rds")
d <- tbl_df(data)

dmg_mult <- sort(unique(tolower(d$PROPDMGEXP)))

mult <- tibble(key = dmg_mult, 
               value = c(1, 0, 0, 0, 1, 10, 100, 1000, 10000, 1e+05, 1e+06, 1e+07, 1e+08, 1e+09, 100, 1000, 1e+06))

convert_dmg <- function(val, e) {
    mult <- tibble(key = dmg_mult, 
                   value = c(1, 0, 0, 0, 1, 10, 100, 1000, 10000, 1e+05, 1e+06, 1e+07, 1e+08, 1e+09, 100, 1000, 1e+06))
    
    m <- filter(mult, key == tolower(e))$value
    z <- val * as.numeric(m)
    z
}

##d <- mutate(d, prop_dmg = PROPDMG * 1)

mutate(d, prop_dmg = convert_dmg(PROPDMG, PROPDMGEXP))
