
%Finding angles of rotation for the different subjects for Y and Z%
Data=xlsread('/Users/finks/Desktop/Projects/STN_Figure/STN_Midline.xlsx');

%Calculation for Y rotation - Use Dorsal and Ventral Points%
DPx=Data(:,20);
DPz=Data(:,22);
VPx=Data(:,23);
VPz=Data(:,25);
Deltax1=(DPx-VPx);
Deltaz1=(DPz-VPz);
angley=atand(Deltax1./Deltaz1);

%Calculation for Z rotation - Use ACPC  Points%

ACx=Data(:,14);
ACy=Data(:,15);
PCx=Data(:,17);
PCy=Data(:,18);
Deltax2=(ACx-PCx);
Deltay2=(ACy-PCy);
Deltax3=Deltax2;
for K=1:5
if Deltax2(K,1)==0 
    Deltax3(K,1)=Deltax2(K,1)-0.5;
else
    Deltax3(K,1)=Deltax2(K,1);
end
end     
anglez=atand(Deltax3./Deltay2);

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
MCP=[X,Y,Z];

%Calculation for X rotation - use AC and MCP

Deltaz=ACz-MCP(:,3);
Deltay=MCP(:,2)-ACy;
anglex=atand(Deltaz./Deltay);