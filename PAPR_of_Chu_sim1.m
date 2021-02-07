%%%%%%%%%%%%%%%%%%%%%     chu序列的PAPR    %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%   PAPR_of_Chu_sim1.m    %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% date:2020年12月23日  author:飞蓬大将军   %%%%%%%%%%

%%%%%%%%%%%%%%%%%程序功能说明
%%%%%观察chu序列的PAPR，以及过采样倍数的影响

%%%%%%    仿真环境
%软件版本：MATLAB R2019a
clear, clf
N=16;
L= 16; 
i= 0:N-1; 
k = 3; 
X = exp(j*k*pi/N*(i.*i));
[x,time] = IFFT_oversampling(X,N);
PAPRdB = PAPR(x);
[x_os,time_os] = IFFT_oversampling(X,N,L); %x_os=x_os*L;
PAPRdB_os = PAPR(x_os);

plot(time,abs(x),'o', time_os,abs(x_os),'k:*');
xlabel('时间（由符号间隔归一化）');
ylabel('|IFFT(u1(k))|');
legend('L = 1','L = 4');
PAPRdB_without_and_with_oversampling=[PAPRdB  PAPRdB_os]

%%%%%实验结论
%%%P186中提到对于chu序列，L =1 和 L=4采样速率的不同，导致PAPR的明显变化
%%%而当L = 4、8、16时，过采样速率没有对PAPR发生太大的变化