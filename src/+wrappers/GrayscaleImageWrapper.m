classdef GrayscaleImageWrapper < wrappers.BaseImageWrapper
    methods
        % Constructor
        function obj = GrayscaleImageWrapper(imageData)
            arguments
                imageData uint8
            end
            
            obj.ImageData = imageData;
            obj.Type = 'grayscale';
        end
        
        % Get Image Size
        function [imageHeight, imageWidth] = GetSize(obj)
            arguments
                obj wrappers.GrayscaleImageWrapper
            end
            
            [imageHeight, imageWidth] = size(obj.ImageData);
        end
        
        % Get Image Data
        function data = GetImageData(obj)
            arguments
                obj wrappers.GrayscaleImageWrapper
            end
            
            data = obj.ImageData;
        end
        
        % Get Type
        function type = GetType(obj)
            arguments
                obj wrappers.GrayscaleImageWrapper
            end
            
            type = obj.Type;
        end
        
        % Get Edge Image using Laplacian Filter
        function imageData = GetLaplacianEdgeImage(obj, threshold)
            arguments
                obj wrappers.GrayscaleImageWrapper
                threshold double
            end
            
            imageData = conv2(obj.ImageData, [0 1 0; 1 -4 1; 0 1 0], 'same') > threshold;
        end
        
        % Get Edge Image using Laplacian of Gaussian Filter
        function imageData = GetLaplacianOfGaussianEdgeImage(obj, threshold, sigma)
            arguments
                obj wrappers.GrayscaleImageWrapper
                threshold double
                sigma double
            end
            
            imageData = edge(obj.ImageData, 'log', threshold, sigma);
        end
        
        % Get Edge Image using Sobel Filter
        function imageData = GetSobelEdgeImage(obj, threshold)
            arguments
                obj wrappers.GrayscaleImageWrapper
                threshold double
            end
            
            imageData = edge(obj.ImageData, 'Sobel', threshold);
        end
        
        % Get Edge Image using Prewitt Filter
        function imageData = GetPrewittEdgeImage(obj, threshold)
            arguments
                obj wrappers.GrayscaleImageWrapper
                threshold double
            end
            
            imageData = edge(obj.ImageData, 'Prewitt', threshold);
        end
        
        % Get Edge Image using Roberts Filter
        function imageData = GetRobertsEdgeImage(obj, threshold)
            arguments
                obj wrappers.GrayscaleImageWrapper
                threshold double
            end
            
            imageData = edge(obj.ImageData, 'Roberts', threshold);
        end
        
        % Get Edge Image using Canny Filter
        function imageData = GetCannyEdgeImage(obj, threshold, sigma)
            arguments
                obj wrappers.GrayscaleImageWrapper
                threshold double
                sigma double
            end
            
            obj.ImageData
            
            imageData = edge(obj.ImageData, 'Canny', threshold, sigma);
        end
        
        % Get Segmented Image using Edge Detection
        function imageData = GetSegmentedImage(obj, edgeImageData, radius)
            arguments
                obj wrappers.GrayscaleImageWrapper
                edgeImageData uint8
                radius double
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