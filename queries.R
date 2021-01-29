install.packages("DBI")
install.packages("RMySQL")
install.packages('dplyr')
install.packages('ggplot2')

library(DBI)
library(RMySQL)
library(dplyr)
library(ggplot2)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

data <- dbGetQuery(MyDataBase, "SELECT * FROM CountryLanguage")

df_es <- data %>%
  filter(Language == 'Spanish')

ggplot(df_es, aes(x = Percentage, y = CountryCode, fill = IsOfficial)) +
  geom_col() + 
  xlab("Porcentaje") + 
  ylab("País") + 
  ggtitle("Porcentaje de la población que habla español") + 
  labs(fill='Idioma Oficial') + 
  scale_fill_discrete(labels = c("Si", "No"))

