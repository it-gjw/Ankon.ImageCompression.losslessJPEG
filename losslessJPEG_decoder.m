%���������ڽ�ѹ����������Ķ��������������н��룬�ָ��ؽ�ԭ�е�ͼ��

function [Re_A,totaloutput]=losslessJPEG_decoder(Errorquant,totaloutput,step)
% global totaloutput
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�ָ�ͼ���1�У���1�е���������
buff=''; %�����ݴ������������
count=1;%������
i=1;
while count<=40+5 %��һ�к͵�һ�е��������ݡ���Ϊͼ����6*40�ĳߴ磬��һ�е�һ�е����ݹ�40+5��
    buff=strcat(buff,totaloutput{1}(i:i+7));%ÿ�δ���8����������ѹ��buff����Ϊ��һ�е�һ�������ǹ̶�8bit�볤��
    i=i+8;
    Re_A1_1D(count)=bin2dec(buff);%������뱾��ʮ������ֵ����ͼ�����ݣ�1ά���У���
    count=count+1;
    buff='';%���buff 
end

Re_Error(1,1:40)=Re_A1_1D(1:40);%��ԭʼͼ��ĵ�һ���������ݴ���Re_Error��һ����
Re_Error(2:6,1)=Re_A1_1D(41:45);%��ԭʼͼ��ĵ�һ���������ݴ���Re_Error��һ����

clear Re_A1_1D;
totaloutput{1}(1:i-1)=[];%���������������Ѿ�����������Ĳ������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�ָ�ͼ��2:end�У�2:end�е�Ԥ���������
buff=[];
count=1;%������
ii=0;
s=Errorquant.tree;
count1=1;
while count<=5*39;%ͼ����˵�һ�е�һ�е����ಿ������
    ii=ii+1;
    if totaloutput{1}(ii)=='0'
        buff(count1)=1;%ÿ����һ��������������ѹ��buff
    else
        buff(count1)=2;%ÿ����һ��������������ѹ��buff
    end 
    count1=count1+1;
    s=s{buff(count1-1)};
    
    if isa(s,'double')%���buff�������뱾��ĳ��������ͬ
        Re_Errorq_1D(count)=s;%������뱾��ʮ������ֵ����ͼ�����ݣ�1ά���У���
        count=count+1;
        count1=1;
        buff=[];%���buff
        s=Errorquant.tree;
    end
end
clear s count1 buff
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

count=1;
for i=2:6 %i��ʾͼ����ĳ���ص�����
    for j=2:40 %j��ʾͼ����ĳ���ص�����
        Re_Errorq(i,j)=Re_Errorq_1D(count);%��Re_Errorq_1D������Ԫ��ת�Ƶ���Re_Errorq��
        count=count+1;%Errorquant_1D��һά����
    end
end

clear Re_Errorq_1D;
totaloutput{1}(1:ii)=[];%���������������Ѿ�����������Ĳ������
% length(totaloutput{1})%�����

%���ڸ�������������Re_Errorq��Ԫ�ػ�ԭ��Re_ErrorԪ��
Re_Error(2:end,2:end)=Re_Errorq(2:end,2:end)*step;%��������Ϊstep
clear Re_Errorq step ii;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���������Ĵ������ǵõ���Re_Error���󣬴�СΪ��6x40x3��
%�þ����У���һ�е�һ��Ϊԭʼͼ�����ݣ�����A�����һ�е�һ����ͬ��������Ԫ�ؾ�Ϊ
%�������������ݣ�����Error��ӦԪ����ͬ��

%���ڸ�������Ԥ���㷨��Re_Error���������㣬�ָ���Re_A����
Re_A=Re_Error;
clear Re_Error;
                                                             
    for i=2:length(Re_A(:,1)) %i��ʾͼ����ĳ���ص�����
        for j=2:length(Re_A(1,:)) %j��ʾͼ����ĳ���ص�����
%             Re_A(i,j)=Re_A(i,j-1)-Re_A(i,j);%���շ�ʽ1�ؽ�ͼ��A
%             Re_A(i,j)=Re_A(i-1,j)-Re_A(i,j);%���շ�ʽ2�ؽ�ͼ��A   
%             Re_A(i,j)=Re_A(i-1,j-1)-Re_A(i,j);%���շ�ʽ3�ؽ�ͼ��A 
%             Re_A(i,j)=Re_A(i-1,j)+Re_A(i,j-1)-Re_A(i-1,j-1)-Re_A(i,j);%���շ�ʽ4�ؽ�ͼ��A
%             Re_A(i,j)=Re_A(i,j-1)+(Re_A(i-1,j)-Re_A(i-1,j-1))/2-Re_A(i,j);%���շ�ʽ5�ؽ�ͼ��A
%             Re_A(i,j)=Re_A(i-1,j)+(Re_A(i,j-1)-Re_A(i-1,j-1))/2-Re_A(i,j);%���շ�ʽ6�ؽ�ͼ��A
            Re_A(i,j)=(Re_A(i,j-1)+Re_A(i-1,j))/2-Re_A(i,j);%���շ�ʽ7�ؽ�ͼ��A 
        end
    end
    
clear i j







