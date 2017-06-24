Data=xlsread('/Users/finks/Desktop/Projects/STN_Figure/STN_Midline.xlsx');

%Calculation for Z rotation - Use Dorsal and Ventral Points%
DPx=Data(:,35);
DPz=Data(:,37);
VPx=Data(:,38);
VPz=Data(:,40);
Deltax=(DPx-VPx);
Deltaz=(DPz-VPz);
anglez=atand(Deltax./Deltaz);

%Calculation for Y rotation - Use ACPC  Points%

ACx=Data(:,26);
ACy=Data(:,27);
PCx=Data(:,29);
PCy=Data(:,30);
Deltax=(ACx-PCx);
Deltay=(ACy-PCy);
angley=atand(Deltax./Deltay);

MCP = [Data(:,32),Data(:,33),Data(:,34)];

%vector of patient ids and full matrices of translation matrix and angles
pid = getDirFileNames(0,'/Users/finks/Desktop/Projects/STN_Figure/STN_Fig_Imgs');

%this is what needs tweaking to improve MCP alignment
tmat=MCP.*-1; %inverse of MCP matrix for translation 

negangley=angley.*-1; %need to rotate opposite direction - inverse of angles
neganglez=anglez.*-1;

%loop of loading patient number and cell number
for K = 1:1
pInd=cell2mat (pid(K));   
    
mri=ea_load_nii(['/Users/finks/Desktop/Projects/STN_Figure/STN_Fig_Imgs/' num2str(pInd) '/T1w_hires.nii']);
mri_vol=mri.img;

%translate and rotate 
tmri_vol=imtranslate(mri_vol, tmat(K,:), 'OutputView', 'full');
rmri_vol=imrotate3(tmri_vol,negangley(K,1),[0 1 0]);
rbmri_vol=imrotate3(rmri_vol,neganglez(K,1),[0 0 1]);
nii=make_nii(rbmri_vol);
filename=sprintf('rot2%s.nii',pInd);
cd /Users/finks/Desktop/Projects/STN_Figure/STN_Fig_Rot
save_nii(nii, filename);
end