%������ͨ����������ͼ����ͳ�Ƴ���ͼ���и���ɫ��ֵ������Ԥ�������ֵ���ķֲ�״��
num=313;%�ܹ�200����Ƭ





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ͳ��ͼ���һ�е�һ�е�������ֵ�ֲ�
A1.count=zeros(1,256);
for l=1:num 
    fname=sprintf('%d.bmp',l);
    A=double(imread(fname));%����ͼ��
    %ͬʱ������Ԫ�ش�uint8ת����double��Ҫ��Ȼ��ֵ��Χֻ��0~255
    A=A(80:220,80:220,1:3);%����Ŀ��ͼ��ı�׼�ߴ�Ϊ240x320���������ʱΪ�˽�ʡʱ�䣬���ܲ��ý�С��ͼƬ         
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    A1.luminance=0:1:255;%Errorquant.luminance��Ӧ����������    
    A1.count=A1.count+hist(A1_1D,A1.luminance);%A1.count���ȳ��ֵĴ�����Խ���ʾ������ֵ����ԽƵ��
%     [A1.count,index]=sort(A1.count);%A1.count������ֵ����Ƶ���̶������ɵ͵���
%     A1.luminance=A1.luminance(index);%A1.luminanceҲͬ��˳������    
end 
save A1.mat A1
clear A1;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ͳ��ͼ����˵�һ�е�һ�����ⲿ�ֵ�����Ԥ��ֵ�ֲ�,��������1
Errorquant.count=zeros(1,511);
for l=1:num
    fname=sprintf('%d.bmp',l);
    A=double(imread(fname));%����ͼ��
    %ͬʱ������Ԫ�ش�uint8ת����double��Ҫ��Ȼ��ֵ��Χֻ��0~255
    A=A(80:220,80:220,1:3);%����Ŀ��ͼ��ı�׼�ߴ�Ϊ240x320���������ʱΪ�˽�ʡʱ�䣬���ܲ��ý�С��ͼƬ    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %��Error�е�Ԫ�ؽ���������������������                                      
    Errorq=round(Error);%Errorq��ʾ�������Error������������1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %ͳ��Errorq�����и�Ԫ����ֵ�ĸ��ʷֲ�                                                
    Errorquant_1D=zeros(1,length(A(:,1,k))*length(A(1,:,k))*3);%ͼ���һά���
    count=1;
    for k=1:3
        for i=2:length(A(:,1,k)) %i��ʾͼ����ĳ���ص�����
            for j=2:length(A(1,:,k)) %j��ʾͼ����ĳ���ص�����
                Errorquant_1D(count)=Errorq(i,j,k);%��Errorquant������Ԫ��ת�Ƶ���Errorquant_1D��
                count=count+1;                %Errorquant_1D��һά����
            end
        end
    end
    Errorquant.luminance=-255:1:255;%Errorquant.luminance��Ӧ����������     
    Errorquant.count=Errorquant.count+hist(Errorquant_1D,Errorquant.luminance);%Errorquant.count���ȳ��ֵĴ�����Խ���ʾ������ֵ����ԽƵ��
%     [Errorquant.count,index]=sort(Errorquant.count);%Errorquant.count������ֵ����Ƶ���̶������ɵ͵���
%     Errorquant.luminance=Errorquant.luminance(index);%Errorquant.luminanceҲͬ��˳������
end
save Errorquant_step1.mat Errorquant
clear Errorquant





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ͳ��ͼ����˵�һ�е�һ�����ⲿ�ֵ�����Ԥ��ֵ�ֲ�,��������2
Errorquant.count=zeros(1,257);
for l=1:num
    fname=sprintf('%d.bmp',l);
    A=double(imread(fname));%����ͼ��
    %ͬʱ������Ԫ�ش�uint8ת����double��Ҫ��Ȼ��ֵ��Χֻ��0~255
    A=A(80:220,80:220,1:3);%����Ŀ��ͼ��ı�׼�ߴ�Ϊ240x320���������ʱΪ�˽�ʡʱ�䣬���ܲ��ý�С��ͼƬ    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %��Error�е�Ԫ�ؽ���������������������                                      
    Errorq=round(Error/2);%Errorq��ʾ�������Error������������2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %ͳ��Errorq�����и�Ԫ����ֵ�ĸ��ʷֲ�                                                
    Errorquant_1D=zeros(1,length(A(:,1,k))*length(A(1,:,k))*3);%ͼ���һά���
    count=1;
    for k=1:3
        for i=2:length(A(:,1,k)) %i��ʾͼ����ĳ���ص�����
            for j=2:length(A(1,:,k)) %j��ʾͼ����ĳ���ص�����
                Errorquant_1D(count)=Errorq(i,j,k);%��Errorquant������Ԫ��ת�Ƶ���Errorquant_1D��
                count=count+1;                %Errorquant_1D��һά����
            end
        end
    end
    Errorquant.luminance=-128:1:128;%Errorquant.luminance��Ӧ����������     
    Errorquant.count=Errorquant.count+hist(Errorquant_1D,Errorquant.luminance);%Errorquant.count���ȳ��ֵĴ�����Խ���ʾ������ֵ����ԽƵ��
%     [Errorquant.count,index]=sort(Errorquant.count);%Errorquant.count������ֵ����Ƶ���̶������ɵ͵���
%     Errorquant.luminance=Errorquant.luminance(index);%Errorquant.luminanceҲͬ��˳������
end
save Errorquant_step2.mat Errorquant
clear Errorquant




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ͳ��ͼ����˵�һ�е�һ�����ⲿ�ֵ�����Ԥ��ֵ�ֲ�,��������4
Errorquant.count=zeros(1,129);
for l=1:num
    fname=sprintf('%d.bmp',l);
    A=double(imread(fname));%����ͼ��
    %ͬʱ������Ԫ�ش�uint8ת����double��Ҫ��Ȼ��ֵ��Χֻ��0~255
    A=A(80:220,80:220,1:3);%����Ŀ��ͼ��ı�׼�ߴ�Ϊ240x320���������ʱΪ�˽�ʡʱ�䣬���ܲ��ý�С��ͼƬ    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %��Error�е�Ԫ�ؽ���������������������                                      
    Errorq=round(Error/4);%Errorq��ʾ�������Error������������4
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %ͳ��Errorq�����и�Ԫ����ֵ�ĸ��ʷֲ�                                                
    Errorquant_1D=zeros(1,length(A(:,1,k))*length(A(1,:,k))*3);%ͼ���һά���
    count=1;
    for k=1:3
        for i=2:length(A(:,1,k)) %i��ʾͼ����ĳ���ص�����
            for j=2:length(A(1,:,k)) %j��ʾͼ����ĳ���ص�����
                Errorquant_1D(count)=Errorq(i,j,k);%��Errorquant������Ԫ��ת�Ƶ���Errorquant_1D��
                count=count+1;                %Errorquant_1D��һά����
            end
        end
    end
    Errorquant.luminance=-64:1:64;%Errorquant.luminance��Ӧ����������     
    Errorquant.count=Errorquant.count+hist(Errorquant_1D,Errorquant.luminance);%Errorquant.count���ȳ��ֵĴ�����Խ���ʾ������ֵ����ԽƵ��
%     [Errorquant.count,index]=sort(Errorquant.count);%Errorquant.count������ֵ����Ƶ���̶������ɵ͵���
%     Errorquant.luminance=Errorquant.luminance(index);%Errorquant.luminanceҲͬ��˳������
end
save Errorquant_step4.mat Errorquant
clear Errorquant
