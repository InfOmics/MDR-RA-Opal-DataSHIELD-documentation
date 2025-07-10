
# install.packages('dsBaseClient', repos=c(getOption('repos'), 'https://cran.obiba.org'))
# install.packages('DSOpal')


# Load DataSHIELD base package
library(dsBaseClient)
library('DSOpal')
library(opalr)


url="https://your-domain.com"
user_name='administrator'
password= 'administrator'

#connect to server 
connections <- opal.login(user_name,password, url=url)
setwd("MDR-RA-Opal-DataSHIELD-documentation/Test_Datashield") #set the working directory to Test_Datashield so as to be able to get correct path to data
project_name = 'TestDatashield'
local_file_path= "Data/DataShield_TestGex_10_rows.RData"
file_name="DataShield_TestGex_10_rows.RData"
users = c('opal-user')

#create project
if(!opal.project_exists(connections,project_name)){
  opal.project_create(connections, project_name, database = "postgresdb")
}

server_path = paste("/projects", project_name, collapse = "", sep = "/")
opal.file_upload(connections, local_file_path, server_path)
filename_parts <- strsplit(file_name, "\\.")[[1]]
if (length(filename_parts) > 2) {
  resource_name <- paste(filename_parts[1:(length(filename_parts) - 1)], collapse = "_")
  extension <- filename_parts[length(filename_parts)]
} else {
  resource_name <- filename_parts[1]
  extension <- filename_parts[2]
}
#create resource secret
token <- opal.token_r_create(connections, resource_name, projects = project_name)
#load data as resource  
opal.resource_create(connections,  project_name , resource_name, url = paste("opal+", url, "/ws/files", server_path, "/", file_name, sep=""), format = "matrix", secret = token)
opal.resource_get(connections, project_name, resource_name)
#give permission to perform analysis
opal.resource_perm_add(connections,  project_name, resource_name, subject = users, type = "group", permission = "view")


opal.logout(connections)
rm(connections)
