function varargout = GUI(varargin)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    % GUI MATLAB code for GUI.fig
    %      GUI, by itself, creates a new GUI or raises the existing                           
    %      singleton*.
    
    %
    %      H = GUI returns the handle to a new GUI or the handle to
    %      the existing singleton*.                                        
    %
    %      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in GUI.M with the given input arguments.
    %
    %      GUI('Property','Value',...) creates a new GUI or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before GUI_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help GUI

    % Last Modified by GUIDE v2.5 15-Mar-2020 10:12:55

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @GUI_OpeningFcn, ...
                       'gui_OutputFcn',  @GUI_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
    % End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to GUI (see VARARGIN)

    % Choose default command line output for GUI
    handles.output = hObject;
    handles.sliderValue = 2;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes GUI wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
    axes(handles.axes1)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])

    axes(handles.axes2)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])

    axes(handles.axes3)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
    set(handles.btn_loadImage,'Enable','on')
    set(handles.btn_segImage,'Enable','off')
    set(handles.btn_satImage,'Enable','off')
    set(handles.btn_LBPVEC,'Enable','off')
    set(handles.btn_classify,'Enable','off')


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;


% --- Executes on button press in btn_loadImage.
function btn_loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to btn_loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Image File');

    if ~isequal(filename,0)
        set(handles.btn_segImage,'Enable','on')
        set(handles.btn_satImage,'Enable','off')
        set(handles.btn_LBPVEC,'Enable','off')
        set(handles.btn_classify,'Enable','off')

        I = imread([pathname,filename]);
        %I = imresize(I,[256,256]);

        axes(handles.axes1);
        imshow(I);title('Input Image');
        handles.imageData = I;
        guidata(hObject,handles);
    else
        return;
    end;


    % --- Executes on button press in btn_segImage.                        
function btn_segImage_Callback(hObject, eventdata, handles)
% hObject    handle to btn_segImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [~,seg_img] = createMask(handles.imageData);
    %seg_img = imresize(seg_img,[256,256]);

    set(handles.btn_satImage,'Enable','on')
    set(handles.btn_LBPVEC,'Enable','off')
    set(handles.btn_classify,'Enable','off')
    axes(handles.axes2);
    imshow(seg_img);title('Segmented Image');
    handles.seg_img = seg_img;
    guidata(hObject,handles);
    


% --- Executes during object creation, after setting all properties.
function btn_loadImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btn_loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in btn_satImage.
function btn_satImage_Callback(hObject, eventdata, handles)
% hObject    handle to btn_satImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    %Get HSV Colour from Segmented Image
    hsv = rgb2hsv(handles.seg_img);
    
    
    set(handles.btn_LBPVEC,'Enable','on')
    set(handles.btn_classify,'Enable','off')
    % Get Saturation Channel 
    Sat = hsv(:,:,2);
    
    handles.Sat = Sat;
    axes(handles.axes3);
    imshow(Sat);title('Saturation Channel');     
    guidata(hObject,handles);
    




% --- Executes when entered data in editable cell(s) in tabFeatEx.
function tabFeatEx_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tabFeatEx (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
    
    


% --- Executes on button press in btn_LBPVEC.
function btn_LBPVEC_Callback(hObject, eventdata, handles)                  
% hObject    handle to btn_LBPVEC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB        
% handles    structure with handles and user data (see GUIDATA)
    set(handles.btn_classify,'Enable','on')                                                             
    featureExt =[];
    
%     rgb = im2double(handles.seg_img);
%     Color Feature
%     stat = statwarna(rgb);
%     mean_r = stat.mean_r;
%     mean_g = stat.mean_g; 
%     mean_b = stat.mean_b;
% 
%     dev_r = stat.dev_r;
%     dev_g = stat.dev_g;
%     dev_b = stat.dev_b;
    % SaturationChannel
    Sat = handles.Sat;
    histLBP = lbp(Sat,1,8,0,'nh');                                                                                                                                                                                               
%     histLBP = imhist(LBP);                                               
    normLBP = histLBP/sum(histLBP); 
    featureExt = [featureExt;normLBP];                                     
    
%     featureExt = [featureExt;normLBP,mean_r,mean_g,mean_b,dev_r,dev_g,dev_b];
    
    handles.featureExt = featureExt;
    set(handles.tabFeatEx,'Data',featureExt);
    
    guidata(hObject,handles);


   % --- Executes on button press in btn_classify.
function btn_classify_Callback(hObject, eventdata, handles)
% hObject    handle to btn_classify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDA)

                                                                            
    load('TrainFeature.mat');
    load('TrainLabel.mat');

    TestFeature = handles.featureExt;                                      

    class = multisvm(TrainFeature, train_label, TestFeature);                                         

    if (class==1)
        disease = 'Bacterial';                                             
    elseif (class==2)      
        disease = 'Brownspot';                                             
    elseif (class==3)
        disease = 'Leafsmut';
    end;

    set(handles.txt_disease,'String',disease);                              
    


% --- Executes on button press in btn_reset.
function btn_reset_Callback(hObject, eventdata, handles)
% hObject    handle to btn_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    axes(handles.axes1)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])

    axes(handles.axes2)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])

    axes(handles.axes3)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
    set(handles.tabFeatEx,'Data',[])
    set(handles.btn_loadImage,'Enable','on')
    set(handles.btn_segImage,'Enable','off')
    set(handles.btn_satImage,'Enable','off')
    set(handles.btn_LBPVEC,'Enable','off')
    set(handles.btn_classify,'Enable','off')
    set(handles.txt_disease,'String','');


% --- Executes on button press in btn_exit.
function btn_exit_Callback(hObject, eventdata, handles)
% hObject    handle to btn_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   close; 
