
# install.packages('dsBaseClient', repos=c(getOption('repos'), 'https://cran.obiba.org'))
# install.packages('DSOpal')

# Load DataSHIELD base package
library(dsBaseClient)
library('DSOpal')
library(opalr)

url1="https://your-domain.com"
user_name1='user-test'
password1= 'P@ssw0rd'

builder <- DSI::newDSLoginBuilder()
builder$append(server="server1", url=url1,
                user=user_name1, password=password1)
#builder$append(server="server2", url=url2,
 #               user=user_name2, password=password2)

logindata <- builder$build()

# Perform login in each server


connections <- datashield.login(logins=logindata)

datashield.tables(connections) #get list of project name and table names


project_name = 'TestDatashield'
table_name= "DataShield_iris"
project_table_name = paste(project_name, table_name, sep = ".")



# assign Opal tables to symbol D
datashield.assign.table(connections, symbol = "D",
                        table = list(server1 = project_table_name))

#datashield.assign.table(connections, symbol = "D",
#                        table = list(server1 = project_table_name,  server2 = project_table_name))

datashield.symbols(connections) #View Opal variables symbol 

ds.summary(x='D',datasources = connections[1]) #view data summary/dictionary

#perform mean and aggregated result from all server
ds.mean(x='D$Sepal.Width',type='combine' )

#perform mean on each server 
#ds.mean(x='D$Sepal.Width',type='split',datasources = connections[2])
ds.mean(x='D$Sepal.Width',type='split',datasources = connections[1]) 

#ds.length(x='D',type='split',datasources = connections[2])
ds.length(x='D',type='split',datasources = connections[1])

ds.mean(x='D$Petal.Length',type='combine')
ds.mean(x='D$Petal.Width',type='combine')

cally <- paste0("meanDS(", 'D$Petal.Width', ")")

mean.local <- datashield.aggregate(connections, as.symbol(cally))

mean.local


datashield.logout(connections)
rm(connections)


