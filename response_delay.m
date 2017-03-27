%Calculation of time delay
%
seclen = TRIAL/slide;%每个trial对应的解算结果有多少个，trail长度/一个滑动窗长
numofcol = DATA_LENGTH/slide/(seclen);%所有的解算结果个数/一个trial的结果个数=trial的个数
firsec = (TRIAL-segment)/slide;%从data_add文件找第一次处理数据之前忽略的长度
count = 0;
A = zeros(1,numofcol);B = zeros(seclen,numofcol);index = zeros(1,numofcol);C=A;
A(1) = trigger(firsec);A(2:end) = trigger(firsec+(1:numofcol-1)*seclen);
B(1:firsec,1) = Signal(1:firsec);B(:,2:numofcol) = reshape(Signal(firsec+1:seclen*(numofcol-1)+firsec),[seclen,numofcol-1]);
for i=1:numofcol
    if(isempty(find(B(:,i)==A(i), 1))==false)
        index(i) = find(B(:,i)==A(i),1)-1;%每个trial，第一次解算出这个trial对应的标签时的索引
    else
        index(i) = seclen;
    end
    count = count+length(find(B(:,i)==A(i)));%在这个trial对应的时长内，所有解算正确的数据长度
end
resdly = sum(index)/numofcol*slide/Fs;%average response delay time,
C(1) = firsec;C(2:end) = seclen;
Accuracy = count/sum(C-index);%分母总数剔除了延时部分