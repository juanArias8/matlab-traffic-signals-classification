function varargout = Gui(varargin)
% GUI MATLAB code for Gui.fig
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
%      applied to the GUI before Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui

% Last Modified by GUIDE v2.5 02-Dec-2016 00:15:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui_OutputFcn, ...
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


% --- Executes just before Gui is made visible.
function Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui (see VARARGIN)

% Choose default command line output for Gui
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
ha = axes('units','normalized', ...
            'position',[0 0 1 1]);
% El fondo hacia la parte inferior
uistack(ha,'bottom');
I=imread('background.jpg');
imagesc(I)
colormap gray
% Ejes invisibles
set(ha,'handlevisibility','off', ...
            'visible','off')

% UIWAIT makes Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);
axes(handles.Pantalla);             % Establece el eje como actual 
set(gca, 'Box', 'on');              % Se encierran los ejes en una caja 
set(gca, 'XTick', [], 'YTick', [])  % No muestra las marcas de la se�al de los ejes
imshow(I);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cargar.
function cargar_Callback(hObject, eventdata, handles)
% hObject    handle to cargar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[nombre direc]=uigetfile('*.*','Abrir Imagen');
if nombre == 0
    return
end
senal=imread(fullfile(direc,nombre));
imshow(senal);
set(handles.pCarpetas, 'UserData', senal);%guardamos la imagen en el componente

% --- Executes on button press in pCarpetas.
function pCarpetas_Callback(hObject, eventdata, handles)
% hObject    handle to pCarpetas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

procesaCarpetas();

%imshow(senalRecor);


% --- Executes on button press in evaluarImagen.
function evaluarImagen_Callback(hObject, eventdata, handles)
% hObject    handle to evaluarImagen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('netRedNeuronal.mat');
senial = get(handles.pCarpetas, 'UserData');
[senial] = binarizar(senial);
set(handles.pCarpetas, 'UserData', senial);
imshow(senial);
x = getFeatures(senial);
yVec = net(x);
[y,ind] = max(yVec);
disp(ind)
mensaje = (['La se�al procesada corresponde a la clase: ', num2str(ind)]);
set(handles.ediText, 'String', mensaje);


% --- Executes on button press in clasificar.
function clasificar_Callback(hObject, eventdata, handles)
% hObject    handle to clasificar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

creaMatrices();


