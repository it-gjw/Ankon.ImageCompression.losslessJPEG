%������ͨ����������ͼ����ͳ�Ƴ���ͼ���и���ɫ��ֵ������Ԥ�������ֵ���ķֲ�״��
num=313;%�ܹ�313����Ƭ

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ͳ��ͼ����˵�һ�е�һ�����ⲿ�ֵ�����Ԥ��ֵ�ֲ�,��������1
Errorquant.count=zeros(1,511);
for l=1:num
    l
    fname=sprintf('%d.bmp',l);
    A=double(imread(fname));%����ͼ��
    %ͬʱ������Ԫ�ش�uint8ת����double��Ҫ��Ȼ��ֵ��Χֻ��0~255
    A=A(70:230,70:230,1:3);%����Ŀ��ͼ��ĳߴ�Ϊ160x160���������ʱΪ�˽�ʡʱ�䣬���ܲ��ý�С��ͼƬ   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    filter(:,:,1)=[1 0;0 0];%bayer��ɫ�˲�����R����
filter(:,:,2)=[0 1;1 0];%bayer��ɫ�˲�����G����
filter(:,:,3)=[0 0;0 1];%bayer��ɫ�˲�����B����

%����ͨGRB��ɫ��Ƭת��BAYER��ʽ��Ƭ
for i=1:80%������ÿ���˲�����Ϊ2x2,ͼ����160�У�������Ҫѭ��80��
    for j=1:80%������ѭ��80��
        A0(2*i-1:2*i,2*j-1:2*j,:)=A(2*i-1:2*i,2*j-1:2*j,:).*filter;%A���ת�����˵�bayer��ʽ��Ƭ���ߴ绹��160x160x3
    end
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ԭʼͼ��160x160x3�ֳ�4����ͼ80x80x1,�ֱ���R����������G������B�������ؼ���
for i=2-1:2:160-1
    for j=2-1:2:160-1
        A0_color{1}((i+1)/2,(j+1)/2)=A0(i,j,1);%A0_color{1}��BAY��ʽ��ͼ����r����Ԫ�ص�����ȡ������ɵ�ͼ�񣬴�СΪ80x80x1
    end
end
        
for i=2-1:2:160-1
    for j=2:2:160
        A0_color{2}((i+1)/2,j/2)=A0(i,j,2);%A0_color{2}��BAY��ʽ��ͼ����g����(�˲��������Ͻǵ��Ǹ�G)Ԫ�ص�����ȡ������ɵ�ͼ�񣬴�СΪ80x80x1
    end
end

for i=2:2:160
    for j=2-1:2:160-1
        A0_color{3}(i/2,(j+1)/2)=A0(i,j,2);%A0_color{3}��BAY��ʽ��ͼ����g����(�˲��������½ǵ��Ǹ�G)Ԫ�ص�����ȡ������ɵ�ͼ�񣬴�СΪ80x80x1
    end
end

for i=2:2:160
    for j=2:2:160
        A0_color{4}(i/2,j/2)=A0(i,j,3);%A0_color{4}��BAY��ʽ��ͼ����b����Ԫ�ص�����ȡ������ɵ�ͼ�񣬴�СΪ80x80x1
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��4��BAYER����ͼ����ˮƽ�˲�
for i=2:80
    A0_color{1}(:,i)=round((A0_color{1}(:,i-1)+A0_color{1}(:,i))/2);
    A0_color{2}(:,i)=round((A0_color{2}(:,i-1)+A0_color{2}(:,i))/2);
    A0_color{3}(:,i)=round((A0_color{3}(:,i-1)+A0_color{3}(:,i))/2);
    A0_color{4}(:,i)=round((A0_color{4}(:,i-1)+A0_color{4}(:,i))/2);
end
    
%��4��BAYER����ͼ���д�ֱ�˲�
for i=2:80
    A0_color{1}(i,:)=round((A0_color{1}(i-1,:)+A0_color{1}(i,:))/2);
    A0_color{2}(i,:)=round((A0_color{2}(i-1,:)+A0_color{2}(i,:))/2);
    A0_color{3}(i,:)=round((A0_color{3}(i-1,:)+A0_color{3}(i,:))/2);
    A0_color{4}(i,:)=round((A0_color{4}(i-1,:)+A0_color{4}(i,:))/2);
end

    
    
    
    
    
    
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %����Ԥ����룬��Ҫע�⣺ͼ���һ�к͵�һ��û�б��룬��Ҫ�����������롣����ļ��д����У�Error����ĵ�һ�к͵�һ��Ϊ��
    for k=1:4 %k��ʾͼ���ĳ����ͼ����R,G1,G2,B�ĸ�                                                                
        for i=2:length(A0_color{1}(:,1)) %i��ʾͼ����ĳ���ص�����
            for j=2:length(A0_color{1}(1,:)) %j��ʾͼ����ĳ���ص�����
%             Error(i,j,k)=A(i,j-1,k)-A(i,j,k);%Error����ΪԤ�������󣬰��շ�ʽ1
%             Error(i,j,k)=A(i-1,j,k)-A(i,j,k);%Error����ΪԤ�������󣬰��շ�ʽ2   
%             Error(i,j,k)=A(i-1,j-1,k)-A(i,j,k);%Error����ΪԤ�������󣬰��շ�ʽ3 
%             Error(i,j,k)=A(i-1,j,k)+A(i,j-1,k)-A(i-1,j-1,k)-A(i,j,k);%Error����ΪԤ�������󣬰��շ�ʽ4
%             Error(i,j,k)=A(i,j-1,k)+(A(i-1,j,k)-A(i-1,j-1,k))/2-A(i,j,k);%Error����ΪԤ�������󣬰��շ�ʽ5
%             Error(i,j,k)=A(i-1,j,k)+(A(i,j-1,k)-A(i-1,j-1,k))/2-A(i,j,k);%Error����ΪԤ�������󣬰��շ�ʽ6
                Error{k}(i,j)=(A0_color{k}(i,j-1)+A0_color{k}(i-1,j))/2-A0_color{k}(i,j);%Error����ΪԤ�������󣬰��շ�ʽ7 
            end
        end
    end    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %��Error�е�Ԫ�ؽ���������������������   
    for k=1:4
    Errorq{k}=round(Error{k}/2);%Errorq��ʾ�������Error������������step=2
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %ͳ��Errorq�����и�Ԫ����ֵ�ĸ��ʷֲ�                                                
    Errorquant_1D=zeros(1,length(A0_color{1}(:,1))*length(A0_color{1}(1,:))*4);%ͼ���һά���
    count=1;
    for k=1:4
        for i=2:length(A0_color{1}(:,1)) %i��ʾͼ����ĳ���ص�����
            for j=2:length(A0_color{1}(1,:)) %j��ʾͼ����ĳ���ص�����
                Errorquant_1D(count)=Errorq{k}(i,j);%��Errorquant������Ԫ��ת�Ƶ���Errorquant_1D��
                count=count+1;                %Errorquant_1D��һά����
            end
        end
    end
    Errorquant.luminance=-255:1:255;%Errorquant.luminance��Ӧ����������     
    Errorquant.count=Errorquant.count+hist(Errorquant_1D,Errorquant.luminance);%Errorquant.count���ȳ��ֵĴ�����Խ���ʾ������ֵ����ԽƵ��
%     [Errorquant.count,index]=sort(Errorquant.count);%Errorquant.count������ֵ����Ƶ���̶������ɵ͵���
%     Errorquant.luminance=Errorquant.luminance(index);%Errorquant.luminanceҲͬ��˳������
end

Errorquant.luminance(find(Errorquant.count==0))=[];
Errorquant.count(find(Errorquant.count==0))=[];
[Errorquant.tree,Errorquant.huffmancode]=huffman(Errorquant.count,Errorquant.luminance);
% p=Errorquant.count;
% s=cell(length(p),1);
% s1=cell(length(p),1);
% for i=1:length(p)
%     s{i}=i;
%     s1{i}=Errorquant.luminance(i);
% end
% 
% while size(s,1)>2
%     [p,i]=sort(p);
%     p(2)=p(1)+p(2);
%     p(1)=[];
%     s=s(i);
%     s1=s1(i);
%     s{2}={s{1},s{2}};
%     s1{2}={s1{1},s1{2}};
%     s(1)=[];
%     s1(1)=[];
% end
% Errorquant.tree=s1;

[temp,i]=sort(Errorquant.count);
Errorquant.luminance=Errorquant.luminance(i);
Errorquant.huffmancode=Errorquant.huffmancode(i);
Errorquant.count=temp(end:-1:1);

temp=Errorquant.luminance(end:-1:1);
 Errorquant.luminance=temp(end:-1:1);
 Errorquant.luminance=temp;
 temp=Errorquant.huffmancode(end:-1:1);
 Errorquant.huffmancode=temp;



% save codebook_bayer.mat Errorquant


