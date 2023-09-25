close all;
%% Image initiation
[FileName,PathName] = uigetfile({'*.tif';'*.jpg'},'Select the Microscopic Image, Please select a closed contour');
SEM_Org=imread(strcat(PathName,FileName));    % Read image 
imshow(SEM_Org);

%Get a croped part of the image
corped1 = imcrop(SEM_Org);


[y x]=size(corped1);
correction_factor=floor(y/3);

%Visual tolld to measure the SEM image bar length 
measure=imtool(SEM_Org);


bar_pixels_length=input('Please eneter the measured bar length ');
bar_real_length=input('Please enter the real bar length in micrometers ');

%If colored image transform to grayscale image
im_size=size(SEM_Org);
dimensionality=size(im_size);
if dimensionality(2) ==3
I2 = rgb2gray(corped1);
else 
    I2=corped1;
end



T = adaptthresh(I2, 0.5);




Binary_im=imbinarize(I2,T);
figure;
imshow(Binary_im)
Binary_im=padarray(Binary_im,[1 0],1);

%Fill any gaps in between the binariazed fibers 
Binary_im2=bwareaopen(Binary_im,500);
Binary_im2= bwmorph(Binary_im2,'thicken',2);
%Binary_im2=bwareaopen(Binary_im2,600);
Binary_im2= bwmorph(Binary_im2,'bridge',Inf);
Binary_im2= bwmorph(Binary_im2,'bridge',Inf);
Binary_im2= imfill(Binary_im2,8,'holes');

figure;
imshow(Binary_im2)
title("Before Corecction")


%Remove individual objects( Background noise)




%The diamter (in pixels) of the yarn at each row is the sum of white pixels accros that
%row 

size_correction=sum(Binary_im2);


correction_indicies=find(size_correction > correction_factor);

min_index=min(correction_indicies);
max_index=max(correction_indicies);

Binary_im3 = Binary_im2(:,min_index:max_index);

figure;
imshow(Binary_im3)
title("After Correction")

size_matrix_pixels=sum(Binary_im3');
%Exclude the padded ones to the top and the bottom of the image
size_matrix_pixels_new=size_matrix_pixels(2:end-1);


%Calculate the real distances
distances_real=((size_matrix_pixels_new.*bar_real_length)./bar_pixels_length)./1000;


figure;
histfit(distances_real)
xlabel('Diameter in mm')
ylabel('Frequency');
mu=mean(distances_real);    % Average yarn diameter
title(sprintf('The average yarn diameter is %.2f',mu));
mean_diameter= mean(distances_real);

fprintf('The mean diameter of the yarn is : %.2f mm.\n', mean_diameter)
diameter_variance=std(distances_real);
fprintf('The std is : %.2f mm.\n', diameter_variance)


