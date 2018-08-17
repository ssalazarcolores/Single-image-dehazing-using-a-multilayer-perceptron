[file,absPath]=uigetfile('*.tif;*.bmp;*.png;*.jpeg;*.jpg;*.gif','File Image');
name=[absPath file];
image = double(imread(name))/255.0;

tic
result= dehaze(image, 0.7,8);
toc


