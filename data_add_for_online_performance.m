data_index=data_index+1;
data_index_mod=mod(data_index-1,DATA_LENGTH)+1;
%在线滤波
data_unfilter(data_index_mod,:)=x(ch);%C++里扔进来的数据存起来
if data_index_mod<=filt_n+1
    xx=[filter_b(2:data_index_mod),-filter_a(2:data_index_mod)];
    yy=[data_unfilter(data_index_mod-1:-1:1,:);data(data_index-1:-1:1,:)];
else
    xx=[filter_b(2:filt_n+1),-filter_a(2:filt_n+1)];
    yy=[data_unfilter(data_index_mod-1:-1:data_index_mod-filt_n,:);
        data(data_index_mod-1:-1:data_index_mod-filt_n,:)];
end
data(data_index_mod,:)=filter_b(1)*data_unfilter(data_index_mod,:);
if(size(xx,2)>0)
    data(data_index_mod,:)=data(data_index_mod,:)+xx*yy;
end

%数据处理
if mod(data_index,slide)==0%每slide个数据处理一次
       % if mod(data_index,TRIAL)>(TRIAL_TRAISIENT) || mod(data_index,TRIAL)==0
         if(data_index_mod>segment)
            index=index+1;
            Y=data(data_index_mod-segment+1:data_index_mod,:)';%4个通道窗长内数据
            for j=1:frecount
                z1 = [reference_1{j};Y];%将两个矩阵合成一个矩阵
                C_1 = cov(z1.');      %计算自协方差矩阵
                Cxx_1 = C_1(1:sx, 1:sx) + 10^(-8)*eye(sx);   %求得X的自协方差矩阵
                Cxy_1 = C_1(1:sx, sx+1:sx+sy);         %求得X和Ｙ的互协方差矩阵
                Cyx_1 = Cxy_1';
                Cyy_1 = C_1(sx+1:sx+sy, sx+1:sx+sy) + 10^(-8)*eye(sy);%求得Y的自协方差矩阵
                [Wx_1,r_1] = eig(inv(Cxx_1)*Cxy_1*inv(Cyy_1)*Cyx_1);%r is eigenvalues;A*Wx = r*Wx，r的index与Wx的列的index对应
                r_1 = sqrt(real(r_1));      % Canonical correlations   典型相关系数
                r_1 = diag(r_1);%矩阵转换成向量后上下翻转
%                 V = fliplr(Wx);%左右翻转
                [r_1,~]= sort((real(r_1)),'descend');
                %r_1 = flipud(r_1);	
                rou_1(j) = r_1(1);%fundamental
                z1 = [reference_2{j};Y];%将两个矩阵合成一个矩阵
                C_1 = cov(z1.');      %计算自协方差矩阵
                Cxx_1 = C_1(1:sx, 1:sx) + 10^(-8)*eye(sx);   %求得X的自协方差矩阵
                Cxy_1 = C_1(1:sx, sx+1:sx+sy);         %求得X和Ｙ的互协方差矩阵
                Cyx_1 = Cxy_1';
                Cyy_1 = C_1(sx+1:sx+sy, sx+1:sx+sy) + 10^(-8)*eye(sy);%求得Y的自协方差矩阵
                [Wx_1,r_1] = eig(inv(Cxx_1)*Cxy_1*inv(Cyy_1)*Cyx_1);%r is eigenvalues;A*Wx = r*Wx，r的index与Wx的列的index对应
                r_1 = sqrt(real(r_1));      % Canonical correlations   典型相关系数
                r_1 = diag(r_1);%矩阵转换成向量后上下翻转
%                 V = fliplr(Wx);%左右翻转
                [r_1,~]= sort((real(r_1)));
                r_1 = flipud(r_1);	
                rou_2(j) = r_1(1);%harmonics
            end
            R_1(index,:) = rou_1;
            R_2(index,:) = rou_2;
            rr1 = sort(rou_1,'descend');signal_1=find(rou_1==rr1(1) | rou_1==rr1(2));Signal_1(index,:) = signal_1;
            rr2 = sort(rou_2,'descend');signal_2=find(rou_2==rr2(1) | rou_2==rr2(2));Signal_2(index,:) = signal_2;
            
            if (signal_1~=signal_2)
                Signal(index) = 5;
            else
                Signal(index) = find(rou_1==rr1(1));%按基波
            end
%             if(intersect(signal_1,signal_2))
%                 Signal(index) = find(rou_1==rr1(1));
%             else
%                 Signal(index) = 5;
%             end
            trigger(index) = x(DATA_CHANNEL+1);
         %end
         
        end  
else
    signal_1=-1;
    velocity=0;
    variance=0;
    output = [signal_1 velocity variance];
end