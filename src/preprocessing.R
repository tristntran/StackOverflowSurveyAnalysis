library(readr)
library(MASS)
library(reshape2)
library(tidyr)
library(dplyr)
#===============================================================================
df <- read_csv("stack-overflow-developer-survey-2022/survey_results_public.csv") %>%
  drop_na(c(ResponseId, LearnCode, TimeAnswering,
            TimeSearching, MentalHealth, Age, Blockchain,
            Gender, WorkExp, SOPartFreq, SOVisitFreq,
            LanguageHaveWorkedWith, MainBranch, WorkExp)) %>%
            mutate(WorkExpBin = cut(WorkExp, breaks=seq(0,50,5)))
df$Blockchain <- factor(df$Blockchain, 
                        levels=c("Very unfavorable",
                                 "Unfavorable",
                                 "Indifferent",
                                 "Favorable" ,
                                 "Very favorable"))
df$Gender = as.factor(
  ifelse(df$Gender %in% c('Man','Woman', "Prefer not to say"),
         as.character(df$Gender),
         "Other"
         )
  )
df_whole <- df %>% mutate(nLanguagesWant = count.fields(textConnection(LanguageWantToWorkWith),
                                                    sep = ";"),
                      nLanguageHaveWorkedWith = count.fields(textConnection(LanguageHaveWorkedWith), 
                                                             sep = ";"),
                      isMan = ifelse(Gender == "Man", "Man", "Other"))
# bin for the work exp
# order age by factor
# handle NAs
# bin users
df_split <- df %>% tidyr::separate_rows(LearnCode, sep = ";") %>%
  tidyr::separate_rows(MentalHealth, sep = ";") %>%
  tidyr::separate_rows(LanguageHaveWorkedWith, sep = ";")

# TODO do GENDER processing
df_whole <- df_whole %>% dplyr::select(ResponseId, LearnCode, TimeAnswering,
                            TimeSearching, MentalHealth, Age, Blockchain,
                            Gender, WorkExp, SOPartFreq, SOVisitFreq, LanguageHaveWorkedWith,
                            nLanguagesWant, nLanguageHaveWorkedWith, MainBranch, WorkExpBin, isMan)
df_split <- df_split %>% dplyr::select(ResponseId, LearnCode, TimeAnswering,
              TimeSearching, MentalHealth, Age, Blockchain,
              Gender, WorkExp, SOPartFreq, SOVisitFreq,
              LanguageHaveWorkedWith, MainBranch, WorkExpBin)
