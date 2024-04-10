# Gender bias in Wikipedia Biographies of German Politicians

This repository contains R Mardowns that use the Comparative legislator Database in order to analyse the Wikipedia biographoes of German Politicians to examine gender asymmetries. This code is part of my master thesis as a student of the Master of Data Science for Public Policy at Hertie School, 2024. 

## Requirements

The raw and cleaned data is too big for github and can thus be found in this google drive foulder: https://drive.google.com/drive/u/0/folders/1gEd6ji1lLCFKnp0cOyAHSK_YQGQGXnXs?q=sharedwith:public%20parent:1gEd6ji1lLCFKnp0cOyAHSK_YQGQGXnXs

Before running the R Markdown documents, ensure you have installed R and RStudio. Also make sure to run the code in the setup.R file before working with the mardown files as this will assure that all necessary packages are installed.

## Structure

The repository is structured as follows:
**1. Aquire the wikipedia data** that I am working with
**2. Clean the data** and apply a matching strategy
**3. Conduct a descriptive analysis** of the data and visualise the results
**4. Conduct a PMI analysis** and save the resutls in the folder pmi_lists - these leists were then annotaded manually
**5. visualisation of the results** of the pmi analysis


## Credits

The code in step **4. Conduct a PMI analysis** is based on the code written by Eduardo Graells-Garrido and can be found in the following repository: https://github.com/clauwag/WikipediaGenderInequality/tree/master/notebooks
