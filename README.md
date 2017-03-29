# LESH (Local Energy based Shape Histogram) feature Extraction
 
# Usage: 
lesh_vect = calc_LESH(im) ;

# Input: 
im = Image or Local patch

# output: 
 lesh_vect= LESH feature vector (128 dimentional for 16 partitions and 512 dimentional for 64 partitions of the 
             image/patch. (see FeatureParam.m)
 
 

Works on image or patch of any size (preferably square). 

Recomended partition size w is 8 (512-dim vector) for an image of size greater than 64x64. In patches of size 32x32, partition size should be changed to 4 (to yield a 128 dim vector) 
 
There are a number of parametes to adjust for different applications.
file FeatureParam.m may be modified to change e.g. the number of scale and orientation of GABOR filter. partion size may be changed to yield a longer vector or vice versa, more coarse partions or more fine partions may affect the discrimination quality of feature vector. 
Recomended settings are 8x8(64) partition size(512-dimenstional vector) and 5 scales and 8 orientations for GABOR filter bank.

# Please Note:
This updated optimized version does not include the Gaussian weighing as described in the paper. With the current optimzation, we have found it works better for general shape description.

Acknowledgemnt: The code uses updated version of phasecongruency detection from Peter kovesi Matlab toolbox. 
Please use the respective paper citation in the file phasecong3.m 


The software is provided "as is", without warranty of any kind.

# References:

[1] M.S.Sarfraz and O.Hellwich,"Head Pose Estimation in Face Recognition across Pose Scenarios" 
    in Int.  Conference on Computer Vision Theory and Applications VISAPP, Vol. 1, pp. 235 -242, Portugal, 2008.

[2] M.S.Sarfraz, O.Hellwich," An Efficient Front-end Facial Pose Estimation System for Face Recognition", 
    In International Journal of Pattern Recognition and Image Analysis, distributed by Springer, Vol.18(3) pp. 434441, 2008.
    
[3] M.Saquib Sarfraz and Olaf Hellwich, "On Head Pose Estimation in Face Recognition", 
    J. Braz, A. Ranchordas, H. Arajo and J. Jorge Editors, Advances in Computer Graphics and Computer Vision.
    Lecture notes CCIS 24, pp 162-175, Springer, 2009.
