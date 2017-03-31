%注意：这里面评估正确率的思想是串口输出指令与它对应的时刻标签对比正误
%延时的评估方法是：凡是串口没有输出指令的时刻都是延时
%即认为但凡串口输出就不属于延时，以前认为类别之间转换过程全都是延时，现在是类别之间转换只要串口输出指令就不算延时，而是归为分类错误；
%其实延时和正确率归根结底是一个东西。
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
fprintf('分类器输出正确率:%f\n',sum((Signal-trigger)==0)/N*100);%分类器输出指令的正确率
%disp(sum((serial-serial_tri)~=0)/M*100);
% fprintf('正确率:%f\n',sum((seriall-serial_trii)==0)/M*100);
% fprintf('延时:%f\n',1-M/N);
plot(1:N,trigger);hold on;scatter(1:N,Signal);axis([1 N 1 5]);legend('标签','解算结果');
