%%%%%%%%%%%%%%%%%%%%%   IEEE 802.16eǰ�����е�PAPR    %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%   PAPR_of_preamble_sim1.m    %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% date:2020��12��23��  author:����󽫾�   %%%%%%%%%%

%%%%%%%%%%%%%%%%%������˵��
%%%%%�۲�IEEE 802.16eǰ�����е�PAPR 

%%%%%%    ���滷��
%����汾��MATLAB R2019a

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
xlabel('ǰ�����[0~113]');
ylabel('|IFFT(u1(k))|');
legend('L = 1','L = 16');
title('PAPRdB without and with oversampling')

%****************************   ʵ����
%%%%%�ο�����P186
%%%%%   ǰ�����зŴ��ʵ����⣬������ǰ����ʱ����нϵ͵�PAPR����Ҳ��Ϊʲô
%%%%%   ��ͬ�Ĳ������ʲ�û��ʹ����Щ����PAP���Բ�ͬ

