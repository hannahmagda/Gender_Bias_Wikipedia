# Gender bias in Wikipedia Biographies of German Politicians

This repository contains R Mardowns that use the Comparative legislator Database in order to analyse the Wikipedia biographoes of German Politicians to examine gender asymmetries. This code is part of my master thesis as a student of the Master of Data Science for Public Policy at Hertie School, 2024. 

# Executive Summary

Gender bias is a concern with wide-ranging societal implications. This applies in particular to platforms like Wikipedia that claim neutrality and are widely used to get information about politicians. This thesis focuses on investigating gender bias within Wikipedia biographies of German politicians and provides a monitoring technique. This is of academic as well as public interest since citizens often rely on Wikipedia for political information without awareness of possible biases. While previous studies have explored and indeed found gender biases on Wikipedia, they did not focus on specific occupational groups and did not employ advanced statistical methods to improve comparability across biographies. This research aims to bridge this gap by introducing a matching strategy prior to biography analysis, thus enhancing existing methodologies.
Using a Database containing diverse information about German politicians, each politician's Wikipedia article is collected. I analyse descriptive differences between male and female biographies and employ Pointwise Mutual Information to identify the most discriminative words for gender. Those words are annotated in one of four categories: \textit{Family}, \textit{Gender}, \textit{Relationship} and \textit{Other}. This method enables the measurement of gender bias within the texts. Additionally, I utilise version-controlled Wikipedia data to also observe possible shifts in biases over time.
The results of my analysis indicate that, after matching, there are no significant differences between the biographies of men and women.

## Code Requirements

All the data processing, statistical analyses, and visualizations were conducted using R, a programming language used for statistical computing and data analysis.
The raw and cleaned data is too big to be put on github and can thus either be replicated using script 1 and 2 or can be found in this google drive folder: https://drive.google.com/drive/u/0/folders/1gEd6ji1lLCFKnp0cOyAHSK_YQGQGXnXs

## Structure

The repository is structured as follows:  
**1. Aquire the wikipedia data** that I am working with  
**2. Clean the data** and **apply a matching strategy**  
**3. Conduct a descriptive analysis** of the data and visualise the results  
**4. Conduct a PMI analysis** and save the resutls in the folder pmi_lists - these lists were then annotaded manually  
**5. visualisation of the results** of the pmi analysis  


## Credits

The code in step **4. Conduct a PMI analysis** is strongly inspired by the code written by Eduardo Graells-Garrido and can be found in the following repository: https://github.com/clauwag/WikipediaGenderInequality/tree/master/notebooks
