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
            imageData = utils.Operator.ApplyLaplacian(grayImageData, alpha);
        end
        
        % Get Edge Image using Laplacian of Gaussian Filter
        function imageData = GetLaplacianOfGaussianEdgeImage(obj, hsize, sigma)
            arguments
                obj wrappers.ColoredImageWrapper
                hsize double {mustBePositive, mustBeInteger}
                sigma double {mustBePositive}
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            imageData = utils.Operator.ApplyLaplacianOfGaussian(grayImageData, hsize, sigma);
        end
        
        % Get Edge Image using Sobel Filter
        function imageData = GetSobelEdgeImage(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            imageData = utils.Operator.ApplySobel(grayImageData);
        end
        
        % Get Edge Image using Prewitt Filter
        function imageData = GetPrewittEdgeImage(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            imageData = utils.Operator.ApplyPrewitt(grayImageData);
        end
        
        % Get Edge Image using Roberts Filter
        function imageData = GetRobertsEdgeImage(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            imageData = utils.Operator.ApplyRoberts(grayImageData);
        end
        
        % Get Edge Image using Canny Filter
        function imageData = GetCannyEdgeImage(obj, threshold, sigma)
            arguments
                obj wrappers.ColoredImageWrapper
                threshold double {mustBeGreaterThanOrEqual(threshold, 0), mustBeLessThanOrEqual(threshold, 1)}
                sigma double {mustBePositive}
            end
            
            grayImageData = rgb2gray(obj.ImageData);
            doubleImageData = im2double(grayImageData);
            imageData = edge(doubleImageData, 'Canny', threshold, sigma);
        end
        
        % Get Segmented Image using Edge Detection
        function imageData = GetSegmentedImage(obj, edgeImageData, radius, minimumPixel)
            arguments
                obj wrappers.ColoredImageWrapper
                edgeImageData double
                radius double {mustBeNonnegative, mustBeInteger}
                minimumPixel double {mustBeNonnegative, mustBeInteger}
            end
            
            imageData = utils.Operator.ApplySegmentation(obj.ImageData, edgeImageData, radius, minimumPixel);
        end
    end
end