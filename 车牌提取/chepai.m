clc;clear;close all
%%
%��������
n=2;
I=imread('1.jpg');
% figure
% subplot(n,n,1)
% imshow(I);
%%
% %�ü�
[row,col,n]=size(I);
I=I(1:round(1/2*row),1:col,1:3);
r=I(:,:,1);
% subplot(n,n,2)
% imshow(I);
%����
%��Ҫ�������ǵĽǶȣ�λ�ò��
%С��ʶ�����������
%%
%�����������
%��������
r=I(:,:,1);
g=I(:,:,2);
b=I(:,:,3);
%%
%������ɫ������С������
r1=r>0&r<40;
g1=g>20&g<65;
b1=b>90&b<170;
im_con=r1.*g1.*b1;
se=strel('disk',3);
im_con=imdilate(im_con,se);
% subplot(n,n,1)
% imshow(im_con);
%%
im=bwconncomp(im_con);
s=im.PixelIdxList{1};
%%
% %�����������
r=I(:,:,1);
im_box1=zeros(size(r));
im_box1(s)=1;
% subplot(n,n,2)
% imshow(im_box1)
%%
I_kc=kuangchu(I,im_box1);
% figure
% imshow(I_kc);
% imshow(I_bw);
%����
%��Ϊ������ɫ���ң�ֻ������ɫ����
%��Ҫ������ɫû��̫�����
%���յĹ��ߣ��ع��Ҫ����
%������Ⱦ���Ǻ�����
%��������
%���ؼ��
%�ַ�����
%%
th=graythresh(I_kc);
I_bw=im2bw(I_kc,th);
%%
%�Ƕ�У��
%����Ӧ��ת
theta=auto_xzhuan(I_bw);
I_angle=imrotate(I_kc,theta,'loose');
% subplot(1,2,1)
% imshow(I_angle);
%%
%����ӦУ��
I_jz=auto_jz(I_angle);
% subplot(1,2,2)
imshow(I_jz);
%%
% ����У��
% k=0.87;
% I_jz=txjz(I_angle,k);
% subplot(1,2,2)
% imshow(I_jz);
%����
%���սǶ�Ҫ���
%��������Ӧ���ڣ���Ҫ�˹�����
%%
%�����������
%��������
r=I_jz(:,:,1);
g=I_jz(:,:,2);
b=I_jz(:,:,3);
%%
%������ɫ������С������
r1=r>0&r<40;
g1=g>20&g<65;
b1=b>90&b<200;
im_con=r1.*g1.*b1;
se=strel('disk',2);
im_con=imclose(im_con,se);
% subplot(n,n,2)
% imshow(im_con);
%%
im=bwconncomp(im_con);
s=im.PixelIdxList{1};
%%
%�����������
im_box2=zeros(size(r));
im_box2(s)=1;
% subplot(n,n,3)
% imshow(im_box2);
%%
%�����������
I_jz=kuangchu(I_jz,im_box2);
% subplot(n,n,3)
% imshow(I);
% %%
sh=graythresh(I_jz);
I0=im2bw(I_jz,sh);
I0=bwmorph(I0,'thin',1);
% figure
% imshow(I0);
%%
%�ҵ��ַ��ָ�
myfengge(I0);
%%
% ����
% ���þ��ַ��ָ�ģ�Ҫ��ǰ������У���������ʣ��õ��ĳ��Ʒ���
% ��������
% �����ַ�����ϵ�����������ַ�
% %
% ����
% �ַ�ƥ��
% OCR
% ������
% ģ��ƥ��


