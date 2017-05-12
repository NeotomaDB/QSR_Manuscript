# QSR_Manuscript
Repository for scripts and figures associated with Neotoma ms. to be submitted to QSR

## Scraping Data from Neotoma
Outcome: This process will generate a flat csv text file with six columns: datasetID, levels (rows in count matrix), taxa (columns in count matrix), occs (rows * columns in count matrix), date (of submission to NeotomaDB), dataset type. 

- Open a terminal/shell with python in the path
- ```cd``` in the ```/scripts``` directory. 
- ```python get_neotoma_ds_summaries.py /name/of/file/to/dump/into.csv```. This will run the scraper, dumping contents into the filename specified. Warning: this will erase and overwrite the file if it already exists. 

## Summarizing and Cleaning the Data
Outcome: This process will generate a CSV with cumulative sums for each year in the dataset

- Open RStudio 
- Open the file ```summarize_records.R```
- Set the working directory 
- Set the input file to the file you generated in step 1
- Run the script

## Plotting the data
Outcome: This will produce a stacked line chart of the data in the summaries, generated during step 2.

- Open RStudio
- Open the file ```plot_summaries.R```
- Set the working directory
- Run the script.
- Save the output from the graphics window in RStudio.
