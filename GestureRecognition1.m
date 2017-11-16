% ÿ��ʹ��֮ǰ����clear�������߿���������ͷ

function varargout = GestureRecognition1(varargin)
% GESTURERECOGNITION1 MATLAB code for GestureRecognition1.fig
%      GESTURERECOGNITION1, by itself, creates a new GESTURERECOGNITION1 or raises the existing
%      singleton*.
%
%      H = GESTURERECOGNITION1 returns the handle to a new GESTURERECOGNITION1 or the handle to
%      the existing singleton*.
%
%      GESTURERECOGNITION1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GESTURERECOGNITION1.M with the given input arguments.
%
%      GESTURERECOGNITION1('Property','Value',...) creates a new GESTURERECOGNITION1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GestureRecognition1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GestureRecognition1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GestureRecognition1

% Last Modified by GUIDE v2.5 16-Nov-2017 13:39:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GestureRecognition1_OpeningFcn, ...
                   'gui_OutputFcn',  @GestureRecognition1_OutputFcn, ...
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


% --- Executes just before GestureRecognition1 is made visible.
function GestureRecognition1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GestureRecognition1 (see VARARGIN)

% Choose default command line output for GestureRecognition1
global flag
global myCam
myCam=webcam;
flag=1;
handles.output = hObject;
MyStruct=struct('fs',44100,'time',0.5);
handles.MyStruct=MyStruct;
% handles.flag=flag;
% flag=0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GestureRecognition1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GestureRecognition1_OutputFcn(hObject, eventdata, handles) 
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
% handles.flag=1;
global flag
global myCam;
flag=1;
while(flag)  %��ѭ����һֱ���˳�
readCnt=1;
imgSubMean=100;
imgRead=[];
threshold=0;
numBackGround=0;  %�����ȶ���֡��
hand=0;   %1��������ͷ��Χ��0���ڡ�
set(handles.edit3,'string','��ⱳ��')
while(flag)  %�������ȶ����˳�
%     imgRead=imread(['0000',num2str(strRead),'.bmp']);
%     strRead=strRead+1;
       img=snapshot(myCam);
       imgRead=img(80:end,80:end-80,:);
       imshow(imgRead);
    if(readCnt>1)     %����������ͼƬ�Ϳ�ʼ������
        imgSub=imgTemp-imgRead;
        imgTemp=imgRead;
        imgSubGray=rgb2gray(imgSub);
        imgSubMean=mean(imgSubGray(:));
    else
        imgTemp=imgRead;
        imgGray=rgb2gray(imgRead);
        threshold=mean(imgGray(:))/6;  %��ԭʼͼƬ�����ؾ�ֵ��1/6������ֵ��
        imgSub=imgRead;
        readCnt=readCnt+1;
    end
    if(numBackGround>5)   %����44֡�ȶ����򱳾��ȶ�
        backGroundRead=imgRead;
        set(handles.edit3,'string','�����ȶ�')
%         figure;
%         imshow(gestureSeg(backGroundRead));
        break;
    end
    if(imgSubMean<threshold)       %���������ص������ֵʱ����Ϊ�����ȶ���״̬��������һ��״̬
        numBackGround=numBackGround+1;
    else
        numBackGround=0;
    end
end

%��ʼ����ֽ���
%�����������Ʒָ������ֵ����һ���̶Ⱦ���Ϊ���ֽ���
numStable=0;% ��¼�����ȶ���֡��
meanAxisTemp=0;
xAxisTemp=0;  %���������ʼ��
yAxisTemp=0;
xAxisSub=100;  %����������ʼ��
yAxisSub=100;
numMove=1;   %��¼�����ͼƬ��������֮��ʼ������
% figure;
while(flag)
    %����ͼƬ�����������������ʶ���ж��Ƿ������ƽ���
    img=snapshot(myCam);
    imgRead=img(80:end,80:end-80,:);
    imshow(imgRead);
    imgSub=imgRead-backGroundRead;
    imgPrcess=gestureSeg(imgSub);
    imgSubMean=mean(imgPrcess(:));
    if(imgSubMean>0.001)    %���ֽ��뿪ʼ��ʼ�ȴ����ȶ�,��ֵ����ͼƬ���ز���ȫΪ0
        set(handles.edit3,'string','�ֽ���')
        hand=1;
        while(flag)
%           if(strRead>9)
%                imgRead=imread(['000',num2str(strRead),'.bmp']);
%           elseif(strRead>99)
%                imgRead=imread(['00',num2str(strRead),'.bmp']);
%           else
%               imgRead=imread(['0000',num2str(strRead),'.bmp']);
%           end
%           imshow(imgRead);
%           strRead=strRead+1;
          img=snapshot(myCam);
          imgRead=img(80:end,80:end-80,:);
          imshow(imgRead);
          imgSub=imgRead-backGroundRead;
          imgPrcess=gestureSeg(imgSub);
          [xAxis,yAxis]=find(imgPrcess);
          xAxisMean=mean(xAxis);
          yAxisMean=mean(yAxis);
          if(numMove<2)
              numMove=numMove+1;
          else
          xAxisSub=abs(xAxisTemp-xAxisMean);
          yAxisSub=abs(yAxisTemp-yAxisMean);
          end
          xAxisTemp=xAxisMean;
          yAxisTemp=yAxisMean;
          
           if((xAxisSub<10)&&(yAxisSub<10))     %�����ȶ����ȶ����Ƶ�֡����һ
               numStable=numStable+1;       
           else
               numStable=0;   %����һ���������¼���
           end
           if(numStable>4)    %һ���ȶ�֡������3��������Ϊ�����ȶ�����ʼ�������Ƹ���
               set(handles.edit3,'string','��ʼ׷��')    
               break;
           end

        end
        break;
    end     
end

%�����Ѿ��ȶ�����ʼ�������Ƹ���
%��⿴���Ƿ�ʼ�ƶ������ǿ�ʼ����ʼ��¼֡�������ֱ�����뿪��������ٴ�ֹͣ
%ͼƬ����ϵ�Ǵ����Ͻǿ�ʼ��ˮƽ��x����ֱ��y�����Ը�ֵ�������½Ƿ����ƶ������������Ͻ��ƶ�
%���������ĵ�x��yֵ
j=0;
while(1)    %ֱ�����뿪�����Χ��֮�󣬲��������ѭ��
xAxisTemp=0;  %���������ʼ��
yAxisTemp=0;
xAxisSub=0;  %����������ʼ��
yAxisSub=0;
pos.x=[];    %��¼����λ��
pos.y=[];
i=1;       %���ĵĸ���
readCnt=1; %ͼƬ������һ
direction=0; %������Ϊ�󣬸�Ϊ�ң�1Ϊˮƽ��2Ϊ��ֱ
numMove=1;   %��¼�����ͼƬ��������֮��ʼ������
numStable=1;
set(handles.edit3,'string','�ȴ���������')    
while(flag)   %ֱ���ֿ�ʼ�˶��������뿪����ͷ��Χ���������ѭ��

      img=snapshot(myCam);
      imgRead=img(80:end,80:end-80,:);
      imshow(imgRead);
      %����������
    %           imshow(imgRead);
      imgSub=imgRead-backGroundRead;
      imgPrcess=gestureSeg(imgSub);  
      imgSubMean=mean(imgPrcess);
      if(imgSubMean<0.01)    %���뿪������ͷ��Χ 
      set(handles.edit3,'string','���뿪������ͷ��Χ')
         hand=0;
         break;
      end
      [xAxis,yAxis]=find(imgPrcess);
      xAxisMean=mean(xAxis);
      yAxisMean=mean(yAxis);
      if(numMove<2)
          numMove=numMove+1;
      else
         xAxisSub=abs(xAxisTemp-xAxisMean);
         yAxisSub=abs(yAxisTemp-yAxisMean);
      end
      xAxisTemp=xAxisMean;
      yAxisTemp=yAxisMean;
      %�Ƚ���������

      if((xAxisSub>10)||(yAxisSub>10)) %�ֿ�ʼ�ƶ�
          pos.x(i)=xAxisTemp;
          pos.y(i)=yAxisTemp;
          pos.xMaxBegin=max(xAxis);     %��¼�ֿ�ʼ����ʱ�ֵ����·�λ�õ�����
          pos.yMaxBegin=max(yAxis);
          i=i+1;
          tic
          set(handles.edit3,'string','�ֿ�ʼ�ƶ�')
          j=j+1;
          if(j>8)
              j=j;
          end
          numStable=1;    
          break;
      end

end
       
       
       
%��ʼ��¼�켣
while(flag) %ֱ���������н������������ѭ��

      img=snapshot(myCam);
      imgRead=img(80:end,80:end-80,:);
      imshow(imgRead);
      %����������

      imgSub=imgRead-backGroundRead;
      imgPrcess=gestureSeg(imgSub);  
      [xAxis,yAxis]=find(imgPrcess);
      xAxisMean=mean(xAxis);
      yAxisMean=mean(yAxis); 
      xAxisSub=abs(xAxisTemp-xAxisMean);
      yAxisSub=abs(yAxisTemp-yAxisMean);
      xAxisTemp=xAxisMean;
      yAxisTemp=yAxisMean;          
      if((xAxisSub>10)||(yAxisSub>10)) %�����ƶ�
          pos.x(i)=xAxisTemp;
          pos.y(i)=yAxisTemp;
          i=i+1; 
    %               if(i>2)
    %                 a=[pos.x;pos.y];
    %                 insertMarker(imgRead,a','+','Color','red');
    %                 imshow(imgRead);
    %               end
          numStable=1;               %һ���ƶ������¼���
      else                            %������Ϊ��ֹͣ���������Ѿ�����������ͷ
         numStable=numStable+1; 
      end
      if(numStable>3)            %����5��ֹͣ������������ʶ�������
          set(handles.edit3,'string','��ʼ�ж�')
          pos.xMaxFinal=max(xAxis);     %��¼�ֿ�ʼ����ʱ�ֵ����·�λ�õ�����
          pos.yMaxFinal=max(yAxis);
          i=0;
          numMove=1;
          break;
      end

end  

   if(hand) %������뿪������ͷ
%���ڹ����ʶ��
         stdX=std(pos.x);            %��x��y���׼��
         stdY=std(pos.y);
         if((stdX>20)&&(stdY>20))    %ʶ��ΪԲ
          xTemp=diff(pos.x);
             xTemp(xTemp<0)=0;
             postiveX=find(xTemp);  %�ҵ�����仯��x������ֵ
             yTemp=pos.y(postiveX);
             if(yTemp(2)>yTemp(1))  %������Ϊ����ô��˳ʱ�룬����Ϊ��ʱ�룬��������������ͼƬ
                 display('��ʱ��');
             else
                 display('˳ʱ��')
             end
         else
             if(stdX>stdY)    %��������ֱ�����ϵı仯
                 if(pos.x(1)>pos.x(end))   %��ֱ���������ϱ仯 
%                      if(abs(pos.xMaxBegin-pos.xMaxFinal<10))  %��ֱ������zoomOut������������ƽ��
%                          display('zoomOut');
%                      else
                     drection=2;  
                        set(handles.edit2,'string','up')
%                      end
                 else
%                      if(abs(pos.yMaxBegin-pos.yMaxFinal)<10)
%                          display('zoomIn');
%                      else
                     drection=-2;  
                         set(handles.edit2,'string','down') 
%                      end
                 end
             else
                 if(pos.y(1)>pos.y(end))
                 drection=1;  
                     set(handles.edit2,'string','right')
                 else
                 drection=-1;  
                     set(handles.edit2,'string','left')   
                 end
             end
     toc    
         end
   else
       break;
       end
    end
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.flag=0;
% guidata(hObject, handles);
global flag
flag=0;



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla;
close all
clear all



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
