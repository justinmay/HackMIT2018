"KIT Dataset for Tracking People in Aerial Image Sequences"
http://www.ipf.kit.edu/downloads_People_Tracking.php
(C) http://creativecommons.org/licenses/by/3.0/ "KIT AIS Dataset"

2012-10-26

Results of the IPF detection algorithm for single persons in aerial images.
----------------------------------------------------------------------------

No threshold has been applyed to the results.
The detection score (confidence) varies between 0 and 1.

If you want to turn the detection score into a true (conditional) probability, you may use the following formulars:
p(score|Detection,Object)  = 10.893/2 * (1 - tanh²(10.893 * score - 6.933))
p(score|Detection,!Object) = 17.210/2 * (1 - tanh²(17.210 * score - 6.108))

If you do apply a threshold, the probability changes accordingly:
p(score|Detection,Th,Object)  = p(score|Detection,Object)  / p(score>=Th|Detection,Object) 
p(score|Detection,Th,!Object) = p(score|Detection,!Object) / p(score>=Th|Detection,!Object) 
with
p(score>=Th|Detection,Object)  = 1/2 * (1 + tanh(10.893 * score - 6.933))
p(score>=Th|Detection,!Object) = 1/2 * (1 + tanh(17.210 * score - 6.108)) 


