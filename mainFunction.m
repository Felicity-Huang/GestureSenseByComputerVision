%������
%���뿪����ͷ���߼�
%�㷨�߼�
%��������ͷʱ���ȼ��ȷ�������Ѿ���ֹ��һֱ��⵽45֡��֡�����һ����ֵʱ�����Ǳ�����ֹ
%Ȼ�����ֽ�������ͷ��Χ���־�ֹ��Ҳ���ǿ�ʼ�����ƣ����ǻ��������ƿ�ʼ�ͽ���֮ǰҪ��һ��ͣ�٣�����������ȡ��
%Ȼ�������Ƿ�ʼ�˶�����ʼ�˶���ʼ��¼��Ȼ��ֱ����ֹͣ
%��ȡ���ʱ����ڵ�ͼƬ��������������ʶ��

%Ҫ��
%���������ƶ������������ƶ���Χ�ڲ����з�ɫ�ͽ���ɫ������ڣ���Ȼ��Ӱ���о�
%�����Ҫ���õ�ʹ�����뿪����ͷ�о����߼������취
%һ���Ǳ�������ȫ�޷�ɫ�ͽ���ɫ���壬���Ǹ����ݱ����еķ�ɫ��Χ��С�ֶ�������ֵ���������������Ͳ����˶���
%Ŀǰѡ�񷽰�һ����Ϊ��

%% ��ʼ��
close all
clear all
strWrite=0; %дͼƬ�ı��
strRead=0;  %��ͼƬ�ı��5
%set up webcam
myCam=webcam;
img=snapshot(myCam);
backGroundRead=img(80:end,80:end-80,:);
while(1)  %��ѭ����һֱ���˳�


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
while(1)
    %����ͼƬ�����������������ʶ���ж��Ƿ������ƽ���
    img=snapshot(myCam);
    imgRead=img(80:end,80:end-80,:);
    imshow(imgRead);
    imgSub=imgRead-backGroundRead;
    backGroundRead=imgRead;
    imgPrcess=gestureSeg(imgSub);
    imgSubMean=mean(imgPrcess(:));
    if(imgSubMean>0.001)    %���ֽ��뿪ʼ��ʼ�ȴ����ȶ�,��ֵ����ͼƬ���ز���ȫΪ0
        display('�ֽ���');
        hand=1;
        while(1)
          img=snapshot(myCam);
          imgRead=img(80:end,80:end-80,:);
          imshow(imgRead);
          imgSub=imgRead-backGroundRead;
          backGroundRead=imgRead;
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
          
%            if((xAxisSub<10)&&(yAxisSub<10))     %�����ȶ����ȶ����Ƶ�֡����һ
           if(isnan(xAxisSub)&&isnan(yAxisSub))
               numStable=numStable+1;       
           else
               numStable=0;   %����һ���������¼���
           end
           if(numStable>4)    %һ���ȶ�֡������3��������Ϊ�����ȶ�����ʼ�������Ƹ���
               display('�����ȶ�����ʼ׷������');
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
figureStay=[];
figureTime=1; %����֡����ֹ�ж�
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
display('�ȴ���������');      
while(1)   %ֱ���ֿ�ʼ�˶��������뿪����ͷ��Χ���������ѭ��

      img=snapshot(myCam);
      imgRead=img(80:end,80:end-80,:);
      imshow(imgRead);
      %����������
    %           imshow(imgRead);
      imgSub=imgRead-backGroundRead;
      backGroundRead=imgRead;
      imgPrcess=gestureSeg(imgSub);  
      imgSubMean=mean(imgPrcess(:));
      if(imgSubMean<0.01)    %����Ϊ��0ʱ�����ƾ�ֹ�жϼ�һ
          figureTime=figureTime+1;
          if(figureTime>10) %����ʮ֡��ⲻ���˶������鿴���Ƿ��뿪������ͷ
              figureStay=gestureSeg(imgRead);  
              imgSubMean=mean(figureStay(:));
              if(imgSubMean<0.05)    %���뿪������ͷ��Χ 
                 display('���뿪������ͷ��Χ');
                 hand=0;
                 break;
              end
          end
      else
          figureTime=1;
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
          display('�ֿ�ʼ�ƶ�');
          j=j+1;
          if(j>8)
              j=j;
          end
          numStable=1;    
          break;
      end

end
       
       
       
%��ʼ��¼�켣
while(1) %ֱ���������н������������ѭ��

      img=snapshot(myCam);
      imgRead=img(80:end,80:end-80,:);
      imshow(imgRead);
      %����������

      imgSub=imgRead-backGroundRead;
      backGroundRead=imgRead;
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

          numStable=1;               %һ���ƶ������¼���
      else                            %������Ϊ��ֹͣ���������Ѿ�����������ͷ
         numStable=numStable+1; 
      end
      if(numStable>3)            %����5��ֹͣ������������ʶ�������
          display('���ƶ���ɿ�ʼ�ж�����');
          pos.xMaxFinal=max(xAxis);     %��¼�ֿ�ʼ����ʱ�ֵ����·�λ�õ�����
          pos.yMaxFinal=max(yAxis);
          i=0;
          numMove=1;
          break;
      end

end  

 
%���ڹ����ʶ��
    if(hand)
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
%                  if(abs(pos.xMaxBegin-pos.xMaxFinal<10))  %��ֱ������zoomOut������������ƽ��
%                      display('zoomOut');
%                  else
                 drection=2;  
                 display('up');
%                  end
             else
%                  if(abs(pos.yMaxBegin-pos.yMaxFinal)<10)
%                      display('zoomIn');
%                  else
                 drection=-2;  
                 display('down');    
%                  end
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
         end
    else
        break;
    end
end
end

    pause(4);
 delete(myCam);
