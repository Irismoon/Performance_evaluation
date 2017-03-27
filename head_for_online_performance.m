%%
clc;clear all;
Fs=128;
filt_n=4;
[filter_b,filter_a]=butter(filt_n,2/(Fs/2),'high');%4�װ�����˹��ͨ�˲���

%%
%data_add�ļ��еĲ���
DATA_LENGTH=200*Fs;
DATA_CHANNEL=8;
ch=[1,3,5,7];%ָǰ��AF3,AF4,F3,F4,����Emotiv���Ŵ���������Ҷ����P3,P4,O1,O2����
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
segment= 1*Fs;%����
slide=Fs/8;%��������
TRIAL=Fs*5;%ѵ��ʱ��ÿ��ͬ���ǩ�ĳ���
TRIAL_TRAISIENT = Fs/4+segment;
TRIAL_STEADY = TRIAL - TRIAL_TRAISIENT;
%trigger=zeros(DATA_LENGTH*(TRIAL_STEADY/TRIAL)/slide,1);
trigger=zeros(DATA_LENGTH/slide,1);
Signal = trigger;Signal_1 = zeros(DATA_LENGTH/slide,2);Signal_2=Signal_1;
Vari = trigger;
R_1 = zeros(length(trigger),4);
R_2 = zeros(length(trigger),4);
reference_1 = cell(frecount,1);
reference_2 = cell(frecount,1);
for i=1:frecount
    reference_1{i} = [cos(2*pi*freq(i)/Fs*(1:segment));-sin(2*pi*freq(i)/Fs*(1:segment))];%����
    reference_2{i} = [cos(4*pi*freq(i)/Fs*(1:segment));-sin(4*pi*freq(i)/Fs*(1:segment))];%harmonics
%    reference{i} = reference{i}';
end%�����ο��ź�
signal=-1;
velocity=0;
variance=0;
output = [signal velocity variance];
sx = 2;
sy = 4;
rou_1 = zeros(1,4);
rou_2 = zeros(1,4);
%%
%test�ļ��еĲ���
serial_tri = -ones(length(trigger),1);%���������ָ��ʱ�̶�Ӧ��trigger
serial = serial_tri;%���������ָ��
%serial��trigger�Աȿ��Կ���ʵ��������Щʱ��ϵͳ�����ָ�serial��serial_tri�Աȿ��Եõ��������Ʋ��Ժ����ȷ��
seriall = [];%�洢����һ���������Щָ��
serial_trii = [];%�洢�������ָ��ʱ�ı�ǩ
%��������ʵ���ǰ�serial_tri��serial�����-1��ֵ�ó�������һ��
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