clear
clc
load('C:\Users')% run this line first
AA = double(squeeze(Avizo_nameinworkspace));%change the name to the one in workspace
AA_x = squeeze(AA(1,:,:));
AA_y = squeeze(AA(2,:,:));
alpha = zeros(size(AA_x));
for m = 1:size(AA_x,1)
    for n = 1:size(AA_x,2)
        if AA_x(m,n) >= 0 && AA_y(m,n) >= 0
            alpha(m,n) = asin(abs(AA_y(m,n))/(AA_x(m,n)^2+AA_y(m,n)^2)) * 180 / pi;
        elseif AA_x(m,n) < 0 && AA_y(m,n) >= 0
            alpha(m,n) = 180 - (asin(abs(AA_y(m,n))/(AA_x(m,n)^2+AA_y(m,n)^2)) * 180 / pi);
        elseif AA_x(m,n) < 0 && AA_y(m,n) < 0
            alpha(m,n) = (asin(abs(AA_y(m,n))/(AA_x(m,n)^2+AA_y(m,n)^2)) * 180 / pi) + 180;
        elseif AA_x(m,n) >= 0 && AA_y(m,n) < 0
            alpha(m,n) = 360 - (abs(AA_y(m,n))/(AA_x(m,n)^2+AA_y(m,n)^2) * 180 / pi);
        end
    end
end
figure,hist(alpha(:),360) %show the angle histogram, here we divide the 360 degrees to 360 equal sections
[save_alphaY,save_alphaX]=hist(alpha(:),360);%save the histogram, alphaX is the X axis, alphaY is the Y axis

AA_abs = sqrt(AA_x.^2 + AA_y.^2);
AA_abs_nonzero = AA_abs;
AA_abs_nonzero(AA_abs_nonzero == 0) = [];
figure,hist(AA_abs_nonzero,500)
[save_sizeY,save_sizeX]=hist(AA_abs_nonzero(:,18),500);


%% size VS angle

p = 36;     % divide 360 degree into p part (i.e. 0~10,10~20,...,350~360), you can choose other number like: 18 or 10....
size = zeros(1,p); 
for i = 1:p
    alpha_position = find(alpha >= (i-1)*(360/p) & alpha < i*(360/p));
    size(i) = mean(AA_abs(alpha_position));
end
size(isnan(size)) = 0;  % average size of vector of 0~10,10~20,...,350~360
angle = 1:p;  % number of angle range

figure,plot(angle,size) % size VS angle
