function state_derivative = motion_eqns(t, state)
    % Extract state variables
    x = state(1);
    y = state(2);
    z = state(3);
    vx = state(4);
    vy = state(5);
    vz = state(6);

    

    % Use the Earth class
    R_Earth = 6371e3;     % Radius of the Earth (km)
    GM = 3.986004418e14;  % m^3 s^(-2)
    earth = Earth(R_Earth, GM); 


    % Compute vectors v and r based on time t
    v = [vx, vy, vz];
    r = [x, y, z];

    % Compute density at a given altitude 
    rho = earth.density(r);

    % Compute ballistic coefficient 
    Cb = 50; 

    % Compute derivatives
    dvdt = -GM * r / norm(r)^3 - 0.5 * rho * Cb * norm(v)^2 * v;
    drdt = v;

    % Create the state derivative vector
    state_derivative = [drdt'; dvdt'];
end


