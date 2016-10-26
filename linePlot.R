library(ggplot2)
library(grid)
library(scales)
library(extrafont)

#Read experiment data
experimentsResults = data.frame()
xvalues = c(10:19)
implementation = c("gpu", "cpuParallel", "cpuSerial")
for (i in 1:length(implementation)) {
    fileName = paste(c(implementation[i], ".csv"), collapse="")
    csvFile = read.csv(file=fileName, head=TRUE, sep = ",")
    csvFile["implementation"] = i
    if (is.data.frame(experimentsResults) && nrow(experimentsResults)==0) {
        experimentsResults = csvFile
    }
    experimentsResults = merge(experimentsResults, csvFile, all=TRUE)
}

# Draw the plot
p = ggplot(experimentsResults, aes(x = size, y = time, group=implementation))
p = p + geom_line(size=1.5)
p = p + geom_point(aes(shape=factor(implementation, labels=c("GPU", "CPU Parallel", "CPU Serial"))), size = 7, fill="black")

# Format font, background and grids
p = p + theme_bw()
p = p + theme(text=element_text(family="Times New Roman"))
p = p + theme(panel.grid.minor.x = element_blank())
p = p + theme(panel.grid.major.x = element_blank())

# Format axis
p = p + xlab("|R|")
p = p + ylab("Elapsed time (s)")
p = p + theme(axis.line = element_line(color="black"))
p = p + theme(axis.text = element_text(size=30))
p = p + theme(axis.title = element_text(size=30))
p = p + theme(axis.title.y = element_text(vjust = 1.2))
p = p + theme(axis.title.x = element_text(vjust = -0.4))
p = p + theme(aspect.ratio=1)
p = p + coord_cartesian(ylim = c(0.1, 40000)) 
p = p + scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x), labels = trans_format("log10", math_format(10^.x)))
p = p + scale_x_continuous(breaks = xvalues, labels = math_format(2^.x)(xvalues))

# Format the legend
p = p + theme(legend.title=element_blank())
p = p + theme(legend.key=element_blank())
p = p + theme(legend.key.width=unit(40, "pt"))
p = p + theme(legend.key.height=unit(30, "pt"))        
p = p + theme(legend.position=c(0.25,0.85))
p = p + theme(legend.background=element_rect(fill="transparent"))
p = p + theme(legend.text = element_text(size=30))
p = p + guides(shape = guide_legend(reverse=TRUE))

# Save figure
ggsave(plot = p, filename="ggplot2Final.png")

print(p)
