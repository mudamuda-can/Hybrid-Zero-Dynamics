function [] = poincare()
    import autogen_func.swing_model
    import autogen_func.impact_model
    
    import autogen_func.controller_ctl
    
    swing_phase_model = @(q1,q2,q3,dq1,dq2,dq3,u1,u2) swing_model(q1,q2,q3,dq1,dq2,dq3,u1,u2); 
    simple_controller = @(q1,q2,q3,dq1,dq2,dq3) controller_ctl(q1,q2,q3,dq1,dq2,dq3);

    i = @(a) [pi/8, -pi/8, pi/6, a, -a, 0];
    
    dq1 = 1:0.1:7;
    
    rho = repelem(Inf, size(dq1, 2));
    for index = 1:size(dq1, 2)
        x_minus = i(dq1(index));
        xm_cell = num2cell(x_minus);
        x_plus = impact_model(xm_cell{:});

        options = odeset('Events', @eventsfn);
        [t, y, te, ye, ie] = ode45(@(t, y) odefunc(t, y), [0, Inf], x_plus, options);
        dtheta = ye(1,4);
        for idx = 1:15
            if ie ~= 1
                break
            end
            xm_cell = num2cell(y(end,:));
            x_plus = impact_model(xm_cell{:});
            [~, y, ~, ye, ie] = ode45(@(t, y) odefunc(t, y), [0, 3], x_plus, options);
        end
        if ie == 1
            rho(index) = dtheta;
        end
    end
    plot(dq1, rho, 'LineWidth', 3);
    hold on;
    grid on;
    plot(dq1, dq1, 'LineWidth', 1);
    xlabel('$\dot{\theta_1}^{-}$','Interpreter','latex')
    ylabel('$\rho(\dot{\theta_1}^{-})$','Interpreter','latex')
    title('Poincare map')

    function [dx] = odefunc(~, x)
        u = simple_controller(x(1), x(2), x(3), x(4), x(5), x(6));
        dx = swing_phase_model(x(1), x(2), x(3), x(4), x(5), x(6), u(1), u(2));
    end

    function [value, isterminal, direction] = eventsfn(~, y)
        value = [y(1) > pi/8, abs(y(1)) > pi/2 || abs(y(2)) > pi/2];
        isterminal = [1, 1];
        direction  = [0, 0];
    end
end