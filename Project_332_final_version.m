clc; 
close all;
disp("MECH 332")
disp("Designing and Synthesizing 4 bar mechanisms.")
disp("A Project by: Ghina El Sharif, Tarek Haidar, Omar Kanj.")
%Choosing type of mechanism
disp("For both mechanisms the positive direction is assumed to be counterclockwise for the angles, velocities and acceleration.")
type_of_mechanism = input("If you would like to simulate a RRRR mechanism write 1." + ...
    "If you would like to simulate a RRRP mechanism write 2: ");
if type_of_mechanism == 1
    % Value entry: 
    
    r1 = input("Enter the length of r1: ");
    r2 = input("Enter the length of r2: ");
    r3 = input("Enter the length of r3: ");
    r4 = input("Enter the length of r4: ");
    theta1 = input("Enter the angle theta 1 between the grounded and r1: ");
    
    % Grashof's criteria:    
    % we use the min and max functions to find which between the radii is the
    % smallest and which is the largest in order to apply grashof.
    LS=min([r1,r2,r3,r4]);
    LL=max([r1,r2,r3,r4]);
    if (LS+LL>(r1+r2+r3+r4)-(LS+LL))
        disp("The Grashof condition is not satisfied and there are no cranks in this four-bar mechanism.")
        g = 1;
        if r1+r2<r3+r4
        theta2a= acosd((r2^2+r1^2-(r4-r3)^2)/(2*r1*r2));
        theta_min= theta1+theta2a;
        theta_max= theta1+360 -theta2a;
        else
            theta2a= acosd((r2^2+r1^2-(r4+r3)^2)/(2*r1*r2));
        theta_min= theta1-theta2a;
        theta_max= theta1 + theta2a;
        end
        y = input("press (1) if you would like to see an animation for greshof, else press (2): ");
        if y==1

        for theta2b = theta_min:theta_max
        c1 = (2*r1*r4*cosd(theta1)) - 2*r2*r4*cosd(theta2b);
        c2 = (2*r1*r4*sind(theta1)) - 2*r2*r4*sind(theta2b);
        c3 = (r1^2 + r2^2 - r3^2 + r4^2 - 2*r1*r2*cosd(theta1-theta2b));
        tn2 = -c2 - sqrt((c1^2) + (c2^2) - (c3^2));
        td = (c3-c1);
        theta42 = 2*atan2d(tn2,td);
        
        zn = r1*sind(theta1) + r4*sind(theta42) - r2*sind(theta2b);
        zd2 = r1*cosd(theta1) + r4*cosd(theta42) - r2*cosd(theta2b);
        theta3 = atan2d(zn,zd2); 
        xO2=0;   
        yO2=0;
        xO4=xO2+r1*cosd(theta1);
        yO4=xO2+r1*sind(theta1);  
        xA=xO2+r2*cosd(theta2b);
        yA=yO2+r2*sind(theta2b);
        xB=xO4+r4*cosd(theta42);
        yB=yO4+r4*sind(theta42);
       R2=plot([xO2 xA], [yO2 yA],'ro-','LineWidth',5);hold on; %r2
       R3=plot([xA xB], [yA yB], 'go-','LineWidth',5); hold on; %r3
       R4=plot([xB xO4], [yB yO4], 'bo-','LineWidth',5); hold on; %r4
       R1=plot([xO4 xO2], [yO4 yO2], 'co-','LineWidth',5);hold on; %r
       link_x=[xO2; xA; xB; xO4];
       link_y=[yO2; yA; yB; yO4];
       hold on;
       hold off
       pause(0.01);
       delete(R1);
       delete(R2);
       delete(R3);
       delete(R4);
        end
       
        end
        disp( " if you do not have an angle between: ")
        disp(theta_min)
        disp("and")
        disp(theta_max)
        z = input("press(1), else press (2)");
        if z == 1
            return 
        end 
    else
        disp("The Grashof condition is satisfied and at least one link is a crank.");
        g=0;
        
    end
    need = input("input 1 if you need at a certain instant, 2 for full animation: " );
    if need == 1
        pt=1;
        while pt == 1
    theta2 = input("Enter the angle theta 2 between the grounded and r2: ");
    w2 = input("Enter the value of the angular velocity of r2: ");
    alfa2 = input("Enter the value of the angular acceleration of r2: ");
    question_for_position_placement = input("Do you want to find the position of an extra point? (if yes write 1, if no write 2): "); 
    % Position analysis:
    
    c1 = (2*r1*r4*cosd(theta1)) - 2*r2*r4*cosd(theta2);
    c2 = (2*r1*r4*sind(theta1)) - 2*r2*r4*sind(theta2);
    c3 = (r1^2 + r2^2 - r3^2 + r4^2 - 2*r1*r2*cosd(theta1-theta2));
    tn1 = -c2 + sqrt((c1^2) + (c2^2) - (c3^2));
    tn2 = -c2 - sqrt((c1^2) + (c2^2) - (c3^2));
    td = (c3-c1);    
    theta41 = 2*atan2d(tn1,td);
    theta42 = 2*atan2d(tn2,td);   
    zn1 = r1*sind(theta1) + r4*sind(theta41) - r2*sind(theta2);
    zd1 = r1*cosd(theta1) + r4*cosd(theta41) - r2*cosd(theta2);
    zn2 = r1*sind(theta1) + r4*sind(theta42) - r2*sind(theta2);
    zd2 = r1*cosd(theta1) + r4*cosd(theta42) - r2*cosd(theta2);
    theta31 = atan2d(zn1,zd1);
    theta32 = atan2d(zn2,zd2);
    disp("first theta3 = ");
    disp(theta31)
    disp("first theta4 = ");
    disp(theta41)
    disp("second theta3 = ");
    disp(theta32)
    disp("second theta4 = ");
    disp(theta42)
    % Plotting the 4 bar:
   
    xO2=0;   
        yO2=0;
        xO4=xO2+r1*cosd(theta1);
        yO4=xO2+r1*sind(theta1);  
        xA=xO2+r2*cosd(theta2);
        yA=yO2+r2*sind(theta2);
        xB=xO4+r4*cosd(theta41);
        yB=yO4+r4*sind(theta41);
        subplot(2,2,1);
        hold on;
       plot([xO2 xA], [yO2 yA],'ro-','LineWidth',5);hold on; %r2
       plot([xA xB], [yA yB], 'go-','LineWidth',5); hold on; %r3
       plot([xB xO4], [yB yO4], 'bo-','LineWidth',5); hold on; %r4
       plot([xO4 xO2], [yO4 yO2], 'co-','LineWidth',5);hold on; %r
       axis off
       hold off
       subplot(2,2,2);
        hold on;
      xB=xO4+r4*cosd(theta42);
       yB=yO4+r4*sind(theta42);
     R2=plot([xO2 xA], [yO2 yA],'ro-','LineWidth',5);hold on; %r2
       R3=plot([xA xB], [yA yB], 'go-','LineWidth',5); hold on; %r3
       R4=plot([xB xO4], [yB yO4], 'bo-','LineWidth',5); hold on; %r4
       R1=plot([xO4 xO2], [yO4 yO2], 'co-','LineWidth',5);hold on; %r1
     
       axis off
       hold off        
    
    % Velocity analysis:
    if theta2<0   %this step is taken to make sure the velocity and tangential acceleration are calculated correctly 
        theta2=theta2+360;
    end 
    if theta31<0
        theta31=theta31+360;
    end 
    if theta32<0
        theta32=theta32+360;
    end
    if theta41<0
        theta41=theta41+360;
    end
    if theta42<0
        theta42=theta42+360;
    end
    
    %Vb = Va + Vba
    % r4*w4*(sind() i + cosd() j) = r2*w2*(sind(90 - theta2) i + cosd(90 - theta2) j)+r3*w3*(sind() i + cosd() j)
    disp("for first theta values")
    syms w4 w3
    eqn1a = (r4*sind(90+theta41))*w4 - (r3*sind(90+theta31))*w3 == (r2*w2*sind(90+theta2));
    eqn2a = (r4*cosd(90+theta41))*w4 - (r3*cosd(90+theta31))*w3 == (r2*w2*cosd(90+theta2));
    sola = solve([eqn1a,eqn2a],[w4,w3]);
    w41 = sola.w4;
    w31 = sola.w3;
    
    w_31 = double(w31);
    w_41 = double(w41);
    if w_31<0
        disp("w3 =")
        disp(-w_31)
        disp("clockwise")
    else
        disp("w3 =")
        disp(w_31)
        disp("counterclockwise")
    end
    if w_41<0
        disp("w4 =")
        disp(-w_41)
        disp("clockwise")
    else
        disp("w4 =")
        disp(w_41)
        disp("counterclockwise")
    end
    disp("for second theta values")
    syms w4 w3
    eqn1b = (r4*sind(90+theta42))*w4 - (r3*sind(90+theta32))*w3 == (r2*w2*sind(90+theta2));
    eqn2b = (r4*cosd(90+theta42))*w4 - (r3*cosd(90+theta32))*w3 == (r2*w2*cosd(90+theta2));
    solb = solve([eqn1b,eqn2b],[w4,w3]);
    w42 = solb.w4;
    w32 = solb.w3;
    
    w_32 = double(w32);
    w_42 = double(w42);
    if w_32<0
        disp("w3 =")
        disp(-w_32)
        disp("clockwise")
    else
        disp("w3 =")
        disp(w_32)
        disp("counterclockwise")
    end
    if w_42<0
        disp("w4 =")
        disp(-w_42)
        disp("clockwise")
    else
        disp("w4 =")
        disp(w_42)
        disp("counterclockwise")
    end
    Va = r2*w2;
    Vb = r4*w_42;
    Vba = r3*w_32;
    
    if Va < 0
        Va = Va*(-1);
    end
    if Vb < 0 
        Vb = Vb*(-1);
    end
    if Vba < 0
        Vba = Vba*(-1);
    end
    
    disp("Va =")
    disp(Va)
    disp("Vb =")
    disp(Vb)
    disp("Vba =")
    disp(Vba)
    
    % Acceleration analysis:
    
    %Ab = Aa + Aba
    %Ab = Abn + Abt;
    %Aa = Aan + Aat;
    %Aba = Aban + Abat;
    
    %For the first graph
    
    Aatx1 = r2*alfa2*cosd(90 + theta2);
    Aaty1 = r2*alfa2*sind(90 + theta2); 
    Aanx1 = r2*((w2)^2)*cosd(180 + theta2);
    Aany1 = r2*((w2)^2)*sind(180 + theta2);    
    syms alfa4 alfa3    
    Abnx1 = r4*((w_41)^2)*cosd(180 + theta41);
    Abny1 = r4*((w_41)^2)*sind(180 + theta41);    
    Abanx1 = r3*((w_31)^2)*cosd(180 + theta31);
    Abany1 = r3*((w_31)^2)*sind(180 + theta31);   
    
    %Aan = Aanx + Aany;
    %Aat = Aatx + Aaty;    
    
    eqn1b = (r4*((w_41)^2)*cosd(180 + theta41) + r4*alfa4*cosd(90 + theta41) - Abanx1 - r3*alfa3*cosd(90 + theta31) == Aanx1 + Aatx1);
    eqn2b = (Abny1 + r4*alfa4*sind(90 + theta41) - Abany1 - r3*alfa3*sind(90 + theta31) == Aany1 + Aaty1);
    solb = solve([eqn1b,eqn2b],[alfa4,alfa3]);
    alfa41 = solb.alfa4;
    alfa31 = solb.alfa3;    
    alfa_31 = double(alfa31);
    alfa_41 = double(alfa41);
    if alfa_31<0
        disp("alfa_31 =")
        disp(-alfa_31)
        disp("clockwise")
    else
        disp("alfa_31 =")
        disp(alfa_31)
        disp("counterclockwise")
    end 
    if alfa_41<0
        disp("alfa_41 =")
        disp(-alfa_41)
        disp("clockwise")
    else
        disp("alfa_41 =")
        disp(alfa_41)
        disp("counterclockwise")
    end
    
    %Ab = Aa + Aba
    Abtx1 = r4*alfa_41*cosd(90 + theta41);
    Abty1 = r4*alfa_41*sind(90 + theta41);
    Abatx1 = r3*alfa_31*cosd(90 + theta31);
    Abaty1 = r3*alfa_31*sind(90 + theta31);
    Aan1 = sqrt(Aanx1^2 + Aany1^2);
    Aat1 = sqrt(Aatx1^2 + Aaty1^2);
    Aa1 = Aan1 + Aat1;
    disp("Aa1 = ")
    disp(Aa1)
    
    Abn1 = sqrt((Abnx1)^2 + (Abny1)^2);
    Abt1 = sqrt((Abtx1)^2 + (Abty1)^2);
    Ab1 = Abn1 + Abt1;
    disp("Ab1 = ")
    disp(Ab1)
    
    Aban1 = sqrt((Abanx1)^2 + (Abany1)^2);
    Abat1 = sqrt((Abatx1)^2 + (Abaty1)^2);
    Aba1 = Aban1 + Abat1;
    disp("Aba1 = ")
    disp(Aba1)
    
    % For the second graph
    
    Aatx2 = r2*alfa2*cosd(90 + theta2);
    Aaty2 = r2*alfa2*sind(90 + theta2); 
    Aanx2 = r2*((w2)^2)*cosd(180 + theta2);
    Aany2 = r2*((w2)^2)*sind(180 + theta2);    
    syms alfa4 alfa3    
    Abnx2 = r4*((w_42)^2)*cosd(180 + theta42);
    Abny2 = r4*((w_42)^2)*sind(180 + theta42);   
    Abanx2 = r3*((w_32)^2)*cosd(180 + theta32);
    Abany2 = r3*((w_32)^2)*sind(180 + theta32);   
    
    %Aan = Aanx + Aany;
    %Aat = Aatx + Aaty;    
    
    eqn1b = (r4*((w_42)^2)*cosd(180 + theta42) + r4*alfa4*cosd(90 + theta42) - Abanx2 - r3*alfa3*cosd(90 + theta32) == Aanx2 + Aatx2);
    eqn2b = (Abny2 + r4*alfa4*sind(90 + theta42) - Abany2 - r3*alfa3*sind(90 + theta32) == Aany2 + Aaty2);
    solb = solve([eqn1b,eqn2b],[alfa4,alfa3]);
    alfa42 = solb.alfa4;
    alfa32 = solb.alfa3;    
    alfa_32 = double(alfa32);
    alfa_42 = double(alfa42);
    
     if alfa_32<0
        disp("alfa_32 =")
        disp(-alfa_32)
        disp("clockwise")
    else
        disp("alfa_32 =")
        disp(alfa_32)
        disp("counterclockwise")
    end 
    if alfa_42<0
        disp("alfa_42 =")
        disp(-alfa_42)
        disp("clockwise")
    else
        disp("alfa_42 =")
        disp(alfa_42)
        disp("counterclockwise")
    end
    
    %Ab = Aa + Aba
    Abtx2 = r4*alfa_42*cosd(90 + theta42);
    Abty2 = r4*alfa_42*sind(90 + theta42);
    Abatx2 = r3*alfa_32*cosd(90 + theta32);
    Abaty2 = r3*alfa_32*sind(90 + theta32);
    Aan2 = sqrt(Aanx2^2 + Aany2^2);
    Aat2 = sqrt(Aatx2^2 + Aaty2^2);
    Aa2 = Aan2 + Aat2;
    disp("Aa2 = ")
    disp(Aa2)    
    
    Abn2 = sqrt((Abnx2)^2 + (Abny2)^2);
    Abt2 = sqrt((Abtx2)^2 + (Abty2)^2);
    Ab2 = Abn2 + Abt2;
    disp("Ab2 = ")
    disp(Ab2)
    
    Aban2 = sqrt((Abanx2)^2 + (Abany2)^2);
    Abat2 = sqrt((Abatx2)^2 + (Abaty2)^2);
    Aba2 = Aban2 + Abat2;
    disp("Aba2 = ")
    disp(Aba2)
    % Vp = Va + Vpa
    if question_for_position_placement == 1
        link = input("choose a number: 1-driver, 2-follower, 3-coupler: ");
        beta = input("Enter the value of beta which is the angle between the point and the link: ");
        distance_to_p = input("Enter the distance from the joint to P: ");
        if beta<0
            beta=beta+360;
        end
        if link == 1
            Vpax1 = w2*distance_to_p*cosd(90+beta + theta2);
            Vpay1 = w2*distance_to_p*sind(90+beta + theta2);
            Vpa1 = sqrt(Vpax1^2 + Vpay1^2);
            Vp1 = Vpa1;
            Vp2 = Vpa1;
            Apatx1 = alfa2*distance_to_p*cosd(90+beta + theta2);
            Apaty1 = alfa2*distance_to_p*sind(90+beta + theta2);
            Apanx1 = (w2^2)*distance_to_p*cosd(180+beta + theta2);
            Apany1 = (w2^2)*distance_to_p*sind(180+beta + theta2);
            Apat1=sqrt(Apatx1^2+Apaty1^2);
            Apan1=sqrt(Apanx1^2+Apany1^2);
            Ap1=sqrt(Apat1^2+Apan1^2);
            Ap2=Ap1;
    
    
        end
        if link == 2
            Vpax1 = w_41*distance_to_p*cosd(90+beta + theta41);
            Vpay1 = w_41*distance_to_p*sind(90+beta + theta41);
            Vpa1 = sqrt(Vpax1^2 + Vpay1^2);
            Vp1 = Vpa1;
    
            Apatx1 = alfa_41*distance_to_p*cosd(90+beta + theta41);
            Apaty1 = alfa_41*distance_to_p*sind(90+beta + theta41);
            Apanx1 = (w_41^2)*distance_to_p*cosd(180+beta + theta41);
            Apany1 = (w_41^2)*distance_to_p*sind(180+beta + theta41);
            Apat1=sqrt(Apatx1^2+Apaty1^2);
            Apan1=sqrt(Apanx1^2+Apany1^2);
            Ap1=sqrt(Apat1^2+Apan1^2);
    
            Vpax2 = w_42*distance_to_p*cosd(90+beta + theta42);
            Vpay2 = w_42*distance_to_p*sind(90+beta + theta42);
            Vpa2 = sqrt(Vpax2^2 + Vpay2^2);
            Vp2 = Vpa2;
            Apatx2 = alfa_42*distance_to_p*cosd(90+beta + theta42);
            Apaty2 = alfa_42*distance_to_p*sind(90+beta + theta42);
            Apanx2 = (w_42^2)*distance_to_p*cosd(180+beta + theta42);
            Apany2 = (w_42^2)*distance_to_p*sind(180+beta + theta42);
            Apat2=sqrt(Apatx1^2+Apaty1^2);
            Apan2=sqrt(Apanx1^2+Apany1^2);
            Ap2=sqrt(Apat1^2+Apan1^2);
           
        end
        if link == 3
            Vpax1 = w_32*distance_to_p*cosd(90+beta + theta32);
            Vpay1 = w_32*distance_to_p*sind(90+beta + theta32);
            Vpa1 = sqrt(Vpax1^2 + Vpay1^2);
            Vp1 = Vpa1 + Va;
            Apatx1 = alfa_31*distance_to_p*cosd(90+beta + theta31);
            Apaty1 = alfa_31*distance_to_p*sind(90+beta + theta31);
            Apanx1 = (w_31^2)*distance_to_p*cosd(180+beta + theta31);
            Apany1 = (w_31^2)*distance_to_p*sind(180+beta + theta31);
            Apat1=sqrt(Apatx1^2+Apaty1^2);
            Apan1=sqrt(Apanx1^2+Apany1^2);
            Ap1=sqrt(Apat1^2+Apan1^2)+Aa1;
    
            Vpax2 = w_32*distance_to_p*cosd(90+beta + theta32);
            Vpay2 = w_32*distance_to_p*sind(90+beta + theta32);
            Vpa2 = sqrt(Vpax2^2 + Vpay2^2);
            Vp2 = Vpa2 + Va;
            Apatx2 = alfa_32*distance_to_p*cosd(90+beta + theta32);
            Apaty2 = alfa_32*distance_to_p*sind(90+beta + theta32);
            Apanx2 = (w_32^2)*distance_to_p*cosd(180+beta + theta32);
            Apany2 = (w_32^2)*distance_to_p*sind(180+beta + theta32);
            Apat2=sqrt(Apatx2^2+Apaty2^2);
            Apan2=sqrt(Apanx2^2+Apany2^2);
            Ap2=sqrt(Apat2^2+Apan2^2)+Aa2;
        end
        disp("Vp1 = ")
        disp(Vp1)
        disp("Vp2 = ")
        disp(Vp2)
        disp("Ap1 = ")
        disp(Ap1)
        disp("Ap2 = ")
        disp(Ap2)
    end
    pt=input("if you need at another angle press(1), else press (2): ");
        end
        if pt == 2
            return 
        end 
   
   end
    if need == 2
        if g == 1
            disp(" a full animation is not possible for this non greshof mechanism")
            return 
        end 
        if g == 0
    
        %Position analysis at every interval:
        for theta2 = 0:360
        c1 = (2*r1*r4*cosd(theta1)) - 2*r2*r4*cosd(theta2);
        c2 = (2*r1*r4*sind(theta1)) - 2*r2*r4*sind(theta2);
        c3 = (r1^2 + r2^2 - r3^2 + r4^2 - 2*r1*r2*cosd(theta1-theta2));
        
        tn1 = (-c2 + sqrt((c1^2) + (c2^2) - (c3^2)));
        tn2 = -c2 - sqrt((c1^2) + (c2^2) - (c3^2));
        td = (c3-c1);
        
        theta41 = 2*atan2d(tn1,td);
        theta42 = 2*atan2d(tn2,td);
        
        zn = r1*sind(theta1) + r4*sind(theta42) - r2*sind(theta2);
        zd2 = r1*cosd(theta1) + r4*cosd(theta42) - r2*cosd(theta2);
        
        theta3 = atan2d(zn,zd2);
        %disp("theta3 =");
        %disp(theta3)
        %disp("theta4 =");
        %disp(theta4)  
        xO2=0;   
        yO2=0;
        xO4=xO2+r1*cosd(theta1);
        yO4=xO2+r1*sind(theta1);  
        xA=xO2+r2*cosd(theta2);
        yA=yO2+r2*sind(theta2);
        xB=xO4+r4*cosd(theta42);
        yB=yO4+r4*sind(theta42);
       R2=plot([xO2 xA], [yO2 yA],'ro-','LineWidth',5);hold on; %r2
       R3=plot([xA xB], [yA yB], 'go-','LineWidth',5); hold on; %r3
       R4=plot([xB xO4], [yB yO4], 'bo-','LineWidth',5); hold on; %r4
       R1=plot([xO4 xO2], [yO4 yO2], 'co-','LineWidth',5);hold on; %r1
       a=2*r2+r3;
       axis([-a a -a a])
       axis off
       hold off
       
       pause(0.000001)
       delete(R1)
       delete(R2)
       delete(R3)
       delete(R4)
        end
        end
        x=input("if you would like to see graphs press(1), else press (2): ");
        if x == 1
        theta2=0;
        c1 = (2*r1*r4*cosd(theta1)) - 2*r2*r4*cosd(theta2);
        c2 = (2*r1*r4*sind(theta1)) - 2*r2*r4*sind(theta2);
        c3 = (r1^2 + r2^2 - r3^2 + r4^2 - 2*r1*r2*cosd(theta1-theta2));
        tn1 = (-c2 + sqrt((c1^2) + (c2^2) - (c3^2)));
        tn2 = -c2 - sqrt((c1^2) + (c2^2) - (c3^2));
        td = (c3-c1);
        theta4a = 2*atan2d(tn2,td);
        zn = r1*sind(theta1) + r4*sind(theta4a) - r2*sind(theta2);
        zd2 = r1*cosd(theta1) + r4*cosd(theta4a) - r2*cosd(theta2);
        theta3a = atan2d(zn,zd2);
        if theta3a<0
        theta3a=theta3a+360;
        end 
        if theta4a<0
        theta4a=theta4a+360;
        end
    syms w4 w3
    eqn1a = (r4*sind(90+theta4a))*w4 - (r3*sind(90+theta3a))*w3 == (r2*w2*sind(90+theta2));
    eqn2a = (r4*cosd(90+theta4a))*w4 - (r3*cosd(90+theta3a))*w3 == (r2*w2*cosd(90+theta2));
    sola = solve([eqn1a,eqn2a],[w4,w3]);
    w41 = sola.w4;
    w31 = sola.w3;
    w_3a = double(w31);
    w_4a = double(w41);
    w2=sqrt(w2^2+2*alfa2*1);
                  
        for theta2b = 1:360
            c1 = (2*r1*r4*cosd(theta1)) - 2*r2*r4*cosd(theta2b);
            c2 = (2*r1*r4*sind(theta1)) - 2*r2*r4*sind(theta2b);
            c3 = (r1^2 + r2^2 - r3^2 + r4^2 - 2*r1*r2*cosd(theta1-theta2b));
                    
            t1 = (-c2 + sqrt((c1^2) + (c2^2) - (c3^2)))/(c3-c1);
            t2 = (-c2 - sqrt((c1^2) + (c2^2) - (c3^2)))/(c3-c1);
            tn1 = (-c2 + sqrt((c1^2) + (c2^2) - (c3^2)));
            tn2 = -c2 - sqrt((c1^2) + (c2^2) - (c3^2));
            td = (c3-c1);
                    
            theta4b = 2*atan2d(tn1,td);
                    
            zn = r1*sind(theta1) + r4*sind(theta4b) - r2*sind(theta2b);
            zd2 = r1*cosd(theta1) + r4*cosd(theta2b) - r2*cosd(theta2b);        
            theta3b = atan2d(zn,zd2);
            if theta3b<0
        theta3b=theta3b+360;
            end 
        if theta4b<0
        theta4b=theta4b+360;
        end
       
    syms w4 w3
    eqn1a = (r4*sind(90+theta4b))*w4 - (r3*sind(90+theta3b))*w3 == (r2*w2*sind(90+theta2b));
    eqn2a = (r4*cosd(90+theta4b))*w4 - (r3*cosd(90+theta3b))*w3 == (r2*w2*cosd(90+theta2b));
    sola = solve([eqn1a,eqn2a],[w4,w3]);
    w41 = sola.w4;
    w31 = sola.w3;
    w_3b = double(w31);
    w_4b = double(w41);
               
            subplot(2,2,1)
            hold on
            plot([theta2 theta2b], [theta3a theta3b], '-r', 'LineWidth',1);
            title(' Coupler angle ')
            xlabel('\theta2')
            ylabel('\theta3')
            grid on
                   
            subplot(2,2,2)
            hold on
            plot([theta2 theta2b], [theta4a theta4b], '-r', 'LineWidth',1);
            title(' Rocker angle ')
            xlabel('\theta2')
            ylabel('\theta4')
            grid on
            hold off
            subplot(2,2,3)
            hold on
            plot([theta2 theta2b], [w_3a w_3b], '-r', 'LineWidth',1);
            title(' Coupler angular velocity ')
            xlabel('\theta2')
            ylabel('w3')
            grid on
                   
            subplot(2,2,4)
            hold on
            plot([theta2 theta2b], [w_4a w_4b], '-r', 'LineWidth',1);
            title(' Rocker angular velocity ')
            xlabel('\theta2')
            ylabel('w4')
            grid on
            hold off
            theta2=theta2b;
            theta3a=theta3b;
            theta4a=theta4b;
            w_3a=w_3b;
            w_4a=w_4b;
            w2=sqrt(w2^2+2*alfa2*1);
            

            

        end
        end
        if x==2
            return
        end
    end 
end

if type_of_mechanism == 2

 % Crank slider mechanism
 % Value Entry:
 % r0 is the offset

    r2 = input("Enter the desired value for r2: ");
    r3 = input("Enter the desired value for r3: ");
    thetag=input("enter the desired value between the slider ground and the horizontal: ");
    choosing_instant_animation_or_graphs = input("For kinematic analysis of crank slider at a certain instant, press 1, For animation of crank slider press 2: ");
    
    if choosing_instant_animation_or_graphs == 1
        pt = 1;
        while pt == 1
        r0 = input("Enter the desired offset perpendicular to the horizantal ground: ");
        theta2 = input("Enter desired value for theta2: ");
        w2 = input("Enter the desired value for w2: ");
        alfa2 = input("enter the desired value of alfa2: ");
        A = 1;
        B = -2*r2*cosd(theta2);
        C = (r2^2)+2*r0*r2*sind(theta2)+(r0^2)-(r3^2);
    
        r1a=((-B-sqrt((B^2)-4*A*C))/(2*A));
        r1b=((-B+sqrt((B^2)-4*A*C))/(2*A));
        tn1= -r0-r2*sind(theta2);
        td1 = -r2*cosd(theta2)+r1a;
        tn2= -r0-r2*sind(theta2);
        td2 =-r2*cosd(theta2)+r1b;
        theta31 = atan2d(tn1,td1);
        theta32 = atan2d(tn2,td2);
         xO2=0;   
        yO2=r0*cosd(thetag);  
        xA=xO2+r2*cosd(theta2+thetag);
        yA=yO2+r2*sind(theta2+thetag);
        xB=r0*sind(thetag)+r1b*cosd(thetag);
        yB=r1b*sind(thetag);
           
        R2=plot([xO2 xA], [yO2 yA],'ro-','LineWidth',5);hold on; %r2
        R3=plot([xA xB], [yA yB], 'go-','LineWidth',5); hold on; %r3
       sliderx=[xB-r3/4 xB-r3/4 xB+r3/4 xB+r3/4];
        slidery=[yB-r3/4 yB+r3/4 yB+r3/4 yB-r3/4];
        polyin= polyshape(sliderx,slidery) ;
        poly2 = rotate(polyin,thetag,[xB yB]);
        S=plot(poly2,"FaceColor",'m' ); 
       axis off
        hold off
        if theta32<0
            theta32=theta32+360;
        end
        
        if theta31<0
            theta31=theta31+360;
        end
        %Vb=Vba+Va
        syms w3 Vb
        eqn1a = (Vb*cosd(thetag) == r2*w2*cosd(90+theta2)+r3*w3*cosd(90+theta32));
        eqn2a = (Vb*sind(thetag) == r2*w2*sind(90+theta2)+r3*w3*sind(90+theta32));
        sola = solve([eqn1a,eqn2a],[w3,Vb]);
        w32 = sola.w3;
        Vb2 = sola.Vb;
        
        w32 = double(w32);
        Vb2 = double(Vb2);
    
        syms w3 Vb
        eqn1a = (Vb*cosd(thetag) == r2*w2*cosd(90+theta2)+r3*w3*cosd(90+theta31));
        eqn2a = (Vb*sind(thetag) == r2*w2*sind(90+theta2)+r3*w3*sind(90+theta31));
        sola = solve([eqn1a,eqn2a],[w3,Vb]);
        w31 = sola.w3;
        Vb1 = sola.Vb;
        
        
        w31 = double(w31);
        Vb1 = double(Vb1);
    
        %ab= abat+aban+aat+aan
        Aatx2 = r2*alfa2*cosd(90+theta2);
        Aaty2 = r2*alfa2*sind(90+theta2); 
        Aanx2 = r2*((w2)^2)*cosd(180 + theta2);
        Aany2 = r2*((w2)^2)*sind(180 + theta2);        
        syms Ab alfa3       
        Abanx1 = r3*((w31)^2)*cosd(180 + theta31);
        Abany1 = r3*((w31)^2)*sind(180 + theta31);        
        
        %Aan = Aanx + Aany;
        %Aat = Aatx + Aaty;        
        
        eqn1b = (Ab*cosd(thetag) - Abanx1 - r3*alfa3*cosd(90+theta31) == Aanx2 + Aatx2);
        eqn2b = (Ab*sind(thetag) - Abany1 - r3*alfa3*sind(90+theta31) == Aany2 + Aaty2);
        solb = solve([eqn1b,eqn2b],[Ab,alfa3]);
        Ab1 = solb.Ab;
        alfa31 = solb.alfa3;        
        alfa_31 = double(alfa31);
        Ab1 = double(Ab1);        
        syms Ab alfa3        
        Abanx2 = r3*((w32)^2)*cosd(180 + theta32);
        Abany2 = r3*((w32)^2)*sind(180 + theta32);        
        
        %Aan = Aanx + Aany;
        %Aat = Aatx + Aaty;        
        
        eqn1b = (Ab*cosd(thetag) - Abanx2 - r3*alfa3*cosd(90+theta32) == Aanx2 + Aatx2);
        eqn2b = (Ab*sind(thetag) - Abany2 - r3*alfa3*sind(90+theta32) == Aany2 + Aaty2);
        solb = solve([eqn1b,eqn2b],[Ab,alfa3]);
        Ab2 = solb.Ab;
        alfa32 = solb.alfa3;
        
        alfa_32 = double(alfa32);
        Ab2 = double(Ab2);
        
    
        disp("first theta3 = ")
        disp(theta31)
    
        disp("second theta3 = ")
        disp(theta32)
    
        disp("first r1 = ")
        disp(r1a)
    
        disp("second r1 = ")
        disp(r1b)
    
        disp("first w3 = ")
        disp(w31)
    
        disp("second w3 = ")
        disp(w32)
    
        Va = r2*w2;
        
        disp("Va = ")
        disp(Va)
        Vba1 = r3*w31;
    
        Vba2 = r3*w32;
    
        disp("Vba1 = ")
        disp(Vba1)
        disp("Vba2 = ")
        disp(Vba2)
        disp("alfa_31 = ")
        disp(alfa_31)
    
        disp("alfa_32 = ")
        disp(alfa_32)
        
        Aa = sqrt(Aatx2^2 + Aaty2^2) + sqrt(Aanx2^2 + Aany2^2);
        disp("Aa = ")
        disp(Aa)
        Aba1 = sqrt((r3*alfa_31*cosd(90+theta31))^2 + (r3*alfa_31*sind(90+theta31))^2) + sqrt(Abanx1^2 + Abany1^2);
        disp("Aba1 = ")
        disp(Aba1)
        
        Aba2 = sqrt((r3*alfa_32*cosd(90+theta32))^2 + (r3*alfa_32*sind(90+theta32))^2) + sqrt(Abanx2^2 + Abany2^2);
        disp("Aba2 = ")
        disp(Aba2)
    
        disp("Ab1 = ")
        disp(Ab1)
    
        disp("Ab2 = ")
        disp(Ab2)
    question_if_user_wants_to_find_position_of_a_point = input("Enter 1 if you want to simulate a point on one of the links: ");
    if question_if_user_wants_to_find_position_of_a_point == 1
            link = input("choose a number: 1-driver, 2-coupler: ");
            beta = input("Enter the value of beta which is the angle between the point and the link: ");
            distance_to_p = input("Enter the distance from the joint to P: ");
            if beta<0
                beta=beta+360;
            end
            if link == 1
                Vpax1 = w2*distance_to_p*cosd(90+beta + theta2);
                Vpay1 = w2*distance_to_p*sind(90+beta + theta2);
                Vpa1 = sqrt(Vpax1^2 + Vpay1^2);
                Vp1 = Vpa1;
                Vp2 = Vpa1;
                Apatx1 = alfa2*distance_to_p*cosd(90+beta + theta2);
                Apaty1 = alfa2*distance_to_p*sind(90+beta + theta2);
                Apanx1 = (w2^2)*distance_to_p*cosd(180+beta + theta2);
                Apany1 = (w2^2)*distance_to_p*sind(180+beta + theta2);
                Apat1=sqrt(Apatx1^2+Apaty1^2);
                Apan1=sqrt(Apanx1^2+Apany1^2);
                Ap1=sqrt(Apat1^2+Apan1^2);
                Ap2=Ap1;
        
        
            end
            
            if link == 2
                Vpax1 = w32*distance_to_p*cosd(90+beta + theta32);
                Vpay1 = w32*distance_to_p*sind(90+beta + theta32);
                Vpa1 = sqrt(Vpax1^2 + Vpay1^2);
                Vp1 = Vpa1 + Va;
                Apatx1 = alfa_31*distance_to_p*cosd(90+beta + theta31);
                Apaty1 = alfa_31*distance_to_p*sind(90+beta + theta31);
                Apanx1 = (w_31^2)*distance_to_p*cosd(180+beta + theta31);
                Apany1 = (w_31^2)*distance_to_p*sind(180+beta + theta31);
                Apat1=sqrt(Apatx1^2+Apaty1^2);
                Apan1=sqrt(Apanx1^2+Apany1^2);
                Ap1=sqrt(Apat1^2+Apan1^2)+Aa1;
        
                Vpax2 = w_32*distance_to_p*cosd(90+beta + theta32);
                Vpay2 = w_32*distance_to_p*sind(90+beta + theta32);
                Vpa2 = sqrt(Vpax2^2 + Vpay2^2);
                Vp2 = Vpa2 + Va;
                Apatx2 = alfa_32*distance_to_p*cosd(90+beta + theta32);
                Apaty2 = alfa_32*distance_to_p*sind(90+beta + theta32);
                Apanx2 = (w_32^2)*distance_to_p*cosd(180+beta + theta32);
                Apany2 = (w_32^2)*distance_to_p*sind(180+beta + theta32);
                Apat2=sqrt(Apatx2^2+Apaty2^2);
                Apan2=sqrt(Apanx2^2+Apany2^2);
                Ap2=sqrt(Apat2^2+Apan2^2)+Aa2;
            end
            disp("Vp1 = ")
            disp(Vp1)
            disp("Vp2 = ")
            disp(Vp2)
            disp("Ap1 = ")
            disp(Ap1)
            disp("Ap2 = ")
            disp(Ap2)
           
    end 
     pt = input("if you have another angle, press (1), else press (2): ");
    if pt == 2
        return  
    end
        end
    end

% Animation for crank slider + graphs for change in theta2 and theta3 w.r.t time: 
    if choosing_instant_animation_or_graphs == 2
        r0 = input("Enter the desired offset perpendicular to line of action coupler-slider joint: ");
        for theta2= 0:360
        A = 1;
        B = -2*r2*cosd(theta2);
        C = (r2^2)+2*r0*r2*sind(theta2)+(r0^2)-(r3^2);
        r1b=((-B+sqrt((B^2)-4*A*C))/(2*A));
        tn2= -r0-r2*sind(theta2);
        td2 =-r2*cosd(theta2)+r1b;
        theta32 = atan2d(tn2,td2);
       xO2=0;   
        yO2=r0*cosd(thetag);  
        xA=xO2+r2*cosd(theta2+thetag);
        yA=yO2+r2*sind(theta2+thetag);
        xB=r0*sind(thetag)+r1b*cosd(thetag);
        yB=r1b*sind(thetag);
       R2=plot([xO2 xA], [yO2 yA],'ro-','LineWidth',5);hold on; %r2
       R3=plot([xA xB], [yA yB], 'go-','LineWidth',5); hold on; %r3
       sliderx=[xB-r3/4 xB-r3/4 xB+r3/4 xB+r3/4];
        slidery=[yB-r3/4 yB+r3/4 yB+r3/4 yB-r3/4];
        polyin= polyshape(sliderx,slidery) ;
        poly2 = rotate(polyin,thetag,[xB yB]);
        S=plot(poly2,"FaceColor",'m' );
        a= 2*r2+r3;
       axis([-a a -a a])
       axis off
       hold off
       
       pause(0.01);
       delete(R3);
       delete(R2);
       delete(S);
        end
    end
    x = input("if you would like to see graphs, press (1), if no press(2): ");
    if x == 1
        disp("Note that all the angles here all the angles are measured with respect the x-axis that it is oriented 20 theta0 degrees from the original one")
        r0 = input("Enter the desired offset perpendicular to line of action coupler-slider joint: ");
        w2 = input("Enter the desired value for w2: ");
        alfa2 = input("enter the desired value of alfa2: ");
        theta2= 0;
        A = 1;
        B = -2*r2*cosd(theta2);
        C = (r2^2)+2*r0*r2*sind(theta2)+(r0^2)-(r3^2);
        r1a=((-B+sqrt((B^2)-4*A*C))/(2*A));
        tn2= -r0-r2*sind(theta2);
        td2 =-r2*cosd(theta2)+r1b;
        theta31 = atan2d(tn2,td2);
        
        if theta31<0
            theta31=theta31+360;
        end
        %Vb=Vba+Va
        syms w3 Vb
        eqn1a = (Vb*cosd(thetag) == r2*w2*cosd(90+theta2)+r3*w3*cosd(90+theta31));
        eqn2a = (Vb*sind(thetag) == r2*w2*sind(90+theta2)+r3*w3*sind(90+theta31));
        sola = solve([eqn1a,eqn2a],[w3,Vb]);
        w31 = sola.w3;
        Vb1 = sola.Vb;
        
        w31a = double(w31);
        Vb1a = double(Vb1);
         %ab= abat+aban+aat+aan
        Aatx2 = r2*alfa2*cosd(90+theta2);
        Aaty2 = r2*alfa2*sind(90+theta2); 
        Aanx2 = r2*((w2)^2)*cosd(180 + theta2);
        Aany2 = r2*((w2)^2)*sind(180 + theta2);
   
        syms Ab alfa3
       
        Abanx1 = r3*((w31a)^2)*cosd(180 + theta31);
        Abany1 = r3*((w31a)^2)*sind(180 + theta31);
        
        eqn1b = (Ab*cosd(thetag) - Abanx1 - r3*alfa3*cosd(90+theta31) == Aanx2 + Aatx2);
        eqn2b = (Ab*sind(thetag) - Abany1 - r3*alfa3*sind(90+theta31) == Aany2 + Aaty2);
        solb = solve([eqn1b,eqn2b],[Ab,alfa3]);
        Ab1 = solb.Ab;
        alfa31 = solb.alfa3;
        
        alfa_31 = double(alfa31);
        Ab1 = double(Ab1);
        w2=sqrt(w2^2+2*alfa2*1);
        
        for theta22= 1:360
        B = -2*r2*cosd(theta22);
        C = (r2^2)+2*r0*r2*sind(theta22)+(r0^2)-(r3^2);
        r1b=((-B+sqrt((B^2)-4*A*C))/(2*A));
        tn2= -r0-r2*sind(theta22);
        td2 =-r2*cosd(theta22)+r1b;
        theta32 =atan2d(tn2,td2);
        if theta32<0
            theta32=theta32+360;
        end
        %Vb=Vba+Va
        syms w3 Vb
        eqn1a = (Vb*cosd(thetag) == r2*w2*cosd(90+theta22)+r3*w3*cosd(90+theta32));
        eqn2a = (Vb*sind(thetag) == r2*w2*sind(90+theta22)+r3*w3*sind(90+theta32));
        sola = solve([eqn1a,eqn2a],[w3,Vb]);
        w31 = sola.w3;
        Vb1 = sola.Vb;     
        w31b = double(w31);
        Vb1b = double(Vb1);

        %ab= abat+aban+aat+aan
        Aatx2 = r2*alfa2*cosd(90+theta22);
        Aaty2 = r2*alfa2*sind(90+theta22); 
        Aanx2 = r2*((w2)^2)*cosd(180 + theta22);
        Aany2 = r2*((w2)^2)*sind(180 + theta22);
        syms Ab alfa3
        Abanx1 = r3*((w31b)^2)*cosd(180 + theta32);
        Abany1 = r3*((w31b)^2)*sind(180 + theta32);
        eqn1b = (Ab*cosd(thetag) - Abanx1 - r3*alfa3*cosd(90+theta32) == Aanx2 + Aatx2);
        eqn2b = (Ab*sind(thetag) - Abany1 - r3*alfa3*sind(90+theta32) == Aany2 + Aaty2);
        solb = solve([eqn1b,eqn2b],[Ab,alfa3]);
        Ab1 = solb.Ab;
        alfa31 = solb.alfa3;        
        alfa_31b = double(alfa31);
        Ab1b = double(Ab1);

        subplot(2,2,1)
        hold on;
        plot([theta2 theta22], [theta31 theta32],'-r', 'LineWidth',1);
        
        title(' Coupler rotation ')
        xlabel('\theta2')
        ylabel('\theta3')
        grid on;hold off;
        subplot(2,2,2)
        hold on;
        plot([theta2 theta22], [r1a r1b], '-r', 'LineWidth',1);
       
        
        title(' Slider displacement ')
        xlabel('\theta2')
        ylabel('Displacement')
        grid on
        hold off;
        subplot(2,2,3)
        hold on;
        plot([theta2 theta22], [w31a w31b],'-r', 'LineWidth',1);
        
        title(' Coupler angular speed ')
        xlabel('\theta2')
        ylabel('w3')
        grid on;hold off;
        subplot(2,2,4)
        hold on;
        plot([theta2 theta22], [alfa_31 alfa_31b], '-r', 'LineWidth',1);
       
        title(' coupler angular acceleration ')
        xlabel('\theta2')
        ylabel('alfa 3')
        grid on
        hold off;   
        theta31=theta32;
        theta2=theta22;
        r1a=r1b;
        w31a = w31b;
        Vb1a =Vb1b;
        alfa_31 = alfa_31b;
        Ab1 = Ab1b;
        w2=sqrt(w2^2+2*alfa2*1);
        end
    end
end









