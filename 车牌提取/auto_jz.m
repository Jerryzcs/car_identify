function I_jz=auto_jz(I_angle)
%I_angleΪrgbͼ��
%I_jzΪУ�����rgbͼ��
%k0Ϊ����Ӧ��У��ϵ��
th=1000;
for k=0.7:0.01:1.5
    M=txjz(I_angle,k);
    I_m=mean(M);
    I_n=find(I_m>0.04);
    [~,I_col]=size(I_n);
    if I_col<th
        th=I_col;
        k0=k;
    end
end
I_jz=tx(I_angle,k0);