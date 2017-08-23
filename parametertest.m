Data=xlsread('/Users/finks/Desktop/Projects/STN_Figure/STN_Midline.xlsx');

%vector of patient ids and full matrices of translation matrix and angles
pid = getDirFileNames(0,'/Users/finks/Desktop/Projects/STN_Figure/STN_Fig_Imgs');

tmat=MCP.*-1; %inverse of MCP matrix for translation 

negangley=angley.*-1; 
neganglez=anglez.*-1; 

%loop of loading patient number and cell number
for K = 1:4
pInd=cell2mat (pid(K));   

mri=ea_load_nii(['/Users/finks/Desktop/Projects/STN_Figure/STN_Fig_Imgs/' num2str(pInd) '/T1w_hires.nii']);
mri_vol=mri.img;

%adjusting points to account for first rotation
%DPadjx=((DPx.*(cos(neganglez(K,1))))-(DPz.*(sin(neganglez(K,1)))));
%DPadjz=((DPx.*(sin(neganglez(K,1))))+(DPz.*(cos(neganglez(K,1)))));
%VPadjx=((VPx.*(cos(neganglez(K,1))))-(VPz.*(sin(neganglez(K,1)))));
%VPadjz=((VPx.*(sin(neganglez(K,1))))+(VPz.*(cos(neganglez(K,1)))));
%Deltax=(VPx-DPx); 
%Deltaz=(DPz-VPz); 
%angley=atand(Deltax./Deltaz);
%negangley=angley.*-1;


%translate and rotate 
tmri_vol=imtranslate(mri_vol, tmat(K,:), 'OutputView', 'full');
rmri_vol=imrotate3(tmri_vol,negangley(K,1),[0 1 0]);
rbmri_vol=imrotate3(rmri_vol,neganglez(K,1),[0 0 1]);
nii=make_nii(rbmri_vol);
filename=sprintf('rotchange0823a%s.nii',pInd);
cd /Users/finks/Desktop/Projects/STN_Figure/STN_Fig_Rot
save_nii(nii, filename);
end