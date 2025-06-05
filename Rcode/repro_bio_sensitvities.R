library(here)
library(r4ss)
library(dplyr)
library(purrr)
library(furrr)
library(ggplot2)

#testing ref folder

ref_model <- r4ss::SS_read(here::here('Document','report','ref_model'))
#this error:
#Multiple files in directory match pattern *.par, choosing based on the preferences described in the help for get_par_name(): ss3.par

#copied over the files from the google drive in models/base_model

#run base model

base_model_dir <- file.path(here::here('models','base_model'))

#add plots to base model folder

base_replist <- SS_output(dir = base_model_dir)
SS_plots(base_replist)


rcr_base_model_dir <- file.path(here::here('models','rcr_base_model'))

copy_SS_inputs(
  dir.old = base_model_dir, 
  dir.new = rcr_base_model_dir,
  create.dir = TRUE,
  overwrite = TRUE,
  use_ss_new = FALSE,
  verbose = TRUE
)

rcr_base_model <- r4ss::SS_read(here::here('models','rcr_base_model'))

r4ss::get_ss3_exe(dir = rcr_base_model_dir)

r4ss::run(dir = rcr_base_model_dir, show_in_console = TRUE, extras = "-nohess")

replist <- SS_output(dir = rcr_base_model_dir)

SS_plots(replist)

##############################################################

model_directory <- here::here(
  'models')
base_model_name <- here::here(
  'models',
  'rcr_base_model'
)
exe_loc <- here::here('models/rcr_base_model/ss3')
base_model <- SS_read(base_model_name, ss_new = TRUE)
base_out <- SS_output(base_model_name)