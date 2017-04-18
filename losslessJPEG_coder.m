%������������ʾJPEG-LSѹ���㷨���̼�ѹ��Ч���������ٶȺ��ڴ����Ĳ�����
%JPEG-LS��Ҫ����DPCM�����Huffman�������ϣ��ǽ��������
%    C B D
%    A X         % X��Ҫ���������
%������ʾ���Ƕ�X����Ԥ��ļ��ַ�ʽ
% Selection-value Prediction 
% 0 No prediction 
% 1 A 
% 2 B 
% 3 C 
% 4 A + B �C C 
% 5 A + (B �C C)/2 
% 6 B + (A �C C)/2 
% 7 (A + B)/2 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t0=cputime;%�����ʱ��ʼ
A=double(imread('170.bmp'));%����ͼ��
%ͬʱ������Ԫ�ش�uint8ת����double��Ҫ��Ȼ��ֵ��Χֻ��0~255
% A=A(121:160,121:160,1:3);%����Ŀ��ͼ��ı�׼�ߴ�Ϊ240x320���������ʱΪ�˽�ʡʱ�䣬���ܲ��ý�С��ͼƬ     
A=A(101:180,101:180,1:3);%����Ŀ��ͼ��ı�׼�ߴ�Ϊ240x320���������ʱΪ�˽�ʡʱ�䣬���ܲ��ý�С��ͼƬ 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����Ԥ����룬��Ҫע�⣺ͼ���һ�к͵�һ��û�б��룬��Ҫ�����������롣����ļ��д����У�Error����ĵ�һ�к͵�һ��Ϊ��
for k=1:3 %k��ʾͼ���ĳ����                                                                
    for i=2:length(A(:,1,k)) %i��ʾͼ����ĳ���ص�����
        for j=2:length(A(1,:,k)) %j��ʾͼ����ĳ���ص�����
%             Error(i,j,k)=A(i,j-1,k)-A(i,j,k);%Error����ΪԤ�������󣬰��շ�ʽ1
%             Error(i,j,k)=A(i-1,j,k)-A(i,j,k);%Error����ΪԤ�������󣬰��շ�ʽ2   
%             Error(i,j,k)=A(i-1,j-1,k)-A(i,j,k);%Error����ΪԤ�������󣬰��շ�ʽ3 
%             Error(i,j,k)=A(i-1,j,k)+A(i,j-1,k)-A(i-1,j-1,k)-A(i,j,k);%Error����ΪԤ�������󣬰��շ�ʽ4
%             Error(i,j,k)=A(i,j-1,k)+(A(i-1,j,k)-A(i-1,j-1,k))/2-A(i,j,k);%Error����ΪԤ�������󣬰��շ�ʽ5
%             Error(i,j,k)=A(i-1,j,k)+(A(i,j-1,k)-A(i-1,j-1,k))/2-A(i,j,k);%Error����ΪԤ�������󣬰��շ�ʽ6
            Error(i,j,k)=(A(i,j-1,k)+A(i-1,j,k))/2-A(i,j,k);%Error����ΪԤ�������󣬰��շ�ʽ7 
        end
    end
end

JPEGLS_coderoutput1='';%��JPEGLSѹ������������������(ͼ��ĵ�һ�У���һ�в���) 
temp='';
for k=1:3
    for j=1:length(A(1,:,k)) %j��ʾͼ����ĳ���ص�����
        temp=A1.huffmancode(find(A1.luminance==A(1,j,k)));
        JPEGLS_coderoutput1=strcat(JPEGLS_coderoutput1,temp);
    end
    for i=2:length(A(:,1,k))%i��ʾͼ����ĳ���ص�����
        temp=A1.huffmancode(find(A1.luminance==A(i,1,k)));
        JPEGLS_coderoutput1=strcat(JPEGLS_coderoutput1,temp);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��Error�е�Ԫ�ؽ���������������������                                      
% Errorq=round(Error);%Errorq��ʾ�������Error������������1
% Errorq=round(Error/2);%Errorq��ʾ�������Error������������2
Errorq=round(Error/4);%Errorq��ʾ�������Error������������4

JPEGLS_coderoutput2='';%��JPEGLSѹ������������������(ͼ���2:end�У�2:end�в���)
temp='';
for k=1:3
    for i=2:length(A(:,1,k)) %i��ʾͼ����ĳ���ص�����
        for j=2:length(A(1,:,k)) %j��ʾͼ����ĳ���ص�����
            temp=Errorquant.huffmancode(find(Errorquant.luminance==Errorq(i,j,k)));
            JPEGLS_coderoutput2=strcat(JPEGLS_coderoutput2,temp);
        end
    end
end
time=cputime-t0 %��ʱ����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����ԭʼͼ���С����JPEG-LSѹ�����ͼ���С�Ƚ�
temp=length(A(:,1,1))*length(A(1,:,1))*3; %ԭʼͼ������Ԫ������
originalsize=temp*ceil(log2(255-0)); %ԭʼͼ���С

JPEGLSsize1=length(JPEGLS_coderoutput1{1});
JPEGLSsize2=length(JPEGLS_coderoutput2{1});
compressionratio=originalsize/(JPEGLSsize1+JPEGLSsize2) %JPEGLSѹ�������ȫû��ѹ����ԭʼͼ���ѹ���� 

    