function theta=auto_xzhuan(I_bw)
%I_bwΪ�����bwͼ��
%thetaΪ�Զ���ת����ѽǶ�
%�ú�������ʵ������Ӧ�Ǽ���
%thΪ�趨��ֵ
th=1000;
c=0.05;
theta=10;
for a=-theta:theta
    I_rot=imrotate(I_bw,a,'loose');
    im_m=mean(I_rot,2);
    t=find(im_m>c); %�ҵ��о�ֵ�ķ���Ԫ��,��ֵ0.05��������΢���
    [im_row,~]=size(t);
    if im_row<th    %����������ʱ�����
        th=im_row;
        theta=a;
    end
end
