function varargout = Tumor_GUI(varargin)
% TUMOR_GUI MATLAB code for Tumor_GUI.fig
%      TUMOR_GUI, by itself, creates a new TUMOR_GUI or raises the existing
%      singleton*.
%
%      H = TUMOR_GUI returns the handle to a new TUMOR_GUI or the handle to
%      the existing singleton*.
%
%      TUMOR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUMOR_GUI.M with the given input arguments.
%
%      TUMOR_GUI('Property','Value',...) creates a new TUMOR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Tumor_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Tumor_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Tumor_GUI

% Last Modified by GUIDE v2.5 03-Jun-2020 17:04:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Tumor_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Tumor_GUI_OutputFcn, ...
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

global im

% --- Executes just before Tumor_GUI is made visible.
function Tumor_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Tumor_GUI (see VARARGIN)

% Choose default command line output for Tumor_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Tumor_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Tumor_GUI_OutputFcn(hObject, eventdata, handles) 
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

global im im2
im = [];
[path,user_cancel] = imgetfile();
if user_cancel
    msgbox(sprintf('Invalid Selection'),'Error','Warn');
    return
end
im = imread(path);
im2 = im2double(im);
axes(handles.axes1);
imshow(im);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
org=imresize(im,[256 256]);
noisy= imnoise(org,'gaussian',0,0.001);
ns_r = normal_shrink(noisy(:,:,1)); 
ns_g = normal_shrink(noisy(:,:,2));
ns_b = normal_shrink(noisy(:,:,3));
ns_r= uint8(ns_r);
ns_g= uint8(ns_g);
ns_b= uint8(ns_b);
ns = cat(3, ns_r, ns_g, ns_b);
ns2gray = rgb2gray(ns);
ns2gray = double(ns2gray);
B = bilateral(ns2gray);
img = double(B);
 k = 5;
 [ Unew, centroid, obj_func_new ] = fuzzyCMeans( img, k );
axes(handles.axes2);
 imshow(Unew(:,:,1),[]);
 axes(handles.axes23);
 imshow(Unew(:,:,2),[]);
 axes(handles.axes24);
 imshow(Unew(:,:,3),[]);
 axes(handles.axes25);
 imshow(Unew(:,:,4),[]);
 axes(handles.axes26);
 imshow(Unew(:,:,5),[]);





% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
org=imresize(im,[256 256]);
noisy= imnoise(org,'gaussian',0,0.001);
ns_r = normal_shrink(noisy(:,:,1)); 
ns_g = normal_shrink(noisy(:,:,2));
ns_b = normal_shrink(noisy(:,:,3));
ns_r= uint8(ns_r);
ns_g= uint8(ns_g);
ns_b= uint8(ns_b);
ns = cat(3, ns_r, ns_g, ns_b);
ns2gray = rgb2gray(ns);
ns2gray = double(ns2gray);
B = bilateral(ns2gray);
 [k, class, img_vect, noOfIter]= adaptive_kmeans(B);
 cluster1 = reshape(class(1:length(img_vect),1:1), [256,256] );
 axes(handles.axes28);
 imshow(cluster1,[]);
 cluster1 = reshape(class(1:length(img_vect),2:2), [256,256] );
 axes(handles.axes29);
 imshow(cluster1,[]);
 cluster1 = reshape(class(1:length(img_vect),3:3), [256,256] );
 axes(handles.axes30);
 imshow(cluster1,[]);
 cluster1 = reshape(class(1:length(img_vect),4:4), [256,256] );
 axes(handles.axes31);
 imshow(cluster1,[]);
  cluster1 = reshape(class(1:length(img_vect),5:5), [256,256] );
 axes(handles.axes32);
 imshow(cluster1,[]);



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
org=imresize(im,[256 256]);
noisy= imnoise(org,'gaussian',0,0.001);
ns_r = normal_shrink(noisy(:,:,1)); 
ns_g = normal_shrink(noisy(:,:,2));
ns_b = normal_shrink(noisy(:,:,3));
ns_r= uint8(ns_r);
ns_g= uint8(ns_g);
ns_b= uint8(ns_b);
ns = cat(3, ns_r, ns_g, ns_b);
ns2gray = rgb2gray(ns);
ns2gray = double(ns2gray);
B = bilateral(ns2gray);
 k = 5;
[k, class, img_vect]= kmeans(B, 5);
 cluster = reshape(class(1:length(img_vect),1:1), [256,256] );
 axes(handles.axes33);
 imshow(cluster,[]);
 cluster = reshape(class(1:length(img_vect),2:2), [256,256] );
 axes(handles.axes34);
 imshow(cluster,[]);
 cluster = reshape(class(1:length(img_vect),3:3), [256,256] );
 axes(handles.axes35);
 imshow(cluster,[]);
 cluster = reshape(class(1:length(img_vect),4:4), [256,256] );
 axes(handles.axes36);
 imshow(cluster,[]);
 cluster = reshape(class(1:length(img_vect),5:5), [256,256] );
 axes(handles.axes37);
 imshow(cluster,[]);

 
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
ClearImagesFromAxes(handles.axes22);
ClearImagesFromAxes(handles.axes18);
axes(handles.axes22);
bw = im2bw(im,0.7);
label = bwlabel(bw);
stats = regionprops(label,'Solidity','Area');

density = [stats.Solidity];
area = [stats.Area];
high_dense_area = density > 0.5;
max_area = max(area(high_dense_area));
tumor_label = find(area==max_area);
tumor = ismember(label,tumor_label);

se = strel('square',5);
tumor = imdilate(tumor,se);

[B,L] = bwboundaries(tumor,'noholes');

imshow(im)
hold on
for i=1:length(B)
    plot(B{i}(:,2),B{i}(:,1), 'y' ,'linewidth',1.45);
end


axes(handles.axes18);
bw = im2bw(im,0.7);
label = bwlabel(bw);
stats = regionprops(label,'Solidity','Area');
density = [stats.Solidity];
area = [stats.Area];
high_dense_area = density > 0.5;

max_area = max(area(high_dense_area));
tumor_label = find(area == max_area);
tumor = ismember(label,tumor_label);
se = strel('square',5);
tumor = imdilate(tumor,se);
if(tumor~=0)
    print('no tumor');
end
imshow(tumor,[]);

function ClearImagesFromAxes(h)
  axesHandlesToChildObjects = findobj(h, 'Type', 'image');
  if ~isempty(axesHandlesToChildObjects)
    delete(axesHandlesToChildObjects);
  end
  return;
