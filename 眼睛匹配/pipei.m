function distance=pipei(src,temp)
%ʵ��ͼsrc��temp��ƥ��
%����src,temp��Ҫ��Ϊ�Ҷ�ͼ
%�ߴ�src>temp
[src_height,src_width]=size(src);
% imshow(src);
%%
%��ȡ����
[temp_height,temp_width]=size(temp);
% imshow(temp);
%%
for i=1:(src_height-temp_height)
    for j=1:(src_width-temp_width)
        src1=src(i:i-1+temp_height,j:j-1+temp_width);
        distance(i,j)=distan(src1,temp);
    end
end
