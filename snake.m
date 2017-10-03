function varargout = snake(varargin)
% SNAKE MATLAB code for snake.fig
%      SNAKE, by itself, creates a new SNAKE or raises the existing
%      singleton*.
%
%      H = SNAKE returns the handle to a new SNAKE or the handle to
%      the existing singleton*.
%
%      SNAKE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SNAKE.M with the given input arguments.
%
%      SNAKE('Property','Value',...) creates a new SNAKE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before snake_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to snake_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help snake

% Last Modified by GUIDE v2.5 13-Sep-2017 17:17:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @snake_OpeningFcn, ...
    'gui_OutputFcn',  @snake_OutputFcn, ...
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
end

% --- Executes just before snake is made visible.
function snake_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to snake (see VARARGIN)

% Choose default command line output for snake
handles.output = hObject;
handles.snakeSize = 1;
handles.set = 0;
handles.scoreNum = 0;
handles.touching = false;
handles.snake = NaN(50, 2);
handles.x = 10;
handles.y = 10;
handles.snake(1, 1) = handles.x;
handles.snake(1, 2) = handles.y;
handles.food = randi(18, 1, 4);
whitebg('black');
plotSnake(hObject, handles);
axis([0 20 0 20]);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes snake wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = snake_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in upButton.
function upButton_Callback(hObject, eventdata, handles)
% hObject    handle to upButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.set = 1;
while handles.set == 1
    
    if handles.snakeSize ~= 1
        for j = handles.snakeSize:-1:2
            handles.snake(j, 1) = handles.snake(j - 1, 1);
            handles.snake(j, 2) = handles.snake(j - 1, 2);
        end
    end
    
    handles.snake(1, 2) = handles.snake(1, 2) + 1;
    
    [f1x, f1y, f2x, f2y, size, scr, isTouching] = newPositions(hObject, handles);
    handles.touching = isTouching;
    
    if isTouching == true
        
        handles.food(1) = f1x;
        handles.food(2) = f1y;
        handles.food(3) = f2x;
        handles.food(4) = f2y;
        handles.snakeSize = size;
        handles.score = scr;
        
    end
    
    if handles.touching == true
        handles.snake(handles.snakeSize, 1) = handles.snake(handles.snakeSize - 1, 1);
        handles.snake(handles.snakeSize, 2) = handles.snake(handles.snakeSize - 1, 2);
        handles.snake(handles.snakeSize, 2) = handles.snake(handles.snakeSize, 2) + 1;
        set(handles.score, 'String', num2str(handles.scoreNum));
        handles.touching = false;
    end
    
    if handles.snake(1, 1) == 20 || handles.snake(1, 1) == 0 || handles.snake(1, 2) == 0 || handles.snake(1, 2) == 20

        handles.snake(:, 1) = 26;
        handles.snake(:, 2) = 26;
        set(handles.score, 'String', 'You lose');
        
    end
    
    guidata(hObject, handles);
    plotSnake(hObject, handles);
    
end
end

% --- Executes on button press in rightButton.
function rightButton_Callback(hObject, eventdata, handles)
% hObject    handle to rightButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.set = 2;
while handles.set == 2
    
    if handles.snakeSize ~= 1
        for j = handles.snakeSize:-1:2
            handles.snake(j, 1) = handles.snake(j - 1, 1);
            handles.snake(j, 2) = handles.snake(j - 1, 2);
        end
    end
    
    handles.snake(1, 1) = handles.snake(1, 1) + 1;
    
    [f1x, f1y, f2x, f2y, size, scr, isTouching] = newPositions(hObject, handles);
    
    if isTouching == true
        
        handles.food(1) = f1x;
        handles.food(2) = f1y;
        handles.food(3) = f2x;
        handles.food(4) = f2y;
        handles.snakeSize = size;
        handles.score = scr;
        
    end
    
    if handles.touching == true
        handles.snake(handles.snakeSize, 1) = handles.snake(handles.snakeSize - 1, 1);
        handles.snake(handles.snakeSize, 2) = handles.snake(handles.snakeSize - 1, 2);
        handles.snake(handles.snakeSize, 1) = handles.snake(handles.snakeSize, 1) + 1;
        set(handles.score, 'String', num2str(handles.scoreNum));
        handles.touching = false;
    end
 
            if handles.snake(1, 1) == 20 || handles.snake(1, 1) == 0 || handles.snake(1, 2) == 0 || handles.snake(1, 2) == 20
                handles.snake(:, 1) = 26;
                handles.snake(:, 2) = 26;
                set(handles.score, 'String', 'You lose');
            end
    
    guidata(hObject, handles);
    plotSnake(hObject, handles);
end
end

% --- Executes on button press in downButton.
function downButton_Callback(hObject, eventdata, handles)
% hObject    handle to downButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.set = 3;
while handles.set == 3
    
    if handles.snakeSize ~= 1
        for j = handles.snakeSize:-1:2
            handles.snake(j, 1) = handles.snake(j - 1, 1);
            handles.snake(j, 2) = handles.snake(j - 1, 2);
        end
    end
    
    handles.snake(1, 2) = handles.snake(1, 2) - 1;
    
    [f1x, f1y, f2x, f2y, size, scr, isTouching] = newPositions(hObject, handles);
    
    if isTouching == true
        
        handles.food(1) = f1x;
        handles.food(2) = f1y;
        handles.food(3) = f2x;
        handles.food(4) = f2y;
        handles.snakeSize = size;
        handles.score = scr;
        
    end
    
    if handles.touching == true
        handles.snake(handles.snakeSize, 1) = handles.snake(handles.snakeSize - 1, 1);
        handles.snake(handles.snakeSize, 2) = handles.snake(handles.snakeSize - 1, 2);
        handles.snake(handles.snakeSize, 2) = handles.snake(handles.snakeSize, 2) - 1;
        set(handles.score, 'String', num2str(handles.scoreNum));
        handles.touching = false;
    end
    
            if handles.snake(1, 1) == 20 || handles.snake(1, 1) == 0 || handles.snake(1, 2) == 0 || handles.snake(1, 2) == 20
                handles.snake(:, 1) = 26;
                handles.snake(:, 2) = 26;
                set(handles.score, 'String', 'You lose');
            end
    
    guidata(hObject, handles);
    plotSnake(hObject, handles);
end
end

% --- Executes on button press in leftButton.
function leftButton_Callback(hObject, eventdata, handles)
% hObject    handle to leftButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.set = 4;
while handles.set == 4
    
    if handles.snakeSize ~= 1
        for j = handles.snakeSize:-1:2
            handles.snake(j, 1) = handles.snake(j - 1, 1);
            handles.snake(j, 2) = handles.snake(j - 1, 2);
        end
    end
    
    handles.snake(1, 1) = handles.snake(1, 1) - 1;
    
    [f1x, f1y, f2x, f2y, size, scr, isTouching] = newPositions(hObject, handles);
    
    if isTouching == true
        
        handles.food(1) = f1x;
        handles.food(2) = f1y;
        handles.food(3) = f2x;
        handles.food(4) = f2y;
        handles.snakeSize = size;
        handles.score = scr;
        
    end
    
    if handles.touching == true
        handles.snake(handles.snakeSize, 1) = handles.snake(handles.snakeSize - 1, 1);
        handles.snake(handles.snakeSize, 2) = handles.snake(handles.snakeSize - 1, 2);
        handles.snake(handles.snakeSize, 1) = handles.snake(handles.snakeSize, 1) - 1;
        set(handles.score, 'String', num2str(handles.scoreNum));
        handles.touching = false;
    end
    
            if handles.snake(1, 1) == 20 || handles.snake(1, 1) == 0 || handles.snake(1, 2) == 0 || handles.snake(1, 2) == 20
                handles.snake(:, 1) = 26;
                handles.snake(:, 2) = 26;
                set(handles.score, 'String', 'You lose');
            end
    
    guidata(hObject, handles);
    plotSnake(hObject, handles);
end
end

function plotSnake(hObject, handles)

for i = 1:handles.snakeSize
    plot(handles.snake(i, 1), handles.snake(i, 2), 'w*');
    hold on
end

hold on
plot(handles.food(1), handles.food(2), 'gs');
hold on
plot (handles.food(3), handles.food(4), 'rs');
hold off
axis([0 20 0 20]);
guidata(hObject, handles);
drawnow;
end