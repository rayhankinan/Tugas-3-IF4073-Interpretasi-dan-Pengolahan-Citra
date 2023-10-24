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
        function imageData = GetLaplacianEdgeImage(obj, threshold, alpha)
            arguments
                obj wrappers.ColoredImageWrapper
                threshold double {mustBeGreaterThanOrEqual(threshold, 0), mustBeLessThanOrEqual(threshold, 1)}
                alpha double {mustBeGreaterThanOrEqual(alpha, 0), mustBeLessThanOrEqual(alpha, 1)}
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            doubleImageData = im2double(grayImageData);
            h = fspecial('laplacian', alpha);
            imageData = conv2(doubleImageData, h, 'same') > 255 * threshold;
        end
        
        % Get Edge Image using Laplacian of Gaussian Filter
        function imageData = GetLaplacianOfGaussianEdgeImage(obj, threshold, hsize, sigma)
            arguments
                obj wrappers.ColoredImageWrapper
                threshold double {mustBeGreaterThanOrEqual(threshold, 0), mustBeLessThanOrEqual(threshold, 1)}
                hsize double {mustBePositive, mustBeInteger}
                sigma double {mustBeGreaterThanOrEqual(sigma, 0)}
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            doubleImageData = im2double(grayImageData);
            h = fspecial('log', hsize, sigma);
            imageData = conv2(doubleImageData, h, 'same') > 255 * threshold;
        end
        
        % Get Edge Image using Sobel Filter
        function imageData = GetSobelEdgeImage(obj, threshold)
            arguments
                obj wrappers.ColoredImageWrapper
                threshold double {mustBeGreaterThanOrEqual(threshold, 0), mustBeLessThanOrEqual(threshold, 1)}
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            doubleImageData = im2double(grayImageData);
            imageData = edge(doubleImageData, 'Sobel', threshold);
        end
        
        % Get Edge Image using Prewitt Filter
        function imageData = GetPrewittEdgeImage(obj, threshold)
            arguments
                obj wrappers.ColoredImageWrapper
                threshold double {mustBeGreaterThanOrEqual(threshold, 0), mustBeLessThanOrEqual(threshold, 1)}
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            doubleImageData = im2double(grayImageData);
            imageData = edge(doubleImageData, 'Prewitt', threshold);
        end
        
        % Get Edge Image using Roberts Filter
        function imageData = GetRobertsEdgeImage(obj, threshold)
            arguments
                obj wrappers.ColoredImageWrapper
                threshold double {mustBeGreaterThanOrEqual(threshold, 0), mustBeLessThanOrEqual(threshold, 1)}
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            doubleImageData = im2double(grayImageData);
            imageData = edge(doubleImageData, 'Roberts', threshold);
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
                edgeImageData uint8
                radius double {mustBePositive, mustBeInteger}
            end
            
            % Dilate filled edge image
            se = strel('disk', radius);
            dilatedImageData = imdilate(edgeImageData, se);
            
            % Fill holes in edge image
            filledEdgeImageData = imfill(dilatedImageData, 'holes');
            
            % Create mask from filled edge image
            filledEdgeImageMask = filledEdgeImageData > 0;
            
            % Apply mask to original image
            imageData = obj.ImageData .* uint8(filledEdgeImageMask);
        end
    end
end