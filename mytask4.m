main();
%
%¬џ¬ќƒ:
%€вный метод работает в несколько раз дольше, особенно если увеличивать
%отрезок.
%“ак как €вный метод плохо справл€етс€(как по времени, так и по результату)
%с поставленной задачей, при этом решение находит не€вный метод -> имеет
%место жесткость
%при запуске поиска решени€ €вным методом во 2 системе на отрезке[0 1000]
%мой ноутбук чуть не умер при этом решение так и не было найдено. на
%отрезке от 0 до 10 разница во времени в 50 раз.
%http://www.polybook.ru/comma/3.10.pdf
%т.о одно и то же уравнение с разными параметрами может быть как жестким
%так и не жестким.
%

function [] = main()

    dsolve('D2y + 100000.001 * Dy + 100*y = 0')
    %C3*exp(-t/1000) + C2*exp(-100000*t)
    
    solution = @(c1, c2, x) c1 * exp(-x/1000) + c2 * exp(-100000*x);
    %построим общее решение
    X = linspace(-0.00002, 0.00005, 100);
    figure;
    subplot(1,2,1);
    hold on;
    for c1 = -1:1:1
        for c2 = -1:1:1
            plot(solution(c1, c2, X));
        end
    end
    title("ќбщее решение y'' + 100000.001*y' + 100*y = 0");
    hold off;
    
    


    X = linspace(-10000, 10000, 100000);
    subplot(1,2,2);
    hold on;
    for c1 = -1:1:1
        for c2 = -1:1:1
            plot(X, solution(c1, c2, X));
        end
    end
    title("ќбщее решение y'' + 100000.001*y' + 100*y = 0");
    hold off;
   
    % –ассмотрим частные решени€:
    % 1) c1 = -1, c2 = 1
    % 2) c1 = 1, c2 = -1
    
    
    % y(x) = c1 * e ^ (-100000 * x) + c2 * e ^ (-0.001 * x)
    % y'(x) = -c1 * 100000 * e ^ (-100000 * x) - c2 * 0.001 * e ^ (-0.001 * x)
    
    
%Cистема 1
     c1 = -1;c2 = 1;
    % y' = z
    % z' = 100000.001*z - 100*y
    % — начальными услови€ми:
    % y(0) = 0
    % z(0) = 99999.999
    y0=0;
    z0=99999.999;
    f1 = @(x,y) [y(2); -c1*100000.001*y(2)-c2*0.001*y(1)];
    time = [0, 1000];
    %€вный метод
    tic;
    [t,y] = ode23(f1, time, [y0,z0]);
    tm=toc;
    ERR = [y-solution(c1,c2,t)];
    figure;
    subplot(2,2,1)
    hold on
    plot(t,y,'r')
    plot(t,solution(c1,c2,t),'b')
    title("явный метод "+ num2str(tm) +" cek")
    subplot(2,2,2)
    hold on
    plot(t, ERR)
    title("явный метод -ќЎ»Ѕ ј")
    
    %не€вный метод
    tic;
    [t2,y2] = ode15s(f1, time, [y0, z0]);
    tm=toc;
    ERR2 = [y2-solution(-1,1,t2)];
    
    subplot(2,2,3)
    hold on
    plot(t2,y2,'r')
    plot(t2,solution(-1,1,t2),'b')
    title("Ќ≈явный метод "+ num2str(tm) +" cek")
    subplot(2,2,4)
    hold on
    plot(t2, ERR2)
    title("Ќ≈явный метод -ќЎ»Ѕ ј")

    
    
    
%Cистема 2
    c1 = 1; c2 = -1;
    % y' = z
    % z' = -100000.001*z + 100*y
    % — начальными услови€ми:
    % y(0) = 0
    % z(0) = -99999.999
    
    y0=0;
    z0=-99999.999;
    f1 = @(x,y) [y(2); -c1*100000.001*y(2)-c2*0.001*y(1)];
    time = [0, 10];
    %€вный метод
    tic;
    [t,y] = ode23(f1, time, [y0,z0]);
    tm=toc;
    ERR = [y-solution(c1,c2,t)];
     figure;
    subplot(2,2,1)
    hold on
    plot(t,y,'r')
    plot(t,solution(c1,c2,t),'b')
    title("явный метод "+ num2str(tm) +" cek")
    subplot(2,2,2)
    hold on
    plot(t, ERR)
    title("явный метод -ќЎ»Ѕ ј")
    
    %не€вный метод
    tic;
    [t2,y2] = ode15s(f1, time, [y0, z0]);
    tm=toc;
    ERR2 = [y2-solution(-1,1,t2)];
    
    subplot(2,2,3)
    hold on
    plot(t2,y2,'r')
    plot(t2,solution(-1,1,t2),'b')
    title("Ќ≈явный метод "+ num2str(tm) +" cek")
    subplot(2,2,4)
    hold on
    plot(t2, ERR2)
    title("Ќ≈явный метод -ќЎ»Ѕ ј")
    
    
    
    
end