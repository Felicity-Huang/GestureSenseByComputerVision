function img=gestureSeg(im)
a=im;
f = rgb2ycbcr(a);
f_cb = f(:,:,2);
f_cr = f(:,:,3);
f = (f_cb>=100)&(f_cb<=127)&(f_cr>=138)&(f_cr<=170);
%  figure;imshow(f);

I2 = f;

% figure;
% se=strel('ball',5,3);
%  se = [1;1;1];
% I3 = imerode(I2,se);                                  % ��ʴImerode(X,SE).����X�Ǵ������ͼ��SE�ǽṹԪ�ض���
% subplot(1,3,1);imshow(I3);title('��ʴ���ͼ��');
I4 = bwareaopen(I2,2000);                              % �Ӷ�����ͼ�����Ƴ���������2000���ص����Ӷ�����ʧ���������İ�ɫ������������2000���ַ�
% subplot(1,3,2);imshow(I4);title('�Ӷ������Ƴ�С����');
se = strel('rectangle',[5,5]);                        % 5X5�ľ���
I5 = imclose(I4,se);                                  % ��5*5�ľ��ζ�ͼ����б�����(�����ͺ�ʴ)
% subplot(1,3,3);imshow(I5);title('ƽ��ͼ�������');
img=I5;