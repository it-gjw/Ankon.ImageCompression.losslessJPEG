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
    for j=1:length(Errorquant.huffmancode)
        if strcmp(buff,Errorquant.huffmancode(j))%���buff�������뱾��ĳ��������ͬ
            Re_Errorq_1D(count)=Errorquant.luminance(j);%������뱾��ʮ������ֵ����ͼ�����ݣ�1ά���У���
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
            Re_Errorq(i,j,k)=Re_Errorq_1D(count);%��Re_Errorq_1D������Ԫ��ת�Ƶ���Re_Errorq��
            count=count+1;%Errorquant_1D��һά����
        end
    end
end
%���ڸ�������������Re_Errorq��Ԫ�ػ�ԭ��Re_ErrorԪ��
Re_Error=Re_Errorq;%��������Ϊ1
% Re_Error=Re_Errorq*2;%��������Ϊ2
% Re_Error=Re_Errorq*4;%��������Ϊ4



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
        Re_Error(1,j,k)=Re_A1_1D(count);%��ԭʼͼ��ĵ�һ���������ݴ���Re_Error��һ����
        count=count+1;
    end
    for i=2:length(A(:,1,k))%i��ʾͼ����ĳ���ص�����
        Re_Error(i,1,k)=Re_A1_1D(count);%��ԭʼͼ��ĵ�һ���������ݴ���Re_Error��һ����
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







