function I=kuangchu(I,im_box)
%�����������
%IΪrgbԭͼ��
%im_boxΪ��ֵͼ�񣬼�Ҫ��ͼ��I�Ͽ��������
[row,col]=find(im_box);
minrow=min(row);
maxrow=max(row);
mincol=min(col);
maxcol=max(col);
I=I(minrow:maxrow,mincol:maxcol,1:3);