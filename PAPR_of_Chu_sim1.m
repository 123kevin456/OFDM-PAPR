%%%%%%%%%%%%%%%%%%%%%     chu���е�PAPR    %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%   PAPR_of_Chu_sim1.m    %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% date:2020��12��23��  author:����󽫾�   %%%%%%%%%%

%%%%%%%%%%%%%%%%%������˵��
%%%%%�۲�chu���е�PAPR���Լ�������������Ӱ��

%%%%%%    ���滷��
%����汾��MATLAB R2019a
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
xlabel('ʱ�䣨�ɷ��ż����һ����');
ylabel('|IFFT(u1(k))|');
legend('L = 1','L = 4');
PAPRdB_without_and_with_oversampling=[PAPRdB  PAPRdB_os]

%%%%%ʵ�����
%%%P186���ᵽ����chu���У�L =1 �� L=4�������ʵĲ�ͬ������PAPR�����Ա仯
%%%����L = 4��8��16ʱ������������û�ж�PAPR����̫��ı仯