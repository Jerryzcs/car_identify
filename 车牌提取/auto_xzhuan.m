function theta=auto_xzhuan(I_bw)
%I_bwΪ�����bwͼ��
%thetaΪ�Զ���ת����ѽǶ�
%�ú�������ʵ������Ӧ�Ǽ���
%thΪ�趨��ֵ
th=1000;
for a=-30:30
    I_rot=imrotate(I_bw,a,'loose');
    im_m=mean(I_rot,2);
    t=find(im_m>0.05); %�ҵ��о�ֵ�ķ���Ԫ��,��ֵ0.05��������΢���
    [im_row,~]=size(t);
    if im_row<th    %����������ʱ�����
        th=im_row;
        theta=a;
    end
end
