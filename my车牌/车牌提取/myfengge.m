function myfengge(I0)
%I0Ϊbwͼ��
%�ҵ��ַ��ָ�
%����ʵ�ַָ��ַ���Ч��
%��ʾΪ��ֵͼ��ָ��ַ�
[~,col]=size(I0);
n=10;
t=fix(col/n);
a(1)=1;
for i=1:7
    len=t;
    while mean(I0(:,a(i)+len))>0.06  %��ֵ��С��ѡ
        len=len+1;
    end
    a(i+1)=a(i)+len;
end
figure
for i=1:7
    subplot(3,3,i)
    imshow(I0(:,a(i):a(i+1)));
end