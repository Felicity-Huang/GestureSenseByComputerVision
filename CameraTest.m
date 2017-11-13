%ͼƬ����Ƶ¼�Ʋ���
%����¼�Ʒ�ʽ��matlab���ֵ��÷�ʽ��һ��opencv���÷�ʽ
%ͼ��ߴ�Ĭ����480x640��¼�ƺ��ȡΪ400x480��Ҫ���� 


%% ��ʼ��
close all
clear all
doPhoto=false;   %�Ƿ�¼��ͼƬ
cnt=0;         %��������ʼ��
j=0;           %����¼��ͼƬ�ļ��
%% winvideo
% By lyqmath
clc; clear all; 
close all;
vid = videoinput('winvideo',1);
set(vid,'ReturnedColorSpace','rgb');
vidRes=get(vid,'VideoResolution');
width=vidRes(1);
height=vidRes(2);
nBands=get(vid,'NumberOfBands');
figure('Name', 'Matlab��������ͷ By Lyqmath', 'NumberTitle', 'Off', 'ToolBar', 'None', 'MenuBar', 'None');
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
tic
preview(vid,hImage);
toc

%% webcam
% ���ǿ��Բ��ϵ�¼����ʾ�����ߴ���֮������ʾ
% ����������оͿ��Խ���ͼ��Ĵ����õ������Ȼ���������ط�����
% ���ƶ�����Ƶ�Ƶ�����ʶ��ֻ���������˼�����Ӿ�����
%set up webcam
myCam=webcam;
%set up video writer
%���ɶ���������������оͿ��Կ�����������
 myWriter=VideoWriter('myMoive3.avi');
 myWriter.FrameRate=5;
 open(myWriter);
% %Grab and Process frame
frames=20;
pause(5);
while(1)
    for i1=1:frames
        tic
        img=snapshot(myCam);
        toc
        figure(1)
        subplot(1,2,1)
        img1=img(80:end,80:end-80,:);
        imshow(img1);
        subplot(1,2,2)
        img2=img(160:end-160,120:end-120,:);
        imshow(img);
        photo.cdata=img1;
        photo.colormap=[];
        axis image
        axis off;
      
        writeVideo(myWriter,photo)
        if doPhoto
            if(cnt>20)
                j=2;
            end
            j=j+0.1;
            if(j>1)
                if cnt<10
                str=['0000',num2str(cnt),'.bmp'];
                elseif cnt<100
                    str=['000',num2str(cnt),'.bmp'];
                elseif cnt<1000
                     str=['00',num2str(cnt),'.bmp'];
                else
                   str=['0',num2str(cnt),'.bmp'];
                end
                imwrite(img1,str);
                cnt=cnt+1;
             end
        end
    end
end
delete(myCam);
  

%% opencv
camera =cv.VideoCapture();
while(1)
    tic
    img=camera.read;
    imshow(img);
    axis image
    axis off;
    toc
end
