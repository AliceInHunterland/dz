main();
%
%�����:
%������ ������ ��� ������������� �������- ��������� ������� �
% ��������������� ����� x, ��������� ��������� �������� ������.
% ������� ����� ������� ���� �����.
%
%http://qilab.phys.msu.ru/people/zadkov/teaching/seminar1/semnumer3.pdf
%����� ����� �������� ���������� ��� |1 + h?| ? 1, �.�. ���
%?2 ? h? ? 0
% ��� ? � ����� ������ = -10000
% �� ���� h <= 2 / 10000, �� ���� h <= 0.0002 (� ���� ��������� figure 
%������� ����� ������� �������� ����������)
%������� ������������ ������ ������������ ��� ����� ���� ��������� ��������
% h?, ��� ������� ����� ��������.
%�������� ������������ �������� ������ ������ ��������:
% |1/(1 - h?)| ? 1 
% �.�,  ������� ����� ������ �������� ��� ����� ��������������� ?
%������� ������� ����� ������ � ������ ������
%����������������.
%
%
function [] = main()
    dsolve('Dy = -10000 * y')
    %C24*exp(-10000*t)
    % ������� const = 1
    % y(0) = 1
    ans_y = @(x) exp(-10000 * x);
    dy = @(x, y) -10000 * y;
    
   % b = 0.1;
   % h= 0.01;
    
    graf(0.1, 0.01, dy,ans_y)
    graf(0.1, 0.001, dy,ans_y)
    
    graf(0.02, 0.0001, dy,ans_y)
    graf(0.03, 0.000001, dy,ans_y)
    
    
    function pic = graf(b, h, dy, ans_y)
    [X1 Y1 ERR1] = Eyler(0, b, h, dy, 1, ans_y);
    [X2 Y2 ERR2] = NeEyler(0, b, h, dy, 1, ans_y);
    figure;
    subplot(1,3,1);
    hold on;
    plot(X1, ERR1, 'b');
    plot(X2, ERR2, 'r');
    legend('����� �����', '������� �����');
    hold off;
    title("���: " + num2str(h) + ", �������: [0;" + num2str(b) + "]");
    xlabel('x');
    ylabel('������');
  
    subplot(1,3,2);
    hold on;
    plot(X1, ERR1);
    title("���: " + num2str(h) + ", �������: [0;" + num2str(b) + "]" + ...
        ", ����� �����");
    xlabel('x');
    ylabel('������');
    subplot(1,3,3);
    hold on;
    plot(X2, Y2);
    title("���: " + num2str(h) + ", �������: [0;" + num2str(b) + "]" + ...
        ", ������� �����");
    xlabel('x');
    ylabel('������');
    
    

    end



end
%������� ����� ������� ������  
        function [X Y ERR]=Eyler(a, b, h, f, y0, ans_y)
            Y = y0;
            ERR = 0.0;
            X = a:h:b;
            y=y0;
            for x = a+h:h:b
               y = y + h*f(x,y);
               Y = [Y y]; 
               err = ans_y(x) - y;
               ERR = [ERR err];
            end

           
        end
    %������� ������� ������� ������  
    function [X Y ERR]=NeEyler(a, b, h, f, y0, ans_y)
            Y = y0;
            ERR = 0.0;
            X = a:h:b;
            y=y0;
            for x = a+h:h:b
               y = y / (1 + h * 10000);
               Y = [Y y]; 
               err = ans_y(x) - y;
               ERR = [ERR err];
            end

           
        end