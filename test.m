%����
%���ĵ�ִ�п��Ʋ��ԣ������������ķ��������ж��ι��ˣ������������
%�������ڼ������߷��മ�������ָ��
%�ĵ�����˵����signal���Է������Ľ����������,negative,positive,minus������ֵ����
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
        serial(serialindex) = 5;%���������ֵ��ʱ�̶�Ӧ��ָ��ͱ�ǩ��¼������ͬʱ��¼ʱ���ָ��ֵ
        serial_tri(serialindex) = trigger(index);
        seriall = [seriall 5];
        serial_trii = [serial_trii trigger(index)];
    else
        for k=1:4
            if(mark(k)>=threshold)
                serialindex = index;%serialindex+1;
                mark(k) = mark(k) - minus;
                serial(serialindex) = k;%���������ֵ��ʱ�̶�Ӧ��ָ��ͱ�ǩ��¼������ͬʱ��¼ʱ���ָ��ֵ
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