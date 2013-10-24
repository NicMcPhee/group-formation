group-formation
===============

Some (fairly crude) tools to help support the creation of (semi-)random groups

To use these create a ```past_groups.txt``` file (I should make 
that settable on the command line) that indicates all the prior group relationships.
This looks like
```
# Name	Name	Lab.number
Chris	Pat	1
Ben	Sandy	1
Sally	Ted	2
Jack	Mary    2
```
 
Also create a ```prefs.txt``` (also should be settable, and optional) with people's 
preferences; this can be empty. Then run ```gen_dist_matrix.rb``` to get 
a distance matrix. I then load that in R (```d <- read.table("group_dist.R")```) 
and use a clustering algorithm like agnes (```ag <- agnes(d, diss=TRUE)```) or 
fanny (```fa <- fanny(d, k, diss=TRUE)```) to see how people cluster. With 
the ```diss=TRUE``` argument, individuals in the same cluster (or close to 
each other in the dendrogram) are good candidates to be in a group together.
