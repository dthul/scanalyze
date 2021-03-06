function dp=imdist(name,par,p)
%IMDIST distorts image coordinates with radial and tangential error
%components.
%
%Usage:
%   dp=imdist(name,par,p)
%
%where
%   name = string that is specific to the camera and the framegrabber.
%          This string must be defined in configc.m
%   par  = camera intrinsic parameters
%   p    = image coordinates (in pixels) to be distorted (n x 2 matrix)
%   dp   = distorted image coordinates

%   Version 2.0  15.5.-97
%   Janne Heikkila, University of Oulu, Finland

sys=configc(name);
NDX=sys(1); NDY=sys(2); Sx=sys(3); Sy=sys(4);
Asp=par(1); Foc=par(2);
Cpx=par(3); Cpy=par(4);
Rad1=par(5); Rad2=par(6);
Tan1=par(7); Tan2=par(8);

cx=(p(:,1)-Cpx)*Sx/NDX/Asp;
cy=(p(:,2)-Cpy)*Sy/NDY;

r2=cx.*cx+cy.*cy;
delta=Rad1*r2+Rad2*r2.*r2;

dx=cx.*(1+delta)+2*Tan1*cx.*cy+Tan2*(r2+2*cx.*cx); 
dy=cy.*(1+delta)+Tan1*(r2+2*cy.*cy)+2*Tan2*cx.*cy; 

dp=NDX*Asp*dx/Sx+Cpx;
dp(:,2)=NDY*dy/Sy+Cpy;
