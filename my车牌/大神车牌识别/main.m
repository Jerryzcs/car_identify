clear;close;clc
car=imread('car.jpg');
r=car(:,:,1); %RGB��ɫͨ��
g=car(:,:,2);
b=car(:,:,3);
% imshow(car);
%% RGB��Χ���������޸ģ������ֶ������ҵ��Ŀ��з�Χ
r1=r<25;
g1=g>20&g<65;
b1=b>90&b<140;
img_merge=r1.*g1.*b1; %�ҵ���ɫ����Ķ�ֵͼ
n=9;
mask=ones(n,n)/(n.^2);
img_conv=conv2(img_merge,mask,'valid'); %��ά������㣬�ҵ���ɫ��������
max_i=max(max(img_conv)); %��ɫ�����������ĵ�
% subplot(1,2,1)
% % imshow(img_merge);
% imshow(img_conv);
%% ȷ������λ�ü���С
length=15;
width=15;
[x_pos,y_pos]=find(img_conv==max_i); %�ҵ�����������λ����Ϊbox���
x_pos=x_pos(1,1);
y_pos=y_pos(1,1);
% rectangle('Position',[y_pos,x_pos,1,1],'EdgeColor','b','LineWidth',3);
% plate=car(x_pos:x_pos+length,y_pos:y_pos+width,:); 
% imshow(plate);
%%
for i=1:2
up_mean=1;
down_mean=1;
right_mean=1;
left_mean=1;
thres=0; %������ֵ��������
    
while up_mean>thres %��������
    up_mean=mean(img_conv(x_pos:x_pos+length,y_pos));
    y_pos=y_pos-1;
end
while left_mean>thres %��������
    left_mean=mean(img_conv(x_pos,y_pos:y_pos+width));
    x_pos=x_pos-1;

end
thres=0.1; %������ֵ��������
while right_mean>thres %��������
    right_mean=mean(img_conv(x_pos+length,y_pos:y_pos+width));
    length=length+1;
end
while down_mean>thres %��������
    down_mean=mean(img_conv(x_pos:x_pos+length,y_pos+width));
    width=width+1;
end
end
plate=car(x_pos+1:x_pos+length,y_pos+1:y_pos+width,:); %����ȷ������λ��
% rectangle('Position',[y_pos,x_pos,width,length],'EdgeColor','b','LineWidth',3);
% subplot(1,2,2)
% imshow(plate);
% imshow(img_conv);
%% ��һ��ȷ������λ��
r_p=plate(:,:,1);
g_p=plate(:,:,2);
b_p=plate(:,:,3);

r2=r_p<25; %rpg��ɫͨ����Χ
g2=g_p>20&g_p<65;
b2=b_p>90&b_p<140;
img_m2=r2.*g2.*b2; %�ҵ���ɫ����Ķ�ֵͼ
% subplot(1,2,1)
% imshow(img_m2);
% mask2=[1,1;1,1];
% img_m2=imerode(img_m2,mask2); %��ʴͼ��ȥ��

%% ������ת
best_angle=1000;
for i=-30:30
temp_plate=imrotate(img_m2,i,'loose');
mean_img=mean(temp_plate,2);
t=find(mean_img);
[num_row,~]=size(t);
   if num_row<best_angle
       best_angle=num_row;
       rot_plate=temp_plate;
       rot_img=imrotate(plate,i,'loose');
   end
end
% subplot(1,2,2)
% imshow(rot_plate);
%% ������ֵ��һ��ȷ������λ��
plate_thresh=1; %�Զ��峵�Ʒ�Χ��ֵ��Ŀǰ�������ǵ�����������ʱ��Ҫ����ֵ��������ֵ��Ӱ�쳵���ַ���Χ��
x_m2=find(sum(rot_plate)>plate_thresh);
min_x2=min(x_m2);%�����������
max_x2=max(x_m2); %�����յ�����
y_m2=find(sum(rot_plate,2)>plate_thresh);
min_y2=min(y_m2); %�����������
max_y2=max(y_m2);%�����յ�����
plate2=rot_img(min_y2:max_y2,min_x2:max_x2,:);
% subplot(1,2,2)
% imshow(plate2);

%% ���ƻҶȻ�����ֵ��
i2=im2double(plate2);
i3=rgb2gray(i2);
i3_a=i3(i3>0); %ȥ��0����Ϊ��ת�Ƕȹ�����кܶ�0��Ӱ���ֵ����ֵ
sh=graythresh(i3_a);
i4=im2bw(i3,sh);
% subplot(1,2,2)
% imshow(i4);

%% �����ַ��ָ�
[~,m]=size(i4);
length_i=ones(1,1); %���ηָ�
pos_k=zeros(2,7); %�ҵ�7���ַ�λ��
k=1;
length=fix(m/21); %һ�ηָ�ĳ���
i=1;
  while k<7
     length=fix(m/21);
    while length_i(i)+length<m&& mean(mean(i4(:,length_i(i)+length)))>0.08 %����������������С����ֵʱ�ָ�
        length=length+1;
    end
    if mean(mean(i4(:,length_i(i):length_i(i)+length)))>0.1 %�жϷָ��ͼ�Ƿ�Ϊ�ַ�
        pos_k(1,k)=length_i(i);
        pos_k(2,k)=length_i(i)+length;
        k=k+1;
    end
    length_i(i+1)=length_i(i)+length;
    i=i+1;
 end
 pos_k(1,7)=pos_k(2,6); %�����ַ���Χȷ��
 pos_k(2,7)=m;
 %% ����ָ��ַ�
 figure
 subplot(4,10,[1:5,11:15,21:25]);
 imshow(car)
 title('ԭͼ')
 
 subplot(4,10,6:10);
 imshow(plate)
 title('��ɫ����')
 
 subplot(4,10,16:20);
 imshow(rot_img)
 title('��ת����')
 
  subplot(4,10,26:30);
 imshow(plate2)
 title('���ζ�λ')
 
    for i=1:7
        subplot(4,10,30+i);
        imshow(i4(:,pos_k(1,i):pos_k(2,i)))
    end
    title('�ַ��ָ�');