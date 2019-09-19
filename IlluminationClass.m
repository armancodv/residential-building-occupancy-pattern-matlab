classdef IlluminationClass
    properties
        e_v = 150; % average luminance level for residential building (lux)
        k_i = 92.200; % luminance efficacy in workplane (lum/W)
        % area = floor area of building
        % n_oc = number of occupants
        % n_ro = number of rooms
        
        p = 0;
        schedule = zeros(7,1);

        p_h = zeros(1,1);
        

    end
    
    methods
        function illumination = init(illumination, occupancy_light, t_length, area, n_oc, n_ro)
            illumination.p_h = zeros(1,t_length);
            illumination.schedule = zeros(7,t_length);
            for d=1:7
                for i=1:t_length
                    if(occupancy_light(d,i))
                        illumination.schedule(d,i) = 1;
                    end
                end
            end
            illumination.p = illumination.calculate_power(area,n_oc,n_ro);
        end
        function illumination = solve(illumination, i, h_array, d)
            h = ceil(h_array(i));
            illumination.p_h(i) = illumination.p * illumination.schedule(d,h);
        end
        function pow = calculate_power(illumination,A,n_oc,n_ro)
            pow = (illumination.e_v/illumination.k_i)*A*(n_oc/n_ro);
        end
    end
end

