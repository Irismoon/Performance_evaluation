%%
clc;clear all;
Fs=128;
filt_n=4;
[filter_b,filter_a]=butter(filt_n,2/(Fs/2),'high');%4阶巴特沃斯高通滤波器

%%
%data_add文件中的参数
DATA_LENGTH=200*Fs;
DATA_CHANNEL=8;
ch=[1,3,5,7];%指前额AF3,AF4,F3,F4,但是Emotiv反着戴，就是枕叶区的P3,P4,O1,O2数据
ch_size=length(ch);
data_index=0;
index=0;
data_unfilter=zeros(DATA_LENGTH,ch_size);
data=zeros(DATA_LENGTH,ch_size);

freq = [11.25,6.4,7.5,9];%freq for VR
%freq = [12.66,7.525,8.444,9.433];%freq for monitor
%freq = [12.525,9.4934,8.2973,15.0249];%LSZ
%freq = [12.5 9.37 8.33 6.8182];
%freq=[12 10 8.5714 6.667];
frecount = length(freq);
peroid=1000./freq;
segment= 1*Fs;%窗长
slide=Fs/8;%滑动窗长
TRIAL=Fs*5;%训练时的每个同类标签的长度
TRIAL_TRAISIENT = Fs/4+segment;
TRIAL_STEADY = TRIAL - TRIAL_TRAISIENT;
%trigger=zeros(DATA_LENGTH*(TRIAL_STEADY/TRIAL)/slide,1);
trigger=zeros(DATA_LENGTH/slide,1);
Signal = trigger;Signal_1 = zeros(DATA_LENGTH/slide,1);Signal_2=Signal_1;
Vari = trigger;
R_1 = zeros(length(trigger),4);
R_2 = zeros(length(trigger),4);
reference_1 = cell(frecount,1);
reference_2 = cell(frecount,1);
for i=1:frecount
    reference_1{i} = [cos(2*pi*freq(i)/Fs*(1:segment));-sin(2*pi*freq(i)/Fs*(1:segment))];%基波
    reference_2{i} = [cos(4*pi*freq(i)/Fs*(1:segment));-sin(4*pi*freq(i)/Fs*(1:segment))];%harmonics
%    reference{i} = reference{i}';
end%产生参考信号
signal=-1;
velocity=0;
variance=0;
output = [signal velocity variance];
sx = 2;
sy = 4;
rou_1 = zeros(1,4);
rou_2 = zeros(1,4);
%%
%test文件中的参数
serial_tri = -ones(length(trigger),1);%串口输出的指令时刻对应的trigger
serial = serial_tri;%串口输出的指令
%serial与trigger对比可以看到实际上在哪些时刻系统输出了指令，serial与serial_tri对比可以得到经过控制策略后的正确率
seriall = [];%存储串口一共输出了哪些指令
serial_trii = [];%存储串口输出指令时的标签
%这两个其实就是把serial_tri和serial里面非-1的值拿出来放在一起。
serialindex = 0;
mark = zeros(1,5);
threshold = 30;
negative = 10;
positive = 20;
minus = 10;
landthld = 180;
landvar = 0.005;
land_var = 0;
IS_TRAIN=0;