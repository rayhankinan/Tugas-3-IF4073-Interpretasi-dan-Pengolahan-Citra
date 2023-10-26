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
        
        % Get Edge Image using Laplacian Filter
        GetLaplacianEdgeImage(obj, alpha)
        
        % Get Edge Image using Laplacian of Gaussian Filter
        GetLaplacianOfGaussianEdgeImage(obj, hsize, sigma)
        
        % Get Edge Image using Sobel Filter
        GetSobelEdgeImage(obj)
        
        % Get Edge Image using Prewitt Filter
        GetPrewittEdgeImage(obj)
        
        % Get Edge Image using Roberts Filter
        GetRobertsEdgeImage(obj)
        
        % Get Edge Image using Canny Filter
        GetCannyEdgeImage(obj, threshold, sigma)
        
        % Get Segmented Image using Edge Detection
        GetSegmentedImage(obj, edgeImageData, radius, minimumPixel)
    end
end