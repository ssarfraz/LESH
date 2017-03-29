 % LESH (Local Energy based Shape Histogram) feature Extraction
 % usage: [lesh]=calc_LESH(im)

 %Input: 
 %im = Image or Local patch
 % some parameters are set as default, see file feature_param.m for details
 % output: 
 % Shape_vect= LESH feature vector (128 dimentional for 16 partitions and 512 dimentional for 64 partitions of the image/patch..see FeatureParam)
 
 %Copyright: %2007-2017 M.Saquib Sarfraz
 

% Permission is hereby  granted, free of charge, to any  person obtaining a copy
% of this software and associated  documentation files (the "Software"), to deal
% in the Software without restriction, subject to the following conditions:
% 
% Citation to the following published article(s) must be made in any
% published work using LESH
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% The software is provided "as is", without warranty of any kind.

%UPDATE: 
%Gaussian weighing is off in this verison as it did not produce good results in other general applications

% References:
%%[1]  M.S.Sarfraz and O.Hellwich,"Head Pose Estimation in Face Recognition across Pose Scenarios" 
%     in Int.  Conference on Computer Vision Theory and Applications VISAPP, Vol. 1, pp. 235 -242, Portugal, 2008.
% [2] M.Saquib Sarfraz and Olaf Hellwich, �On Head Pose Estimation in Face Recognition�, 
%     J. Braz, A. Ranchordas, H. Ara�jo and J. Jorge Editors, Advances in Computer Graphics and Computer Vision.
%     Lecture notes CCIS 24, pp 162-175, Springer, 2009.
% [3] M.S.Sarfraz, O.Hellwich,� An Efficient Front-end Facial Pose Estimation System for Face Recognition�, 
%     In International Journal of Pattern Recognition and Image Analysis, distributed by Springer, Vol.18(3) pp. 434�441, 2008.

function [Shape_vect]=calc_LESH(im)  %%,scale,n_orient,w,debug)



feature_param=FeatureParam(); %%%% load some parameters values
% 
  scale=feature_param.n_scale;  
  n_orient=feature_param.n_orient;
  w=feature_param.partition; %image will be partitioned in w x w partitions
 %sigma=feature_param.sigma;  % not needed, Gaussian weighing is off
 debug=feature_param.debug;
 blksize=ceil(size(im)/w); % Just a small fix to make it work with arbitrary image size to have required partitions
 im=imresize(im,blksize*w);

 [~ , ~, or, ~, pc , ~, ~] = phasecong3(im,scale,n_orient); 

 [~, L]=max(cat(3,pc{:}),[],3);%%%getting the Label map L

 blksize=size(im)/w;  
 %%%
 pct=sum(cat(3,pc{:}),3); %Just for display purpose
 orientation=or./22.5;
 %%%
 
 pc_im=zeros(size(im,1),size(im,2),n_orient);
 g=cell(w,w);
for ort=1:n_orient
    pc_im(:,:,ort)=pc{ort}.*(L==ort);
end
g = mat2cell(pc_im,blksize(1)*ones(1,w),blksize(2)*ones(1,w),n_orient)';

Shape_vect = sum(sum(cat(3,g{:}),1));
Shape_vect=Shape_vect(:);

Shape_vect=((Shape_vect-min(Shape_vect))/(max(Shape_vect)-min(Shape_vect)))'; % feature scaling b/w 0-1, comment if needed

Shape_vect(isnan(Shape_vect))=0; 

if debug==1
    %figure; 
   subplot(2,3,1)
   imshow(im,[])
   title(sprintf('Orignal Image'));
   subplot(2,3,2)
   imshow(pct,[])
   title(sprintf('Local Energy Map'));
   subplot(2,3,3)
   imshow(orientation,[])
   title(sprintf('Orientation Map'));
   subplot(2,3,[4 5 6])
   plot(Shape_vect');
            set(gca, 'XTick', [0:32:length(Shape_vect)]);
            xlim([1,size(Shape_vect,2)]);
            title(sprintf('Processed LESH Vector '));

 drawnow();
%toc;
end
end
