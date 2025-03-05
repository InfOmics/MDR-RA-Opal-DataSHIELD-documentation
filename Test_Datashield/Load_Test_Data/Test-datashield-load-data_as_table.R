
install.packages('dsBaseClient', repos=c(getOption('repos'), 'https://cran.obiba.org'))
install.packages('DSOpal')

# Load DataSHIELD base package
library(dsBaseClient)
library('DSOpal')
library(tibble)
data("iris")

url="https://hpcb-mmusculus.di.univr.it"
user_name='administrator'
password= 'administrator'

#connect to server 
connections <- opal.login(user_name,password, url=url)

#upload to table function
upload_table_iris = function(connections,data, table_name, project_name, users){
  data         <- as_tibble(data, rownames = '_row_id_')
  opal.table_save(connections, data, project = project_name, table =table_name, id.name = "_row_id_", force = TRUE)
  opal.table_perm_add(connections, project_name, table_name, subject = users, type = "group", permission = "view")
}


project_name = 'TestDatashield'
table_name= "DataShield_iris"
users = c('opal-user')


#create project
if(!opal.project_exists(connections,project_name)){
      opal.project_create(connections, project_name, database = "postgresdb")
    }

#upload iris data to Datashield project table
upload_table_iris(connections,iris, table_name, project_name , users)


opal.logout(connections)
rm(connections)