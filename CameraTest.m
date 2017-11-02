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
preview(vid,hImage);


%% webcam
%���ǿ��Բ��ϵ�¼����ʾ�����ߴ���֮������ʾ
%����������оͿ��Խ���ͼ��Ĵ����õ������Ȼ���������ط�����
%���ƶ�����Ƶ�Ƶ�����ʶ��ֻ���������˼�����Ӿ�����
% %set up webcam
% myCam=webcam;
% %set up video writer
% myWriter=VideoWriter('myMoive.avi');
% open(myWriter);
% %Grab and Process frame
% frames=50;
% 
% for i1=1:frames
%     img=snapshot(myCam);
%     img=img>60 & img<170;
%     imagesc(img);
%     axis image
%     axis off;
%     
%     writeVideo(myWriter,double(img))
% end
delete(myCam);
    
