# ImagefusionSPL
1. If you have not done so before, configure Matlab's MEX compiler by entering
    >> mex -setup 
   (for using OMP OMPBox.)
   More details, please check the folder 'ksvdbox'->'ompbox'
   
2. all .mat files are learned operateors 'Omega' or dictionaries 'D', 
   e.g., LearnedOmega_adm64X25.mat, which can be learned by the functions in 'analysisLearning'
         LearnedD25X256.mat, which can be learned by the functions in 'ksvdbox'
         
3. Folders && Main Functions:

--toolbox
    Evaluation: fusion evaluations by Q_MI and Q_ABF;
    Focus: two multi-focus images;
    ksvdbox: KSVD for dictionary learning;

--fusion methods

SF-DCT: image fusion approach in discrete cosine transform

    demo_SFDCTvar.m -- quick start, when pz=7, sigma=0;
    
    mainSFDCTvar.m  -- fusion based on DCT
    
SR-KSVD: sparse representation K-SVD-based fusion

    demo_SRKSVD.m -- quick start, when pz=7, sigma=0;
    
    sparse_fusion.m  -- fusion based on sparse representation
    
Proposed: proposed method
    demo_fusionAnalysis.m -- quick start, when pz=7, sigma=0;
    
    mainFusionFunction  -- fusion based on learned Omega
    
    Fusion.m-- global optimization based on ADMM;
    
   

4. Possible bug
'Error using conv2 N-D arrays are not supported.'  When happens it, please run again. 
That happened that the commond doesn't run because color images do not tranfer into gray images.
