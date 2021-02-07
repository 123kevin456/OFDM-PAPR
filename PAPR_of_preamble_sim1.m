%%%%%%%%%%%%%%%%%%%%%   IEEE 802.16e前导序列的PAPR    %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%   PAPR_of_preamble_sim1.m    %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% date:2020年12月23日  author:飞蓬大将军   %%%%%%%%%%

%%%%%%%%%%%%%%%%%程序功能说明
%%%%%观察IEEE 802.16e前导序列的PAPR 

%%%%%%    仿真环境
%软件版本：MATLAB R2019a

% clear, clf
N=1024; 
L= 16;
Npreamble=114; 
n=0:Npreamble-1; % Mod='BPSK'; 
%PAPR = zeros(N_preamble,1); PAPR_os = zeros(N_preamble,1);
for i = 1:Npreamble
   X=load(['.\\Wibro-Preamble\\Preamble_sym' num2str(i-1) '.dat']);
   X = X(:,1); 
   X = sign(X); 
   X = fftshift(X);
   x = IFFT_oversampling(X,N); 
   PAPRdB(i) = PAPR(x);
   x_os = IFFT_oversampling(X,N,L);
   PAPRdB_os(i) = PAPR(x_os);
end
plot(n,PAPRdB,'-o', n,PAPRdB_os,':*');
if L == 4
    PAPRdB_L4 = PAPRdB;
    PAPRdB_os_L4 = PAPRdB_os;
end
if L == 8
    PAPRdB_L8 = PAPRdB;
    PAPRdB_os_L8 = PAPRdB_os;
end 
if L == 16
    PAPRdB_L16 = PAPRdB;
    PAPRdB_os_L16 = PAPRdB_os;
end
xlabel('前导编号[0~113]');
ylabel('|IFFT(u1(k))|');
legend('L = 1','L = 16');
title('PAPRdB without and with oversampling')

%****************************   实验结果
%%%%%参考书上P186
%%%%%   前导码有放大功率的问题，因此设计前导码时便具有较低的PAPR，这也是为什么
%%%%%   不同的采样速率并没有使得这些序列PAP明显不同

