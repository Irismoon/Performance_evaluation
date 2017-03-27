%测试
%此文档执行控制策略，即将分类器的分类结果进行二次过滤，再输出给串口
%可以用于检验在线分类串口输出的指令
%文档参数说明：signal来自分类器的结果即分类结果,negative,positive,minus都是阈值参数
if(signal>=1&&signal<5&&IS_TRAIN==0)
    if(signal_1~=signal_2)
        
        
    mark(signal) = mark(signal)+positive;
    for k=1:4
        if(mark(k) >= negative)
            mark(k) = mark(k) - negative;
        end
    end
    if (land_var >= landthld)
        serialindex = index;%serialindex+1;
        serial(serialindex) = 5;%将输出串口值该时刻对应的指令和标签记录下来，同时记录时间和指令值
        serial_tri(serialindex) = trigger(index);
        seriall = [seriall 5];
        serial_trii = [serial_trii trigger(index)];
    else
        for k=1:4
            if(mark(k)>=threshold)
                serialindex = index;%serialindex+1;
                mark(k) = mark(k) - minus;
                serial(serialindex) = k;%将输出串口值该时刻对应的指令和标签记录下来，同时记录时间和指令值
                serial_tri(serialindex) = trigger(index);
                seriall = [seriall k];
                serial_trii = [serial_trii trigger(index)];
            end
        end
     end
    
end
%end
% for j = 1:1264
% if(Signal(j)>=0&&Signal(j)<4&&IS_TRAIN==0)
%     mark(Signal(j)+1) = mark(Signal(j)+1)+positive;
%     for i=1:4
%         if(mark(i) >= negative)
%             mark(i) = mark(i) - negative;
%         end
%     end
%     for i=1:4
%         if(mark(i)>=threshold)
%             mark(i) = mark(i) - minus;
%             serial = [serial i-1];
%         end
%     end
% end
% end
% dataa = [];
% num = 0;
% for i = 1:32
%     indices = 0;
%     indices = find(data(i,:)==0 | data(i,:)==1 | data(i,:)==2 | data(i,:)==3);
%     dataa = [dataa data(i,indices)];
%     num = num+length(indices);
% end