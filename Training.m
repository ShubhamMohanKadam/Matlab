for iii = 1:17

% [f p] = uigetfile('*.*');
I = imread(['dataset\',num2str(iii),'.jpg']);

norm_img = stainnorm_reinhard(I,I);
I = norm_img;

cform = makecform('srgb2lab');

lab_I = applycform(I,cform);
ab = double(lab_I(:,:,2:3));

nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 4;

[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
    'Replicates',3);
pixel_labels = reshape(cluster_idx,nrows,ncols);


% segmented_images = cell(1,3);

rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    
    color = I;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
    
end

Fig1 = segmented_images{1};
Fig2 = segmented_images{2};
Fig3 = segmented_images{3};
Fig4 = segmented_images{4};


figure,
subplot(2,2,1);
imshow(Fig1);
title('Clustered Image 1');
subplot(2,2,2);
imshow(Fig2);
title('Clustered Image 2');
subplot(2,2,3);
imshow(Fig3);
title('Clustered Image 3');
subplot(2,2,4);
imshow(Fig4);
title('Clustered Image 4');


% -- Finding Final Clustered Result -- %
INP = input('Enter the image No. of clustered image [1 - 4] :: ');

switch (INP)
    case 1 
        bw1 = double(segmented_images{1});
        SEGIMG = segmented_images{1};
        bw1 = im2bw(bw1);
    case 2
        bw1 = double(segmented_images{2});
        SEGIMG = segmented_images{2};
        bw1 = im2bw(bw1);
    case 3
        bw1 = double(segmented_images{3});
        SEGIMG = segmented_images{3};
        bw1 = im2bw(bw1);
    case 4 
        bw1 = double(segmented_images{4});
        SEGIMG = segmented_images{4};
        bw1 = im2bw(bw1);
end

freq = medfreq(SEGIMG(:),SEGIMG(1,:));
Varval = var(var(double(SEGIMG)));
SEGIMG1 = imresize(SEGIMG,[256 256]);
Kurt_val = kurtosis(double(SEGIMG));
Skew_val = skewness(double(SEGIMG));
Area_val = area(im2bw(SEGIMG));
Perim_val = mean(bwperim(SEGIMG,8));
Perim_val = Perim_val(:);


% Label the binary image.
labeledImage = bwlabel(im2bw(SEGIMG));
% Measure the solidity of all the blobs.
measurements = regionprops(labeledImage, 'Solidity');
% Sort in oder of decreasing solidity.
[sortedS, sortIndexes] = sort([measurements.Solidity], 'descend');
% Get the solidity of the most solid blob
highestSolidity = sortedS(1);
% Get the label of the most solid blob
labelWithHighestSolidity = sortIndexes(1);

  glcm = graycomatrix(rgb2gray(SEGIMG), 'offset', [0 1], 'Symmetric', true);

  xFeatures = 4:6;
  x = haralickTextureFeatures(glcm, 4:6);

  Harval = x( xFeatures )    ;

  close all;
  GLCM2 = graycomatrix(rgb2gray(SEGIMG),'Offset',[2 0;0 2]);

stats = glcm(GLCM2,0);

v1 = stats.autoc(1);
v2 = stats.contr(1);
v3 = stats.corrm(1);
v4 = stats.corrp(1);
v5 = stats.cprom(1);
v6 = stats.cshad(1);
v7 = stats.dissi(1);
v8 = stats.energ(1);
v9 = stats.entro(1);
v10 = stats.homom(1);
v11 = stats.homop(1);
v12 = stats.maxpr(1);
v13 = stats.idmnc(1);

Glcm_fea = [v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13];


Trainfea(iii,:) = [freq Varval(:)' Kurt_val(:)' Skew_val(:)' Area_val  Perim_val' Glcm_fea];
iii
end

save Trainfea Trainfea