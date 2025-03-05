
install.packages('dsBaseClient', repos=c(getOption('repos'), 'https://cran.obiba.org'))
install.packages('DSOpal')


# Load DataSHIELD base package
library(dsBaseClient)
library('DSOpal')
library(opalr)


url="https://your-domain.com"
user_name='administrator'
password= 'administrator'

#connect to server 
connections <- opal.login(user_name,password, url=url)

project_name = 'TestDatashield'

users = c('opal-user')

#create project
if(!opal.project_exists(connections,project_name)){
  opal.project_create(connections, project_name, database = "postgresdb")
}

resource_name <- "DataShield_TestGex_reduced_datasize"
resource_url='https://github.com/InfOmics/MDR-RA-Opal-DataSHIELD-documentation/raw/refs/heads/main/Test_Datashield/Data/DataShield_TestGex_10row.rda'

#load data as resource   
opal.resource_create(connections,  project_name , resource_name, url = resource_url, format = "matrix")
#give permission to perform analysis
opal.resource_perm_add(connections,  project_name, resource_name, subject = users, type = "group", permission = "view")



opal.logout(connections)
rm(connections)