function two_process_model_with_markov_chain(total_time, input_params, shift, makeplots=false)
    # USAGE: two_process_model_with_markov_chain(total_time, input_params, shift, makeplots)
    #
    # This function simulates the changes in sleep state using a markov chain model similar to Kemp and Kamphuisen SLEEP 1986
    # The markov chain generates sleep states based on the values of the ahat terms that derive their values
    # from the level of the homeostat and the Circadian curve.  The homeostat goes up with time constant taui when the 
    # sleep state is W or R and goes down with time constant taud when the sleep state is S.
    
    
    # Extract parameters from input struct
    taui_baseline = input_params[:taui_baseline]
    taud_baseline = input_params[:taud_baseline]
    taui_work     = input_params[:taui_work]
    taud_work     = input_params[:taud_work]
    
    alertness_duration_scale_factor_B       = input_params[:alertness_duration_scale_factor_B]
    sleepiness_duration_scale_factor_SWS_B  = input_params[:sleepiness_duration_scale_factor_SWS_B]
    sleepiness_duration_scale_factor_REMS_B = input_params[:sleepiness_duration_scale_factor_REMS_B]
    alertness_duration_scale_factor_W       = input_params[:alertness_duration_scale_factor_W]
    sleepiness_duration_scale_factor_SWS_W  = input_params[:sleepiness_duration_scale_factor_SWS_W]
    sleepiness_duration_scale_factor_REMS_W = input_params[:sleepiness_duration_scale_factor_REMS_W]
    
    # Set up the time vector (with increments of 10 seconds)
    t        = 0:10/60/60:total_time
    dt       = 10/60/60
    phase    = mod.(t, 24)
    num_days = total_time / 24
    
    # Set up the sleep deprivation, if applied
    if shift == "AW"
        sleep_dep_start_stop_times = [38, 46, 62, 70, 86, 94, 110, 118]
    elseif shift == "RW"
        sleep_dep_start_stop_times = [26, 34, 50, 58, 74, 82, 98, 106]
    else
        sleep_dep_start_stop_times = Float64[]
    end
    
    sleep_dep = zeros(length(t))
    
    if !isempty(sleep_dep_start_stop_times)
        if length(sleep_dep_start_stop_times) % 2 != 0
            error("sleep_dep_start_stop_times must have an even number of elements")
        end
        
        sleep_dep_start_times = sleep_dep_start_stop_times[1:2:end-1]
        sleep_dep_end_times = sleep_dep_start_stop_times[2:2:end]
        
        for i in 1:length(sleep_dep_start_times)
            ind_sleep_dep_start = findall(x -> abs(x - sleep_dep_start_times[i]) < 1e-6, t)
            ind_sleep_dep_end   = findall(x -> abs(x - sleep_dep_end_times[i])   < 1e-6, t)
            sleep_dep[ind_sleep_dep_start[1]:ind_sleep_dep_end[1]] .= 1
        end
    end
    
    # Circadian curve
    circ_amp   = 0.25
    circ_curve = circ_amp * sin.((π/12) .* -t)
    C          = circ_curve
    
    num_simulations = 50  # was 100
    
    # Initialize S, state and C
    state    = fill('S', (length(t), num_simulations))  # initialize all states to 'S'
    S        = zeros(length(t), num_simulations)
    S[1, :] .= 0.3  # starting value for S, the homeostat
    
    # Set up the random variables in a power law for W episode duration
    # Define distributions for duration modeling
    pd_w = GeneralizedPareto(0.231707, 217.976, 1)  # k, sigma, theta
    pd_s = nothing  # Julia doesn't have a direct Burr distribution
    pd_r = nothing  # We'll implement a custom sampler for these
    
    # Custom samplers for Burr distribution
    function random_burr_s()
        # Burr distribution parameters: alpha=177.113, c=4.10314, k=1.48324
        u = rand()
        return 177.113 * ((1 - u)^(-1/1.48324) - 1)^(1/4.10314)
    end
    
    function random_burr_r()
        # Burr distribution parameters: alpha=172.817, c=2.629, k=4.75
        u = rand()
        return 172.817 * ((1 - u)^(-1/4.75) - 1)^(1/2.629)
    end
    
    # Initialize time-dependent parameters
    taui = fill(taui_baseline, length(t))
    taud = fill(taud_baseline, length(t))
    alertness_duration_scale_factor       = ones(length(t))
    sleepiness_duration_scale_factor_SWS  = ones(length(t))
    sleepiness_duration_scale_factor_REMS = ones(length(t))
    
    # Set parameter transitions at 8640 time points (day transition)
    taui[1:8640]   .= taui_baseline
    taui[8641:end] .= taui_work
    taud[1:8640]   .= taud_baseline
    taud[8641:end] .= taud_work
    
    alertness_duration_scale_factor[1:8640]         .= alertness_duration_scale_factor_B
    alertness_duration_scale_factor[8641:end]       .= alertness_duration_scale_factor_W
    sleepiness_duration_scale_factor_SWS[1:8640]    .= sleepiness_duration_scale_factor_SWS_B
    sleepiness_duration_scale_factor_SWS[8641:end]  .= sleepiness_duration_scale_factor_SWS_W
    sleepiness_duration_scale_factor_REMS[1:8640]   .= sleepiness_duration_scale_factor_REMS_B
    sleepiness_duration_scale_factor_REMS[8641:end] .= sleepiness_duration_scale_factor_REMS_W
    
    long_wake_episode_timings = zeros(length(t))
    long_wake_counter         = zeros(num_simulations)
    
    # Run the MC simulation for several different runs
    for run in 1:num_simulations
        num_R_runs = 0
        i = 1
        long_wake_counter[run] = 0
        run_long_wake_episode_timings = zeros(length(t))
        
        while i < length(t)
            sleepiness = S[i, run] - C[i]
            alertness = 1 - S[i, run] + C[i]
            
            if state[i, run] == 'W'
                # Handle 'W' state transitions
                # Rare long wake episode possibility
                if alertness > (8-0.5)*rand() + 0.5
                    W_SW = round(Int, (180-30)*rand() + 30)  # Uniform random between 30 and 180 epochs
                    Wshortest_epochs = W_SW
                    
                    if i + Wshortest_epochs > length(t)
                        Wshortest_epochs = length(t) - i
                    end
                    
                    next_state = 'S'
                    if i + 1 <= length(t) && i + W_SW <= length(t)
                        state[i+1:i+W_SW, run] .= 'W'
                    end
                    
                    if i + W_SW + 1 <= length(t)
                        state[i+W_SW+1, run] = 'S'
                    end
                    
                    for j in 1:min(W_SW, length(t) - i)
                        if i + j <= length(t)
                            S[i+j, run] = 1 - (1 - S[i+j-1, run]) * exp(-dt / taui[i])
                        end
                    end
                    
                    long_wake_counter[run] += 1
                    run_long_wake_episode_timings[i] = 1
                else
                    # Normal Markov chain
                    if rand() < 0.135 * sleepiness - 0.0135
                        next_state = 'R'  # Go to REMS
                    else
                        next_state = 'S'
                    end
                    
                    # Generate duration from generalized Pareto distribution and scale it
                    Wshortest_epochs = round(Int, (rand(pd_w) / 10) * alertness_duration_scale_factor[i] * (alertness + 0.3) - 1)
                    
                    if Wshortest_epochs <= 0
                        Wshortest_epochs = 1
                    end
                    
                    if i + Wshortest_epochs > length(t)
                        Wshortest_epochs = length(t) - i
                    end
                    
                    # Set the states and update the homeostat
                    if i + 1 <= length(t) && i + Wshortest_epochs <= length(t)
                        state[i+1:i+Wshortest_epochs, run] .= 'W'
                    end
                    
                    if i + Wshortest_epochs + 1 <= length(t)
                        state[i+Wshortest_epochs+1, run] = next_state
                    end
                    
                    for j in 1:min(Wshortest_epochs, length(t) - i)
                        if i + j <= length(t)
                            S[i+j, run] = 1 - (1 - S[i+j-1, run]) * exp(-dt / taui[i])
                        end
                    end
                end
                
            elseif state[i, run] == 'S'
                # Handle 'S' state transitions
                if rand() < -0.007 * phase[i] + 0.51
                    next_state = 'R'  # Go to REMS
                else
                    next_state = 'W'
                end
                
                # Use custom sampler for Burr distribution
                Wshortest_epochs = round(Int, (random_burr_s() / 10) * sleepiness_duration_scale_factor_SWS[i] * (sleepiness + 0.7) - 1)
                
                if Wshortest_epochs <= 0
                    Wshortest_epochs = 1
                end
                
                if i + Wshortest_epochs > length(t)
                    Wshortest_epochs = length(t) - i
                end
                
                # Set the states and update the homeostat
                if i + 1 <= length(t) && i + Wshortest_epochs <= length(t)
                    state[i+1:i+Wshortest_epochs, run] .= 'S'
                end
                
                if i + Wshortest_epochs + 1 <= length(t)
                    state[i+Wshortest_epochs+1, run] = next_state
                end
                
                for j in 1:min(Wshortest_epochs, length(t) - i)
                    if i + j <= length(t)
                        S[i+j, run] = S[i+j-1, run] * exp(-dt / taud[i])
                    end
                end
                
            elseif state[i, run] == 'R'
                # Handle 'R' state transitions
                num_R_runs += 1
                
                if rand() < 0.5  # R is equally likely to go to W or S
                    next_state = 'W'
                else
                    next_state = 'S'
                end
                
                # Use custom sampler for Burr distribution
                Wshortest_epochs = round(Int, (random_burr_r() / 10) * sleepiness_duration_scale_factor_REMS[i] * (sleepiness + 0.7) - 1)
                
                if Wshortest_epochs <= 0
                    Wshortest_epochs = 1
                end
                
                if i + Wshortest_epochs > length(t)
                    Wshortest_epochs = length(t) - i
                end
                
                # Set the states and update the homeostat
                if i + 1 <= length(t) && i + Wshortest_epochs <= length(t)
                    state[i+1:i+Wshortest_epochs, run] .= 'R'
                end
                
                if i + Wshortest_epochs + 1 <= length(t)
                    state[i+Wshortest_epochs+1, run] = next_state
                end
                
                for j in 1:min(Wshortest_epochs, length(t) - i)
                    if i + j <= length(t)
                        S[i+j, run] = 1 - (1 - S[i+j-1, run]) * exp(-dt / taui[i])
                    end
                end
            end
            
            # Update the next state after the episode
            if i + Wshortest_epochs + 1 <= length(t)
                if next_state == 'W' || next_state == 'R'
                    S[i+Wshortest_epochs+1, run] = 1 - (1 - S[i+Wshortest_epochs, run]) * exp(-dt / taui[i])
                else
                    S[i+Wshortest_epochs+1, run] = S[i+Wshortest_epochs, run] * exp(-dt / taud[i])
                end
            end
            
            # Override the Markov Chain sleep state if sleep deprivation is turned on
            if i + Wshortest_epochs + 1 < length(t)
                if sum(sleep_dep[i+1:i+Wshortest_epochs+1]) > 0
                    sleep_dep_locs_this_cycle = findall(x -> x > 0, sleep_dep[i+1:i+Wshortest_epochs+1])
                    for j in sleep_dep_locs_this_cycle
                        if i + j <= length(t)
                            state[i+j, run] = 'W'
                            if i + j - 1 <= length(t)
                                S[i+j, run] = 1 - (1 - S[i+j-1, run]) * exp(-dt / taui[i])
                            end
                        end
                    end
                end
            end
            
            # Update sleepiness and alertness values
            for j in 1:min(Wshortest_epochs, length(t) - i)
                if i + j <= length(t)
                    sleepiness = S[i+j, run] - C[min(i+j, length(C))]
                    alertness = 1 - S[i+j, run] + C[min(i, length(C))]
                end
            end
            
            i = i + Wshortest_epochs + 1
        end
        
        # Accumulate long wake episodes
        long_wake_episode_timings .+= run_long_wake_episode_timings
    end
    
    # Calculate sleep state percentages
    wake_percentage = [count(c -> c == 'W', state[:, j]) / size(state, 1) for j in 1:num_simulations]
    SWS_percentage  = [count(c -> c == 'S', state[:, j]) / size(state, 1) for j in 1:num_simulations]
    REM_percentage  = [count(c -> c == 'R', state[:, j]) / size(state, 1) for j in 1:num_simulations]
    
    av_wake_percentage = mean(wake_percentage)
    av_SWS_percentage  = mean(SWS_percentage)
    av_REM_percentage  = mean(REM_percentage)
    
    # In Julia, we'd replace the external function call with a local function
    # For this conversion, we'll create a placeholder that returns empty structs
    # You'll need to implement this function separately
    sleep_measure_averages = Dict()
    sleep_measure_stds     = Dict()
    
    # This would be a stub for the external function call in the original code
    # sleep_measure_averages, sleep_measure_stds = group_and_plot_Wepisodes_SWS_REMS_duration(shift, state, num_simulations, 0)
    
    # Visualization code (only if makeplots is true)
    # if makeplots
    #     # First make a shaded plot showing average trace of the homeostat
    #     if length(S) > length(t)
    #         S = S[1:length(t), :]
    #         tnew = t
    #         circ_curvenew = circ_curve
    #     else
    #         tnew = t
    #         circ_curvenew = circ_curve
    #     end
        
        # Plotting code would go here
        # This would need to be implemented using Julia's plotting libraries 
        # like Plots.jl, which has a different syntax than MATLAB.
        
        # In a full implementation, you would convert the MATLAB plotting code to Julia
    #end
    
    println("End of two_process_model_with_markov_chain")
    
    return S, state, long_wake_episode_timings, sleep_measure_averages, sleep_measure_stds
end

# This function would need to be implemented separately
# function group_and_plot_Wepisodes_SWS_REMS_duration(shift, state, num_simulations, makeplots)
#     # Placeholder function - you would need to implement this separately
#     sleep_measure_averages = Dict()
#     sleep_measure_stds = Dict()
    
#     return sleep_measure_averages, sleep_measure_stds
# end

# # This function would need to be implemented separately
# function make_shaded_state_percentages_plot(t, state, sleep_dep_start_stop_times)
#     # Placeholder function - you would need to implement this separately
# end
