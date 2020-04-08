function varargout = Main_GUI(varargin)
% MAIN_GUI MATLAB code for Main_GUI.fig
%      MAIN_GUI, by itself, creates a new MAIN_GUI or raises the existing
%      singleton*.
%
%      H = MAIN_GUI returns the handle to a new MAIN_GUI or the handle to
%      the existing singleton*.
%
%      MAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI.M with the given input arguments.
%
%      MAIN_GUI('Property','Value',...) creates a new MAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_GUI

% Last Modified by GUIDE v2.5 01-Jun-2017 12:02:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_GUI_OutputFcn, ...
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


% --- Executes just before Main_GUI is made visible.
function Main_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_GUI (see VARARGIN)

% Choose default command line output for Main_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

a1 = imread('icon\3.png');
b1 = imresize(a1,0.04);
set(handles.pushbutton1, 'CData', b1);
set(handles.pushbutton2, 'CData', b1);
set(handles.pushbutton3, 'CData', b1);
set(handles.pushbutton4, 'CData', b1);


set(handles.checkbox5,'enable','off');
set(handles.checkbox6,'enable','off');
set(handles.checkbox7,'enable','off');
set(handles.checkbox8,'enable','off');

set(handles.checkbox9,'enable','off');
set(handles.checkbox10,'enable','off');
set(handles.checkbox11,'enable','off');
set(handles.checkbox12,'enable','off');

set(handles.checkbox13,'enable','off');
set(handles.checkbox14,'enable','off');
set(handles.checkbox15,'enable','off');
set(handles.checkbox16,'enable','off');

set(handles.checkbox1,'enable','off');
set(handles.checkbox2,'enable','off');
set(handles.checkbox3,'enable','off');
set(handles.checkbox4,'enable','off');

set(handles.checkbox17,'enable','off');


% --- Outputs from this function are returned to the command line.
function varargout = Main_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I
[f p] = uigetfile('*.*');
I = imread([p f]);
axes(handles.axes1);
imshow(I);
title('Input Image');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



set(handles.checkbox1,'enable','on');
set(handles.checkbox2,'enable','on');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.checkbox3,'enable','on');
set(handles.checkbox4,'enable','on');
set(handles.checkbox5,'enable','on');


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1

global I norm_img

norm_img = stainnorm_reinhard(I,I);

axes(handles.axes1);
imshow(norm_img);
title('Normalized Image');

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% ================= Segemntation ==================== %

global norm_img cell pixel_labels nColors Fig1 Fig2 Fig3 Fig4 segmented_images

% -- CLUSTERING -- %

I = norm_img;

% figure,imshow(I),title('H&E image');
% Hematoxylin and eosin

text(size(I,2),size(I,1)+15,...
    'Clustering process is done', ...
    'FontSize',7,'HorizontalAlignment','right');
cform = makecform('srgb2lab');

lab_I = applycform(I,cform);
ab = double(lab_I(:,:,2:3));

nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 4;

[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
    'Replicates',3);
pixel_labels = reshape(cluster_idx,nrows,ncols);


% segmented_images = cell(1,3);

rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    
    color = I;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
    
end

Fig1 = segmented_images{1};
Fig2 = segmented_images{2};
Fig3 = segmented_images{3};
Fig4 = segmented_images{4};


set(handles.checkbox6,'enable','on');
set(handles.checkbox7,'enable','on');


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3

set(handles.checkbox8,'enable','on');
set(handles.checkbox9,'enable','on');
set(handles.checkbox10,'enable','on');
set(handles.checkbox11,'enable','on');
set(handles.checkbox12,'enable','on');
set(handles.checkbox13,'enable','on');
set(handles.checkbox14,'enable','on');
set(handles.checkbox15,'enable','on');
set(handles.checkbox16,'enable','on');

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4

set(handles.checkbox17,'enable','on');

% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6

global pixel_labels

axes(handles.axes1);
imshow(pixel_labels,[]); axis off;
title('Image labeled by cluster index');


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


global Fig1 Fig2 Fig3 Fig4 segmented_images SEGIMG

figure,
subplot(2,2,1);
imshow(Fig1);
title('Clustered Image 1');
subplot(2,2,2);
imshow(Fig2);
title('Clustered Image 2');
subplot(2,2,3);
imshow(Fig3);
title('Clustered Image 3');
subplot(2,2,4);
imshow(Fig4);
title('Clustered Image 4');


% -- Finding Final Clustered Result -- %
INP = input('Enter the image No. of clustered image [1 - 4] :: ');

switch (INP)
    case 1 
        bw1 = double(segmented_images{1});
        SEGIMG = segmented_images{1};
        bw1 = im2bw(bw1);
        axes(handles.axes1);
        imshow(segmented_images{1}), title('Objects in cluster 1');
        hold on;
        boundaries = bwboundaries(bw1);
        numberOfBoundaries = size(boundaries);
        for k = 1 : numberOfBoundaries
            thisBoundary= boundaries{k};
            axes(handles.axes1),plot(thisBoundary(:,2), thisBoundary(:,1), 'r', 'LineWidth',1.5);
        end
        hold off;
    case 2
        bw1 = double(segmented_images{2});
        SEGIMG = segmented_images{2};
        bw1 = im2bw(bw1);
        axes(handles.axes1);
        imshow(segmented_images{2}), title('Objects in cluster 1');
        hold on;
        boundaries = bwboundaries(bw1);
        numberOfBoundaries = size(boundaries);
        for k = 1 : numberOfBoundaries
            thisBoundary= boundaries{k};
            axes(handles.axes1),plot(thisBoundary(:,2), thisBoundary(:,1), 'r', 'LineWidth',1.5);
        end
        hold off;
    case 3
        bw1 = double(segmented_images{3});
        SEGIMG = segmented_images{3};
        bw1 = im2bw(bw1);
        axes(handles.axes1);
        imshow(segmented_images{3}), title('Objects in cluster 1');
        hold on;
        boundaries = bwboundaries(bw1);
        numberOfBoundaries = size(boundaries);
        for k = 1 : numberOfBoundaries
            thisBoundary= boundaries{k};
            axes(handles.axes1),plot(thisBoundary(:,2), thisBoundary(:,1), 'r', 'LineWidth',1.5);
        end
        hold off;
    case 4 
        bw1 = double(segmented_images{4});
        SEGIMG = segmented_images{4};
        bw1 = im2bw(bw1);
        axes(handles.axes1);
        imshow(segmented_images{4}), title('Objects in cluster 1');
        hold on;
        boundaries = bwboundaries(bw1);
        numberOfBoundaries = size(boundaries);
    for k = 1 : numberOfBoundaries
        thisBoundary= boundaries{k};
        axes(handles.axes1),plot(thisBoundary(:,2), thisBoundary(:,1), 'r', 'LineWidth',1.5);
    end
        hold off;

end


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8

global SEGIMG freq

freq = medfreq(SEGIMG(:),SEGIMG(1,:));

set(handles.uitable1,'data',freq);

% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9

global SEGIMG Varval

Varval = var(var(double(SEGIMG)));

set(handles.uitable1,'data',Varval(:));

% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10

global SEGIMG Kurt_val

SEGIMG1 = imresize(SEGIMG,[256 256]);

Kurt_val = kurtosis(double(SEGIMG));

set(handles.uitable1,'data',Kurt_val(:));

% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11

global SEGIMG Skew_val

Skew_val = skewness(double(SEGIMG));


set(handles.uitable1,'data',Skew_val(:));

% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12

global SEGIMG Area_val

Area_val = area(im2bw(SEGIMG));

set(handles.uitable1,'data',Area_val(:));


% --- Executes on button press in checkbox13.
function checkbox13_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox13

global SEGIMG Perim_val

Perim_val = mean(bwperim(SEGIMG,8));
Perim_val = Perim_val(:);

set(handles.uitable1,'data',Perim_val);


% --- Executes on button press in checkbox14.
function checkbox14_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox14

global SEGIMG labelWithHighestSolidity

% Label the binary image.
labeledImage = bwlabel(im2bw(SEGIMG));
% Measure the solidity of all the blobs.
measurements = regionprops(labeledImage, 'Solidity');
% Sort in oder of decreasing solidity.
[sortedS, sortIndexes] = sort([measurements.Solidity], 'descend');
% Get the solidity of the most solid blob
highestSolidity = sortedS(1);
% Get the label of the most solid blob
labelWithHighestSolidity = sortIndexes(1);

set(handles.uitable1,'data',labelWithHighestSolidity);

% --- Executes on button press in checkbox15.
function checkbox15_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox15

global SEGIMG Harval

  glcm = graycomatrix(rgb2gray(SEGIMG), 'offset', [0 1], 'Symmetric', true);

  xFeatures = 4:6;
  x = haralickTextureFeatures(glcm, 4:6);

  Harval = x( xFeatures )    ;

set(handles.uitable1,'data',Harval);

% --- Executes on button press in checkbox16.
function checkbox16_Callback(hObject, eventdata, handles)

% -- GLCM Feature -- %
global Glcm_fea SEGIMG

GLCM2 = graycomatrix(rgb2gray(SEGIMG),'Offset',[2 0;0 2]);

stats = glcm(GLCM2,0);

v1 = stats.autoc(1);
v2 = stats.contr(1);
v3 = stats.corrm(1);
v4 = stats.corrp(1);
v5 = stats.cprom(1);
v6 = stats.cshad(1);
v7 = stats.dissi(1);
v8 = stats.energ(1);
v9 = stats.entro(1);
v10 = stats.homom(1);
v11 = stats.homop(1);
v12 = stats.maxpr(1);
v13 = stats.idmnc(1);

Glcm_fea = [v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13];

set(handles.uitable1,'data',Glcm_fea);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


load Trainfeature
load TestFeature
load Target

result = MCS(Trainfeature',Target(1:16),TestFeature);

if result == 1
    set(handles.text6,'string','Identified as - Interphase');
elseif result == 2
    set(handles.text1,'string','Identified as - Preprophase');
elseif result == 3
    set(handles.text6,'string','Identified as - Prophase');
elseif result == 4
    set(handles.text6,'string','Identified as - Prometaphase');  
elseif result == 5
    set(handles.text6,'string','Identified as - Metaphase');   
elseif result == 6
    set(handles.text6,'string','Identified as - Anaphase');   
end


Estimations

% --- Executes on button press in checkbox17.
function checkbox17_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox17

 
global freq Varval Kurt_val Skew_val Area_val  Perim_val Glcm_fea TestFeature

TestFeature=[freq Varval(:)' Kurt_val(:)' Skew_val(:)' Area_val  Perim_val' Glcm_fea];

TestFeature = TestFeature(1:500);
save  TestFeature TestFeature

set(handles.uitable1,'data',TestFeature);
