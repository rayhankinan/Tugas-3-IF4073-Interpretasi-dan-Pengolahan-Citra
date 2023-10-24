classdef (Abstract) BaseImageWrapper
    properties
        ImageData uint8 {mustBeNumeric}
        Type string {mustBeMember(Type, {'grayscale', 'color'})}
    end
    
    methods
        % Get Image Size
        GetSize(obj)
        
        % Get Image Data
        GetImageData(obj)
        
        % Get Image Type
        GetType(obj)
    end
end