%ע�⣺������������ȷ�ʵ�˼���Ǵ������ָ��������Ӧ��ʱ�̱�ǩ�Ա�����
%��ʱ�����������ǣ����Ǵ���û�����ָ���ʱ�̶�����ʱ
%����Ϊ������������Ͳ�������ʱ����ǰ��Ϊ���֮��ת������ȫ������ʱ�����������֮��ת��ֻҪ�������ָ��Ͳ�����ʱ�����ǹ�Ϊ�������
%��ʵ��ʱ����ȷ�ʹ�������һ��������
tic;head_for_online_performance;
IS_TRAIN=true;
%data_src=load('..\\data-2010.07.11_23.20\\data_cnt-2010.07.11_23.20.txt');
data_src=load('data_cnt-2017.01.15_14.24.txt');
for i=1:DATA_LENGTH
    x=data_src(i,:);
    data_add_for_online_performance;
    %test;
end
toc;
head_for_online_performance;
IS_TRAIN=false;
data_src=load('data_cnt-2017.01.15_14.13.txt');
load('coeff.mat');
for i=1:DATA_LENGTH
    x=data_src(i,:);
    data_add_for_online_performance;
    %test;
end


N=length(trigger);
%M = length(seriall);
trigger(11:end) = trigger(1:end-10);
fprintf('�����������ȷ��:%f\n',sum((Signal-trigger)==0)/N*100);%���������ָ�����ȷ��
%disp(sum((serial-serial_tri)~=0)/M*100);
% fprintf('��ȷ��:%f\n',sum((seriall-serial_trii)==0)/M*100);
% fprintf('��ʱ:%f\n',1-M/N);
plot(1:N,trigger);hold on;scatter(1:N,Signal);axis([1 N 1 5]);legend('��ǩ','������');

%%
figure(2);
clf;
hold on;
for i=1:length(R)
    if trigger(i)==5
        sty='b*';
    end
    if trigger(i)==1
        sty='ro';
    end
    if trigger(i)==2
        sty='gp';
    end
    if trigger(i)==3
        sty='g*';
    end
    if trigger(i)==4
        sty='yo';
    end
     plot3(coeff(1,2).linear'*rou'+coeff(1,2).const,...
         coeff(1,3).linear'*rou'+coeff(1,3).const,...
         coeff(1,4).linear'*rou'+coeff(1,4).const,...
         coeff(1,5).linear'*rou'+coeff(1,5).const,sty);
end

