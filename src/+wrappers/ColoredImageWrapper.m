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
    end
end