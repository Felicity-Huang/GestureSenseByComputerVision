%������
%ֱ�����������Ƽ�ⲿ�ֺ���ֱ�ӵ�������󣬹�����break������
%% ��ʼ��
close all
clear all
% backGroundRead=imread('00001.bmp');
strWrite=0; %дͼƬ�ı��
strRead=0;  %��ͼƬ�ı��
%set up webcam
myCam=webcam;
img=snapshot(myCam);
backGroundRead=img(80:end,80:end-80,:);
%% ������ٴ���
%����ͼƬ��ʼ��
%����������ؾ�ֵ����һ����ֵ��Ϊ�����Ѿ��̶�����ʼ������һ��
while(1)  %��ѭ����һֱ���˳�
readCnt=1;
imgSubMean=100;
imgRead=[];
threshold=0;
numBackGround=0;  %�����ȶ���֡��
while(1)
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
    if(numBackGround>35)   %����3֡�ȶ����򱳾��ȶ�
        backGroundRead=imgRead;
        display('�����ȶ�');
        break;
    end
    if(imgSubMean<threshold)       %���������ص������ֵʱ����Ϊ�����ȶ���״̬��������һ��״̬
        numBackGround=numBackGround+1;
    end
end

%��ʼ����ֽ���
%�����������Ʒָ������ֵ����һ���̶Ⱦ���Ϊ���ֽ���
% readCnt=1; %ͼƬ������һ
numStable=0;% ��¼�����ȶ���֡��
meanAxisTemp=0;
xAxisTemp=0;  %���������ʼ��
yAxisTemp=0;
xAxisSub=100;  %����������ʼ��
yAxisSub=100;
numMove=1;   %��¼�����ͼƬ��������֮��ʼ������
while(1)
    %����ͼƬ�����������������ʶ���ж��Ƿ������ƽ���
%     imgRead=imread(['0000',num2str(strRead),'.bmp']);
%     strRead=strRead+1;
    img=snapshot(myCam);
    imgRead=img(80:end,80:end-80,:);
    imshow(imgRead);
    imgSub=imgRead-backGroundRead;
    imgPrcess=gestureSeg(imgSub);
    imgSubMean=mean(imgPrcess(:));
    if(imgSubMean>0.001)    %���ֽ��뿪ʼ��ʼ�ȴ����ȶ�,��ֵ����ͼƬ���ز���ȫΪ0
        display('�ֽ���');
        while(1)
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
           if(numStable>2)    %һ���ȶ�֡������3��������Ϊ�����ȶ�����ʼ�������Ƹ���
               display('�����ȶ�����ʼ׷������');
               break;
           end
%           readCnt=readCnt+1;
        end
        break;
    end     
end

%�����Ѿ��ȶ�����ʼ�������Ƹ���
%��⿴���Ƿ�ʼ�ƶ������ǿ�ʼ����ʼ��¼֡�������ֱ�����뿪��������ٴ�ֹͣ
%ͼƬ����ϵ�Ǵ����Ͻǿ�ʼ��ˮƽ��x����ֱ��y�����Ը�ֵ�������½Ƿ����ƶ������������Ͻ��ƶ�
%���������ĵ�x��yֵ
while(1)    %ֱ�����뿪�����Χ��֮�󣬲��������ѭ��
tic
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

% while(1)         
       while(1)   %ֱ���ֿ�ʼ�˶����������ѭ��
           %��������
%           if(strRead>9)
%               imgRead=imread(['000',num2str(strRead),'.bmp']);
%           elseif(strRead>99)
%               imgRead=imread(['00',num2str(strRead),'.bmp']);
%           else
%               imgRead=imread(['0',num2str(strRead),'.bmp']);   
%           end
%           strRead=strRead+1;
          img=snapshot(myCam);
          imgRead=img(80:end,80:end-80,:);
          imshow(imgRead);
          %����������
%           imshow(imgRead);
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
          %�Ƚ���������
          if((xAxisSub>10)||(yAxisSub>10)) %�ֿ�ʼ�ƶ�
              pos.x(i)=xAxisTemp;
              pos.y(i)=yAxisTemp;
              i=i+1;
              display('�ֿ�ʼ�ƶ�');
              break;
          end
%            readCnt=readCnt+1;
       end
       %��ʼ��¼�켣
       while(1)%ֱ���������н������������ѭ��
           %��������
%           if(strRead>9)
%               imgRead=imread(['000',num2str(strRead),'.bmp']);
%           elseif(strRead>99)
%               imgRead=imread(['00',num2str(strRead),'.bmp']);
%           else
%               imgRead=imread(['0',num2str(strRead),'.bmp']);   
%           end
%           strRead=strRead+1;
          img=snapshot(myCam);
          imgRead=img(80:end,80:end-80,:);
          imshow(imgRead);
          %����������
%           imshow(imgRead);
          imgSub=imgRead-backGroundRead;
          imgPrcess=gestureSeg(imgSub);  
          [xAxis,yAxis]=find(imgPrcess);
          xAxisMean=mean(xAxis);
          yAxisMean=mean(yAxis); 
          xAxisSub=xAxisTemp-xAxisMean;
          yAxisSub=yAxisTemp-yAxisMean;
          xAxisTemp=xAxisMean;
          yAxisTemp=yAxisMean;          
          if((xAxisSub>10)||(yAxisSub>10)) %�����ƶ�
              pos.x(i)=xAxisTemp;
              pos.y(i)=yAxisTemp;
              i=i+1; 
              numStable=0;               %һ���ƶ������¼���
          else                            %������Ϊ��ֹͣ���������Ѿ�����������ͷ
             numStable=numStable+1; 
          end
          if(numStable>15)            %����8��ֹͣ������������ʶ�������
              display('���ƶ���ɿ�ʼ�������');
              break;
          end
       end  
%        break;                     %���Ƽ�¼��������ʼʶ��
% end
     stdX=std(pos.x);            %��x��y���׼��
     stdY=std(pos.y);
     if((stdX>20)&&(stdY>20))    %ʶ��ΪԲ
         xTemp=pos.x;
%          stdYTemp=stdY;  
         xTemp(xTemp<0)=0;
         postiveX=find(xTemp);  %�ҵ�����仯��x������ֵ
         yTemp=pos.y(postiveX);
         if(yTemp(2)>yTemp(1))  %������Ϊ����ô��˳ʱ�룬����Ϊ��ʱ�룬��������������ͼƬ
             display('˳ʱ��');
         else
             display('��ʱ��')
         end
     else
         
     if(stdX>stdY)
         if(pos.x(1)>pos.x(end))
         drection=2;  
         display('up');
         else
         drection=-2;  
         display('down');    
         end
     else
         if(pos.y(1)>pos.y(end))
         drection=1;  
         display('right');
         else
         drection=-1;  
         display('left');    
         end
     end
 toc  
         img=snapshot(myCam);
         imgRead=img(80:end,80:end-80,:);
         imshow(imgRead);
         imgSub=imgRead-backGroundRead;
         imgPrcess=gestureSeg(imgSub);   
         imgSubMean=mean(imgPrcess(:));
         if(imgSubMean<0.001)    %���뿪������ͷ��Χ   
             break;
          end
        end
    end
end
    pause(4);
 delete(myCam);
%     tic
%     img=imgRead-backGroundRead;
%     imgPrcess=gestureSeg(img);
%     toc
%     imshow(imgPrcess)
%     str=[num2str(cnt),'.jpg'];
%     imwrite(imgPrcess,str);
%     cnt=cnt+1;
%% �ȴ��������
% clear all
% tic
% backGroundProcess=gestureSeg(backGroundRead);
% imgProcess=gestureSeg(imgRead);
% img=imgProcess-backGroundProcess;
% img = bwareaopen(img,2500);  % �Ӷ�����ͼ�����Ƴ���������2000���ص����Ӷ���
% toc
% figure;
% imshow(img);
