function [anglez, angley, MCP] = VolAngMCP()
%Finding angles of rotation for the different subjects for Y and Z%
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

ACx=Data(:,2);
ACy=Data(:,3);
PCx=Data(:,5);
PCy=Data(:,6);
Deltax=(ACx-PCx);
Deltay=(ACy-PCy);
angley=atand(Deltax./Deltay);

%locating MCP

ACx=Data(:,2);
ACy=Data(:,3);
ACz=Data(:,4);
PCx=Data(:,5);
PCy=Data(:,6);
PCz=Data(:,7);
X=(ACx+PCx)./2;
Y=(ACy+PCy)./2;
Z=(ACz+PCz)./2;
anglez; angley; MCP=[X,Y,Z];