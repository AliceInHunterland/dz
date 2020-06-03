main();

% �����:
%��� ������� ������ ���� ��� 1 ��������� � ����������� �� ������ ���������
%������ ��������� ������� (figure1 �-� ������-������� ������ � �����
%�������������, � �-� �����-����� - ����� - � ���� �������������), ��������
%����� ������� ��������� ����� ��������, ��� ���������� ������� ������� 
%����������� ��� � + �������������, ��� � � -. �������� ������ ������
%������� ������ ������� �������, ��� ��� ����� ������� ���������� �� 
%�������������.
%��� �������� ������� ���������, � ��� �� ��������� �������� �������, ���
%��� ��� ����� ������� �������� � ���� ��� ���������� � �������������.  
% 
%
%http://www.apmath.spbu.ru/ru/education/final/question29.pdf
%������ ��������� �� �������� ��������� ���������������� ������������- ��
%����������� ������ ������� �����������(|y(t) - ?(t)| < ?)-> ������� �� 
% ��������� -> ������ ��������� ������ ���� ������ �������
%
%
function [] = main()
% ������ � ������������� ���� ��� �(0)=1 �'(0)=-4.1

    dsolve('D2y = 16.81*y', 'y(0) = 1.0', 'Dy(0) = -4.1')
    dsolve('D2y + 8.2*Dy + 16.81*y = 0', 'y(0) = 1.0', 'Dy(0) = -4.1')
    % y(t) = exp(-(41*t)/10)
    % y'(t) = -4.1 * exp(-4.1*t)
    ans_y = @(t) exp(-4.1*t);
    Dy = @(t) -4.1 * exp(-4.1*t);

    
    % �������1:
    % z' = 16.81*y
    % y' = z
    % y(0) = 1.0
    % z(0) = -4.1
    sys1 = dsolve('Dz = 16.81*y', 'Dy = z', 'y(0) = 1.0', 'z(0) = -4.1');
    disp(sys1.y)
    disp(sys1.z)
    
    
    sys_y = @(x,y,z) z;
    sys_z = @(x,y,z) 16.81*y;
    a_y=0;
    a_z=0;
    start_znach_y = 1.0;
    start_znach_z = -4.1;

    
    b=10; h=0.001;
    X = linspace(0, b, 1000);
% ������ ����� ������� �����_����� 4 �������
    [X1 Y1 Z1] = Runge(a_z, b, h, sys_y, sys_z, start_znach_y, start_znach_z);
% ������ ����� ������� ������
    [X2 Y2 Z2] = Eyler(a_z, b, h, sys_y, sys_z, start_znach_y, start_znach_z);
    
% ��������� �������� �������  
    figure;
    title("y(t), y'' = 16.81*y");
    hold on;
    % ������������� �������
    plot(X, ans_y(X), 'r');
    % ������� �-��� �����-����� 4 �������
    plot(X1, Y1, 'g');
    % ������� ������� ������
    plot(X2, Y2, 'b');
    hold off;
    
    
%     figure;
%     title("y'(t), y'' = 16.81*y");
%     hold on;
%     % ������������� �������
%     plot(X, Dy(X), 'r');
%     % ������� �-��� �����-����� 4 �������
%     plot(X1, Z1, 'g');
%     % ������� ������� ������
%     plot(X2, Z2, 'b');
%     hold off;
    
    
% ��������� ����� �������

    dsolve('D2y = 16.81*y')
    %C20*exp(-(41*t)/10) + C21*exp((41*t)/10)
    
    
    figure;
    title("����� ������� y'' = 16.81*y");
    hold on;
    for c1 = -2:1:2
        for c2 = -2:1:2
            X = -0.5:0.01:0.5;
            plot(X, c1 * exp(4.1*X) + c2 * exp(-4.1*X));
        end
    end
    hold off;
    
    

 
    % �������2:
    % z' + 8.2*z + 16.81*y = 0
    % y' = z
    % y(0) = 1.0
    % z(0) = -4.1
    sys2 = dsolve('Dz + 8.2*z + 16.81*y = 0', 'Dy = z', 'y(0) = 1.0', 'z(0) = -4.1');
    disp(sys2.y)
    disp(sys2.z)
    
    sys2_y = @(x,y,z) z;
    sys2_z = @(x,y,z) - 8.2*z - 16.81*y;

    
    
    [X1 Y1 Z1] = Runge(a_z,b,h,sys2_y,sys2_z,start_znach_y,start_znach_z);
    [X2 Y2 Z2] = Eyler(a_z,b,h,sys2_y,sys2_z,start_znach_y,start_znach_z);
    
    
    figure;
    title("y(t), y'' + 8.2*y' + 16.81y = 0");
    hold on;
    plot(X, ans_y(X), 'r');
    plot(X1, Y1, 'g');
    plot(X2, Y2, 'b');
    hold off;
    
    
%     figure;
%     title("y'(t),  y'' + 8.2*y' + 16.81y = 0");
%     hold on;
%     plot(X, Dy(X), 'r');
%     plot(X1, Z1, 'g');
%     plot(X2, Z2, 'b');
%     hold off;
%     
    
    
    dsolve('D2y + 8.2*Dy + 16.81*y = 0')
    %C22*exp(-(41*t)/10) + C23*t*exp(-(41*t)/10)
    
        figure;
    title("����� ������� y'' + 8.2*y' + 16.81*y = 0");
    hold on;
    for c1 = -2:1:2
        for c2 = -2:1:2
            X = -0.5:0.01:0.5;
           plot(X, c1 * exp(-4.1*X) + c2 .* X .* exp(-4.1*X));
        end
    end
    hold off;
    
    
    
   
    
%������� ����� ������� ������  
    function [X Y Z] = Eyler(a,b,h,sys_y,sys_z,start_znach_y,start_znach_z)
            Y = [start_znach_y];
            Z = [start_znach_z];
            X = a:h:b;
            
            y = start_znach_y;
            z = start_znach_z;
            
            for x = a+h:h:b
               next_y = y + h * sys_y(x, y, z);
               next_z = z + h * sys_z(x, y, z);
               y = next_y;
               z = next_z;
               Z = [Z z];
               Y = [Y y];

            end

    end
     
    
%������� ����� ������� ����-����� 4 �������
% http://www.toehelp.ru/theory/informat/lecture14.html
    function [X Y Z]=Runge(a, b, h, sys_y, sys_z, start_znach_y, start_znach_z)
            Y = [start_znach_y];
            Z = [start_znach_z];
            X = a:h:b;
            
            y = start_znach_y;
            z = start_znach_z;
            for x = a+h:h:b
                next = runge_kutta(x,sys_y,sys_z, y, z, h);
                z = next(1);
                y = next(2);
                Z = [Z z];
                Y = [Y y];
            end
    end
    function next = runge_kutta(x,sys_y,sys_z, y, z, h)
    
    k1 = h * sys_y(x, y, z);
    m1 = h * sys_z(x, y, z);
    
    k2 = h * sys_y(x + h/2.0, y + k1/2.0, z + m1/2.0);
    m2 = h * sys_z(x + h/2.0, y + k1/2.0, z + m1/2.0);
    
    k3 = h * sys_y(x + h/2.0, y + k2/2.0, z + m2/2.0);
    m3 = h * sys_z(x + h/2.0, y + k2/2.0, z + m2/2.0);
    
    k4 = h * sys_y(x + h, y + k3, z + m3);
    m4 = h * sys_z(x + h, y + k3, z + m3);
    
    next_y = y + (k1 + 2*k2 + 2*k3 + k4) / 6.0;
    next_z = z + (m1 + 2*m2 + 2*m3 + m4) / 6.0;
    
    next = [next_z next_y];
    
    end
    
    
end