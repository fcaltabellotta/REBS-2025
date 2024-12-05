
library(asar)
library(satf)

asar::convert_output(
  output_file = "Report.sso",
  outdir = "C:/Users/Jason.Cope/Documents/Github/REBS-2025/Document",
  model = "ss3",
  file_save = TRUE,
  savedir = "C:/Users/Jason.Cope/Documents/Github/REBS-2025/Document",
  save_name = "reye_blkspt_convert_output")

asar::create_template(
  format = "pdf",
  office = "NWFSC",
  region = "U.S. West Coast",
  species = "Rougheye and Blackspotted Rockfishes",
  complex=TRUE,
  spp_latin = "Sebastes aleutianus",
  year = 2025,
  file_dir = "C:/Users/Jason.Cope/Documents/Github/REBS-2025/Document/",
  author = c("Jason M. Cope", "Vladlena Gertseva", "Fabio Caltabellotta", "Claire Rosemond", "Alison D. Whitman"),
  include_affiliation = TRUE,
  simple_affiliation = FALSE,
  #param_names = c("nf","sf"),
  #param_values = c("Trawl", "Hook-and_line","At-sea Hake","Foreign catches"),
  resdir = "C:/Users/Jason.Cope/Documents/Github/REBS-2025/Document",
  model_results = "reye_blkspt_convert_output.csv"
  #model = "SS3"
)

