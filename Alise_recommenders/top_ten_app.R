library(dplyr)
library(tidyr)
library(readr)

# ----------------------------------
# load dataset users
dataset_users <- read_csv("user_info/Info_users_all_2020_05_01.csv") 
dataset_u1 <- read_csv("user_info/App_runs_by_users_2020_05_01.csv") %>% rename(nb_run_app=count)
dataset_u2 <- read_csv("user_info/user_ratings_2020_05_01.csv") 

# correct the usernames
dataset_u1 <- dataset_u1 %>% mutate_if(is.character, stringr::str_replace_all, 
                                       pattern = "@iplantcollaborative.org", replacement = "")
dataset_u2 <- dataset_u2 %>% mutate_if(is.character, stringr::str_replace_all, 
                                       pattern = "@iplantcollaborative.org", replacement = "")


# merge app and users
# create dataset for App runs + ratings for users
dataset_app_all <- inner_join(dataset_u1, dataset_u2, by=c("user_id", "app_id", "username"))
dataset_app_all <- dataset_app_all %>% select(-id_v192)

# merge with user info table
user_domain <- dataset_users %>% select(username, research_area_id)
app_udomain <- inner_join(user_domain, dataset_app_all, by= "username")

# gather by domain
app_domain <- app_udomain %>% select(research_area_id, app_name, app_id, nb_run_app) %>% 
  group_by(research_area_id, app_id) %>% mutate(runs_by_domain=sum(nb_run_app)) %>%
  select(-nb_run_app) %>% unique()


# print csv
write.csv(data_merge, "countsapp_by_domain.csv", row.names=FALSE)


