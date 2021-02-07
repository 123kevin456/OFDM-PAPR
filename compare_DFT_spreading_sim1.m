%%%%%%%%%%%%%%%%%%%%%  分析OFDMA/LFDMA/IFDMA的PAPR  %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%   compare_DFT_spreading_sim1.m    %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%      date:2021年2月6日  改编:飞蓬大将军   %%%%%%%%%%

%%%%%%%%%%%%%%%%%程序功能说明
%%%%%分析OFDMA/LFDMA/IFDMA的PAPR

%%%%%%    仿真环境
%软件版本：MATLAB R2020b

% Plot Fig. 7.31
clear, clf
N=256; 
Nd=64; % FFT size and Data block size (# of subcarriers per user)
gss='*^<sd>v.'; % Numbers of subblocks and graphic symbols
bs=[2 4 6]; 
N_b=length(bs);
dBs = 0:0.2:12; 
dBcs = dBs+(dBs(2)-dBs(1))/2;
Nblk = 5000; % Number of OFDM blocks for iteration
for i=1:N_b
   b=bs(i); M=2^b;
   rand('twister',5489); randn('state',0);
   CCDF_OFDMa = CCDF_PAPR_DFTspreading_sim1('OF',N,b,N,dBcs,Nblk); % CCDF of OFDMA
   CCDF_LFDMa = CCDF_PAPR_DFTspreading_sim1('LF',Nd,b,N,dBcs,Nblk); % CCDF of LFDMA
   CCDF_IFDMa = CCDF_PAPR_DFTspreading_sim1('IF',Nd,b,N,dBcs,Nblk); % CCDF of IFDMA
   subplot(130+i)
   semilogy(dBs,CCDF_OFDMa,'-o', dBs,CCDF_LFDMa,'-<', dBs,CCDF_IFDMa,'-*')
   legend('OFDMA','LFDMA','IFDMA')
   axis([dBs([1 end]) 1e-3 1]); grid on;
   title([num2str(M) '-QAM CCDF ',num2str(N),'-point ',num2str(Nblk) '-blocks']);
   xlabel(['PAPR_0[dB] for ',num2str(M),'-QAM']); ylabel('Pr(PAPR>PAPR_0)'); 
end
%%%实验结论
%%IFDMA、LFDMA相比于OFDMA，PAPR有效降低