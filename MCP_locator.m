function MCP = MCP_locator()
% Need to rotate images around a central, uniform point %
% Loading ACPC data to use for calculating MCP          %
Data=xlsread('/Users/finks/Desktop/Projects/STN_Figure/STN_Midline.xlsx');

ACx=Data(:,2);
ACy=Data(:,3);
ACz=Data(:,4);
PCx=Data(:,5);
PCy=Data(:,6);
PCz=Data(:,7);
X=(ACx+PCx)./2;
Y=(ACy+PCy)./2;
Z=(ACz+PCz)./2;
MCP=[X,Y,Z];
