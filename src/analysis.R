source("preprocessing.R")
install.packages("stargazer")
library(stargazer)
# create a model for the blockchain
blockchain_model <- lm(as.numeric(Blockchain)~factor(LearnCode) + WorkExp, data=df_split)
blockchain_modelbin <- lm(as.numeric(Blockchain)~factor(LearnCode) + factor(WorkExpBin), data=df_split)
# outputs a latex code
stargazer(blockchain_model, out="blockchain.tex")

stargazer(blockchain_modelbin, out="blockchain.tex")

GenderModel <- lm(WorkExp~factor(Gender), data=df_whole)
summary(GenderModel)
stargazer(GenderModel, out="gender.tex")

mentalHealth <- lm(WorkExp ~ MentalHealth, data = df_split)
summary(mentalHealth)
stargazer(mentalHealth, out="gender.tex")

work_exp <- lm(WorkExp ~ Factor(LearnCode), data = df_split)
summary(work_exp)
stargazer(work_exp)
