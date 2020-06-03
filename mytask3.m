main();
%
%¬џ¬ќƒ:
%счита€ ошибку как аналитическое решение- численное решение в
% рассматриваемой точке x, построили несколько графиков ошибки.
% Ќе€вный метод показал себ€ лучше.
%
%http://qilab.phys.msu.ru/people/zadkov/teaching/seminar1/semnumer3.pdf
%явный ћетод €вл€етс€ устойчивым при |1 + h?| ? 1, т.е. при
%?2 ? h? ? 0
% где ? в нашем случае = -10000
% то есть h <= 2 / 10000, то есть h <= 0.0002 (в двух последних figure 
%решение €вным методом €вл€етс€ устойчивым)
%ќбласть устойчивости метода определ€етс€ как набор всех возможных значений
% h?, при которых метод стабилен.
%”словием устойчивости не€вного метода Ёйлера €вл€етс€:
% |1/(1 - h?)| ? 1 
% т.е,  не€вный метод Ёйлера устойчив при любом неположительном ?
%поэтому не€вный метод Ёйлера в данном случае
%предпочтительнее.
%
%
function [] = main()
    dsolve('Dy = -10000 * y')
    %C24*exp(-10000*t)
    % положим const = 1
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
    legend('€вный метод', 'не€вный метод');
    hold off;
    title("Ўаг: " + num2str(h) + ", ќтрезок: [0;" + num2str(b) + "]");
    xlabel('x');
    ylabel('ќшибка');
  
    subplot(1,3,2);
    hold on;
    plot(X1, ERR1);
    title("Ўаг: " + num2str(h) + ", ќтрезок: [0;" + num2str(b) + "]" + ...
        ", явный метод");
    xlabel('x');
    ylabel('ќшибка');
    subplot(1,3,3);
    hold on;
    plot(X2, Y2);
    title("Ўаг: " + num2str(h) + ", ќтрезок: [0;" + num2str(b) + "]" + ...
        ", Ќе€вный метод");
    xlabel('x');
    ylabel('ќшибка');
    
    

    end



end
%–ешение €вным методом Ёйлера  
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
    %–ешение не€вным методом Ёйлера  
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