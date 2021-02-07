%%%%%%%%%%%%%%%%%%%%%  计算单载波基带/通频带信号的PAPR   %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%   single_carrier_PAPR_sim1.m    %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% date:2020年12月22日  author:飞蓬大将军   %%%%%%%%%%

%%%%%%%%%%%%%%%%%程序说明
%%%%分析单载波下的PAPR，可画出图

%%%%%%    仿真环境
%软件版本：MATLAB R2019a

clear
Ts = 1;
L = 8;
Nos = 8;

Fc = 1; 
b = 2;
M = 2^b;
[X,Mod] = mapper_sim1(b);
L_ = L*4;
i_b = 1;
[xt_pass_,time_] = modulation(X,Ts,L_,Fc); %%连续时间
[xt_pass,time] = modulation(X,Ts,L,Fc); %%%L倍过采样

for i_s = 1:M
     xt_base(L*(i_s-1)+1 : L*i_s) = X(i_s)*ones(1,L);
end
PAPR_dB_base = PAPR(xt_base);
figure(1);  
% clf;
subplot(311);
stem(time,real(xt_base),'k.'); 
hold on;  
ylabel('S_{I}(n)');
title([Mod ', ' num2str(M) ' symbols, Ts=' num2str(Ts) 's, Fs=' num2str(1/Ts*2*Nos) 'Hz, Nos=' num2str(Nos) ', baseband, g(n)=u(n)-u(n-Ts)']);
subplot(312);
stem(time,imag(xt_base),'k.'); 
hold on; 
ylabel('S_{Q}(n)');
subplot(313);
stem(time,abs(xt_base).^2,'k.'); 
hold on;
title(['PAPR = ' num2str(round(PAPR_dB_base(i_b)*100)/100) 'dB']);
xlabel ('samples'); 
ylabel('|S_{I}(n)|^{2}+|S_{Q}(n)|^{2}');    
figure(2);
clf;   
PAPR_dB_pass(i_b) = PAPR(xt_pass);
subplot(211);
stem(time,xt_pass,'k.'); 
hold on; 
plot(time_,xt_pass_,'k:');
title([Mod ', ' num2str(M) ' symbols, Ts=' num2str(Ts) 's, Fs=' num2str(1/Ts*2*Nos) 'Hz, Nos=' num2str(Nos) ', Fc=' num2str(Fc) 'Hz, g(n)=u(n)-u(n-Ts)']);
ylabel('S(n)');
subplot(212)
stem(time,xt_pass.*xt_pass,'r.'); 
hold on;
plot(time_,xt_pass_.*xt_pass_,'k:');
title(['PAPR = ' num2str(round(PAPR_dB_pass(i_b)*100)/100) 'dB']);
xlabel('samples');
ylabel('|S(n)|^{2}');    
%bb_I = zeros(1,M*Nos*2); bb_Q = zeros(1,M*Nos*2);
disp('PAPRs of baseband/passband signals'); 
PAPRs_of_baseband_passband_signals=[PAPR_dB_base; PAPR_dB_pass]