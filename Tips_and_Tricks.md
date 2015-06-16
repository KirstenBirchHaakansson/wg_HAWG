## Working Directory ##
Most code is designed to be run from R with the stock directory (e.g. ./NSAS) set as the working directory. Changes from this will generally cause code to break - I wish there was a nice way around this, but there isn't really, unfortunately. All paths in the code should be setup relative to this directory.

## Output Figures ##

Remember that when setting up /running many of these scripts you will need to specify the output device. If no device is configured, R generally displays the figures in the graphics window. If you wish to save the graphs, eg to png or PDF, for example, then should configure the output device as part of the code (before the plotting statements, obviously) and then close it afterwards. eg to produce a single pdf file

```
pdf(file.path(".","results","figures.pdf")
#<Make your plots>
dev.off()
```
or to plot each figure as a single (numbered) file
```
png(file.path(".","results","figures - %02d.png")
#<Plotting scripts>
dev.off()
```