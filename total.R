
######
library(tseries)
library("readxl")
library(ggplot2)
library(fpp2)
library(writexl)

klkmmkkjj

datagen<- read.csv("C:/Users/azhar/Desktop/forecast/generationForecast.csv")
genarationforecast<-ts(datagen$Point.Forecast,frequency=2*48)

datacoal<- read.csv("C:/Users/azhar/Desktop/forecast/coalforecast.csv")
coalforecast<-ts(datacoal$Point.Forecast,frequency=2*48)

dataceboil<- read.csv("C:/Users/azhar/Desktop/forecast/ceboilforecast.csv")
ceboilforecast<-ts(dataceboil$Point.Forecast,frequency=2*48)

databiomas<- read.csv("C:/Users/azhar/Desktop/forecast/biomasforecast.csv")
biomasforecast<-ts(databiomas$Point.Forecast,frequency=2*48)

dataIPP<- read.csv("C:/Users/azhar/Desktop/forecast/IPPforecast.csv")
IPPforecast<-ts(dataIPP$Point.Forecast,frequency=2*48)

sheets<-list("totgen"=genarationforecast,"coal"=coalforecast,"oil"=ceboilforecast,"biomass"=biomasforecast,"IPP"=IPPforecast)
write.csv(sheets, file="C:/Users/azhar/Desktop/forecast/alphaForecast.csv")

alpha<- read.csv("C:/Users/azhar/Desktop/forecast/alphaForecast.csv")
coalalpha<-ts(alpha$alphacoal,frequency=2*48)
ceboilalpha<-ts(alpha$alphaoil,frequency=2*48)
biomassalpha<-ts(alpha$alphabiomass,frequency=2*48)
IPPalpha<-ts(alpha$alphaIPP,frequency=2*48)

##################################
#Intensity calculation
#####################

intensity.function<- coalalpha*0.225+ ceboilalpha*0.2325+biomassalpha*0.03+IPPalpha*0.2325


##################################
#C Calculation in excel sheet using intensity function and generation
##################################################

sheets1<-list("intensiyfunction"=intensity.function,"generation(MW)"=genarationforecast)
write.csv(sheets1, file="C:/Users/azhar/Desktop/forecast/finlaforecasting.csv")


###############################################################
#APril first 3 day
###########################################################
next3 <-read_xlsx("C:/Users/azhar/Desktop/forecast/3days.xlsx")
coal<-ts(next3[5] ,frequency=2*48)
ceboil<-ts(next3[6],frequency=2*48)
biomass<-ts(next3[10],frequency=2*48)
IPP<- ts(next3[7],frequency=2*48)


actual3dayemission<-coal*0.9+ ceboil*0.93+biomass*0.12+IPP*0.93

############################################################
#3daycforecasting
############################################

next3day<- read.csv("C:/Users/azhar/Desktop/forecast/finlaforecasting.csv")

next3daycforecasting<-ts(next3day$cemission,frequency=2*48)



################################################
#next3daycforecasting,actual3dayemission  final plot
#####################################################



autoplot(next3daycforecasting)+autolayer(actual3dayemission)
