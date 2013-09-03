# 
# MIT License
# 
# Bob Rudis (@hrbrmstr) bob@rudis.net | http://rud.is/b | http://amzn.to/sudabook
#

library(ggplot2)

#
# make a bullet graph (retuns a ggplot2 object)
#
# expects a data frame with columns: measure|high|mean|low|target|value 
#
# which equates to:
#   measure: label of what's being measured
#      high: the high value for the measure
#      mean: the mean value for the measure
#       low: the low value for the measure
#    target: the target value for the measure
#     value: the actual value of the measure
#
# NOTE: you *can* put multiple rows in the data frame, but they should all be at the same
#       scale. That either means normalizing the values or representing them as pecentages.
#       you are better off making multiple, invididual bullet graphs if the scales are
#       very different.
# 
# Adapted from: http://bit.ly/1fs6ooC
#

bullet.graph <- function(bg.data){
  
  # compute max and half for the ticks and labels
  max.bg <- max(bg.data$high)
  mid.bg <- max.bg / 2

  gg <- ggplot(bg.data) 
  gg <- gg + geom_bar(aes(measure, high),  fill="goldenrod2", stat="identity", width=0.5, alpha=0.2) 
  gg <- gg + geom_bar(aes(measure, mean),  fill="goldenrod3", stat="identity", width=0.5, alpha=0.2) 
  gg <- gg + geom_bar(aes(measure, low),   fill="goldenrod4", stat="identity", width=0.5, alpha=0.2) 
  gg <- gg + geom_bar(aes(measure, value), fill="black",  stat="identity", width=0.2) 
  gg <- gg + geom_errorbar(aes(y=target, x=measure, ymin=target, ymax=target), color="red", width=0.45) 
  gg <- gg + geom_point(aes(measure, target), colour="red", size=2.5) 
  gg <- gg + scale_y_continuous(breaks=seq(0,max.bg,mid.bg))
  gg <- gg + coord_flip()
  gg <- gg + theme(axis.text.x=element_text(size=5),
                   axis.title.x=element_blank(),
                   axis.line.y=element_blank(), 
                   axis.text.y=element_text(hjust=1, color="black"), 
                   axis.ticks.y=element_blank(),
                   axis.title.y=element_blank(),
                   legend.position="none",
                   panel.background=element_blank(), 
                   panel.border=element_blank(),
                   panel.grid.major=element_blank(),
                   panel.grid.minor=element_blank(),
                   plot.background=element_blank())

  return(gg)

}

# test it out!

# 5/1 seems to be a good ratio for individual bullet graphs but you
# can change it up to fit your dashboard needs

incidents <- data.frame(
  measure=c("Total Events (K)", "Security Events (K)"),
  high=c(3200,2000),
  mean=c(2170,1500),
  low=c(1500,500), 
  target=c(2500,1750),
  value=c(2726,1600)
)

incidents.bg <- bullet.graph(incidents)
ggsave("incident-total-events.pdf", incidents.bg, width=5, height=2)

incidents.pct <- data.frame(
  measure=c("Total Events (%)", "Security Events (%)", "Filtered (%)", "Tickets (%)"),
  high=c(100,100,100,100),
  mean=c(45,40,50,30),
  low=c(25,20,10,5), 
  target=c(55,40,45,35),
  value=c(50,45,60,25)
)

incidents.pct.bg <- bullet.graph(incidents.pct)
ggsave("incident-total-events-pct.pdf", incidents.pct.bg, width=10, height=5)


