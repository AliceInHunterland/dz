main();
%
%�����: 
%����������� ���������� , �� ����� ������������ ��� ������� �������
%������� ���������
%


function [] = main()

g = 9.8;
m = 5;
h_start = 110;
h_end = 50;
time = [0 50];
T_max=4*m*g;
T_min=0;
T_fun = @(k_p, k_d, z, z_derivative) max(min(k_p * (z - h_end) + k_d * z_derivative + m*g, T_max), T_min);

f_z= @(t, z, K) [z(2), g-T_fun(K(1), K(2),z(1),z(2))/m]';

%func= @(koef) J
% ������������ ��������-> ������� ������������
K = fminsearch(@(koef) J(h_start,h_end, koef, time, m, g, T_fun), [0 0])    
% K(1) = K_p, K(2) = K_d

%K = [1, 1]
% ������ ������� ������� � ���������� ��������������
[t,z] = ode45(@(t,z) f_z(t,z,K), time, [h_start; 0]);
figure;
hold on
grid on
plot(t,z)
plot(t,T_fun(K(1),K(2),z(:, 1),z(:, 2)))
title('������ �������� ����')
legend('Z', 'Z ''','T')




function Integral = J(h_start,h_end, K, time, m, g, T_fun)

    % ������ ������� :
    %z1' = z2
    %z2' = g- T/m
    % ��� ���� �<�_max: T = K_p(z-z*) + K_d* z'+m*g;
    % ����� T=T_max.
    % ��������� ������� :
    %z(0)=h_start
    %z'(0)= 0
    
    [t,z] = ode45(@(t,z)f_z(t,z,K), time, [h_start; 0]);
    
    %����� �������� �� �������:
    % (z-z*)^2+z'^2 +T^2
    % �� ���������� time
    
    fval = (z(:,1) - h_end).^2 + z(:, 2).^2 +( T_fun(K(1),K(2),z(:, 1),z(:, 2))).^2;
   % if (K(1).* (z(1) - h_end) + K(2).* z(2)+ m *g < T_max) & (K(1).* (z(1) - h_end) + K(2).* z(2)+ m *g>0)
          Integral = trapz(t, fval);
   % else
    %    Integral= T_max;
   % end
end
%     function dzdt= f_z(t,z,K,T_max,m,g,h_end)
%         %����������� �����������
%         if (K(1).* (z(1) - h_end) + K(2).* z(2)+ m *g < T_max) & (K(1).* (z(1) - h_end) + K(2).* z(2)+ m *g>0)
%            dzdt = [z(2); g-(K(1).* (z(1) - h_end) + K(2).* z(2)+ m *g)./ m];
%         else
%             dzdt = [z(2); g-T_max./ m];
%         end
%         
%     end
   
end