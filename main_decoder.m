%����6x40�Ĵ�С���ζ�ȡͼ��ĸ�������
%ͼ���СΪx*y,����ȡ48��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global bayerimage0
load codebook_step1_fordecoder%�����뱾
step=1;%ѹ������Ϊ2
x=240;%ͼ�������
y=320;%ͼ�������
z=0;%ROI��ʼ����
w=0;%ROI��ʼ����
q=0;%ROI��������
p=0;%ROI��������

for m=1:4 %4��ɫ�ʷ���ͼ0.5x*0.5y*1
    for n=1:0.25*x*y/(6*40) %ÿ��ɫ�ʷ���ͼ����0.25*x*y/(6*40)��6x40x1��ͼ
        t0=cputime;%��ʼ��ʱ
        [Re_A,totaloutput]=losslessJPEG_decoder(Errorquant,totaloutput,step);
        Re_A0_color{m}(6*(ceil(n/(0.5*y/40))-1)+1:6*ceil(n/(0.5*y/40)),40*(mod((n-1),(0.5*y/40)))+1:40*(mod((n-1),(0.5*y/40))+1))=Re_A;%ͼ��Ľ���
        time=cputime-t0%��ʱ����
    end
end
clear Errorquant t0 time step

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�Բ�ɫ����ͼ���д�ֱ���˲�
for i=x/2:-1:2
    Re_A0_color{1}(i,:)=2*Re_A0_color{1}(i,:)-Re_A0_color{1}(i-1,:);
    Re_A0_color{2}(i,:)=2*Re_A0_color{2}(i,:)-Re_A0_color{2}(i-1,:);
    Re_A0_color{3}(i,:)=2*Re_A0_color{3}(i,:)-Re_A0_color{3}(i-1,:);
    Re_A0_color{4}(i,:)=2*Re_A0_color{4}(i,:)-Re_A0_color{4}(i-1,:);
end

%�Բ�ɫ����ͼ����ˮƽ���˲�
for i=y/2:-1:2
    Re_A0_color{1}(:,i)=2*Re_A0_color{1}(:,i)-Re_A0_color{1}(:,i-1);
    Re_A0_color{2}(:,i)=2*Re_A0_color{2}(:,i)-Re_A0_color{2}(:,i-1);
    Re_A0_color{3}(:,i)=2*Re_A0_color{3}(:,i)-Re_A0_color{3}(:,i-1);
    Re_A0_color{4}(:,i)=2*Re_A0_color{4}(:,i)-Re_A0_color{4}(:,i-1);
end
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��4��������ͼ0.5x*0.5y*1��ϳ�Ϊ������BAYER��ʽͼ��x*y*3
Re_A0=zeros(x,y,3);

for i=2-1:2:x-1
    for j=2-1:2:y-1
        Re_A0(i,j,3)=Re_A0_color{1}((i+1)/2,(j+1)/2);%b����Ԫ�ػָ���Re_A0ͼ����
    end
end
        
for i=2-1:2:x-1
    for j=2:2:y
        Re_A0(i,j,2)=Re_A0_color{2}((i+1)/2,j/2);%g����(�˲��������Ͻǵ��Ǹ�G)Ԫ�ػָ���Re_A0ͼ����
    end
end

for i=2:2:x
    for j=2-1:2:y-1
        Re_A0(i,j,2)=Re_A0_color{3}(i/2,(j+1)/2);%g����(�˲��������½ǵ��Ǹ�G)Ԫ�ػָ���Re_A0ͼ����
    end
end

for i=2:2:x
    for j=2:2:y
        Re_A0(i,j,1)=Re_A0_color{4}(i/2,j/2);%b����Ԫ�ػָ���Re_A0ͼ����
    end
end
subplot(2,2,3),subimage(uint8(Re_A0)),title('�ָ�BAYERͼ��Re_A0')
bayerimage1=Re_A0;%����PSNR�õĲ�����ʵ��ʹ��ʱ��ɾ��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��BAYER��ʽ��Ƭ���в�ֵ���ָ���ΪRGB��ɫ��Ƭ
for i=2:2:x-2
    Re_A0(i,:,3)=(Re_A0(i-1,:,3)+Re_A0(i+1,:,3))/2;
end
Re_A0(x,:,3)=Re_A0(x-1,:,3);

for i=2:2:y-2
    Re_A0(:,i,3)=(Re_A0(:,i-1,3)+Re_A0(:,i+1,3))/2;
end
Re_A0(:,y,3)=Re_A0(:,y-1,3);       %��Re_A0��Ƭ��B������ֵ�ָ�


for i=3:2:x-1
    Re_A0(i,:,1)=(Re_A0(i-1,:,1)+Re_A0(i+1,:,1))/2;
end
Re_A0(1,:,1)=Re_A0(2,:,1);

for i=3:2:y-1
    Re_A0(:,i,1)=(Re_A0(:,i-1,1)+Re_A0(:,i+1,1))/2;
end
Re_A0(:,1,1)=Re_A0(:,2,1);           %��Re_A0��Ƭ��R������ֵ�ָ�

Re_A0(1,1,2)=(Re_A0(2,1,2)+Re_A0(1,2,2))/2;
Re_A0(x,y,2)=(Re_A0(x,y-1,2)+Re_A0(x-1,y,2))/2;
for i=2:x-1
    if Re_A0(i,1,2)==0
        Re_A0(i,1,2)=(Re_A0(i+1,1,2)+Re_A0(i,2,2))/2;
    end
    if Re_A0(i,y,2)==0
        Re_A0(i,y,2)=(Re_A0(i-1,y,2)+Re_A0(i,y-1,2))/2;
    end
end
for j=2:y-1
    if Re_A0(1,j,2)==0
        Re_A0(1,j,2)=(Re_A0(2,j,2)+Re_A0(1,j+1,2))/2;
    end
    if Re_A0(x,j,2)==0
        Re_A0(x,j,2)=(Re_A0(x-1,j,2)+Re_A0(x,j-1,2))/2;
    end
end
for i=2:x-1
    for j=2:y-1
        if Re_A0(i,j,2)==0
            Re_A0(i,j,2)=(Re_A0(i+1,j,2)+Re_A0(i,j+1,2)+Re_A0(i-1,j,2)+Re_A0(i,j-1,2))/4;
        end
    end
end %��Re_A0��Ƭ��G������ֵ�ָ�

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ͼ������PSNR
A0=double(imread('sample3.bmp'));%����ͼ�񣬱�׼ͼ���СΪx*y
subplot(2,2,2),subimage(uint8(A0)),title('ԭʼRGBͼ��A0')
Re_A0=uint8(Re_A0);%��������н�ͼ������Ԫ�ظĳ�double���ȣ������������Ҫת����uint8ģʽ
subplot(2,2,4),subimage(Re_A0),title('�ָ�RGBͼ��Re_A0')

A0_1D=zeros(1,x*y*3);%ͼ��A0��һά���
count=1;
for k=1:3
    for i=1:x %i��ʾͼ����ĳ���ص�����
        for j=1:y %j��ʾͼ����ĳ���ص�����
            A0_1D(count)=bayerimage0(i,j,k);%��Errorquant������Ԫ��ת�Ƶ���Errorquant_1D��
            count=count+1;                %Errorquant_1D��һά����
        end
    end
end

Re_A0_1D=zeros(1,x*y*3);%�ָ�ͼ��Re_A0��һά���
count=1;
for k=1:3
    for i=1:x %i��ʾͼ����ĳ���ص�����
        for j=1:y %j��ʾͼ����ĳ���ص�����
            Re_A0_1D(count)=bayerimage1(i,j,k);%��Errorquant������Ԫ��ת�Ƶ���Errorquant_1D��
            count=count+1;                %Errorquant_1D��һά����
        end
    end
end
MSE=sum((A0_1D-Re_A0_1D).^2)/length(A0_1D);
PSNR=10*log10((2^8-1)^2/MSE)%��ֵ�����
subplot(2,2,1),subimage(uint8(bayerimage0)),title('ԭʼBAYERͼ��A0')
clear A0_1D Re_A0_1D count i j k MSE Re_A n totaloutput A0 Re_A0 A0_color Re_A0_color filter m;