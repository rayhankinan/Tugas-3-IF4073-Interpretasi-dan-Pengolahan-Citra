classdef Operator
    methods (Static)
        function binarizeData = ApplyLaplacian(imageData, alpha)
            arguments
                imageData uint8
                alpha double {mustBeGreaterThanOrEqual(alpha, 0), mustBeLessThanOrEqual(alpha, 1)}
            end
            
            doubleImageData = im2double(imageData);
            h = fspecial('laplacian', alpha);
            doubleResultData = conv2(doubleImageData, h, 'same');
            resultData = im2uint8(doubleResultData);
            binarizeData = imbinarize(resultData);
        end
        
        function binarizeData = ApplyLaplacianOfGaussian(imageData, hsize, sigma)
            arguments
                imageData uint8
                hsize double {mustBePositive, mustBeInteger}
                sigma double {mustBePositive}
            end
            
            doubleImageData = im2double(imageData);
            h = fspecial('log', hsize, sigma);
            doubleResultData = conv2(doubleImageData, h, 'same');
            resultData = im2uint8(doubleResultData);
            binarizeData = imbinarize(resultData);
        end
        
        function segmentedData = ApplySegmentation(imageData, edgeImageData, radius)
            arguments
                imageData uint8
                edgeImageData logical
                radius double {mustBeNonnegative, mustBeInteger}
            end
            
            % Dilate filled edge image
            se = strel('disk', radius);
            dilatedImageData = imdilate(edgeImageData, se);
            
            % Fill holes in edge image
            filledEdgeImageData = imfill(dilatedImageData, 'holes');
            
            % Apply mask to original image
            segmentedData = imageData .* uint8(filledEdgeImageData);
        end
    end
end