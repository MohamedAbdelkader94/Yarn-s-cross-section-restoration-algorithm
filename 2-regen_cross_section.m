clear;clc;
[FileName1,PathName1] = uigetfile({'*.tif'},'Select one of the images in the directory');

%Image directory

im_dir2=[PathName1,FileName1];
im_dir22=join(im_dir2);
ref_image=imread(im_dir2);
dim_ref=size(ref_image);
a1=dir([PathName1 '/*.jpg']);


[FileName,PathName] = uigetfile({'*.xlsx'},'Select the first cross section Image');

a=dir([PathName '/*.xlsx']);
%Number of sheets
xls_n = numel(a);   %No of sheets in the directory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index=1;

%Loop on each image and detect the cross sections in it
for k = 1:xls_n 
    %Read the Kth xlsx sheet 
   
im_dir=[PathName,a(k).name];
im_dir1=join(im_dir);
num = xlsread(im_dir1);
x_points=num(:,1);
y_points=num(:,2);

%Diameter as measured for the previous cross section algorithm
%diameter=num(:,3);
dim=size(x_points);

%diameter as an average value, constant diameter on the generated cross
%section
diameter=8.*ones(dim(1),1);

% Create a logical image of a circle with specified
% diameter, center, and image size.
% First create the image.
imageSizeX = dim_ref(1);
imageSizeY = dim_ref(2);
[columnsInImage rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
% Next create the circle in the image.
dim=size(diameter);
dim=dim(1);
%Create empty image for accumilation of each single fiber into the cross
%section image
circlePixels2=imbinarize(zeros(dim_ref(2),dim_ref(1)));
for i=1:dim
%centerX = x_points(i).*2;
%centerY = y_points(i).*2;
%radius = diameter(i).*2;

centerX = x_points(i);
centerY = y_points(i);
radius = diameter(i);

circlePixels = (rowsInImage - centerY).^2 ...
    + (columnsInImage - centerX).^2 <= radius.^2;
% circlePixels is a 2D "logical" array.
% Now, display it.
circlePixels2=circlePixels2 | circlePixels;

Image = getframe(gcf);


colormap([0 0 0; 1 1 1]);
end

image(circlePixels2) ;
imshow(circlePixels2)
Image = getframe(gcf);
name_format=a(k).name;
name_format=name_format(1:8);
name_format=strcat(name_format,'.jpg');
%%imwrite(Image.cdata, join(a(k).name,'out'),'jpg');
imwrite(Image.cdata, join([PathName1,name_format]));
end