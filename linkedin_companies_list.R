# Author - Ankit Agarwal
# Get name of the companies that have been listed on Linkedin by users

# URL of the LinkedIn Company directory page for companies that have names starting from a
# will be of this format
#
#user_url <- "https://www.linkedin.com/directory/companies-a/"
#
# since the information isn't available without being logged in, the web
# scraper needs to log in. Provide your LinkedIn user/pw here (this isn't stored
# anywhere as you can see, it's just used to log in during the scrape session)
#
username <- "userid"              #Your linkedin userid
password <- "password"            #Your Linkedin Password

# takes a couple seconds and might throw a warning, but ignore the warning
# (linkedin_info <- scrape_linkedin(user_url))

############################

library(rvest)

#scrape_linkedin <- function(user_url) {
  linkedin_url <- "http://linkedin.com/"
  pgsession <- html_session(linkedin_url) 
  pgform <- html_form(pgsession)[[1]]
  filled_form <- set_values(pgform,
                            session_key = username, 
                            session_password = password)
  
  submit_form(pgsession, filled_form)
  complist <- as.character(0)
  url <- as.character("https://www.linkedin.com/directory/companies-")
  alpha <- letters
  for (i in alpha) {
    
    
    # URL of the LinkedIn page 
    user_url<-paste0(url,i,"/",sep = '')
    print(user_url) 
    pgsession <- jump_to(pgsession, user_url)
    page_html <- read_html(pgsession)
#}
    name <- page_html %>% html_nodes("a") %>% html_text()
    name <- name[-(1:35)]
    name <- name[-((length(name) - 45):length(name))]
    complist <- c(complist,name)
  }
    
  setwd("C:\\Ankit\\Deloitte\\IDO\\")
  write.csv(complist, file = "companies_list.csv", row.names = F)