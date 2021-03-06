function edge=cmpc(image,nscale,r,mu,k4,cutoff,de,noiseMethod)
if size(image,3)==3
    image=rgb2gray(image);
end
[m,n]=size(image);mu=2;
r=0.5;  size1=3;  s1=7;  noiseMethod=-2;
cutoff=0.3; g=10; kk=3;  epsilon=0.001; mult=5;
sumAn=zeros(m,n);
sumph=zeros(m,n); sumcu=zeros(m,n);
sumrp=zeros(m,n); sumrx=zeros(m,n);sumry=zeros(m,n);sumrz=zeros(m,n);
M0=-1/(size1^2)*ones(size1);  M0(floor(size1/2)+1,floor(size1/2)+1)=(size1^2-1)/size1^2;  image0=conv2(image,M0,'same');
for k=1:nscale
    rp=zeros(size1); rx=zeros(size1); ry=zeros(size1); rz=zeros(size1);
    cx=(-(size1-1)/2:(size1-1)/2)'*ones(1,size1);     cy=cx';
    d=cx.^2+cy.^2+1;      u=cx./d;  v=cy./d;  w=(d-1)./d;   uvw=u.^2+v.^2+w.^2;
%   pf=s1*r^k./(2*pi*((s*r^k)^2+uvw).^2);  pc=s2*r^(k-1)./(2*pi*((s2*r^(k-1))^2+uvw).^2);
    pf=1./(2*pi*((s1*r^k)^2+uvw).^2);  pc=1./(2*pi*((s1*r^(k-1))^2+uvw).^2);
%     pfpf=sqrt(uvw)./(2*pi*((s1*r^k)^2+uvw).^2);  pcpc=sqrt(uvw)./(2*pi*((s1*r^(k-1))^2+uvw).^2);
    pcc=(s1*r^k)*pf-(s1*r^(k-1))*pc;
%     pcc(floor(size1/2)+1,floor(size1/2)+1)=-1*pcc(floor(size1/2)+1,floor(size1/2)+1);
    uc=(pf-pc).*u;   vc=(pf-pc).*v;   wc=(pf-pc).*w;
    rp=conv2(image0,pcc,'same'); rx=conv2(image,uc,'same'); ry=conv2(image,vc,'same');  rz=conv2(image0,wc,'same');
    en=sqrt(rx.^2+ry.^2+rp.^2+rz.^2);
%   ph=atan2(sqrt(rx.^2+ry.^2+rz.^2),rp);
%   cu=atan2(sqrt(rx.^2+ry.^2),rz);
    sumAn=sumAn+en;  sumrp=sumrp+rp;  sumrx=sumrx+rx;  sumry=sumry+ry;  sumrz=sumrz+rz;
end
%     curvature=atan2(sqrt(sumrx.^2+sumry.^2),sumrz);
%     direction=atan2(sumry,sumrx);
%     phase=atan2(sqrt(sumrx.^2+sumry.^2+sumrz.^2),sumrp);

ph=atan2(sqrt(rx.^2+ry.^2+rz.^2),rp);
energy=sqrt(sumrx.^2+sumry.^2+sumrp.^2+sumrz.^2);
% energy=(energy-min(min(energy)))./(max(max(energy))-min(min(energy)));  
% energy=mat2gray(energy);
[M1 or ft T] = phasecongmono(image, 5, 3, 2.1, 0.55, 3.0,0.2,10,0.5,-1);
% M1= phasecong3(image,nscale,6,3,2.0,0.55,k4,cutoff,10,noiseMethod);
edge=mat2gray(energy).*M1;
% pc=mat2gray(energy).*PC1;
end
%  or = atan(-sumry./(sumrx+0.0001));   
%  or(or<0) = or(or<0)+pi;   
%  or = fix(or/pi*180);
%  nonmax = nonmaxsup(energy, or, 1); 
%  figure,imshow(nonmax,[]);

