Rbulletgraph
============

Standalone (non-package) example of how to make bullet graphs (http://www.perceptualedge.com/articles/misc/Bullet_Graph_Design_Spec.pdf) in R

Provided you have a data frame with the following columns:

    measure|high|mean|low|target|value
    
the bullet.graph() function will make one more (depending on the number of rows) bullet graphs based on the scale of 
the max value of "high".

If your data set doesn't "play nice" in that range, you'll either need to make multiple bullet graphs 
(which should be able to be aligned nicely with a grid since the functions returns a ggplot object) or normalize the data
(i.e. convert to percentages).

Sample usage:

```R
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
``` 

![example bullet graph](http://rud.is/dl/incident-total-events.png)



