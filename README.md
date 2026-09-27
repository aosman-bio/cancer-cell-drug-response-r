# Longitudinal PC9 Cell-Count Response to Erlotinib

## Research question

**How does increasing erlotinib concentration alter cell-count trajectories across PC9 cells?**

## Project overview

This project uses R to analyse publicly available longitudinal cancer-cell drug-response data.

The analysis focuses on PC9 cancer cells treated with different concentrations of erlotinib. Cell counts were measured repeatedly over approximately five days using fluorescence microscopy-derived measurements (Tyson et al., 2026; Harris et al., 2016).

The aim was to explore whether increasing erlotinib concentration was associated with changes in cell-count trajectories and endpoint cell counts.

The analysis includes:

* Data exploration and filtering
* Longitudinal data summarisation
* Calculation of means and standard deviations
* Data visualisation using `ggplot2`
* Endpoint concentration-response analysis
* Spearman rank correlation
* Biological interpretation of the results
* Consideration of experimental limitations and reproducibility

This is an exploratory biological data-analysis project rather than an attempt to establish a causal drug mechanism.

## Background

Erlotinib is an epidermal growth factor receptor (EGFR) tyrosine kinase inhibitor used to investigate EGFR-dependent signalling and drug response in cancer cells (Chen et al., 2012).

PC9 is an EGFR-mutant non-small-cell lung cancer (NSCLC) cell line that has been widely used as a model for studying responses to EGFR-targeted therapies. Previous research has demonstrated that PC9 cells harbour activating EGFR mutations and can show sensitivity to EGFR-targeted tyrosine kinase inhibitors such as erlotinib (Chen et al., 2012).

The underlying dataset contains cell-count measurements derived from fluorescence microscopy of cancer cells expressing nuclear-localised fluorescent proteins. This allows cell counts to be measured repeatedly over time during drug exposure (Tyson et al., 2026; Harris et al., 2016).

Cell count provides a measure of cellular accumulation, but does not directly distinguish between reduced proliferation, increased cell death or other biological processes.

## Why this subset and question?

The original dataset contains longitudinal measurements from multiple cancer cell lines treated with a panel of oncology drugs at different concentrations (Tyson et al., 2026).

Rather than analysing the entire dataset, this project focuses on one cell line and one drug to allow a focused concentration-response analysis.

During initial exploration of the dataset, the different cell lines were found to have different final measurement times. There was therefore no single time point at which all seven cell lines could be directly compared using their final measurements.

Rather than forcing a comparison between cell lines at different time points, the analysis was narrowed to PC9 cells, for which a consistent final measurement time of 112.4 hours was available for the selected erlotinib treatment.

PC9 cells and erlotinib were selected to provide a biologically relevant model for investigating how increasing drug concentration is associated with cancer-cell growth.

The question was therefore narrowed to whether increasing erlotinib concentration is associated with changes in PC9 cell-count trajectories and endpoint cell counts.

## Dataset

The data were obtained from the publicly available Zenodo dataset:

**Tyson et al. (2026), "Longitudinal responses of human cancer cell lines to oncology drugs", Zenodo record 18292967.**

The dataset contains cell-count measurements generated from fluorescence microscopy of human cancer cell lines treated with oncology drugs at different concentrations and measured repeatedly over several days (Tyson et al., 2026).

For this analysis, the `HTS001.csv` dataset was used. It contains 48,664 observations and 8 variables, including:

* `drug1` — drug treatment
* `cell.line` — cancer cell line
* `drug1.conc` — drug concentration
* `well` — physical well identifier
* `time` — measurement time in hours
* `cell.count` — measured cell count
* `drug1.units` — concentration units

The analysis focused on the subset of PC9 cells treated with erlotinib.

The data used in this project were processed cell-count measurements derived from fluorescence microscopy rather than raw microscopy images (Tyson et al., 2026).

## Methods

### Data filtering

The dataset was filtered to include only observations from PC9 cells treated with erlotinib.

This reduced the full dataset to the observations relevant to the research question while retaining measurements across the different erlotinib concentrations and time points.

### Longitudinal analysis

Cell counts were summarised for each combination of time point and erlotinib concentration.

For each group, the mean cell count and standard deviation (SD) were calculated.

The resulting summaries were visualised as concentration-specific trajectories over time to examine how cell-count accumulation changed throughout the experiment.

### Endpoint analysis

The final available measurement for the PC9 erlotinib subset occurred at 112.4 hours. Measurements at this time point were analysed separately to examine the concentration-response pattern at the end of the experiment.

For each concentration, the mean cell count and standard deviation were calculated from the two physical wells.

Individual well measurements were plotted alongside the mean and ±1 SD to show both the observed measurements and within-concentration variability.

Because erlotinib concentrations spanned several orders of magnitude, concentration was displayed on a log10 scale.

### Statistical analysis

A Spearman rank correlation was used to assess the association between erlotinib concentration and mean endpoint cell count.

Spearman correlation was selected because the observed concentration-response relationship was not clearly linear and the analysis aimed to assess whether cell count generally decreased as concentration increased.

Concentration was expressed on a log10 scale for the analysis because the tested concentrations spanned several orders of magnitude. Since Spearman correlation is based on ranks, this monotonic transformation does not change the rank ordering of concentrations.

The statistical analysis was treated as exploratory because each concentration was represented by only two physical wells and independent biological replicates were not available.

## Results

### Longitudinal response

At the beginning of the experiment, cell counts were relatively similar across the different erlotinib concentrations.

As the experiment progressed, the concentration-specific trajectories began to separate, with lower cell counts observed at higher erlotinib concentrations during the later stages of the experiment. The separation became visually apparent at approximately 50 hours.

The longitudinal pattern therefore suggested that the effect of increasing erlotinib concentration became more apparent as the experiment progressed.

### Endpoint response

At the final available measurement time of 112.4 hours, cell counts showed a concentration-dependent pattern.

At the lower end of the concentration range, mean cell counts remained relatively high, generally between approximately 390 and 460 cells. At around 1.55 × 10⁻⁸ M, the mean cell count decreased to approximately 184 cells.

At higher concentrations, mean cell counts were generally lower, ranging from approximately 110 to 122 cells.

The response was not a smooth linear decrease. Instead, the data showed a pattern of relatively high cell counts at lower concentrations, followed by a transition to lower cell counts at higher concentrations.

Variation between the two physical wells also differed between concentrations, with some concentrations showing substantially greater well-to-well variation than others.

### Statistical association

There was a strong negative monotonic association between erlotinib concentration and mean endpoint cell count:

**Spearman ρ = −0.867, p = 0.0027**

This indicates that, across the ten concentration-level means, higher erlotinib concentrations tended to be associated with lower PC9 cell counts.

The result provides exploratory statistical evidence of a concentration-response association, but it should not be interpreted as definitive evidence of a causal drug effect because each concentration was represented by only two physical wells and independent biological replicates were not available.

## Biological interpretation

The results are consistent with a concentration-associated reduction in PC9 cell accumulation during erlotinib exposure.

The longitudinal analysis suggests that differences between concentrations became more apparent during the later stages of the experiment, while the endpoint analysis showed substantially lower cell counts at higher erlotinib concentrations.

Because the outcome measured was cell count, these data indicate differences in cell accumulation or proliferation but do not directly establish whether the reduction resulted from inhibited proliferation, increased cell death, or another biological mechanism.

The response also appeared to approach a lower plateau at the highest concentrations tested, rather than continuing to decrease linearly across the full concentration range.

Overall, the analysis demonstrates how longitudinal cell-count data can be used to explore concentration-response patterns and identify features of a biological response that could be investigated further experimentally.

## Limitations

Several limitations should be considered when interpreting these results.

### Limited replication

Each erlotinib concentration was represented by two physical wells at the endpoint. These are technical replicates rather than independent biological replicates, so the analysis cannot establish how reproducible the observed concentration-response pattern would be across independent experiments.

For this reason, the Spearman correlation was treated as exploratory evidence of an association rather than definitive evidence of a biological effect.

### Longitudinal measurements

The same wells were measured repeatedly over time. Therefore, observations from different time points are not independent of one another.

The longitudinal analysis was used to visualise cell-count trajectories rather than to perform formal statistical testing of changes over time. A repeated-measures or mixed-effects model could be used in a future analysis to account explicitly for the dependence between measurements from the same wells.

### Cell count as the outcome

The dataset measures cell count derived from fluorescence microscopy. A reduction in cell count does not by itself distinguish between reduced proliferation, increased cell death, changes in cell attachment, or other biological processes.

Additional experimental measurements would therefore be required to determine the underlying mechanism.

### Exploratory analysis

The approximately 50-hour separation point identified in the longitudinal plot was based on visual inspection rather than a formal change-point analysis.

Similarly, the endpoint analysis describes the observed concentration-response pattern but does not estimate a formal dose-response curve or pharmacological parameters such as IC50.

Future work could extend the analysis using independent biological replicates, dose-response modelling and statistical models designed specifically for repeated measurements.

## Reproducibility

The analysis was conducted in R using `dplyr` for data manipulation and `ggplot2` for data visualisation.

The analysis script is provided as `analysis.R`.

The original dataset is publicly available from the Zenodo record:

**Tyson et al. (2026), "Longitudinal responses of human cancer cell lines to oncology drugs", Zenodo record 18292967.**

The `HTS001.csv` file should be downloaded from the dataset and placed in the project's `data/` directory before running the analysis.

Running `analysis.R` from the beginning reproduces the data filtering, summary calculations, statistical analysis and figures presented in this project.

The generated figures are saved in the `figures/` directory.

## References

* Tyson DR, Bauer JA, Groves SM, Quaranta V, Lubbock A. (2026). *Longitudinal responses of human cancer cell lines to oncology drugs*. Zenodo. Record 18292967.

* Harris LA, Frick PL, Garbett SP, Hardeman KN, Paudel BB, Lopez CF, Quaranta V, Tyson DR. (2016). An unbiased metric of antiproliferative drug effect in vitro. *Nature Methods*, 13(6), 497–500. DOI: 10.1038/nmeth.3852.

* Chen et al. (2012). *Loss of activating EGFR mutant gene contributes to acquired resistance to EGFR tyrosine kinase inhibitors in lung cancer cells*.
