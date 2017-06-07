% Aligning along MCP and rotating %
% Try rotating 2 and comparing 2 volumes %

%translated and rotated volume1%
mri=ea_load_nii('/Users/finks/Desktop/Projects/STN_Figure/STN_Fig_Imgs/101107/T1w_hires.nii');
mri_vol=mri.img;

%need to rotate opposite direction - inverse of angles
%need the revert matrix to be twice the inverse
tmat=MCP.*-1;
rmat=MCP.*2;
negangley=angley.*-1;
neganglez=anglez.*-1;

%translate and rotate volume1
tmri_vol=imtranslate(mri_vol, tmat(1,:), 'OutputView', 'full');
rmri_vol=imrotate3(tmri_vol,negangley(1,1),[0 1 0]);
rbmri_vol=imrotate3(rmri_vol,neganglez(1,1),[0 0 1]);
nii=make_nii(rbmri_vol);
save_nii(nii, 'rotvol1.nii');

%translate and rotate volume2
mri2=ea_load_nii('/Users/finks/Desktop/Projects/STN_Figure/STN_Fig_Imgs/101309/T1w_hires.nii');
mri_vol2=mri2.img;

tmri_vol2=imtranslate(mri_vol2, tmat(2,:), 'OutputView', 'full');
rmri_vol2=imrotate3(tmri_vol2,negangley(2,1),[0 1 0]);
rbmri_vol2=imrotate3(rmri_vol2,neganglez(2,1),[0 0 1]);
nii2=make_nii(rbri_vol2);
save_nii(nii2, 'rotvol2.nii');

%BINGO! worth checking angles to make sure that alignments are good
mri3=ea_load_nii('/Users/finks/Desktop/Projects/STN_Figure/STN_Fig_Imgs/101309/T1w_hires.nii');
mri_vol3=mri3.img;

tmri_vol3=imtranslate(mri_vol3, tmat(3,:), 'OutputView', 'full');
rmri_vol3=imrotate3(tmri_vol3,negangley(3,1),[0 1 0]);
rbmri_vol3=imrotate3(rmri_vol3,neganglez(3,1),[0 0 1]);
nii3=make_nii(rbmri_vol3);
save_nii(nii3, 'rotvol3.nii');
