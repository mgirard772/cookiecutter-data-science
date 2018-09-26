project_root <- getwd()
data_dir <- file.path(project_root, "data")
sql_dir <- file.path(project_root, "src", "data", "sql")
exploratory_dir <- file.path(project_root, "src", "exploratory")

mm_getenv <- function(instance = Sys.getenv("instance")){
  #TODO Check for valid instance argument
  #TODO Check for presence and validity of environment variables (secrets)
  
  #Create initial list of variables
  env <- list(
    promote_server = dplyr::case_when(
      instance == "prod" ~ "http://promote.dsawsnprd.massmutual.com",
      TRUE ~ "http://promote.dsawsnprd.massmutual.com"
    ),
    model_service_server = dplyr::case_when(
      instance == "prod" ~ "https://model-service.prod-kube.dsawsprd.massmutual.com",
      TRUE ~ "https://model-service.dev-kube.dsawsnprd.massmutual.com"
    ),
    papi_server = dplyr::case_when(
      instance == "prod" ~ "https://advana.io",
      TRUE ~ "https://stage.advana.io"
    )
  )
  
  #Append list with variables that depend on variables previously defined
  env <- c(
    env,
    promote_url =
      sprintf(
        "%s/%s/models/%s/predict",
        env$promote_server,
        Sys.getenv("promote_username"),
        env$promote_model_name
      ),
    model_service_url = 
      sprintf(
        "%s/api/v1/models/%s/predict",
        env$model_service_server,
        env$promote_model_name
      )
  )
  
  return(env)
}

vert_connect <- function(){
  require(RJDBC)
  require(mmlib)
  require(dplyr)
  instance <- Sys.getenv("instance")
  vertica_instance <- case_when(
    instance == "prod" ~ "aws_prod",
    TRUE ~ "aws_qa"
  )
  
  vertica_setup(
    Sys.getenv("user"),
    Sys.getenv("pw"),
    server = vertica_instance
  )
}

#Smart function to save a query to file with the option to pull from that instead of Vertica
getData <- function(sql_string, refresh = FALSE, save = TRUE, data_file = NULL){
  require(mmlib)
  require(dplyr)
  require(RJDBC)
  require(readr)
  #refresh <- ifelse(Sys.getenv("refresh") == "FALSE", FALSE, TRUE)
  if(save){
    if(grepl(".sql$", sql_string) & is.null(data_file)){
      data_file <- gsub(".sql", ".rds", gsub(".*/", "", sql_string))
    }
    if(is.null(data_file)) stop("You must provide a data_file argument for raw queries")
    if(!grepl(".rds$", data_file)) stop("Invalid data_file name, must end with .rds")
  }
  if(file.exists(paste0(data_dir, data_file)) & !refresh){
    return(readRDS(paste0(data_dir, data_file)))
  }else {
    query <-
      ifelse(grepl(".sql$", sql_string), readr::read_file(sql_string), sql_string)
    vert_connect()
    data <- mmlib::get_query(query)
    if(save) saveRDS(data, paste0(data_dir, data_file))
    dbDisconnect(mmlib:::package_settings$db)
    return(data)
  }
}

deploy_app <- function(appName, instance = "dev", app_dir){
  require(rsconnect)
  if(is.null(instance)) stop("Instance cannot be NULL")
  if(is.na(instance)) stop("Instance cannot be NA")
  if(!(instance %in% c("dev", "prod"))) stop("Instance must be dev or prod")
  cat("Deploy App: ", paste0(appName, "_", instance), "\n")
  cat("Vertica Instance: ", instance, "\n")
  setwd(app_dir)
  system("cp .Renviron .Renviron_temp")
  system(
    paste0(
      "echo instance='", instance, "' >> .Renviron"
    )
  )
  rsconnect::deployApp(appName = paste0(appName, "_", instance), forceUpdate = TRUE)
  system("cp .Renviron_temp .Renviron")
  system("rm .Renviron_temp")
}
