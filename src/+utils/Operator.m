classdef Operator
    methods (Static)
        function paddedData = ApplyLaplacian(imageData, alpha)
            arguments
                imageData uint8
                alpha double {mustBeGreaterThanOrEqual(alpha, 0), mustBeLessThanOrEqual(alpha, 1)}
            end
            
            % Calculate Laplacian
            doubleImageData = im2double(imageData);
            h = fspecial('laplacian', alpha);
            doubleResultData = conv2(doubleImageData, h, 'valid');
            resultData = im2uint8(doubleResultData);
            binarizeData = imbinarize(resultData);
            
            % Pad result
            [imageHeight, imageWidth] = size(imageData);
            [hHeight, hWidth] = size(h);
            padHeight = floor(hHeight / 2);
            padWidth = floor(hWidth / 2);
            paddedData = zeros(imageHeight, imageWidth);
            paddedData(padHeight + 1:imageHeight - padHeight, padWidth + 1:imageWidth - padWidth) = binarizeData;
        end
        
        function paddedData = ApplyLaplacianOfGaussian(imageData, hsize, sigma)
            arguments
                imageData uint8
                hsize double {mustBePositive, mustBeInteger}
                sigma double {mustBePositive}
            end
            
            % Calculate Laplacian of Gaussian
            doubleImageData = im2double(imageData);
            h = fspecial('log', hsize, sigma);
            doubleResultData = conv2(doubleImageData, h, 'valid');
            resultData = im2uint8(doubleResultData);
            binarizeData = imbinarize(resultData);
            
            % Pad result
            [imageHeight, imageWidth] = size(imageData);
            [hHeight, hWidth] = size(h);
            padHeight = floor(hHeight / 2);
            padWidth = floor(hWidth / 2);
            paddedData = zeros(imageHeight, imageWidth);
            
            if mod(hHeight, 2) == 0
                paddedData(padHeight:imageHeight - padHeight, padWidth:imageWidth - padWidth) = binarizeData;
            else
                paddedData(padHeight + 1:imageHeight - padHeight, padWidth + 1:imageWidth - padWidth) = binarizeData;
            end
        end
        
        function paddedData = ApplySobel(imageData)
            arguments
                imageData uint8
            end
            
            % Calculate Sobel
            doubleImageData = im2double(imageData);
            h = fspecial('sobel');
            v = h';
            doubleResultData = sqrt(conv2(doubleImageData, h, 'valid') .^ 2 + conv2(doubleImageData, v, 'valid') .^ 2);
            resultData = im2uint8(doubleResultData);
            binarizeData = imbinarize(resultData);
            
            % Pad result
            [imageHeight, imageWidth] = size(imageData);
            [hHeight, hWidth] = size(h);
            padHeight = floor(hHeight / 2);
            padWidth = floor(hWidth / 2);
            paddedData = zeros(imageHeight, imageWidth);
            paddedData(padHeight + 1:imageHeight - padHeight, padWidth + 1:imageWidth - padWidth) = binarizeData;
        end
        
        function paddedData = ApplyPrewitt(imageData)
            arguments
                imageData uint8
            end
            
            % Calculate Prewitt
            doubleImageData = im2double(imageData);
            h = fspecial('prewitt');
            v = h';
            doubleResultData = sqrt(conv2(doubleImageData, h, 'valid') .^ 2 + conv2(doubleImageData, v, 'valid') .^ 2);
            resultData = im2uint8(doubleResultData);
            binarizeData = imbinarize(resultData);
            
            % Pad result
            [imageHeight, imageWidth] = size(imageData);
            [hHeight, hWidth] = size(h);
            padHeight = floor(hHeight / 2);
            padWidth = floor(hWidth / 2);
            paddedData = zeros(imageHeight, imageWidth);
            paddedData(padHeight + 1:imageHeight - padHeight, padWidth + 1:imageWidth - padWidth) = binarizeData;
        end
        
        function paddedData = ApplyRoberts(imageData)
            arguments
                imageData uint8
            end
            
            % Calculate Roberts
            doubleImageData = im2double(imageData);
            rPlus = [1 0; 0 -1];
            rMinus = [0 1; -1 0];
            doubleResultData = sqrt(conv2(doubleImageData, rPlus, 'valid') .^ 2 + conv2(doubleImageData, rMinus, 'valid') .^ 2);
            resultData = im2uint8(doubleResultData);
            binarizeData = imbinarize(resultData);
            
            % Pad result
            [imageHeight, imageWidth] = size(imageData);
            [hHeight, hWidth] = size(rPlus);
            padHeight = floor(hHeight / 2);
            padWidth = floor(hWidth / 2);
            paddedData = zeros(imageHeight, imageWidth);
            paddedData(padHeight:imageHeight - padHeight, padWidth:imageWidth - padWidth) = binarizeData;
        end
        
        function segmentedData = ApplySegmentation(imageData, edgeImageData, radius, minimumPixel)
            arguments
                imageData uint8
                edgeImageData logical
                radius double {mustBeNonnegative, mustBeInteger}
                minimumPixel double {mustBeNonnegative, mustBeInteger}
            end
            
            % Create structuring element
            se = strel('disk', radius);
            
            % Close the edge image
            closedImageData = imclose(edgeImageData, se);
            
            % Remove border objects
            borderImageData = imclearborder(closedImageData);
            
            % Fill holes in edge image
            filledEdgeImageData = imfill(borderImageData, 'holes');
            
            % Open the edge image
            openedImageData = imopen(filledEdgeImageData, se);
            
            % Remove small objects
            removedImageData = bwareaopen(openedImageData, minimumPixel);
            
            % Apply mask to original image
            segmentedData = imageData .* uint8(removedImageData);
        end
    end
end