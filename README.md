
1. If you have not done so before, configure Matlab's MEX compiler by entering

    >> mex -setup 
   (for using OMP OMPBox.)
   More details, please check the folder 'ksvdbox'->'ompbox'

2. all .mat files are learned operateors 'Omega' or dictionaries 'D', where are used for image fusion based on proposed method and K-SVD method, respectively. 


   e.g., LearnedOmega_adm64X25.mat, which can be learned by the functions in 'analysisLearning'
         LearnedD25X256.mat, which can be learned by the functions in 'ksvdbox'

3. Folders && Main Functions:

--toolbox

    Evaluation: fusion evaluations by Q_MI and Q_ABF;
    Focus: two multi-focus images;
    ksvdbox: KSVD for dictionary learning;

--analysisLearning: analysis operator learning. 


--fusion methods
SF-DCT: image fusion approach in discrete cosine transform

    demo_SFDCTvar.m -- quick start, when patch size = 7, sigma = 0;
    
    DemofigPatch_DCT.m -- print fusion results when sigma = 0, patch size = 5,6,7,8,9;
    
    DemofigPatch_DCT_sigma15.m -- print fusion results when sigma = 15, patch size  = 5,6,7,8,9;
    
    mainSFDCTvar.m  -- fusion based on DCT
    
    DemofigPatch_DCT_pz7.m  --print fusion results when patch size = 7, sigma= 0,5,10,15,20; 
    
    DemofigPatch_DCT_pz9.m  --print fusion results when patch size = 9, sigma= 0,5,10,15,20; 


SR-KSVD: sparse representation K-SVD-based fusion

    demo_SRKSVD.m -- quick start, when patch size = 7, sigma=0;
    
    DemofigPatch_KSVD.m -- print fusion results when sigma = 0, patch size = 5,6,7,8,9;
    
    DemofigPatch_KSVD_sigma15.m -- print fusion results when sigma = 15, pz = 5,6,7,8,9;
    
    sparse_fusion.m  -- fusion based on sparse representation
    
    DemofigPatch_KSVD_pz7.m  -- print fusion results when patch size = 7, sigma= 0,5,10,15,20; 
    
    DemofigPatch_KSVD_pz9.m  -- print fusion results when patch size = 9, sigma= 0,5,10,15,20; 


Proposed: proposed method

    demo_fusionAnalysis.m -- quick start, when patch size =7, sigma=0;
    
    DemofigPatch.m -- print fusion results when sigma = 0, patch size =5,6,7,8,9;
    
    DemofigPatch_sigma15.m -- print fusion results when sigma = 15, patch size =5,6,7,8,9;
    
    DemofigPatch_pz7.m  --print fusion results when patch size = 7, sigma= 0,5,10,15,20; 
    
    DemofigPatch_pz9.m  --print fusion results when patch size = 9, sigma= 0,5,10,15,20; 

    mainFusionFunction  -- fusion based on learned Omega
    
    Fusion.m-- global optimization based on ADMM;

4. Possible bug

  'Error using conv2 N-D arrays are not supported.'  When happens it, please run again. That happened that the commond doesn't run because color images do not tranfer into gray images.

5. Tips

(1) These ‘DemofigPatch_*.m’ files could print out the values of Q_MI, Q_ABF and elapsed times by SF-DCT method, SR-KSVD, and Proposed method in various parameters (patch size and noisy case). Here, the functions print the values from examples in Fig.1 (a) and (b) and Fig.2 (a) and (b). In IV parts, Fig. 3, Fig. 4 and Table I show the average values by conducting several experiments that is described in the letter. But the similar values can be computed from these ‘.m’ files. More multi-focus images can be download from the dataset website (http://mansournejati.ece.iut.ac.ir/content/lytro-multi-focus-dataset). 

(2) The evaluation functions are sensitive to pixel displacements. So when use the Matlab command to reset the image size, e.g., 'imresize', please make sure the source images are also reset in the same way. 

