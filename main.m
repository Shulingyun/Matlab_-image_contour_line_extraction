%% ƻ��ʶ��
%��Ҫ�����������£�
%��ȡͼƬ��ɫ�ʿռ�ת������ͨ��a�������������㡢��ֵ����ͼ���ںϡ�ˮƽ��ת�Ȳ�����
% By С���
tic
%% ��ȡͼƬ��Ϣ
clear;clc;
data = imread('001.png');%������ͼƬ·��
figure('Name','ͼ�������','NumberTitle','off');
subplot(3,4,1);
imshow(data);
title('��ԭʼͼ��');
%% ��RGBɫ�ʿռ�תΪLabɫ�ʿռ�
L = rgb2lab(data);%ת������rgb2lab()
subplot(3,4,2);
imshow(L(:,:,1));%L����
title('������L');
subplot(3,4,3);
imshow(L(:,:,2));
title('����ɫͨ��a');
subplot(3,4,4);
imshow(L(:,:,3));
title('����ɫͨ��b');
%% �Ե�ͨ��a���в���
d = L(:,:,2);
SE = strel('disk',5);
I2 = imdilate(d,SE);%����
I3 = imerode(I2,SE);%��ʴ
subplot(3,4,5);
imshow(I3);
title('�ݶ�a������');

subplot(346);
ck = imfill(I3);%�ն����
imshow(ck);
title('�޿ն����');

%% ͼ���ں�
subplot(347);
z = mapminmax(ck)+mapminmax(L(:,:,3));%�ȹ�һ��,�ٽ�ͼ����޽����ں�;
imshow(z);
title('��ͼ���ں�');

subplot(3,4,8);
ZZ = imerode(z,SE);%��ʴ
imshow(ZZ);
title('�ฯʴͼ��');
T = imbinarize(ZZ,0.5);%��ֵ��
subplot(3,4,9);
imshow(T);
title('���ֵͼ��');

%% ˮƽ��ת
subplot(3,4,10);
JJ=fliplr(T);  %ˮƽ��ת
imshow(JJ);
title('��ˮƽ��ת');
subplot(3,4,11)
jj=JJ+T;%��תǰ���ں�
imshow(jj);
title('����+���ں�');

%% �ٴθ�ʴ
subplot(3,4,12);
F = imerode(jj,SE);
imshow(F);%�ٴθ�ʴ
title('����ͼ��');
F=bwareaopen(F,50);%�Ƴ�С��50�Ŀն�

%% ƻ�����
FF = logical(F);%����0���䣬������0Ԫ��ȫ��תΪ1����ֻ֤��0��1��
disp('ƻ�������(����):');
area = sum(sum(FF))
zong = numel(FF)
disp('ƻ��ռ����ͼ�����رȣ�%)��');
percent=round(area/zong*100,2)
disp('ƻ������뾶(����):');
R = sqrt(area/pi)
disp('ƻ�������ܳ�(����):');
ZC = 2*pi*R

%% ȷ���ʵ�
%������ñ����Աຯ����������ʵ�,��ȻҲ����ʹ��matlab�Դ��������regionprops(FF,'Centroid'),��������
if 1 == 1          %���������һ��1�ĳ�2��������matlab�Դ��������
    %���Աຯ��
    spot=center(FF);
    X = spot(2); Y = spot(1);
else
    %���Դ�����
    pros = regionprops('table',FF,'Centroid');
    disp('���ĵ�X,Yֵ');
    spot = pros.Centroid
    X = spot(1); Y = spot(2);
end

%% ��ʾ�ʵ�λ��
figure('Name','�ʵ�����λ��','NumberTitle','off');
subplot(121);
imshow(F)%��ʾͼ��
title('�ʵ�λ��');
hold on
plot(X,Y,'*');

%% ��ȡƻ��������
line = bwboundaries(F);%����Ŀ��������������(��ʱ��ֹһ��)
x = line{1,1}(:,2);
y = line{1,1}(:,1);
subplot(122);
plot(x,y,'r');
title('ƻ��������');
%% �㷨��ʱ
toc




