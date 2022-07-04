clc;
clear;
close all;
fs= input('Please enter the sampling frequency required:  ');
start_time=input('Please enter signal starting time: ');
end_time=input('Please enter signal end time: ');
break_points_number=input('please enter number of break points: ');  
information_array= zeros(break_points_number+1,2);
information_array(1,1)=start_time;
information_array(break_points_number+1,2)=end_time;
for i=0:1:(break_points_number-1)
    information_array(i+1,2)=input(['Please enter break point #',int2str(i+1), ' position: ']);
    information_array(i+2,1)=information_array(i+1,2);
end

t_tot=[];
y_tot=[];
tempPoly=[];
for i=0:1:(break_points_number)
    t=linspace(information_array(i+1,1),information_array(i+1,2),fs*abs(information_array(i+1,2)-information_array(i+1,1)));   
    function_type=input(['\nPlease enter the type of the function in position [',num2str(information_array(i+1,1)),' : ', num2str(information_array(i+1,2)), ']\n1.DC Signal\n2.Ramp Signal\n3.General Order Polynomial\n4.Exponential Signal\n5.Sinusoidal Signal\n\nFunction type:  ']);
    if function_type==1
        DC_Amplitude=input('Please enter signal amplitude: ');
        y = DC_Amplitude*ones(1,fs*abs(information_array(i+1,2)-information_array(i+1,1)));
    elseif function_type==2
        Ramp_Slope=input('Please enter the slope: ');
        Ramp_Intercept=input('Please enter the intercept: ');
        y = Ramp_Slope * t + Ramp_Intercept;
    elseif function_type==3
        Highest_Power=input('Please enter the highest power: ');
        for j= Highest_Power:-1:1
        coefficient = input(['Please enter the coefficient for the term X^',int2str(j),' :']);
        tempPoly=[tempPoly coefficient];
        end
        intercept= input('Please enter intercept: ');
        tempPoly=[tempPoly intercept];
        y = polyval(tempPoly,t);
    elseif function_type==4
        Exponential_Amplitude=input('Please enter the amplitude: ');    
        Exponent=input('Please enter the exponent: ');  
        y=Exponential_Amplitude * exp(Exponent*t);

    elseif function_type==5
        Sinusoidal_Amplitude=input('Please enter signal amplitude: ');
        Sinusoidal_Frequency =input('Please enter signal frequency: ');
        Sinusoidal_PhaseShift=input('Please enter the phase shift: ');   
        y = Sinusoidal_Amplitude * sin(Sinusoidal_Frequency * t + Sinusoidal_PhaseShift);  
    end
    t_tot=[t_tot t];
    y_tot=[y_tot y];
end
figure;plot(t_tot,y_tot);
title('SIGNALS GENERATED');
operation = input('\n\nPlease enter the type of the operation to be performed on signal\n1.Amplitude Scaling\n2.Time Reversal\n3.Time Shift\n4.Signal Expansion\n5.Signal Compression\n6.None\n\nOperation: ');
switch operation
    case 1
        factor = input('Please enter the amplitude scale: ');
        y_tot = factor .* y_tot;
    case 2
        t_tot = -1 .* t_tot;
    case 3
        factor = input('Please enter the shifting value: ');
        t_tot = factor + t_tot;
    case 4
        factor = input('Please enter the expansion factor: ');
        t_tot = t_tot .* factor;
    case 5
        factor = input('Please enter the compression factor: ');
        t_tot = t_tot ./ factor;
    case 6
        disp('No operation was done on signal!');
    otherwise
        disp('Operation not in choices!\n')
end
    figure;plot(t_tot,y_tot);
    title('SIGNALS AFTER OPERATION');

