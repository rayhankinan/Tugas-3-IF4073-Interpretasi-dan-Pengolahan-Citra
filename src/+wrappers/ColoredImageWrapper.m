classdef ColoredImageWrapper < wrappers.BaseImageWrapper
    methods
        % Constructor
        function obj = ColoredImageWrapper(imageData)
            arguments
                imageData uint8;
            end
            
            obj.ImageData = imageData;
            obj.Type = 'color';
        end
        
        % Get Image Size
        function [imageHeight, imageWidth] = GetSize(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            [imageHeight, imageWidth, ~] = size(obj.ImageData);
        end
        
        % Get Image Data
        function data = GetImageData(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            data = obj.ImageData;
        end
        
        % Get Type
        function type = GetType(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            type = obj.Type;
        end
        
        % Get Edge Image using Laplacian Filter
        function imageData = GetLaplacianEdgeImage(obj, alpha)
            arguments
                obj wrappers.ColoredImageWrapper
                alpha double {mustBeGreaterThanOrEqual(alpha, 0), mustBeLessThanOrEqual(alpha, 1)}
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            doubleImageData = im2double(grayImageData);
            h = fspecial('laplacian', alpha);
            imageData = conv2(doubleImageData, h, 'same');
        end
        
        % Get Edge Image using Laplacian of Gaussian Filter
        function imageData = GetLaplacianOfGaussianEdgeImage(obj, hsize, sigma)
            arguments
                obj wrappers.ColoredImageWrapper
                hsize double {mustBePositive, mustBeInteger}
                sigma double {mustBeGreaterThanOrEqual(sigma, 0)}
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            doubleImageData = im2double(grayImageData);
            h = fspecial('log', hsize, sigma);
            imageData = conv2(doubleImageData, h, 'same');
        end
        
        % Get Edge Image using Sobel Filter
        function imageData = GetSobelEdgeImage(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            doubleImageData = im2double(grayImageData);
            imageData = edge(doubleImageData, 'Sobel');
        end
        
        % Get Edge Image using Prewitt Filter
        function imageData = GetPrewittEdgeImage(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            doubleImageData = im2double(grayImageData);
            imageData = edge(doubleImageData, 'Prewitt');
        end
        
        % Get Edge Image using Roberts Filter
        function imageData = GetRobertsEdgeImage(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            doubleImageData = im2double(grayImageData);
            imageData = edge(doubleImageData, 'Roberts');
        end
        
        % Get Edge Image using Canny Filter
        function imageData = GetCannyEdgeImage(obj, threshold, sigma)
            arguments
                obj wrappers.ColoredImageWrapper
                threshold double {mustBeGreaterThanOrEqual(threshold, 0), mustBeLessThanOrEqual(threshold, 1)}
                sigma double {mustBeGreaterThanOrEqual(sigma, 0)}
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            doubleImageData = im2double(grayImageData);
            imageData = edge(doubleImageData, 'Canny', threshold, sigma);
        end
        
        % Get Segmented Image using Edge Detection
        function imageData = GetSegmentedImage(obj, edgeImageData, radius)
            arguments
                obj wrappers.ColoredImageWrapper
                edgeImageData double
                radius double {mustBeNonnegative, mustBeInteger}
            end
            
            % Create black and white image from edge image
            bwEdgeImageData = imbinarize(edgeImageData);
            
            % Dilate filled edge image
            se = strel('disk', radius);
            dilatedImageData = imdilate(bwEdgeImageData, se);
            
            % Fill holes in edge image
            filledEdgeImageData = imfill(dilatedImageData, 'holes');
            
            % Apply mask to original image
            imageData = obj.ImageData .* uint8(filledEdgeImageData);
        end
    end
end