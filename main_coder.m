%����6*40�Ĵ�С���ζ�ȡͼ��ĸ�������
%ͼ���СΪx*y,����ȡ48��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global bayerimage0 %��ֻ�Ǹ����ڼ���PSNR�Ĳ�����ʵ��ʹ��ʱ����ɾ��
totaloutput='';%����ͼ������
A0=double(imread('sample3.bmp'));%����ͼ�񣬱�׼ͼ���СΪx*y
load codebook_step1_forcoder%�����뱾��ѹ������Ϊ2��������˵ҽ��Ҫ��ͼƬ�������������Ծ����ܵĲ�Ҫ����ͼ������
step=1;%��������
x=240;%ͼ�������
y=320;%ͼ�������
z=0;%ROI��ʼ����
w=0;%ROI��ʼ����
q=0;%ROI��������
p=0;%ROI��������

%bayer��ɫ�˲����и�ʽ
%  B  G
%  G  R
filter(:,:,3)=[1 0;0 0];%bayer��ɫ�˲�����b����
filter(:,:,2)=[0 1;1 0];%bayer��ɫ�˲�����g����
filter(:,:,1)=[0 0;0 1];%bayer��ɫ�˲�����r����

%����ͨGRB��ɫ��Ƭת��BAYER��ʽ��Ƭ
for i=1:x/2%������ÿ���˲�����Ϊ2*2,ͼ����x�У�������Ҫѭ��120��
    for j=1:y/2%������ѭ��160��
        A0(2*i-1:2*i,2*j-1:2*j,:)=A0(2*i-1:2*i,2*j-1:2*j,:).*filter;
    end
end
bayerimage0=A0;
temp=zeros(x,y,1);
temp=A0(:,:,1)+A0(:,:,2)+A0(:,:,3);
A0=temp;%A0���ת�����˵�bayer��Ƭ���ߴ���x*y*1
clear temp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ԭʼͼ��x*y*3�ֳ�4����ͼ120*160*1,�ֱ���b����������g������r�������ؼ���
for i=2-1:2:x-1
    for j=2-1:2:y-1
        A0_color{1}((i+1)/2,(j+1)/2)=A0(i,j);%A0_color{1}��BAY��ʽ��ͼ����b����Ԫ�ص�����ȡ������ɵ�ͼ�񣬴�СΪ0.5x*0.5y*1
    end
end
        
for i=2-1:2:x-1
    for j=2:2:y
        A0_color{2}((i+1)/2,j/2)=A0(i,j);%A0_color{2}��BAY��ʽ��ͼ����g����(�˲��������Ͻǵ��Ǹ�G)Ԫ�ص�����ȡ������ɵ�ͼ�񣬴�СΪ0.5x*0.5y*1
    end
end

for i=2:2:x
    for j=2-1:2:y-1
        A0_color{3}(i/2,(j+1)/2)=A0(i,j);%A0_color{3}��BAY��ʽ��ͼ����g����(�˲��������½ǵ��Ǹ�G)Ԫ�ص�����ȡ������ɵ�ͼ�񣬴�СΪ0.5x*0.5y*1
    end
end

for i=2:2:x
    for j=2:2:y
        A0_color{4}(i/2,j/2)=A0(i,j);%A0_color{4}��BAY��ʽ��ͼ����r����Ԫ�ص�����ȡ������ɵ�ͼ�񣬴�СΪ0.5x*0.5y*1
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��4��BAYER����ͼ����ˮƽ�˲�
for i=2:y/2
    A0_color{1}(:,i)=round((A0_color{1}(:,i-1)+A0_color{1}(:,i))/2);
    A0_color{2}(:,i)=round((A0_color{2}(:,i-1)+A0_color{2}(:,i))/2);
    A0_color{3}(:,i)=round((A0_color{3}(:,i-1)+A0_color{3}(:,i))/2);
    A0_color{4}(:,i)=round((A0_color{4}(:,i-1)+A0_color{4}(:,i))/2);
end
    
%��4��BAYER����ͼ���д�ֱ�˲�
for i=2:x/2
    A0_color{1}(i,:)=round((A0_color{1}(i-1,:)+A0_color{1}(i,:))/2);
    A0_color{2}(i,:)=round((A0_color{2}(i-1,:)+A0_color{2}(i,:))/2);
    A0_color{3}(i,:)=round((A0_color{3}(i-1,:)+A0_color{3}(i,:))/2);
    A0_color{4}(i,:)=round((A0_color{4}(i-1,:)+A0_color{4}(i,:))/2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��С����ȡͼ��Ϊ���㵥λ

for m=1:4 %4����ɫ����ͼ
    for n=1:0.25*x*y/(6*40)  %ÿ����ɫ����ͼƬ�ϵ���ͼ������0.25*x*y/(6*40)��
        A=A0_color{m}(6*(ceil(n/(0.5*y/40))-1)+1:6*ceil(n/(0.5*y/40)),40*(mod((n-1),(0.5*y/40)))+1:40*(mod((n-1),(0.5*y/40))+1)); %A������ͼ��0.5x*0.5y*1�ϵ�һ��6*40*1С�������㷨��ͼ����Ļ�����λ        
        [JPEGLS_coderoutput1,JPEGLS_coderoutput2]=losslessJPEG_coder(A,Errorquant,step);
        totaloutput=strcat(totaloutput,JPEGLS_coderoutput1,JPEGLS_coderoutput2);
    end
end

TotalCompressionRatio=x*y*8/length(totaloutput{1})%����ѹ����
clear A JPEGLS_coderoutput1 JPEGLS_coderoutput2 n A1 Errorquant A0 i j m filter A0_color step;

       
        