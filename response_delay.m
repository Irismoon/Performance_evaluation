%Calculation of time delay
%
seclen = TRIAL/slide;%ÿ��trial��Ӧ�Ľ������ж��ٸ���trail����/һ����������
numofcol = DATA_LENGTH/slide/(seclen);%���еĽ���������/һ��trial�Ľ������=trial�ĸ���
firsec = (TRIAL-segment)/slide;%��data_add�ļ��ҵ�һ�δ�������֮ǰ���Եĳ���
count = 0;
A = zeros(1,numofcol);B = zeros(seclen,numofcol);index = zeros(1,numofcol);C=A;
A(1) = trigger(firsec);A(2:end) = trigger(firsec+(1:numofcol-1)*seclen);
B(1:firsec,1) = Signal(1:firsec);B(:,2:numofcol) = reshape(Signal(firsec+1:seclen*(numofcol-1)+firsec),[seclen,numofcol-1]);
for i=1:numofcol
    if(isempty(find(B(:,i)==A(i), 1))==false)
        index(i) = find(B(:,i)==A(i),1)-1;%ÿ��trial����һ�ν�������trial��Ӧ�ı�ǩʱ������
    else
        index(i) = seclen;
    end
    count = count+length(find(B(:,i)==A(i)));%�����trial��Ӧ��ʱ���ڣ����н�����ȷ�����ݳ���
end
resdly = sum(index)/numofcol*slide/Fs;%average response delay time,
C(1) = firsec;C(2:end) = seclen;
Accuracy = count/sum(C-index);%��ĸ�����޳�����ʱ����