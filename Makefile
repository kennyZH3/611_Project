.PHONY: clean
.PHONY: init

init:
	mkdir -p derived_data
	mkdir -p figures
	mkdir -p logs

clean:
	rm -rf derived_data
	rm -rf figures
	rm -rf logs
	mkdir -p derived_data
	mkdir -p figures
	mkdir -p logs

derived_data/cleaned_user_behavior.csv:\
 user_behavior_dataset.csv\
 tidy_data.R
	Rscript tidy_data.R

figures/user_behavior_summary.png:\
 derived_data/cleaned_user_behavior.csv\
 variables_overview.R
	Rscript variables_overview.R

figures/app_usage_vs_battery.png:\
 derived_data/cleaned_user_behavior.csv\
 create_app_usage_vs_battery.R
	Rscript create_app_usage_vs_battery.R


figures/data_usage_by_device_gender.png:\
 derived_data/cleaned_user_behavior.csv\
 create_data_usage_by_device_gender.R
	Rscript create_data_usage_by_device_gender.R

figures/app_usage_by_gender.png:\
 derived_data/cleaned_user_behavior.csv\
 create_app_usage_by_gender.R
	Rscript create_app_usage_by_gender.R

figures/battery_data_by_phone.png:\
 derived_data/cleaned_user_behavior.csv\
 create_battery_data_by_phone.R
	Rscript create_battery_data_by_phone.R

figures/behavioral_clusters.png:\
 derived_data/cleaned_user_behavior.csv\
 create_behavioral_clusters.R
	Rscript create_behavioral_clusters.R

figures/classification.png:\
 derived_data/cleaned_user_behavior.csv\
 create_classification.R
	Rscript create_classification.R

figures/age_vs_num_apps.png:\
 derived_data/cleaned_user_behavior.csv\
 create_age_vs_num_apps.R
	Rscript create_age_vs_num_apps.R

report.html:\
 derived_data/cleaned_user_behavior.csv\
 figures/user_behavior_summary.png\
 figures/app_usage_vs_battery.png\
 figures/data_usage_by_device_gender.png\
 figures/app_usage_by_gender.png\
 figures/battery_data_by_phone.png\
 figures/behavioral_clusters.png\
 figures/classification.png\
 figures/age_vs_num_apps.png\
 report_writeup.Rmd
	Rscript -e "rmarkdown::run('report_writeup.Rmd',shiny_args = list(host = '0.0.0.0', port = 8788))"

report_static.pdf:\
 derived_data/cleaned_user_behavior.csv\
 figures/user_behavior_summary.png\
 figures/app_usage_vs_battery.png\
 figures/data_usage_by_device_gender.png\
 figures/app_usage_by_gender.png\
 figures/battery_data_by_phone.png\
 figures/behavioral_clusters.png\
 figures/classification.png\
 figures/age_vs_num_apps.png\
 report_static.Rmd
	Rscript -e "rmarkdown::render('report_static.Rmd', output_format='pdf_document')"

 
 
