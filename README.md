# Mobile Device User Behavior Analysis

This project focuses on analyzing mobile device usage patterns to understand user behaviors based on a dataset containing demographic and device usage information. The analysis includes exploring relationships between app usage, screen-on time, battery drain, and other metrics, with the goal of gaining insights into different user behavior classes.

## Getting Started

To get started, you need to build the Docker image and run an RStudio instance inside a container.

### Prerequisites

- Docker installed on your system.
- Recommended: macOS with an M3 chip. If using a different platform (e.g., Windows), adjust the Dockerfile to match your specific platform.

### Build Docker Image

To build the Docker image, run the following command:

```sh
docker build . -t kz611
```

### Run RStudio in Docker Container

To start RStudio using the built Docker image, use the command below:

```sh
docker run -d -e PASSWORD=yourpassword --rm -p 8788:8788 -p 8787:8787 -v $(pwd):/home/rstudio/project -t kz611
```

Once RStudio is running, you can connect to it by visiting:

```
http://localhost:8787
```

Enter the password you provided to access RStudio.

## Building Reports

### Interactive Report (Shiny App)

The project includes an interactive report generated using Shiny. To build the interactive report, open the terminal in RStudio and type:

```sh
make report.html
```

After running the command, visit the following URL to view the interactive report:

```
http://localhost:8788
```

### Static Report (PDF)

To build the static version of the final report in PDF format, use the following command in the terminal within RStudio:

```sh
make report_static.pdf
```

## Project Overview

This analysis aims to explore mobile device usage behaviors using various machine learning techniques, including clustering and classification. The report covers key insights such as differences in app usage across demographics, battery consumption across devices, and the impact of age and gender on user behavior.

### Key Features

- **Data Cleaning and Preparation**: The dataset undergoes cleaning to remove inconsistencies and prepare it for analysis.
- **Clustering and Classification**: Machine learning techniques such as K-Means and hierarchical clustering are used to group users based on behavior, while classification models predict user behavior classes.
- **Interactive Visualization**: The final report includes interactive components built using Shiny to facilitate better exploration of relationships within the data.

## Directory Structure

- **Dockerfile**: Contains the instructions for building the Docker image for running RStudio and related tools.
- **Makefile**: Automates the process of generating reports, including both interactive and static versions.
- **report_writeup.Rmd**: The main RMarkdown file used for generating the reports.
- **figures/**: Directory containing all generated plots used in the report.
- **derived_data/**: Directory for storing processed data used in analysis.

## Notes

- The Docker container binds to the current working directory, making it easy to work with your local files.
- Ensure that your Docker setup allows port forwarding to access the RStudio and Shiny applications from your browser.


## Acknowledgements

- **rocker/verse** Docker image for providing a convenient R environment.
- The dataset used in this analysis is sourced from Kaggle.

---
Feel free to explore the code and modify it according to your needs. If you encounter any issues, please open an issue in the repository.
