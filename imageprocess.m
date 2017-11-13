%��������ܣ������ԣ������ԣ���ͬ�Ļ����⣬Ч�����̫����......


%% ��ʼ��
clear
% camera = cv.VideoCapture();
%a=camera.read;
test=load('test');
a=test.a;

%%
%HSVģʽ����С�İ���ֵ������.....֮ǰ����ֵ�Ǵ�һƪ������ת�����ģ�Ч��ͦ�õ�,,,,,
% a = camera.read; 
tic
hv = rgb2hsv(a); 
size_image = size(a);
processed = zeros(size_image(1),size_image(2));

for i = 1:size_image(1)
    for j = 1:size_image(2)
         if (abs(hv(i,j,1)-0.22) <= 0.16||hv(i,j,1) >= 0.8)&&abs(hv(i,j,2)-0.4) <= 0.2&&hv(i,j,3)>=0.4
            processed(i,j) = 1;
        end
    end
end

figure;
subplot(1,3,1);imshow(a);title('camera');
subplot(1,3,2);imshow(hv);title('HSV');
subplot(1,3,3);imshow(processed);title('binary');


I2 = processed;
figure;

se = [1;1;1];
I3 = imerode(I2,se);                                  % ��ʴ
subplot(1,3,1);imshow(I3);title('��ʴ���ͼ��');
I4 = bwareaopen(I3,100);                              % �Ӷ�����ͼ�����Ƴ���������100���ص����Ӷ���
subplot(1,3,2);imshow(I4);title('�Ƴ�С����');
se = strel('rectangle',[5,5]);                        % 5X5�ľ���
I5 = imclose(I4,se);                                  % ��5*5�ľ��ζ�ͼ����б�����(�����ͺ�ʴ)
subplot(1,3,3);imshow(I5);title('ƽ��ͼ��');

H = hv(:,:,1);
S = hv(:,:,2);
V = hv(:,:,3);

figure;
subplot(1,3,1);imshow(H);title('HSV�ռ�H����ͼ��');
subplot(1,3,2);imshow(S);title('HSV�ռ�S����ͼ��');
subplot(1,3,3);imshow(V);title('HSV�ռ�V����ͼ��');
toc
%%
%Ycbcrģʽ1,ʵ���ٶȹ���...Ч������һ��ǿ
% clear

%camera = cv.VideoCapture();
%a= camera.read; 
%  a=imread(a);
tic 
Ycbcr = rgb2ycbcr(a);

fThreshold = 0.22;                          %�����ָ���ֵ

[M,N,D] = size(Ycbcr);                      %��ȡͼ���ȣ��߶Ⱥ�ά�ȡ�
processed1 = zeros(M,N);
FaceProbImg = zeros(M,N);                   %��ɫ������ʾ���
Mean = [117.4316 148.5599]';                %��ɫ��ֵ
C = [97.0946 24.4700;  24.4700 141.9966];   %��ɫ����
cbcr = zeros(2,1);                          %��ɫ������Y��������ϴ�ֻ��CbCr������
for i = 1:M
    for j = 1:N
        cbcr(1) = Ycbcr(i,j,2);
        cbcr(2) = Ycbcr(i,j,3);
        FaceProbImg(i,j) = exp(-0.5*(cbcr-Mean)'*inv(C)*(cbcr-Mean));     %�����ɫ��˹�������         
        if FaceProbImg(i,j) > fThreshold                                  %���������ֵ��Ϊ����������
            processed1(i,j) = 1;
        end          
    end
end

figure
imshow(processed1);title('YCbCr');

I2 = processed1;

figure;
se = [1;1;1];
I3 = imerode(I2,se);                                  % ��ʴImerode(X,SE).����X�Ǵ������ͼ��SE�ǽṹԪ�ض���
subplot(1,3,1);imshow(I3);title('��ʴ���ͼ��');
I4 = bwareaopen(I3,250);                              % �Ӷ�����ͼ�����Ƴ���������2000���ص����Ӷ�����ʧ���������İ�ɫ������������2000���ַ�
subplot(1,3,2);imshow(I4);title('�Ӷ������Ƴ�С����');
se = strel('rectangle',[5,5]);                        % 5X5�ľ���
I5 = imclose(I4,se);                                  % ��5*5�ľ��ζ�ͼ����б�����(�����ͺ�ʴ)
subplot(1,3,3);imshow(I5);title('ƽ��ͼ�������');
toc
%%
%Ycbcrģʽ2,Ч���ƺ�����һ��Ҫ�õ�
% clear

% camera = cv.VideoCapture();
% %a = camera.read; 
backGroundRead=imread('00001.bmp');
imRead=imread('00069.bmp');
a=imRead-backGroundRead;
%a = imread('00002.bmp');
 tic
f = rgb2ycbcr(a);
f_cb = f(:,:,2);
f_cr = f(:,:,3);
f = (f_cb>=100)&(f_cb<=127)&(f_cr>=138)&(f_cr<=170);
 figure;imshow(f);

I2 = f;

figure;
% se=strel('ball',5,3);
 se = [1;1;1];
% I3 = imerode(I2,se);                                  % ��ʴImerode(X,SE).����X�Ǵ������ͼ��SE�ǽṹԪ�ض���
% subplot(1,3,1);imshow(I3);title('��ʴ���ͼ��');
I4 = bwareaopen(I2,2500);                              % �Ӷ�����ͼ�����Ƴ���������2000���ص����Ӷ�����ʧ���������İ�ɫ������������2000���ַ�
subplot(1,3,2);imshow(I4);title('�Ӷ������Ƴ�С����');
se = strel('rectangle',[5,5]);                        % 5X5�ľ���
I5 = imclose(I4,se);                                  % ��5*5�ľ��ζ�ͼ����б�����(�����ͺ�ʴ)
subplot(1,3,3);imshow(I5);title('ƽ��ͼ�������');
toc