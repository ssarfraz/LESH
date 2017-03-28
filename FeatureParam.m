function Feature_param=FeatureParam()

Feature_param.n_scale=5;
Feature_param.n_orient=8;
Feature_param.partition=8;   %4 for 4x4=16 partitions (128-dim); 8 for 8x8=64 partions (512-dim vector)
Feature_param.debug=0;   % =1 for displaying energy,orientaion maps AND =0 for not showing any output figures.

Feature_param.sigma=20;
Feature_param.simflag=0;%similarity 0=jeffery divergence 1=bhatacharaya coeff
end