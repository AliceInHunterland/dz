main();
%
%�����:
%����� ����� �������� � ��������� ��� ������, �������� ���� �����������
%�������.
%��� ��� ����� ����� ����� �����������(��� �� �������, ��� � �� ����������)
%� ������������ �������, ��� ���� ������� ������� ������� ����� -> �����
%����� ���������
%��� ������� ������ ������� ����� ������� �� 2 ������� �� �������[0 1000]
%��� ������� ���� �� ���� ��� ���� ������� ��� � �� ���� �������. ��
%������� �� 0 �� 10 ������� �� ������� � 50 ���.
%http://www.polybook.ru/comma/3.10.pdf
%�.� ���� � �� �� ��������� � ������� ����������� ����� ���� ��� �������
%��� � �� �������.
%

function [] = main()

    dsolve('D2y + 100000.001 * Dy + 100*y = 0')
    %C3*exp(-t/1000) + C2*exp(-100000*t)
    
    solution = @(c1, c2, x) c1 * exp(-x/1000) + c2 * exp(-100000*x);
    %�������� ����� �������
    X = linspace(-0.00002, 0.00005, 100);
    figure;
    subplot(1,2,1);
    hold on;
    for c1 = -1:1:1
        for c2 = -1:1:1
            plot(solution(c1, c2, X));
        end
    end
    title("����� ������� y'' + 100000.001*y' + 100*y = 0");
    hold off;
    
    


    X = linspace(-10000, 10000, 100000);
    subplot(1,2,2);
    hold on;
    for c1 = -1:1:1
        for c2 = -1:1:1
            plot(X, solution(c1, c2, X));
        end
    end
    title("����� ������� y'' + 100000.001*y' + 100*y = 0");
    hold off;
   
    % ���������� ������� �������:
    % 1) c1 = -1, c2 = 1
    % 2) c1 = 1, c2 = -1
    
    
    % y(x) = c1 * e ^ (-100000 * x) + c2 * e ^ (-0.001 * x)
    % y'(x) = -c1 * 100000 * e ^ (-100000 * x) - c2 * 0.001 * e ^ (-0.001 * x)
    
    
%C������ 1
     c1 = -1;c2 = 1;
    % y' = z
    % z' = 100000.001*z - 100*y
    % � ���������� ���������:
    % y(0) = 0
    % z(0) = 99999.999
    y0=0;
    z0=99999.999;
    f1 = @(x,y) [y(2); -c1*100000.001*y(2)-c2*0.001*y(1)];
    time = [0, 1000];
    %����� �����
    tic;
    [t,y] = ode23(f1, time, [y0,z0]);
    tm=toc;
    ERR = [y-solution(c1,c2,t)];
    figure;
    subplot(2,2,1)
    hold on
    plot(t,y,'r')
    plot(t,solution(c1,c2,t),'b')
    title("����� ����� "+ num2str(tm) +" cek")
    subplot(2,2,2)
    hold on
    plot(t, ERR)
    title("����� ����� -������")
    
    %������� �����
    tic;
    [t2,y2] = ode15s(f1, time, [y0, z0]);
    tm=toc;
    ERR2 = [y2-solution(-1,1,t2)];
    
    subplot(2,2,3)
    hold on
    plot(t2,y2,'r')
    plot(t2,solution(-1,1,t2),'b')
    title("������� ����� "+ num2str(tm) +" cek")
    subplot(2,2,4)
    hold on
    plot(t2, ERR2)
    title("������� ����� -������")

    
    
    
%C������ 2
    c1 = 1; c2 = -1;
    % y' = z
    % z' = -100000.001*z + 100*y
    % � ���������� ���������:
    % y(0) = 0
    % z(0) = -99999.999
    
    y0=0;
    z0=-99999.999;
    f1 = @(x,y) [y(2); -c1*100000.001*y(2)-c2*0.001*y(1)];
    time = [0, 10];
    %����� �����
    tic;
    [t,y] = ode23(f1, time, [y0,z0]);
    tm=toc;
    ERR = [y-solution(c1,c2,t)];
     figure;
    subplot(2,2,1)
    hold on
    plot(t,y,'r')
    plot(t,solution(c1,c2,t),'b')
    title("����� ����� "+ num2str(tm) +" cek")
    subplot(2,2,2)
    hold on
    plot(t, ERR)
    title("����� ����� -������")
    
    %������� �����
    tic;
    [t2,y2] = ode15s(f1, time, [y0, z0]);
    tm=toc;
    ERR2 = [y2-solution(-1,1,t2)];
    
    subplot(2,2,3)
    hold on
    plot(t2,y2,'r')
    plot(t2,solution(-1,1,t2),'b')
    title("������� ����� "+ num2str(tm) +" cek")
    subplot(2,2,4)
    hold on
    plot(t2, ERR2)
    title("������� ����� -������")
    
    
    
    
end