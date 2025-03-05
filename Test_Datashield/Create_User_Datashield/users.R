
install.packages('dsBaseClient', repos=c(getOption('repos'), 'https://cran.obiba.org'))
install.packages('DSOpal')


# Load DataSHIELD base package
library(dsBaseClient)
library('DSOpal')
library(opalr)


url="https://hpcb-mmusculus.di.univr.it"
user_name='administrator'
password= 'administrator'

#connect to server 
connections <- opal.login(user_name,password, url=url)



user_name="user-test"
password= 'P@ssw0rd'
groups= c('opal-user')

#if new user create and add permission.
if(!oadmin.user_exists(connections,user_name))
  {
    oadmin.user_add(connections,name = user_name, password = password, groups = groups)  

    if(oadmin.user_exists(connections,user_name))
    {
      # add datashield permission to group
      dsadmin.perm_add(connections, subject = groups , type = "group", permission = "use")
      # verify permissions
      dsadmin.perm(connections)

    }
  }

opal.logout(connections)
rm(connections)
