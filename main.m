%% 苹果识别
%主要操作步骤如下：
%读取图片、色彩空间转化、单通道a操作、开闭运算、二值化、图像融合、水平翻转等操作。
% By 小洋葱
tic
%% 读取图片信息
clear;clc;
data = imread('001.png');%这里是图片路径
figure('Name','图像处理过程','NumberTitle','off');
subplot(3,4,1);
imshow(data);
title('①原始图像');
%% 将RGB色彩空间转为Lab色彩空间
L = rgb2lab(data);%转化函数rgb2lab()
subplot(3,4,2);
imshow(L(:,:,1));%L亮度
title('②亮度L');
subplot(3,4,3);
imshow(L(:,:,2));
title('③颜色通道a');
subplot(3,4,4);
imshow(L(:,:,3));
title('④颜色通道b');
%% 对单通道a进行操作
d = L(:,:,2);
SE = strel('disk',5);
I2 = imdilate(d,SE);%膨胀
I3 = imerode(I2,SE);%腐蚀
subplot(3,4,5);
imshow(I3);
title('⑤对a闭运算');

subplot(346);
ck = imfill(I3);%空洞填充
imshow(ck);
title('⑥空洞填充');

%% 图像融合
subplot(347);
z = mapminmax(ck)+mapminmax(L(:,:,3));%先归一化,再将图④与⑥进行融合;
imshow(z);
title('⑦图像融合');

subplot(3,4,8);
ZZ = imerode(z,SE);%腐蚀
imshow(ZZ);
title('⑧腐蚀图像');
T = imbinarize(ZZ,0.5);%二值化
subplot(3,4,9);
imshow(T);
title('⑨二值图像');

%% 水平翻转
subplot(3,4,10);
JJ=fliplr(T);  %水平翻转
imshow(JJ);
title('⑩水平翻转');
subplot(3,4,11)
jj=JJ+T;%翻转前后融合
imshow(jj);
title('将⑨+⑩融合');

%% 再次腐蚀
subplot(3,4,12);
F = imerode(jj,SE);
imshow(F);%再次腐蚀
title('最终图像');
F=bwareaopen(F,50);%移除小于50的空洞

%% 苹果面积
FF = logical(F);%除了0不变，其他非0元素全部转为1，保证只有0和1。
disp('苹果截面积(像素):');
area = sum(sum(FF))
zong = numel(FF)
disp('苹果占整个图像像素比（%)：');
percent=round(area/zong*100,2)
disp('苹果截面半径(像素):');
R = sqrt(area/pi)
disp('苹果截面周长(像素):');
ZC = 2*pi*R

%% 确定质点
%这里调用本人自编函数进行求解质点,当然也可以使用matlab自带函数求解regionprops(FF,'Centroid'),两者相差不大
if 1 == 1          %这里把其中一个1改成2即可利用matlab自带函数求解
    %①自编函数
    spot=center(FF);
    X = spot(2); Y = spot(1);
else
    %②自带函数
    pros = regionprops('table',FF,'Centroid');
    disp('质心的X,Y值');
    spot = pros.Centroid
    X = spot(1); Y = spot(2);
end

%% 显示质点位置
figure('Name','质点所在位置','NumberTitle','off');
subplot(121);
imshow(F)%显示图像
title('质点位置');
hold on
plot(X,Y,'*');

%% 提取苹果轮廓线
line = bwboundaries(F);%返回目标对象的轮廓数据(有时不止一个)
x = line{1,1}(:,2);
y = line{1,1}(:,1);
subplot(122);
plot(x,y,'r');
title('苹果轮廓线');
%% 算法耗时
toc




