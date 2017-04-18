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
A=double(imread('03.jpg'));%����ͼ��
%ͬʱ������Ԫ�ش�uint8ת����double��Ҫ��Ȼ��ֵ��Χֻ��0~255
A=A(200:224,200:232,1:3);%����Ŀ��ͼ��ı�׼�ߴ�Ϊ240x320���������ʱΪ�˽�ʡʱ�䣬���ܲ��ý�С��ͼƬ     



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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��A����ĵ�һ�е�һ�е�ͼ���������Ƚ��и���ͳ��
A1_1D=zeros(1,(length(A(:,1,1))+length(A(1,:,1))-1)*3);%ͼ���һά���
count=1;
for k=1:3
    for j=1:length(A(1,:,k)) %j��ʾͼ����ĳ���ص�����
        A1_1D(count)=A(1,j,k);%��ԭʼͼ��ĵ�һ���������ݴ���A1_1D
        count=count+1;
    end
    for i=2:length(A(:,1,k))%i��ʾͼ����ĳ���ص�����
        A1_1D(count)=A(i,1,k);%��ԭʼͼ��ĵ�һ���������ݴ���A1_1D
        count=count+1;
    end
end

A1.luminance=min(A1_1D):1:max(A1_1D);%Errorquant.luminance��Ӧ����������    
A1.count=hist(A1_1D,length(A1.luminance));%A1.count���ȳ��ֵĴ�����Խ���ʾ������ֵ����ԽƵ��
[A1.count,index]=sort(A1.count);%A1.count������ֵ����Ƶ���̶������ɵ͵���
A1.luminance=A1.luminance(index);%A1.luminanceҲͬ��˳������



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��A����ĵ�һ�е�һ�е�ͼ���������Ƚ���huffman����
A1.huffmancode=huffman(A1.count);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��Error�е�Ԫ�ؽ���������������������                                      
% Errorquant=round(Error);%Errorquant��ʾ�������Error������������1
% Errorquant=round(Error/2);%Errorquant��ʾ�������Error������������2
Errorquant=round(Error/4);%Errorquant��ʾ�������Error������������4


            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ͳ��Errorquant�����и�Ԫ����ֵ�ĸ��ʷֲ�                                                 %���⣺���и���ͳ��ʵ������Ҫ�ܶ������������ܹ����ݾ����ͼ������ر��룬������벻�����ţ����������ܽ�Լ�ܶ������Դ
Errorquant_1D=zeros(1,length(A(:,1,k))*length(A(1,:,k))*3);%ͼ���һά���
count=1;
for k=1:3
    for i=2:length(A(:,1,k)) %i��ʾͼ����ĳ���ص�����
        for j=2:length(A(1,:,k)) %j��ʾͼ����ĳ���ص�����
            Errorquant_1D(count)=Errorquant(i,j,k);%��Errorquant������Ԫ��ת�Ƶ���Errorquant_1D��
            count=count+1;                %Errorquant_1D��һά����
        end
    end
end

Errorquant.luminance=ceil(min(Errorquant_1D)):1:ceil(max(Errorquant_1D));%Errorquant.luminance��Ӧ����������     
Errorquant.count=hist(Errorquant_1D,length(Errorquant.luminance));%Errorquant.count���ȳ��ֵĴ�����Խ���ʾ������ֵ����ԽƵ��
[Errorquant.count,index]=sort(Errorquant.count);%Errorquant.count������ֵ����Ƶ���̶������ɵ͵���
Errorquant.luminance=Errorquant.luminance(index);%Errorquant.luminanceҲͬ��˳������

temp=length(find(Errorquant.count==0));%ɾ��Errorquant������û�г��ֹ�������ֵ
Errorquant.count=Errorquant.count(temp+1:end);
Errorquant.luminance=Errorquant.luminance(temp+1:end);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��Errorquant����huffman����
Errorquant.huffmancode=huffman(Errorquant.count);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����ԭʼͼ���С����JPEG-LSѹ�����ͼ���С�Ƚ�
temp=length(A(:,1,1))*length(A(1,:,1))*3; %ԭʼͼ������Ԫ������
originalsize=temp*ceil(log2(255-0)); %ԭʼͼ���С

JPEGLSsize1=0;%��JPEGLSѹ�����ͼ���С(ͼ���һ�е�һ�����ݲ���)
JPEGLSsize2=0;%��JPEGLSѹ�����ͼ���С(ͼ�����ಿ�ֵ����ݲ���)

JPEGLS_coderoutput1='';%��JPEGLSѹ������������������(ͼ��ĵ�һ�У���һ�в���)                
for i=1:length(A1_1D)
    temp=A1.huffmancode(find(A1.luminance==A1_1D(i)));
    JPEGLSsize1=JPEGLSsize1+length(temp{1});
    JPEGLS_coderoutput1=strcat(JPEGLS_coderoutput1,temp);
end

JPEGLS_coderoutput2='';%��JPEGLSѹ������������������(ͼ���2:end�У�2:end�в���)
for i=1:length(Errorquant_1D)
    temp=Errorquant.huffmancode(find(Errorquant.luminance==Errorquant_1D(i)));
    JPEGLSsize2=JPEGLSsize2+length(temp{1});
    JPEGLS_coderoutput2=strcat(JPEGLS_coderoutput2,temp);                                    
end

compressionratio=originalsize/(JPEGLSsize1+JPEGLSsize2) %JPEGLSѹ�������ȫû��ѹ����ԭʼͼ���ѹ���� 

    
%���������ڽ�ѹ����������Ķ��������������н��룬�ָ��ؽ�ԭ�е�ͼ��
%�������õ����ݰ�����
%���A1.luminance,A1.huffmancode����������(JPEGLS_coderoutput1)
%���Errorquant.luminance,Errorquant.huffmancode����������(JPEGLS_coderoutput2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�ָ�ͼ��2:end�У�2:end�е�Ԥ���������
buff=''; %�����ݴ������������
count=1;%������
for i=1:length(JPEGLS_coderoutput2{1})
    buff=strcat(buff,JPEGLS_coderoutput2{1}(i));%ÿ����һ��������������ѹ��buff
    for j=length(Errorquant.huffmancode):-1:1%�����뱾��Խ�������������ֵ���ָ���Խ�ߣ����ԴӺ���ǰ�һ���߽���Ч��
        if strcmp(buff,Errorquant.huffmancode(j))%���buff�������뱾��ĳ��������ͬ
            Re_Errorquant_1D(count)=Errorquant.luminance(j);%������뱾��ʮ������ֵ����ͼ�����ݣ�1ά���У���
            count=count+1;
            buff='';%���buff
            break
        end
    end
end

count=1;
for k=1:3
    for i=2:length(A(:,1,k)) %i��ʾͼ����ĳ���ص�����
        for j=2:length(A(1,:,k)) %j��ʾͼ����ĳ���ص�����
            Re_Errorquant(i,j,k)=Re_Errorquant_1D(count);%��Re_Errorquant_1D������Ԫ��ת�Ƶ���Re_Errorquant��
            count=count+1;%Errorquant_1D��һά����
        end
    end
end
%���ڸ�������������Re_Errorquant��Ԫ�ػ�ԭ��Re_ErrorԪ��
% Re_Error=Re_Errorquant;%��������Ϊ1
% Re_Error=Re_Errorquant*2;%��������Ϊ2
Re_Error=Re_Errorquant*4;%��������Ϊ2



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�ָ�ͼ���1�У���1�е���������
buff=''; %�����ݴ������������
count=1;%������
for i=1:length(JPEGLS_coderoutput1{1})
    buff=strcat(buff,JPEGLS_coderoutput1{1}(i));%ÿ����һ��������������ѹ��buff
    for j=1:length(A1.huffmancode)
        if strcmp(buff,A1.huffmancode(j))%���buff�������뱾��ĳ��������ͬ
            Re_A1_1D(count)=A1.luminance(j);%������뱾��ʮ������ֵ����ͼ�����ݣ�1ά���У���
            count=count+1;
            buff='';%���buff
            break
        end
    end
end

count=1;
for k=1:3
    for j=1:length(A(1,:,k)) %j��ʾͼ����ĳ���ص�����
        Re_Error(1,j,k)=A1_1D(count);%��ԭʼͼ��ĵ�һ���������ݴ���Re_Error��һ����
        count=count+1;
    end
    for i=2:length(A(:,1,k))%i��ʾͼ����ĳ���ص�����
        Re_Error(i,1,k)=A1_1D(count);%��ԭʼͼ��ĵ�һ���������ݴ���Re_Error��һ����
        count=count+1;
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���������Ĵ������ǵõ���Re_Error���󣬴�СΪ��ͼ������xͼ������x3��
%�þ����У���һ�е�һ��Ϊԭʼͼ�����ݣ�����A�����һ�е�һ����ͬ��������Ԫ�ؾ�Ϊ
%�������������ݣ�����Error��ӦԪ����ͬ��

%���ڸ�������Ԥ���㷨��Re_Error���������㣬�ָ���Re_A����
Re_A=Re_Error;
for k=1:3 %k��ʾͼ���ĳ����                                                                
    for i=2:length(Re_A(:,1,k)) %i��ʾͼ����ĳ���ص�����
        for j=2:length(Re_A(1,:,k)) %j��ʾͼ����ĳ���ص�����
%             Re_A(i,j,k)=Re_A(i,j-1,k)-Re_A(i,j,k);%���շ�ʽ1�ؽ�ͼ��A
%             Re_A(i,j,k)=Re_A(i-1,j,k)-Re_A(i,j,k);%���շ�ʽ2�ؽ�ͼ��A   
%             Re_A(i,j,k)=Re_A(i-1,j-1,k)-Re_A(i,j,k);%���շ�ʽ3�ؽ�ͼ��A 
%             Re_A(i,j,k)=Re_A(i-1,j,k)+Re_A(i,j-1,k)-Re_A(i-1,j-1,k)-Re_A(i,j,k);%���շ�ʽ4�ؽ�ͼ��A
%             Re_A(i,j,k)=Re_A(i,j-1,k)+(Re_A(i-1,j,k)-Re_A(i-1,j-1,k))/2-Re_A(i,j,k);%���շ�ʽ5�ؽ�ͼ��A
%             Re_A(i,j,k)=Re_A(i-1,j,k)+(Re_A(i,j-1,k)-Re_A(i-1,j-1,k))/2-Re_A(i,j,k);%���շ�ʽ6�ؽ�ͼ��A
            Re_A(i,j,k)=(Re_A(i,j-1,k)+Re_A(i-1,j,k))/2-Re_A(i,j,k);%���շ�ʽ7�ؽ�ͼ��A 
        end
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ʾԭʼͼ��A��ѹ�����ؽ�ͼ��Re_A���������ֵ�����PSNR
A=uint8(A);
Re_A=uint8(Re_A);%��������н�ͼ������Ԫ�ظĳ�double���ȣ������������Ҫת����uint8ģʽ

A_1D=zeros(1,length(A(:,1,k))*length(A(1,:,k))*3);%ͼ��A��һά���
count=1;
for k=1:3
    for i=2:length(A(:,1,k)) %i��ʾͼ����ĳ���ص�����
        for j=2:length(A(1,:,k)) %j��ʾͼ����ĳ���ص�����
            A_1D(count)=A(i,j,k);%��Errorquant������Ԫ��ת�Ƶ���Errorquant_1D��
            count=count+1;                %Errorquant_1D��һά����
        end
    end
end

Re_A_1D=zeros(1,length(A(:,1,k))*length(A(1,:,k))*3);%ͼ��A��һά���
count=1;
for k=1:3
    for i=2:length(Re_A(:,1,k)) %i��ʾͼ����ĳ���ص�����
        for j=2:length(Re_A(1,:,k)) %j��ʾͼ����ĳ���ص�����
            Re_A_1D(count)=Re_A(i,j,k);%��Errorquant������Ԫ��ת�Ƶ���Errorquant_1D��
            count=count+1;                %Errorquant_1D��һά����
        end
    end
end

MSE=sum((A_1D-Re_A_1D).^2)/length(A_1D);
PSNR=10*log10((2^8-1)^2/MSE)%��ֵ�����
figure
subplot(1,2,1),subimage(A),title('ԭʼͼ��A')
subplot(1,2,2),subimage(Re_A),title('ѹ�����ؽ�ͼ��Re_A')







