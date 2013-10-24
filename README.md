group-formation
===============

Some (fairly crude) tools to help support the creation of (semi-)random groups.
The basic idea is to use past history and (optionally) student preferences to
generate a notion of distance between students, where small distances make it
more likely for students to be put in a group together. Some constant _k_ is
added to the distance between _A_ and _B_ for each time students _A_ and _B_
have already been in a group together.

There is also support for an optional ```prefs.txt``` file that indicates
student preferences, which are then added to the distances. (Currently the
way that these are added is pretty arbitrary and we should see if we can do
better.)

To use these create a ```past_groups.txt``` file (I should make 
that settable on the command line) that indicates all the prior group relationships.
This looks like
```
# Name	Name	Lab.number
Chris	Pat	    1
Ben	    Sandy	1
Sally	Ted	    2
Jack	Mary    2
```
Rows that start with a '#' are comments and ignored. The first two columns are
actually the only things that are used (and are assumed to be the names of two
students that were in a group together); anything after those two names are
ignored. If you have groups of more than two people you need to put all the
pairwise entries in this file (which is annoying and should be fixed). Thus
if Pat, Chris, and Sandy were in a group together in Lab 4 you'd have to do
something like:
```
Pat     Chris   4
Pat     Sandy   4
Chris   Sandy   4
```

Also create a ```prefs.txt``` (also should be settable, and optional) with people's 
preferences; this can be empty. Then run ```gen_dist_matrix.rb``` to get 
a distance matrix. I then load that in R (```d <- read.table("group_dist.R")```) 
and use a clustering algorithm like agnes (```ag <- agnes(d, diss=TRUE)```) or 
fanny (```fa <- fanny(d, k, diss=TRUE)```) to see how people cluster. With 
the ```diss=TRUE``` argument, individuals in the same cluster (or close to 
each other in the dendrogram) are good candidates to be in a group together.
