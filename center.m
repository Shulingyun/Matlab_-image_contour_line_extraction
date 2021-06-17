function [spot] = center(FF)
%center 计算圆形二值图像的中心点位置
%   centr(二值图）——输入二值图返回图像中心点的行和列位置。

[h,m]=size(FF);%获取图像行和列
label=zeros(h,4);%建立存放弦长变量
k=0;
for ii=1:h
   for jj=1:m
      if FF(ii,jj)==1&&FF(ii,jj-1)==0%由黑变白（开始）
      k=k+1;
          label(k,1:2)=[ii,jj];
      end
      if FF(ii,jj)==1&&FF(ii,jj+1)==0%由白变黑（结尾）
          label(k,3)=jj;
          label(k,4)=label(k,3)-label(k,2);%弦长
      end
   end
end
x=max(label(:,4));%寻找最长弦
max_h=find(label(:,4)==x,100);%返回最长弦所在行
center=sum(max_h)/numel(max_h);%，最长弦不止一条，取平均求最中间一条所在位置
X=label(center,1);%质点所在行X
Y=(label(center,3)+label(center,2))/2;%质点所在列Y
disp('质点所在位置(行Y,列X)');
spot=[X,Y]
end

