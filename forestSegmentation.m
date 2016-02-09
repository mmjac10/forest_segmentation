function forestSegmentation(image_name, image_type)
    
    clc;
    if nargin==1
        image_type='whole';
    end
    
    image=double(imread(image_name));
    
    %remove non-green regions as much as possible
%     image = removeNonGreenRegions(image_name);
    
    if strcmp(image_type, 'sample')==1
        image=image(1:128, 1:128, :);
    end
    
    smin=16;
    smax=64;
    splitting_threshold=1.01;
    merging_threshold=2.0;
    
    partitions=initiateSplittingAndMerging(image, smax, smin, splitting_threshold, ...
        merging_threshold, image_name);
    
    cluster_image=zeros(size(image, 1), size(image, 2));
    
    for i=1:length(partitions)
       for j=1:length(partitions(i).pixel)
           cluster_image(partitions(i).pixel(j).x, partitions(i).pixel(j).y)=rem( (i+20), 255);         
       end
    end
    
    imshow(cluster_image);

end
