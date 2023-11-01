classdef app_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        TabGroup                    matlab.ui.container.TabGroup
        LaplacianTab                matlab.ui.container.Tab
        LaplacianPixelEditField     matlab.ui.control.NumericEditField
        PixelEditFieldLabel_6       matlab.ui.control.Label
        LaplacianRadiusEditField    matlab.ui.control.NumericEditField
        RadiusEditFieldLabel_6      matlab.ui.control.Label
        LaplacianAlphaEditField     matlab.ui.control.NumericEditField
        AlphaLabel                  matlab.ui.control.Label
        LaplacianGoButton           matlab.ui.control.Button
        LaplacianUploadImageButton  matlab.ui.control.Button
        LaplacianOutputImage        matlab.ui.control.UIAxes
        LaplacianEdgeImage          matlab.ui.control.UIAxes
        LaplacianInputImage         matlab.ui.control.UIAxes
        LoGTab                      matlab.ui.container.Tab
        LoGPixelEditField           matlab.ui.control.NumericEditField
        PixelEditFieldLabel_5       matlab.ui.control.Label
        LoGSigmaEditField           matlab.ui.control.NumericEditField
        SigmaEditFieldLabel_2       matlab.ui.control.Label
        LoGRadiusEditField          matlab.ui.control.NumericEditField
        RadiusEditFieldLabel_5      matlab.ui.control.Label
        LoGSizeEditField            matlab.ui.control.NumericEditField
        SizeLabel                   matlab.ui.control.Label
        LoGGoButton                 matlab.ui.control.Button
        LoGUploadImageButton        matlab.ui.control.Button
        LoGOutputImage              matlab.ui.control.UIAxes
        LoGEdgeImage                matlab.ui.control.UIAxes
        LoGInputImage               matlab.ui.control.UIAxes
        SobelTab                    matlab.ui.container.Tab
        SobelPixelEditField         matlab.ui.control.NumericEditField
        PixelEditFieldLabel_4       matlab.ui.control.Label
        SobelRadiusEditField        matlab.ui.control.NumericEditField
        RadiusEditFieldLabel_4      matlab.ui.control.Label
        SobelGoButton               matlab.ui.control.Button
        SobelUploadImageButton      matlab.ui.control.Button
        SobelOutputImage            matlab.ui.control.UIAxes
        SobelEdgeImage              matlab.ui.control.UIAxes
        SobelInputImage             matlab.ui.control.UIAxes
        PrewittTab                  matlab.ui.container.Tab
        PrewittPixelEditField       matlab.ui.control.NumericEditField
        PixelEditFieldLabel_3       matlab.ui.control.Label
        PrewittRadiusEditField      matlab.ui.control.NumericEditField
        RadiusEditFieldLabel_3      matlab.ui.control.Label
        PrewittGoButton             matlab.ui.control.Button
        PrewittUploadImageButton    matlab.ui.control.Button
        PrewittOutputImage          matlab.ui.control.UIAxes
        PrewittEdgeImage            matlab.ui.control.UIAxes
        PrewittInputImage           matlab.ui.control.UIAxes
        RobertsTab                  matlab.ui.container.Tab
        RobertsPixelEditField       matlab.ui.control.NumericEditField
        PixelEditFieldLabel_2       matlab.ui.control.Label
        RobertsRadiusEditField      matlab.ui.control.NumericEditField
        RadiusEditFieldLabel_2      matlab.ui.control.Label
        RobertsGoButton             matlab.ui.control.Button
        RobertsUploadImageButton    matlab.ui.control.Button
        RobertsOutputImage          matlab.ui.control.UIAxes
        RobertsEdgeImage            matlab.ui.control.UIAxes
        RobertsInputImage           matlab.ui.control.UIAxes
        CannyTab                    matlab.ui.container.Tab
        CannyPixelEditField         matlab.ui.control.NumericEditField
        PixelEditFieldLabel         matlab.ui.control.Label
        CannyRadiusEditField        matlab.ui.control.NumericEditField
        RadiusEditFieldLabel        matlab.ui.control.Label
        CannyGoButton               matlab.ui.control.Button
        CannySigmaEditField         matlab.ui.control.NumericEditField
        SigmaEditFieldLabel         matlab.ui.control.Label
        CannyThresholdEditField     matlab.ui.control.NumericEditField
        ThresholdEditFieldLabel     matlab.ui.control.Label
        CannyUploadImageButton      matlab.ui.control.Button
        CannyOutputImage            matlab.ui.control.UIAxes
        CannyEdgeImage              matlab.ui.control.UIAxes
        CannyInputImage             matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: LaplacianUploadImageButton
        function LaplacianUploadImageButtonPushed(app, event)
            filterspec = {'*.jpg;*.tif;*.png;*.bmp','All Image Files'};
            [filename, pathname] = uigetfile(filterspec);
            
            % If the user cancels, return.
            if ~ischar(filename)
                return;
            end
            
            % Construct the full file path.
            filepath = fullfile(pathname, filename);
            
            % Read the image.
            imageData = imread(filepath);
            
            % Show the image.
            imshow(imageData, 'Parent', app.LaplacianInputImage, 'XData', [1 app.LaplacianInputImage.Position(3)], 'YData', [1 app.LaplacianInputImage.Position(4)]);
        end

        % Button pushed function: LaplacianGoButton
        function LaplacianGoButtonPushed(app, event)
            % Get parameter.
            alpha = app.LaplacianAlphaEditField.Value;
            radius = app.LaplacianRadiusEditField.Value;
            minimumPixel = app.LaplacianPixelEditField.Value;

            % Get image.
            imageData = getimage(app.LaplacianInputImage);

            % Create wrapper.
            currentWrapper = utils.ImageWrapperFactory.Create(imageData);

            % Calculate edge image.
            edgeImageData = currentWrapper.GetLaplacianEdgeImage(alpha);

            % Calculate segmented image.
            segmentedImageData = currentWrapper.GetSegmentedImage(edgeImageData, radius, minimumPixel);

            % Show the results.
            imshow(edgeImageData, 'Parent', app.LaplacianEdgeImage, 'XData', [1 app.LaplacianEdgeImage.Position(3)], 'YData', [1 app.LaplacianEdgeImage.Position(4)]);
            imshow(segmentedImageData, 'Parent', app.LaplacianOutputImage, 'XData', [1 app.LaplacianOutputImage.Position(3)], 'YData', [1 app.LaplacianOutputImage.Position(4)]);
        end

        % Button pushed function: LoGUploadImageButton
        function LoGUploadImageButtonPushed(app, event)
            filterspec = {'*.jpg;*.tif;*.png;*.bmp','All Image Files'};
            [filename, pathname] = uigetfile(filterspec);
            
            % If the user cancels, return.
            if ~ischar(filename)
                return;
            end
            
            % Construct the full file path.
            filepath = fullfile(pathname, filename);
            
            % Read the image.
            imageData = imread(filepath);
            
            % Show the image.
            imshow(imageData, 'Parent', app.LoGInputImage, 'XData', [1 app.LoGInputImage.Position(3)], 'YData', [1 app.LoGInputImage.Position(4)]);
        end

        % Button pushed function: LoGGoButton
        function LoGGoButtonPushed(app, event)
            % Get parameter.
            hsize = app.LoGSizeEditField.Value;
            sigma = app.LoGSigmaEditField.Value;
            radius = app.LoGRadiusEditField.Value;
            minimumPixel = app.LoGPixelEditField.Value;

            % Get image.
            imageData = getimage(app.LoGInputImage);

            % Create wrapper.
            currentWrapper = utils.ImageWrapperFactory.Create(imageData);

            % Calculate edge image.
            edgeImageData = currentWrapper.GetLaplacianOfGaussianEdgeImage(hsize, sigma);

            % Calculate segmented image.
            segmentedImageData = currentWrapper.GetSegmentedImage(edgeImageData, radius, minimumPixel);

            % Show the results.
            imshow(edgeImageData, 'Parent', app.LoGEdgeImage, 'XData', [1 app.LoGEdgeImage.Position(3)], 'YData', [1 app.LoGEdgeImage.Position(4)]);
            imshow(segmentedImageData, 'Parent', app.LoGOutputImage, 'XData', [1 app.LoGOutputImage.Position(3)], 'YData', [1 app.LoGOutputImage.Position(4)]);
        end

        % Button pushed function: SobelUploadImageButton
        function SobelUploadImageButtonPushed(app, event)
            filterspec = {'*.jpg;*.tif;*.png;*.bmp','All Image Files'};
            [filename, pathname] = uigetfile(filterspec);
            
            % If the user cancels, return.
            if ~ischar(filename)
                return;
            end
            
            % Construct the full file path.
            filepath = fullfile(pathname, filename);
            
            % Read the image.
            imageData = imread(filepath);
            
            % Show the image.
            imshow(imageData, 'Parent', app.SobelInputImage, 'XData', [1 app.SobelInputImage.Position(3)], 'YData', [1 app.SobelInputImage.Position(4)]);
        end

        % Button pushed function: SobelGoButton
        function SobelGoButtonPushed(app, event)
            % Get parameter.
            radius = app.SobelRadiusEditField.Value;
            minimumPixel = app.SobelPixelEditField.Value;

            % Get image.
            imageData = getimage(app.SobelInputImage);

            % Create wrapper.
            currentWrapper = utils.ImageWrapperFactory.Create(imageData);

            % Calculate edge image.
            edgeImageData = currentWrapper.GetSobelEdgeImage();

            % Calculate segmented image.
            segmentedImageData = currentWrapper.GetSegmentedImage(edgeImageData, radius, minimumPixel);

            % Show the results.
            imshow(edgeImageData, 'Parent', app.SobelEdgeImage, 'XData', [1 app.SobelEdgeImage.Position(3)], 'YData', [1 app.SobelEdgeImage.Position(4)]);
            imshow(segmentedImageData, 'Parent', app.SobelOutputImage, 'XData', [1 app.SobelOutputImage.Position(3)], 'YData', [1 app.SobelOutputImage.Position(4)]);
        end

        % Button pushed function: PrewittUploadImageButton
        function PrewittUploadImageButtonPushed(app, event)
            filterspec = {'*.jpg;*.tif;*.png;*.bmp','All Image Files'};
            [filename, pathname] = uigetfile(filterspec);
            
            % If the user cancels, return.
            if ~ischar(filename)
                return;
            end
            
            % Construct the full file path.
            filepath = fullfile(pathname, filename);
            
            % Read the image.
            imageData = imread(filepath);
            
            % Show the image.
            imshow(imageData, 'Parent', app.PrewittInputImage, 'XData', [1 app.PrewittInputImage.Position(3)], 'YData', [1 app.PrewittInputImage.Position(4)]);
        end

        % Button pushed function: PrewittGoButton
        function PrewittGoButtonPushed(app, event)
            % Get parameter.
            radius = app.PrewittRadiusEditField.Value;
            minimumPixel = app.PrewittPixelEditField.Value;

            % Get image.
            imageData = getimage(app.PrewittInputImage);

            % Create wrapper.
            currentWrapper = utils.ImageWrapperFactory.Create(imageData);

            % Calculate edge image.
            edgeImageData = currentWrapper.GetPrewittEdgeImage();

            % Calculate segmented image.
            segmentedImageData = currentWrapper.GetSegmentedImage(edgeImageData, radius, minimumPixel);

            % Show the results.
            imshow(edgeImageData, 'Parent', app.PrewittEdgeImage, 'XData', [1 app.PrewittEdgeImage.Position(3)], 'YData', [1 app.PrewittEdgeImage.Position(4)]);
            imshow(segmentedImageData, 'Parent', app.PrewittOutputImage, 'XData', [1 app.PrewittOutputImage.Position(3)], 'YData', [1 app.PrewittOutputImage.Position(4)]);
        end

        % Button pushed function: RobertsUploadImageButton
        function RobertsUploadImageButtonPushed(app, event)
            filterspec = {'*.jpg;*.tif;*.png;*.bmp','All Image Files'};
            [filename, pathname] = uigetfile(filterspec);
            
            % If the user cancels, return.
            if ~ischar(filename)
                return;
            end
            
            % Construct the full file path.
            filepath = fullfile(pathname, filename);
            
            % Read the image.
            imageData = imread(filepath);
            
            % Show the image.
            imshow(imageData, 'Parent', app.RobertsInputImage, 'XData', [1 app.RobertsInputImage.Position(3)], 'YData', [1 app.RobertsInputImage.Position(4)]);
        end

        % Button pushed function: RobertsGoButton
        function RobertsGoButtonPushed(app, event)
            % Get parameter.
            radius = app.RobertsRadiusEditField.Value;
            minimumPixel = app.RobertsPixelEditField.Value;

            % Get image.
            imageData = getimage(app.RobertsInputImage);

            % Create wrapper.
            currentWrapper = utils.ImageWrapperFactory.Create(imageData);

            % Calculate edge image.
            edgeImageData = currentWrapper.GetRobertsEdgeImage();

            % Calculate segmented image.
            segmentedImageData = currentWrapper.GetSegmentedImage(edgeImageData, radius, minimumPixel);

            % Show the results.
            imshow(edgeImageData, 'Parent', app.RobertsEdgeImage, 'XData', [1 app.RobertsEdgeImage.Position(3)], 'YData', [1 app.RobertsEdgeImage.Position(4)]);
            imshow(segmentedImageData, 'Parent', app.RobertsOutputImage, 'XData', [1 app.RobertsOutputImage.Position(3)], 'YData', [1 app.RobertsOutputImage.Position(4)]);
        end

        % Button pushed function: CannyUploadImageButton
        function CannyUploadImageButtonPushed(app, event)
            filterspec = {'*.jpg;*.tif;*.png;*.bmp','All Image Files'};
            [filename, pathname] = uigetfile(filterspec);
            
            % If the user cancels, return.
            if ~ischar(filename)
                return;
            end
            
            % Construct the full file path.
            filepath = fullfile(pathname, filename);
            
            % Read the image.
            imageData = imread(filepath);
            
            % Show the image.
            imshow(imageData, 'Parent', app.CannyInputImage, 'XData', [1 app.CannyInputImage.Position(3)], 'YData', [1 app.CannyInputImage.Position(4)]);
        end

        % Button pushed function: CannyGoButton
        function CannyGoButtonPushed(app, event)
            % Get parameter.
            threshold = app.CannyThresholdEditField.Value;
            sigma = app.CannySigmaEditField.Value;
            radius = app.CannyRadiusEditField.Value;
            minimumPixel = app.CannyPixelEditField.Value;

            % Get image.
            imageData = getimage(app.CannyInputImage);

            % Create wrapper.
            currentWrapper = utils.ImageWrapperFactory.Create(imageData);

            % Calculate edge image.
            edgeImageData = currentWrapper.GetCannyEdgeImage(threshold, sigma);

            % Calculate segmented image.
            segmentedImageData = currentWrapper.GetSegmentedImage(edgeImageData, radius, minimumPixel);

            % Show the results.
            imshow(edgeImageData, 'Parent', app.CannyEdgeImage, 'XData', [1 app.CannyEdgeImage.Position(3)], 'YData', [1 app.CannyEdgeImage.Position(4)]);
            imshow(segmentedImageData, 'Parent', app.CannyOutputImage, 'XData', [1 app.CannyOutputImage.Position(3)], 'YData', [1 app.CannyOutputImage.Position(4)]);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 1 640 480];

            % Create LaplacianTab
            app.LaplacianTab = uitab(app.TabGroup);
            app.LaplacianTab.Title = 'Laplacian';

            % Create LaplacianInputImage
            app.LaplacianInputImage = uiaxes(app.LaplacianTab);
            title(app.LaplacianInputImage, 'Input Image')
            app.LaplacianInputImage.XTick = [];
            app.LaplacianInputImage.YTick = [];
            app.LaplacianInputImage.ZTick = [];
            app.LaplacianInputImage.Position = [24 252 198 185];

            % Create LaplacianEdgeImage
            app.LaplacianEdgeImage = uiaxes(app.LaplacianTab);
            title(app.LaplacianEdgeImage, 'Edge Image')
            app.LaplacianEdgeImage.XTick = [];
            app.LaplacianEdgeImage.YTick = [];
            app.LaplacianEdgeImage.ZTick = [];
            app.LaplacianEdgeImage.Position = [221 252 198 185];

            % Create LaplacianOutputImage
            app.LaplacianOutputImage = uiaxes(app.LaplacianTab);
            title(app.LaplacianOutputImage, 'Output Image')
            app.LaplacianOutputImage.XTick = [];
            app.LaplacianOutputImage.YTick = [];
            app.LaplacianOutputImage.ZTick = [];
            app.LaplacianOutputImage.Position = [418 252 198 185];

            % Create LaplacianUploadImageButton
            app.LaplacianUploadImageButton = uibutton(app.LaplacianTab, 'push');
            app.LaplacianUploadImageButton.ButtonPushedFcn = createCallbackFcn(app, @LaplacianUploadImageButtonPushed, true);
            app.LaplacianUploadImageButton.Position = [122 216 100 23];
            app.LaplacianUploadImageButton.Text = 'Upload Image';

            % Create LaplacianGoButton
            app.LaplacianGoButton = uibutton(app.LaplacianTab, 'push');
            app.LaplacianGoButton.ButtonPushedFcn = createCallbackFcn(app, @LaplacianGoButtonPushed, true);
            app.LaplacianGoButton.Position = [516 132 100 23];
            app.LaplacianGoButton.Text = 'Go';

            % Create AlphaLabel
            app.AlphaLabel = uilabel(app.LaplacianTab);
            app.AlphaLabel.HorizontalAlignment = 'right';
            app.AlphaLabel.Position = [268 216 36 22];
            app.AlphaLabel.Text = 'Alpha';

            % Create LaplacianAlphaEditField
            app.LaplacianAlphaEditField = uieditfield(app.LaplacianTab, 'numeric');
            app.LaplacianAlphaEditField.Limits = [0 1];
            app.LaplacianAlphaEditField.Position = [319 216 100 22];

            % Create RadiusEditFieldLabel_6
            app.RadiusEditFieldLabel_6 = uilabel(app.LaplacianTab);
            app.RadiusEditFieldLabel_6.HorizontalAlignment = 'right';
            app.RadiusEditFieldLabel_6.Position = [459 216 42 22];
            app.RadiusEditFieldLabel_6.Text = 'Radius';

            % Create LaplacianRadiusEditField
            app.LaplacianRadiusEditField = uieditfield(app.LaplacianTab, 'numeric');
            app.LaplacianRadiusEditField.Limits = [0 Inf];
            app.LaplacianRadiusEditField.ValueDisplayFormat = '%.0f';
            app.LaplacianRadiusEditField.Position = [516 216 100 22];

            % Create PixelEditFieldLabel_6
            app.PixelEditFieldLabel_6 = uilabel(app.LaplacianTab);
            app.PixelEditFieldLabel_6.HorizontalAlignment = 'right';
            app.PixelEditFieldLabel_6.Position = [470 175 31 22];
            app.PixelEditFieldLabel_6.Text = 'Pixel';

            % Create LaplacianPixelEditField
            app.LaplacianPixelEditField = uieditfield(app.LaplacianTab, 'numeric');
            app.LaplacianPixelEditField.Limits = [0 Inf];
            app.LaplacianPixelEditField.ValueDisplayFormat = '%.0f';
            app.LaplacianPixelEditField.Position = [516 175 100 22];

            % Create LoGTab
            app.LoGTab = uitab(app.TabGroup);
            app.LoGTab.Title = 'LoG';

            % Create LoGInputImage
            app.LoGInputImage = uiaxes(app.LoGTab);
            title(app.LoGInputImage, 'Input Image')
            app.LoGInputImage.XTick = [];
            app.LoGInputImage.YTick = [];
            app.LoGInputImage.ZTick = [];
            app.LoGInputImage.Position = [24 252 198 185];

            % Create LoGEdgeImage
            app.LoGEdgeImage = uiaxes(app.LoGTab);
            title(app.LoGEdgeImage, 'Edge Image')
            app.LoGEdgeImage.XTick = [];
            app.LoGEdgeImage.YTick = [];
            app.LoGEdgeImage.ZTick = [];
            app.LoGEdgeImage.Position = [221 252 198 185];

            % Create LoGOutputImage
            app.LoGOutputImage = uiaxes(app.LoGTab);
            title(app.LoGOutputImage, 'Output Image')
            app.LoGOutputImage.XTick = [];
            app.LoGOutputImage.YTick = [];
            app.LoGOutputImage.ZTick = [];
            app.LoGOutputImage.Position = [418 252 198 185];

            % Create LoGUploadImageButton
            app.LoGUploadImageButton = uibutton(app.LoGTab, 'push');
            app.LoGUploadImageButton.ButtonPushedFcn = createCallbackFcn(app, @LoGUploadImageButtonPushed, true);
            app.LoGUploadImageButton.Position = [122 216 100 23];
            app.LoGUploadImageButton.Text = 'Upload Image';

            % Create LoGGoButton
            app.LoGGoButton = uibutton(app.LoGTab, 'push');
            app.LoGGoButton.ButtonPushedFcn = createCallbackFcn(app, @LoGGoButtonPushed, true);
            app.LoGGoButton.Position = [516 132 100 23];
            app.LoGGoButton.Text = 'Go';

            % Create SizeLabel
            app.SizeLabel = uilabel(app.LoGTab);
            app.SizeLabel.HorizontalAlignment = 'right';
            app.SizeLabel.Position = [276 216 28 22];
            app.SizeLabel.Text = 'Size';

            % Create LoGSizeEditField
            app.LoGSizeEditField = uieditfield(app.LoGTab, 'numeric');
            app.LoGSizeEditField.LowerLimitInclusive = 'off';
            app.LoGSizeEditField.Limits = [0 Inf];
            app.LoGSizeEditField.ValueDisplayFormat = '%.0f';
            app.LoGSizeEditField.Position = [319 216 100 22];
            app.LoGSizeEditField.Value = 5;

            % Create RadiusEditFieldLabel_5
            app.RadiusEditFieldLabel_5 = uilabel(app.LoGTab);
            app.RadiusEditFieldLabel_5.HorizontalAlignment = 'right';
            app.RadiusEditFieldLabel_5.Position = [459 216 42 22];
            app.RadiusEditFieldLabel_5.Text = 'Radius';

            % Create LoGRadiusEditField
            app.LoGRadiusEditField = uieditfield(app.LoGTab, 'numeric');
            app.LoGRadiusEditField.Limits = [0 Inf];
            app.LoGRadiusEditField.ValueDisplayFormat = '%.0f';
            app.LoGRadiusEditField.Position = [516 216 100 22];

            % Create SigmaEditFieldLabel_2
            app.SigmaEditFieldLabel_2 = uilabel(app.LoGTab);
            app.SigmaEditFieldLabel_2.HorizontalAlignment = 'right';
            app.SigmaEditFieldLabel_2.Position = [265 175 39 22];
            app.SigmaEditFieldLabel_2.Text = 'Sigma';

            % Create LoGSigmaEditField
            app.LoGSigmaEditField = uieditfield(app.LoGTab, 'numeric');
            app.LoGSigmaEditField.LowerLimitInclusive = 'off';
            app.LoGSigmaEditField.Limits = [0 Inf];
            app.LoGSigmaEditField.Position = [319 175 100 22];
            app.LoGSigmaEditField.Value = 0.5;

            % Create PixelEditFieldLabel_5
            app.PixelEditFieldLabel_5 = uilabel(app.LoGTab);
            app.PixelEditFieldLabel_5.HorizontalAlignment = 'right';
            app.PixelEditFieldLabel_5.Position = [470 175 31 22];
            app.PixelEditFieldLabel_5.Text = 'Pixel';

            % Create LoGPixelEditField
            app.LoGPixelEditField = uieditfield(app.LoGTab, 'numeric');
            app.LoGPixelEditField.Limits = [0 Inf];
            app.LoGPixelEditField.ValueDisplayFormat = '%.0f';
            app.LoGPixelEditField.Position = [516 175 100 22];

            % Create SobelTab
            app.SobelTab = uitab(app.TabGroup);
            app.SobelTab.Title = 'Sobel';

            % Create SobelInputImage
            app.SobelInputImage = uiaxes(app.SobelTab);
            title(app.SobelInputImage, 'Input Image')
            app.SobelInputImage.XTick = [];
            app.SobelInputImage.YTick = [];
            app.SobelInputImage.ZTick = [];
            app.SobelInputImage.Position = [24 252 198 185];

            % Create SobelEdgeImage
            app.SobelEdgeImage = uiaxes(app.SobelTab);
            title(app.SobelEdgeImage, 'Edge Image')
            app.SobelEdgeImage.XTick = [];
            app.SobelEdgeImage.YTick = [];
            app.SobelEdgeImage.ZTick = [];
            app.SobelEdgeImage.Position = [221 252 198 185];

            % Create SobelOutputImage
            app.SobelOutputImage = uiaxes(app.SobelTab);
            title(app.SobelOutputImage, 'Output Image')
            app.SobelOutputImage.XTick = [];
            app.SobelOutputImage.YTick = [];
            app.SobelOutputImage.ZTick = [];
            app.SobelOutputImage.Position = [418 252 198 185];

            % Create SobelUploadImageButton
            app.SobelUploadImageButton = uibutton(app.SobelTab, 'push');
            app.SobelUploadImageButton.ButtonPushedFcn = createCallbackFcn(app, @SobelUploadImageButtonPushed, true);
            app.SobelUploadImageButton.Position = [122 216 100 23];
            app.SobelUploadImageButton.Text = 'Upload Image';

            % Create SobelGoButton
            app.SobelGoButton = uibutton(app.SobelTab, 'push');
            app.SobelGoButton.ButtonPushedFcn = createCallbackFcn(app, @SobelGoButtonPushed, true);
            app.SobelGoButton.Position = [516 132 100 23];
            app.SobelGoButton.Text = 'Go';

            % Create RadiusEditFieldLabel_4
            app.RadiusEditFieldLabel_4 = uilabel(app.SobelTab);
            app.RadiusEditFieldLabel_4.HorizontalAlignment = 'right';
            app.RadiusEditFieldLabel_4.Position = [459 216 42 22];
            app.RadiusEditFieldLabel_4.Text = 'Radius';

            % Create SobelRadiusEditField
            app.SobelRadiusEditField = uieditfield(app.SobelTab, 'numeric');
            app.SobelRadiusEditField.Limits = [0 Inf];
            app.SobelRadiusEditField.ValueDisplayFormat = '%.0f';
            app.SobelRadiusEditField.Position = [516 216 100 22];

            % Create PixelEditFieldLabel_4
            app.PixelEditFieldLabel_4 = uilabel(app.SobelTab);
            app.PixelEditFieldLabel_4.HorizontalAlignment = 'right';
            app.PixelEditFieldLabel_4.Position = [470 175 31 22];
            app.PixelEditFieldLabel_4.Text = 'Pixel';

            % Create SobelPixelEditField
            app.SobelPixelEditField = uieditfield(app.SobelTab, 'numeric');
            app.SobelPixelEditField.Limits = [0 Inf];
            app.SobelPixelEditField.ValueDisplayFormat = '%.0f';
            app.SobelPixelEditField.Position = [516 175 100 22];

            % Create PrewittTab
            app.PrewittTab = uitab(app.TabGroup);
            app.PrewittTab.Title = 'Prewitt';

            % Create PrewittInputImage
            app.PrewittInputImage = uiaxes(app.PrewittTab);
            title(app.PrewittInputImage, 'Input Image')
            app.PrewittInputImage.XTick = [];
            app.PrewittInputImage.YTick = [];
            app.PrewittInputImage.ZTick = [];
            app.PrewittInputImage.Position = [24 252 198 185];

            % Create PrewittEdgeImage
            app.PrewittEdgeImage = uiaxes(app.PrewittTab);
            title(app.PrewittEdgeImage, 'Edge Image')
            app.PrewittEdgeImage.XTick = [];
            app.PrewittEdgeImage.YTick = [];
            app.PrewittEdgeImage.ZTick = [];
            app.PrewittEdgeImage.Position = [221 252 198 185];

            % Create PrewittOutputImage
            app.PrewittOutputImage = uiaxes(app.PrewittTab);
            title(app.PrewittOutputImage, 'Output Image')
            app.PrewittOutputImage.XTick = [];
            app.PrewittOutputImage.YTick = [];
            app.PrewittOutputImage.ZTick = [];
            app.PrewittOutputImage.Position = [418 252 198 185];

            % Create PrewittUploadImageButton
            app.PrewittUploadImageButton = uibutton(app.PrewittTab, 'push');
            app.PrewittUploadImageButton.ButtonPushedFcn = createCallbackFcn(app, @PrewittUploadImageButtonPushed, true);
            app.PrewittUploadImageButton.Position = [122 216 100 23];
            app.PrewittUploadImageButton.Text = 'Upload Image';

            % Create PrewittGoButton
            app.PrewittGoButton = uibutton(app.PrewittTab, 'push');
            app.PrewittGoButton.ButtonPushedFcn = createCallbackFcn(app, @PrewittGoButtonPushed, true);
            app.PrewittGoButton.Position = [516 132 100 23];
            app.PrewittGoButton.Text = 'Go';

            % Create RadiusEditFieldLabel_3
            app.RadiusEditFieldLabel_3 = uilabel(app.PrewittTab);
            app.RadiusEditFieldLabel_3.HorizontalAlignment = 'right';
            app.RadiusEditFieldLabel_3.Position = [459 216 42 22];
            app.RadiusEditFieldLabel_3.Text = 'Radius';

            % Create PrewittRadiusEditField
            app.PrewittRadiusEditField = uieditfield(app.PrewittTab, 'numeric');
            app.PrewittRadiusEditField.Limits = [0 Inf];
            app.PrewittRadiusEditField.ValueDisplayFormat = '%.0f';
            app.PrewittRadiusEditField.Position = [516 216 100 22];

            % Create PixelEditFieldLabel_3
            app.PixelEditFieldLabel_3 = uilabel(app.PrewittTab);
            app.PixelEditFieldLabel_3.HorizontalAlignment = 'right';
            app.PixelEditFieldLabel_3.Position = [470 175 31 22];
            app.PixelEditFieldLabel_3.Text = 'Pixel';

            % Create PrewittPixelEditField
            app.PrewittPixelEditField = uieditfield(app.PrewittTab, 'numeric');
            app.PrewittPixelEditField.Limits = [0 Inf];
            app.PrewittPixelEditField.ValueDisplayFormat = '%.0f';
            app.PrewittPixelEditField.Position = [516 175 100 22];

            % Create RobertsTab
            app.RobertsTab = uitab(app.TabGroup);
            app.RobertsTab.Title = 'Roberts';

            % Create RobertsInputImage
            app.RobertsInputImage = uiaxes(app.RobertsTab);
            title(app.RobertsInputImage, 'Input Image')
            app.RobertsInputImage.XTick = [];
            app.RobertsInputImage.YTick = [];
            app.RobertsInputImage.ZTick = [];
            app.RobertsInputImage.Position = [24 252 198 185];

            % Create RobertsEdgeImage
            app.RobertsEdgeImage = uiaxes(app.RobertsTab);
            title(app.RobertsEdgeImage, 'Edge Image')
            app.RobertsEdgeImage.XTick = [];
            app.RobertsEdgeImage.YTick = [];
            app.RobertsEdgeImage.ZTick = [];
            app.RobertsEdgeImage.Position = [221 252 198 185];

            % Create RobertsOutputImage
            app.RobertsOutputImage = uiaxes(app.RobertsTab);
            title(app.RobertsOutputImage, 'Output Image')
            app.RobertsOutputImage.XTick = [];
            app.RobertsOutputImage.YTick = [];
            app.RobertsOutputImage.ZTick = [];
            app.RobertsOutputImage.Position = [418 252 198 185];

            % Create RobertsUploadImageButton
            app.RobertsUploadImageButton = uibutton(app.RobertsTab, 'push');
            app.RobertsUploadImageButton.ButtonPushedFcn = createCallbackFcn(app, @RobertsUploadImageButtonPushed, true);
            app.RobertsUploadImageButton.Position = [122 216 100 23];
            app.RobertsUploadImageButton.Text = 'Upload Image';

            % Create RobertsGoButton
            app.RobertsGoButton = uibutton(app.RobertsTab, 'push');
            app.RobertsGoButton.ButtonPushedFcn = createCallbackFcn(app, @RobertsGoButtonPushed, true);
            app.RobertsGoButton.Position = [516 132 100 23];
            app.RobertsGoButton.Text = 'Go';

            % Create RadiusEditFieldLabel_2
            app.RadiusEditFieldLabel_2 = uilabel(app.RobertsTab);
            app.RadiusEditFieldLabel_2.HorizontalAlignment = 'right';
            app.RadiusEditFieldLabel_2.Position = [459 216 42 22];
            app.RadiusEditFieldLabel_2.Text = 'Radius';

            % Create RobertsRadiusEditField
            app.RobertsRadiusEditField = uieditfield(app.RobertsTab, 'numeric');
            app.RobertsRadiusEditField.Limits = [0 Inf];
            app.RobertsRadiusEditField.ValueDisplayFormat = '%.0f';
            app.RobertsRadiusEditField.Position = [516 216 100 22];

            % Create PixelEditFieldLabel_2
            app.PixelEditFieldLabel_2 = uilabel(app.RobertsTab);
            app.PixelEditFieldLabel_2.HorizontalAlignment = 'right';
            app.PixelEditFieldLabel_2.Position = [470 175 31 22];
            app.PixelEditFieldLabel_2.Text = 'Pixel';

            % Create RobertsPixelEditField
            app.RobertsPixelEditField = uieditfield(app.RobertsTab, 'numeric');
            app.RobertsPixelEditField.Limits = [0 Inf];
            app.RobertsPixelEditField.ValueDisplayFormat = '%.0f';
            app.RobertsPixelEditField.Position = [516 175 100 22];

            % Create CannyTab
            app.CannyTab = uitab(app.TabGroup);
            app.CannyTab.Title = 'Canny';

            % Create CannyInputImage
            app.CannyInputImage = uiaxes(app.CannyTab);
            title(app.CannyInputImage, 'Input Image')
            app.CannyInputImage.XTick = [];
            app.CannyInputImage.YTick = [];
            app.CannyInputImage.ZTick = [];
            app.CannyInputImage.Position = [24 252 198 185];

            % Create CannyEdgeImage
            app.CannyEdgeImage = uiaxes(app.CannyTab);
            title(app.CannyEdgeImage, 'Edge Image')
            app.CannyEdgeImage.XTick = [];
            app.CannyEdgeImage.YTick = [];
            app.CannyEdgeImage.ZTick = [];
            app.CannyEdgeImage.Position = [221 252 198 185];

            % Create CannyOutputImage
            app.CannyOutputImage = uiaxes(app.CannyTab);
            title(app.CannyOutputImage, 'Output Image')
            app.CannyOutputImage.XTick = [];
            app.CannyOutputImage.YTick = [];
            app.CannyOutputImage.ZTick = [];
            app.CannyOutputImage.Position = [418 252 198 185];

            % Create CannyUploadImageButton
            app.CannyUploadImageButton = uibutton(app.CannyTab, 'push');
            app.CannyUploadImageButton.ButtonPushedFcn = createCallbackFcn(app, @CannyUploadImageButtonPushed, true);
            app.CannyUploadImageButton.Position = [122 216 100 23];
            app.CannyUploadImageButton.Text = 'Upload Image';

            % Create ThresholdEditFieldLabel
            app.ThresholdEditFieldLabel = uilabel(app.CannyTab);
            app.ThresholdEditFieldLabel.HorizontalAlignment = 'right';
            app.ThresholdEditFieldLabel.Position = [246 216 58 22];
            app.ThresholdEditFieldLabel.Text = 'Threshold';

            % Create CannyThresholdEditField
            app.CannyThresholdEditField = uieditfield(app.CannyTab, 'numeric');
            app.CannyThresholdEditField.UpperLimitInclusive = 'off';
            app.CannyThresholdEditField.Limits = [0 1];
            app.CannyThresholdEditField.Position = [319 216 100 22];
            app.CannyThresholdEditField.Value = 0.5;

            % Create SigmaEditFieldLabel
            app.SigmaEditFieldLabel = uilabel(app.CannyTab);
            app.SigmaEditFieldLabel.HorizontalAlignment = 'right';
            app.SigmaEditFieldLabel.Position = [265 175 39 22];
            app.SigmaEditFieldLabel.Text = 'Sigma';

            % Create CannySigmaEditField
            app.CannySigmaEditField = uieditfield(app.CannyTab, 'numeric');
            app.CannySigmaEditField.LowerLimitInclusive = 'off';
            app.CannySigmaEditField.Limits = [0 Inf];
            app.CannySigmaEditField.Position = [319 175 100 22];
            app.CannySigmaEditField.Value = 0.5;

            % Create CannyGoButton
            app.CannyGoButton = uibutton(app.CannyTab, 'push');
            app.CannyGoButton.ButtonPushedFcn = createCallbackFcn(app, @CannyGoButtonPushed, true);
            app.CannyGoButton.Position = [516 132 100 23];
            app.CannyGoButton.Text = 'Go';

            % Create RadiusEditFieldLabel
            app.RadiusEditFieldLabel = uilabel(app.CannyTab);
            app.RadiusEditFieldLabel.HorizontalAlignment = 'right';
            app.RadiusEditFieldLabel.Position = [459 216 42 22];
            app.RadiusEditFieldLabel.Text = 'Radius';

            % Create CannyRadiusEditField
            app.CannyRadiusEditField = uieditfield(app.CannyTab, 'numeric');
            app.CannyRadiusEditField.Limits = [0 Inf];
            app.CannyRadiusEditField.ValueDisplayFormat = '%.0f';
            app.CannyRadiusEditField.Position = [516 216 100 22];

            % Create PixelEditFieldLabel
            app.PixelEditFieldLabel = uilabel(app.CannyTab);
            app.PixelEditFieldLabel.HorizontalAlignment = 'right';
            app.PixelEditFieldLabel.Position = [470 175 31 22];
            app.PixelEditFieldLabel.Text = 'Pixel';

            % Create CannyPixelEditField
            app.CannyPixelEditField = uieditfield(app.CannyTab, 'numeric');
            app.CannyPixelEditField.Limits = [0 Inf];
            app.CannyPixelEditField.ValueDisplayFormat = '%.0f';
            app.CannyPixelEditField.Position = [516 175 100 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end