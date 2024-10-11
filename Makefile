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

figures/app_usage_vs_battery.png:\
 derived_data/cleaned_user_behavior.csv\
 create_app_usage_vs_battery.R
	Rscript create_app_usage_vs_battery.R


figures/data_usage_by_device.png:\
 derived_data/cleaned_user_behavior.csv\
 create_data_usage_by_device.R
	Rscript create_data_usage_by_device.R

figures/app_usage_by_gender.png:\
 derived_data/cleaned_user_behavior.csv\
 create_app_usage_by_gender.R
	Rscript create_app_usage_by_gender.R

figures/battery_data_clusters.png:\
 derived_data/cleaned_user_behavior.csv\
 create_battery_data_clusters.R
	Rscript create_battery_data_clusters.R

figures/behavioral_clusters.png:\
 derived_data/cleaned_user_behavior.csv\
 create_behavioral_clusters.R
	Rscript create_behavioral_clusters.R

figures/os_clusters_by_demographics.png:\
 derived_data/cleaned_user_behavior.csv\
 create_os_clusters_by_demographics.R
	Rscript create_os_clusters_by_demographics.R

figures/age_vs_num_apps.png:\
 derived_data/cleaned_user_behavior.csv\
 create_age_vs_num_apps.R
	Rscript create_age_vs_num_apps.R