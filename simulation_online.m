%ע�⣺������������ȷ�ʵ�˼���Ǵ������ָ��������Ӧ��ʱ�̱�ǩ�Ա�����
%��ʱ�����������ǣ����Ǵ���û�����ָ���ʱ�̶�����ʱ
%����Ϊ������������Ͳ�������ʱ����ǰ��Ϊ���֮��ת������ȫ������ʱ�����������֮��ת��ֻҪ�������ָ��Ͳ�����ʱ�����ǹ�Ϊ�������
%��ʵ��ʱ����ȷ�ʹ�������һ��������
tic;head_for_online_performance;
%data_src=load('..\\data-2010.07.11_23.20\\data_cnt-2010.07.11_23.20.txt');
data_src=load('data_cnt-2017.01.15_17.31.txt');
for i=1:DATA_LENGTH
    x=data_src(i,:);
    data_add_for_online_performance;
    %test;
end
toc;
N=length(trigger);
%M = length(seriall);
trigger(11:end) = trigger(1:end-10);
fprintf('�����������ȷ��:%f\n',sum((Signal-trigger)==0)/N*100);%���������ָ�����ȷ��
%disp(sum((serial-serial_tri)~=0)/M*100);
% fprintf('��ȷ��:%f\n',sum((seriall-serial_trii)==0)/M*100);
% fprintf('��ʱ:%f\n',1-M/N);
plot(1:N,trigger);hold on;scatter(1:N,Signal);axis([1 N 1 5]);legend('��ǩ','������');
