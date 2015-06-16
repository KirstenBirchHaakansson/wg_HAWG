# Refine Model ([Issue 31](https://code.google.com/p/hawg/issues/detail?id=31)) #
Parameter settings for the SAM assessment model need to be settled on.

Propose to base the approach on a series of scans where we bind parameters together and then test via AIC or LR tests whether the reduced model is significantly different from the parent model.

Parameters to test in this manner:
  * Catchability-at-age and observation variances of HERAS survey
  * Catchability-at-age and observation varainces of IBTS-Q1 survey
  * Catchability-at-age and observation variances of IBTS-Q3 survey
  * Fishing selectivity-at-age and observation variances.

Other models to test
  * MLAI/SCAI power-law vs linear model

# Incorporation of Historic Data into Assessment ([Issue 30](https://code.google.com/p/hawg/issues/detail?id=30)) #

Stock assessment should take into account all available data, including historic catch information. Two data sets are available
  * Catch-at-age back to 1948 (the ICES 1998 dataset)
  * Total catches back to 1900

#2 will not be handled here, but could be the basis of an extension (e.g. via a surplus-production extension (see Eero & MacKenzie MEPS 2011) to the SAM model. This could be the basis of work at the regular HAWG meeting

#1 requires
  * Digitisation of data sets - Emma to handle
  * Incorporation into assessment via VPA-format files

Effect of #1 can be evaluated by
  * Comparison of catch observation variances estimated with and without historic period data
  * Examination of the historic period residuals on their own

#1 may require
  * Possible modification to SAM tpl to allow for different observation variances by period.

### Benchmark goals ###
  * Catch-at-age data back to 1948 to be incorporated but possibly without separate variance estimates
  * Collate, tabulate and plot historic (pre-1948) total landings for potential future use


# Comparison of SAM and ICA Models ([Issue 29](https://code.google.com/p/hawg/issues/detail?id=29)) #
Need to understand what the new model means for perception of the stock. Suggest basing the comparison on three different models

  * The 2010 HAWG (ICA) assessment results
  * An ICA assessment done with the same model settings as 2010, but using the new data work-ups (e.g. SCAI, Natural Mortality, any catch modifications, Munk-net index etc)
  * The refined SAM model

Basis for comparison
  * Plotting of all time series on same plot. Do the ICA models fall within the confidence intervals of the SAM model?
  * Comparison of residuals in some cases where there are known problems (e.g. acoustic time series)
  * Comparison of weightings derived a-priori from Simmonds 2003 vs estimated internally in model