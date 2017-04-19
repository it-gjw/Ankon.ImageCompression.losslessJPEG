%������������ʾJPEG-LSѹ���㷨���̼�ѹ��Ч��
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


function [JPEGLS_coderoutput1,JPEGLS_coderoutput2]=losslessJPEG_coder(A,Errorquant,step)
% global A1 Errorquant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t0=cputime;%�����ʱ��ʼ

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����Ԥ����룬��Ҫע�⣺ͼ���һ�к͵�һ��û�б��룬��Ҫ�����������롣����ļ��д����У�Error����ĵ�һ�к͵�һ��Ϊ��
                                                               
for i=2:length(A(:,1)) %i��ʾͼ����ĳ���ص�����
    for j=2:length(A(1,:)) %j��ʾͼ����ĳ���ص�����
%             Error(i,j)=A(i,j-1)-A(i,j);%Error����ΪԤ�������󣬰��շ�ʽ1
%             Error(i,j)=A(i-1,j)-A(i,j);%Error����ΪԤ�������󣬰��շ�ʽ2   
%             Error(i,j)=A(i-1,j-1)-A(i,j);%Error����ΪԤ�������󣬰��շ�ʽ3 
%             Error(i,j)=A(i-1,j)+A(i,j-1)-A(i-1,j-1)-A(i,j);%Error����ΪԤ�������󣬰��շ�ʽ4
%             Error(i,j)=A(i,j-1)+(A(i-1,j)-A(i-1,j-1))/2-A(i,j);%Error����ΪԤ�������󣬰��շ�ʽ5
%             Error(i,j)=A(i-1,j)+(A(i,j-1)-A(i-1,j-1))/2-A(i,j);%Error����ΪԤ�������󣬰��շ�ʽ6
        Error(i,j)=(A(i,j-1)+A(i-1,j))/2-A(i,j);%Error����ΪԤ�������󣬰��շ�ʽ7 
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
JPEGLS_coderoutput1='';%��JPEGLSѹ������������������(ͼ��ĵ�һ�У���һ�в���) 
temp='';

for j=1:length(A(1,:)) %j��ʾͼ����ĳ���ص�����
    temp=dec2bin(A(1,j));
    temp1=length(temp);
    if temp1==1
        temp1='0000000';
    end
    if temp1==2
        temp1='000000';
    end
    if temp1==3
        temp1='00000';
    end
    if temp1==4
        temp1='0000';
    end
    if temp1==5
        temp1='000';
    end
    if temp1==6
        temp1='00';
    end
    if temp1==7
        temp1='0';
    end
    if temp1==8
        temp1='';
    end
    JPEGLS_coderoutput1=strcat(JPEGLS_coderoutput1,temp1,temp);
end           %�Ե�һ�����ݽ�����ѹ���ĵȳ����룬ÿλ�����ṩ8bit�ռ䡣�����Ͳ���Ҫһ��������뱾codebook_A1�ˣ������ڴ����ġ�
              %�������ڵ�һ�е�һ�����ݽ��٣����ӵ����ݴ�����Ҳ����
for i=2:length(A(:,1))%i��ʾͼ����ĳ���ص�����
    temp=dec2bin(A(i,1));
    temp1=length(temp);
    if temp1==1
        temp1='0000000';
    end
    if temp1==2
        temp1='000000';
    end
    if temp1==3
        temp1='00000';
    end
    if temp1==4
        temp1='0000';
    end
    if temp1==5
        temp1='000';
    end
    if temp1==6
        temp1='00';
    end
    if temp1==7
        temp1='0';
    end
    if temp1==8
        temp1='';
    end
    JPEGLS_coderoutput1=strcat(JPEGLS_coderoutput1,temp1,temp);
end           %�Ե�һ�����ݽ�����ѹ���ĵȳ����룬ÿλ�����ṩ8bit�ռ䡣�����Ͳ���Ҫһ��������뱾codebook_A1�ˣ������ڴ����ġ�
              %�������ڵ�һ�е�һ�����ݽ��٣����ӵ����ݴ�����Ҳ����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��Error�е�Ԫ�ؽ���������������������                                      
Errorq=round(Error/step);%Errorq��ʾ�������Error������������Ϊstep
clear Error step;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
JPEGLS_coderoutput2='';%��JPEGLSѹ������������������(ͼ���2:end�У�2:end�в���)
temp='';

    for i=2:length(A(:,1)) %i��ʾͼ����ĳ���ص�����
        for j=2:length(A(1,:)) %j��ʾͼ����ĳ���ص�����
            if find(Errorquant.luminance==Errorq(i,j))~=0%����ھ����뱾���ҵ��˶�Ӧ������ֵ
                temp=Errorquant.huffmancode(find(Errorquant.luminance==Errorq(i,j)));%��ֱ��ת��Ϊhuffman����
            else   %����ھ����뱾���Ҳ�����Ӧ������ֵ��������ӽ���
                temp1=min(abs(Errorquant.luminance-Errorq(i,j)));
                if find(Errorquant.luminance==(Errorq(i,j)+temp1))~=0
                    temp=Errorquant.huffmancode(find(Errorquant.luminance==(Errorq(i,j)+temp1)));
                else
                    temp=Errorquant.huffmancode(find(Errorquant.luminance==(Errorq(i,j)-temp1)));
                end
            end
            JPEGLS_coderoutput2=strcat(JPEGLS_coderoutput2,temp);
        end
    end

% time=cputime-t0 %��ʱ����
clear Errorq i j t0 temp1 temp;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����ԭʼͼ���С����JPEG-LSѹ�����ͼ���С�Ƚ�
temp=length(A(:,1))*length(A(1,:)); %ԭʼͼ������Ԫ������
originalsize=temp*ceil(log2(255-0)); %ԭʼͼ���С
clear temp;
JPEGLSsize1=length(JPEGLS_coderoutput1);
JPEGLSsize2=length(JPEGLS_coderoutput2{1});%���ﲻ֪��Ϊʲôͬ���Ĳ������õ���JPEGLS_coderoutput1��2�����Ͳ�һ��
compressionratio=originalsize/(JPEGLSsize1+JPEGLSsize2) %JPEGLSѹ�������ȫû��ѹ����ԭʼͼ���ѹ���� 
clear JPEGLSsize1 JPEGLSsize2 originalsize time compressionratio;

    