function [spot] = center(FF)
%center ����Բ�ζ�ֵͼ������ĵ�λ��
%   centr(��ֵͼ�����������ֵͼ����ͼ�����ĵ���к���λ�á�

[h,m]=size(FF);%��ȡͼ���к���
label=zeros(h,4);%��������ҳ�����
k=0;
for ii=1:h
   for jj=1:m
      if FF(ii,jj)==1&&FF(ii,jj-1)==0%�ɺڱ�ף���ʼ��
      k=k+1;
          label(k,1:2)=[ii,jj];
      end
      if FF(ii,jj)==1&&FF(ii,jj+1)==0%�ɰױ�ڣ���β��
          label(k,3)=jj;
          label(k,4)=label(k,3)-label(k,2);%�ҳ�
      end
   end
end
x=max(label(:,4));%Ѱ�����
max_h=find(label(:,4)==x,100);%�������������
center=sum(max_h)/numel(max_h);%����Ҳ�ֹһ����ȡƽ�������м�һ������λ��
X=label(center,1);%�ʵ�������X
Y=(label(center,3)+label(center,2))/2;%�ʵ�������Y
disp('�ʵ�����λ��(��Y,��X)');
spot=[X,Y]
end

