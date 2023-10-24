classdef ImageWrapperFactory
    methods (Static)
        function wrapper = Create(imageData)
            arguments
                imageData uint8
            end % arguments
            
            if size(imageData, 3) == 3
                wrapper = wrappers.ColoredImageWrapper(imageData);
            else
                wrapper = wrappers.GrayscaleImageWrapper(imageData);
            end
        end
    end
end