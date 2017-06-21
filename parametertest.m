Data=xlsread('/Users/finks/Desktop/Projects/STN_Figure/STN_Midline.xlsx');

%Calculation for Z rotation - Use Dorsal and Ventral Points%
DPx=Data(:,8);
DPz=Data(:,10);
VPx=Data(:,11);
VPz=Data(:,13);
Deltax=(DPx-VPx);
Deltaz=(DPz-VPz);
anglez=atand(Deltax./Deltaz);

%Calculation for Y rotation - Use ACPC  Points%

ACx=Data(:,14);
ACy=Data(:,15);
PCx=Data(:,17);
PCy=Data(:,18);
Deltax=(ACx-PCx);
Deltay=(ACy-PCy);
angley=atand(Deltax./Deltay);

%locating MCP

ACx=Data(:,14);
ACy=Data(:,15);
ACz=Data(:,16);
PCx=Data(:,17);
PCy=Data(:,18);
PCz=Data(:,19);
X=(ACx+PCx)./2;
Y=(ACy+PCy)./2;
Z=(ACz+PCz)./2;
MCP = [X,Y,Z];

%rotate with  saggital
mri=ea_load_nii('/Users/finks/Desktop/Projects/STN_Figure/STN_Fig_Imgs/101107/T1w_hires.nii');
mri_vol=mri.img;

%need to rotate opposite direction - inverse of angles
%inverse of MCP matrix for translation
tmat=MCP.*-1;
negangley=angley.*-1;
neganglez=anglez.*-1;

%translate and rotate volume1
tmri_vol=imtranslate(mri_vol, tmat(1,:), 'OutputView', 'full');
rmri_vol=imrotate3(tmri_vol,negangley(1,1),[0 1 0]);
rbmri_vol=imrotate3(rmri_vol,neganglez(1,1),[0 0 1]);
nii=make_nii(rbmri_vol);
save_nii(nii, 'sagrotvol1.nii');

%volume2
mri2=ea_load_nii('/Users/finks/Desktop/Projects/STN_Figure/STN_Fig_Imgs/101309/T1w_hires.nii');
mri_vol2=mri2.img;

tmri_vol2=imtranslate(mri_vol2, tmat(2,:), 'OutputView', 'full');
rmri_vol2=imrotate3(tmri_vol2,negangley(2,1),[0 1 0]);
rbmri_vol2=imrotate3(rmri_vol2,neganglez(2,1),[0 0 1]);
nii2=make_nii(rbmri_vol2);
save_nii(nii2, 'sagrotvol2.nii');