
install.packages('dsBaseClient', repos=c(getOption('repos'), 'https://cran.obiba.org'))
install.packages('DSOpal')
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


# Then perform login in each server

#connections <- datashield.login(logins=logindata,opts = list(ssl_verifyhost=0, ssl_verifypeer=0))
connections <- datashield.login(logins=logindata)




#get list of project name and resource names
datashield.resources(connections)

project_name = 'TestDatashield'

table_name= "DataShield_TestGex_reduced_datasize"

project_table_name = paste(project_name, table_name, sep = ".")

#Assign resource object
DSI::datashield.assign.resource(conns = connections, "rse_resource", project_table_name)
ds.class("rse_resource")

# Retrieve data from resource object and assign to variable symbol D
DSI::datashield.assign.expr(conns = connections, symbol = "D",
                            expr = as.symbol("as.resource.object(rse_resource)"))

ds.class("D")
ds.dim("D")

datashield.symbols(connections) #View Opal variables symbol 

ds.summary(x='D',datasources = connections[1]) #view data summary/dictionary

#perform mean and aggregated result from all server
ds.mean(x='D',type='combine' )

#perform mean on each server 
#ds.mean(x='D',type='split',datasources = connections[2])
ds.mean(x='D',type='split',datasources = connections[1])

#ds.length(x='D',type='split',datasources = connections[2])
ds.length(x='D',type='split',datasources = connections[1])


opal.logout(connections)
rm(connections)

