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
    end
end