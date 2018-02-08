library(digest)

sql_dir <- paste0(Sys.getenv("PROJECT_ROOT"), "/src/data/sql/")

#Add user with username (user) and password (pw), prevent duplicate users
#Password is stored securely as an MD5 hash
addUser <- function(user, pw){
  source(paste0(sql_dir, "vertica_connect.R"))
  query <- paste0("SELECT username FROM ", Sys.getenv("credentials_location"))
  users <- dbGetQuery(db, query)
  if(user %in% users$username){
    dbDisconnect(db)
    stop(paste0("User ", user, " already exists. Select a different username."))
  }
  else{
    pw <- digest(pw, algo = "md5")
    query <- paste0("INSERT INTO ", Sys.getenv("credentials_location"), " VALUES (?,?);")
    dbSendUpdate(db, query, user, pw)
    dbDisconnect(db)
  }

}

#Get a list of users and their hashed passwords
getUsers <- function(){
  source(paste0(sql_dir, "vertica_connect.R"))
  query <- paste0("SELECT * FROM ", Sys.getenv("credentials_location"), ";")
  users <- dbGetQuery(db, query)
  dbDisconnect(db)
  return(users)
}

#Remove a user with username user
removeUser <- function(user){
  source(paste0(sql_dir, "vertica_connect.R"))
  query <- paste0(
    "DELETE FROM ", Sys.getenv("credentials_location"), " WHERE username='",
    user,
    "';"
  )
  dbSendUpdate(db, query)
  dbDisconnect(db)
}


