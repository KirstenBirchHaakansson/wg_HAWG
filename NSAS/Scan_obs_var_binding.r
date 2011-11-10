################################################################################
# Scan observation variance bindings
#
# $Rev$
# $Date$
#
# Author: HAWG model devlopment group
#
# The FLSAM model has the ability to bind the observation variances (weightings)
# of age groups together, effectively using one parameter for many age groups. 
# The appropriate bindings can be identified by performing a series of assessments 
# for each combination and then comparing the results using AIC / LR tests.
#
# Developed with:
#   - R version 2.13.2
#   - FLCore 2.4
#
# To be done:
#
# Notes: Have fun running this assessment!
#
################################################################################

### ============================================================================
### Initialise system, including convenience functions and title display
### ============================================================================
rm(list=ls()); gc(); graphics.off(); start.time <- proc.time()[3]
options(stringsAsFactors=FALSE)
log.msg     <-  function(string) {
	cat(string);flush.console()
}
log.msg("\nScan obs. variance bindings\n===========================\n")

### ============================================================================
### Import externals
### ============================================================================
log.msg("IMPORTING EXTERNAL RESOURCES...\n")
library(FLSAM)
source("Setup_objects.r")
source("Setup_default_FLSAM_control.r")

### ============================================================================
### Modify the default assessment
### ============================================================================
#Now scan through the HERAS ages, tying them sequentlly together
HERAS.ctrls <- list()
for(i in 1:9) {
  ctrl <- NSH.ctrl
  ctrl@obs.vars["HERAS",ac(i:9)] <- 100
  ctrl@name <- sprintf("%i+",i)
  ctrl@desc <- sprintf("Age %i+ observation variances bound together",i)
  HERAS.ctrls[[i]] <- ctrl
}
names(HERAS.ctrls) <- sapply(HERAS.ctrls,slot,"name")

#And ditto for the IBTS ages
IBTS.ctrls <- list()
for(i in 1:5) {
  ctrl <- NSH.ctrl
  ctrl@obs.vars["IBTS-Q1",ac(i:5)] <- 100
  ctrl@name <- sprintf("%i+",i)
  ctrl@desc <- sprintf("Age %i+ observation variances bound together",i)
  IBTS.ctrls[[i]] <- update(ctrl)
}
names(IBTS.ctrls) <- sapply(IBTS.ctrls,slot,"name")

### ============================================================================
### Run the assessment
### ============================================================================
#Perform assessment
HERAS.sams <- lapply(HERAS.ctrls,FLSAM,stck=NSH,tun=NSH.tun,batch.mode=TRUE)
IBTS.sams <- lapply(IBTS.ctrls,FLSAM,stck=NSH,tun=NSH.tun,batch.mode=TRUE)

#Drop any that failed to converge
HERAS.sams <- FLSAMs(HERAS.sams[!sapply(HERAS.sams,is.null)])
IBTS.sams <- FLSAMs(IBTS.sams[!sapply(IBTS.sams,is.null)])

### ============================================================================
### Save results
### ============================================================================
save(NSH,NSH.tun,HERAS.sams,IBTS.sams,file=file.path(resdir,"Scan_obs_var_binding.RData"))

### ============================================================================
### Analyse the results
### ============================================================================
#Build stock objects
HERAS.stcks <- HERAS.sams + NSH
IBTS.stcks <- IBTS.sams + NSH

#Extract AICs
HERAS.AICs <- AIC(HERAS.sams)
IBTS.AICs  <- AIC(IBTS.sams)

#Plot
pdf(file.path(resdir,"Scan_obs_var_binding.pdf"))
plot(HERAS.AICs,main="HERAS bindings scan",ylab="AIC",xaxt="n",xlab="Model",pch=16)
axis(1,labels=names(HERAS.AICs),at=seq(HERAS.AICs))
print(xyplot(value ~ age | fleet,data=obs.var(HERAS),group=name,
      main="HERAS obs_var bindings")
print(plot(HERAS.stcks,main="HERAS obs var scan"))

plot(IBTS.AICs,main="IBTS bindings scan",ylab="AIC",xaxt="n",xlab="Model",pch=16)
axis(1,labels=names(IBTS.AICs),at=seq(IBTS.AICs))
print(xyplot(value ~ age | fleet,data=obs.var(IBTS),group=name,
      main="IBTS obs_var bindings")
print(plot(IBTS.stcks,main="IBTS obs var scan"))

dev.off()

### ============================================================================
### Finish
### ============================================================================
log.msg(paste("COMPLETE IN",sprintf("%0.1f",round(proc.time()[3]-start.time,1)),"s.\n\n"))