
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


check_pw_format = function(password, user) 
{
  pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[@$!%*?&])[A-Za-z0-9@$!%*?&]{8,}$"
  # Check password validity
  is_valid <- grepl(pattern, password, perl = TRUE) & !is.na(password)
  
  if (is_valid) {
    message(paste("User:", user, "- The password is valid."))
    return(TRUE)
  } else {
    message(paste("User:", user, "- has an invalid password!"))
    return(FALSE)
  }
}

user_name="user-test"
password= 'P@ssw0rd'
groups= c('opal-user')

#check password to create user. 
#check_pw_format("Passw0rd!", "Alice")  # Valid password (TRUE)
#check_pw_format("password", "Bob")     # Invalid password (FALSE)
#check_pw_format("Short1!", "Charlie")  # Invalid (too short)
#check_pw_format(NA, "Dave")            # Invalid (missing)

check_pw_format(password,user_name) #Valid 

#if new user create and add permission.
if(!oadmin.user_exists(connections,user_name))
  {
  
    oadmin.user_add(connections,name = user_name, password = password, groups = groups)  

    if(oadmin.user_exists(connections,user_name))
    {
      #give permission to use datashield to perform analysis
      dsadmin.perm_add(connections, subject = groups , type = "group", permission = "use")
      # verify permissions
      dsadmin.perm(connections)

      #oadmin.system_perm_add(connections, subject = group, type = "group", permission = "project_add")
    }
  }

opal.logout(connections)
rm(connections)
