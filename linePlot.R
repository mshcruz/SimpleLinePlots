library(ggplot2)
library(grid)
library(scales)

#Labels, paths, names, etc
## datasetNames = c("TrecTitles", "Trans", "DBLP", "Images")
## datasetCleanNames = c("Titles", "Transactions", "DBLPTitles", "Images")
## datasetSizes = c(10,11,12,13,14,15,16,17,18,19)
## datasetRealSizes = c(1024,2048,4096,8192,16384,32768,65536,131072,262144,524288)
## implementations = c("gpu","cpuParallel","cpuSerial")
## paths = c("../CUDA_Single_CCS_SharedMemory/experiments/k20x", "../CPP_Single_CCS_Parallel/experiments/k20x", "../CPP_Single_CCS_Serial/experiments/k20x")
## columnTitles = c("dataset","implementation","datasetSize","var","value")
## legendLabels=c("GPU", "CPU (Paralell)", "CPU (Serial)")
## legendLabelsAbr=c("GPU", "CPU (P)", "CPU (S)")

## for (d in 1:length(datasetNames)) {
##     for (p in 1:length(paths)) {
##         for (n in 1:length(datasetSizes)) {
##             fileName = paste(c(implementations[p],datasetNames[d],datasetSizes[n],"Random"),collapse = "")
##             fileNameExtension = paste(c(fileName, ".csv"),collapse="")
##             filePathNameExtension = paste(c(paths[p],fileNameExtension),collapse = "/")
##             k = read.csv(file=filePathNameExtension, head = FALSE, sep = ",")
##             k.means = c(mean(k$V1), mean(k$V2), mean(k$V3), mean(k$V4), mean(k$V5), mean(k$V6), mean(k$V7))
##             for (v in 1:length(k.means)) {
##                 experimentsResults = rbind(experimentsResults, c(d,p,datasetRealSizes[n],v,k.means[v]))
##             }
##         }
##     }
## }
## names(experimentsResults) = columnTitles

                                        #Performance Comparison Line Plots - linear scales
## performanceComparisonsNames = c("Overall Performance Comparison", "Minhash Performance Comparison", "Join Performance Comparison")
## performanceComparisonsFilenames = c("OverallComparisonLogLinear.eps", "MinhashComparisonLogLinear.eps", "JoinComparisonLogLinear.eps")
## for (d in 1:length(datasetNames)) {
##     experimentsResultsTotal = subset(experimentsResults, (dataset == d & var == 1))
##     experimentsResultsMinhash = subset(experimentsResults, (dataset == d & var == 4))
##     experimentsResultsJoin = subset(experimentsResults, (dataset == d & var == 5))
##     overallComparisonsData = list(experimentsResultsTotal, experimentsResultsMinhash, experimentsResultsJoin)
##     for (c in 1:length(overallComparisonsData)) {
##         data=data.frame(overallComparisonsData[c])
##         p = ggplot(data, aes(x=datasetSize, y=value, group=factor(implementation, levels=c("3","2","1"), labels=c("CPU (Serial)", "CPU (Parallel)", "GPU"), ordered = TRUE), shape=factor(implementation, levels=c("3","2","1"), labels=c("CPU (Serial)", "CPU (Parallel)", "GPU"), ordered = TRUE) ))
##         p = p + geom_line(aes(linetype=factor(implementation, levels=c("3","2","1"), labels=c("CPU (Serial)", "CPU (Parallel)", "GPU"), ordered = TRUE)), size=1.5)
##         p = p + geom_point(size=5, fill="black")
##         ## if (c == 1) {
##         ##     p = p + annotate("text", size = 6, x = 65000, y = 70, label = "GPU")
##         ##     p = p + annotate("text", size = 6, x = 59000, y = 900, label = "CPU (Parallel)")
##         ##     p = p + annotate("text", size = 6, x = 60000, y = 7550, label = "CPU (Serial)")
##         ## }
##         ## if (c == 2) {
##         ##     p = p + annotate("text", size = 6, x = 65000, y = 0.006, label = "GPU")
##         ##     p = p + annotate("text", size = 6, x = 59000, y = 0.04, label = "CPU (Parallel)")
##         ##     p = p + annotate("text", size = 6, x = 60000, y = 0.2, label = "CPU (Serial)")
##         ## }
##         ## if (c ==3) {
##         ##     p = p + annotate("text", size = 6, x = 65000, y = 30, label = "GPU")
##         ##     p = p + annotate("text", size = 6, x = 59000, y = 900, label = "CPU (Parallel)")
##         ##     p = p + annotate("text", size = 6, x = 60000, y = 7550, label = "CPU (Serial)")
##         ## }        
##         p = p + theme_bw()
##         p = p + xlab("|R| (k)")
##         p = p + ylab("Elapsed time (s)")
## #        p = p + ggtitle(paste(c(performanceComparisonsNames[c],"\n","Dataset",datasetCleanNames[d]),collapse=" "))
##         p = p + theme(legend.title=element_blank())
##         p = p + theme(legend.key=element_blank())
##         p = p + theme(legend.key.width=unit(40, "pt"))
##         p = p + theme(legend.key.height=unit(30, "pt"))        
##         p = p + theme(legend.position=c(0.65,0.22))
##         p = p + theme(legend.background=element_rect(fill="transparent"))
##         p = p + theme(legend.text = element_text(size=30))
## #        p = p + theme(legend.position = "none")
##         p = p + theme(panel.grid.minor.x = element_blank())
##         p = p + theme(panel.grid.major.x = element_blank())
##         p = p + theme(plot.title = element_text(size=20, lineheight=.8, face="bold"))
##         p = p + theme(axis.line = element_line(color="black"))
##         p = p + theme(axis.text = element_text(size=30))
##         p = p + theme(axis.text.x = element_text(angle=45, hjust=1))  
##         p = p + theme(axis.title = element_text(size=30))
##         p = p + theme(axis.title.y = element_text(vjust = 1.2))
##         p = p + theme(axis.title.x = element_text(vjust = -0.4))
##         p = p + theme(aspect.ratio=1)
##         p = p + scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x), labels = trans_format("log10", math_format(10^.x)))
##         p = p + scale_x_continuous(breaks=c(0,100000,200000,300000,400000,500000), labels=c(0,100,200,300,400,500))
##         ggsave(plot = p, filename=paste0(c(datasetCleanNames[d], performanceComparisonsFilenames[c]), collapse = ""))
##         print(p)
##     }
## }
setwd("~/Dropbox/Programming/SimpleLinePlots/.")
#Read experiment data
experimentsResults = data.frame()
xvalues = c(10:19)
implementation = c("gpu", "cpuParallel", "cpuSerial")

for (i in 1:length(implementation)) {
    fileName = paste(c(implementation[i], ".csv"), collapse="")
    csvFile = read.csv(file=fileName, head=FALSE, sep = ",")
    experimentsResults = rbind(experimentsResults, c(csvFile[1]))
}


##             for (v in 1:length(k.means)) {
##                 experimentsResults = rbind(experimentsResults, c(d,p,datasetRealSizes[n],v,k.means[v]))
