function make_shaded_state_percentages_plot(t, sleep_stateAW_sim, sleep_stateRW_sim, sleep_state_percentages_expAW, sleep_state_percentages_expRW)
    # Makes one gigantic figure showing shaded plots of sleep state: 2 for experimental data (AW and RW) and 
    # 2 for simulation output (AW and RW).  
    #
    # INPUTS:  t:  a vector representing time points
    #          sleep_stateAW_sim:  a MxN matrix of chars where M is the number of time steps and N is the number of simulations
    #          sleep_stateRW_sim:  a MxN matrix of chars where M is the number of time steps and N is the number of simulations
    #          sleep_state_percentages_expAW: a Dict containing two fields: "labels" and "data". "labels" has 3 elements and "data" is a 3x67 matrix of numbers
    #          sleep_state_percentages_expRW: a Dict containing two fields: "labels" and "data". "labels" has 3 elements and "data" is a 3x67 matrix of numbers

    

    # Parameters for appearance of panels
    panel_label_fontsize   = 18
    axFontSize             = 6
    axlinewidth            = 2
    linewidth              = 1.5
    title_fontsize         = 12
    text_fontsize          = 12
    exp_sim_label_fontsize = 14

    window_length_in_hours = 2  # Janne uses 2 hour windows in the figure in the paper

    window_length_in_elements = findfirst(x -> abs(x - window_length_in_hours) < 1e-15, t)
    window_times = collect(round(Int,t[ceil(Int, window_length_in_elements/2)]):window_length_in_hours:t[end-ceil(Int, window_length_in_elements/2)])
    
    sleep_dep_start_stop_timesAW = [38, 46, 62, 70, 86, 94, 110, 118]
    sleep_dep_start_stop_timesRW = [26, 34, 50, 58, 74, 82, 98, 106]

    sleep_dep_start_timesAW = sleep_dep_start_stop_timesAW[1:2:end-1]
    sleep_dep_end_timesAW   = sleep_dep_start_stop_timesAW[2:2:end]
    sleep_dep_start_timesRW = sleep_dep_start_stop_timesRW[1:2:end-1]
    sleep_dep_end_timesRW   = sleep_dep_start_stop_timesRW[2:2:end]

    # Set up the plot layout
    # Using default margin without mm units to avoid dependency on Unitful
    #fig = plot(layout = (3, 2), size = (1094, 700), margin = 10)
    
    # ------ AW EXPERIMENTAL DATA -----------------------------------------------------------------------------------
    W_row = findfirst(x -> x == "WAKE", sleep_state_percentages_expAW["labels"])
    S_row = findfirst(x -> x == "SWS", sleep_state_percentages_expAW["labels"])
    R_row = findfirst(x -> x == "REMS", sleep_state_percentages_expAW["labels"])

    wake_percentage_meansAW_exp = sleep_state_percentages_expAW["data"][W_row[1], :] ./ 100
    SWS_percentage_meansAW_exp = sleep_state_percentages_expAW["data"][S_row[1], :] ./ 100
    REM_percentage_meansAW_exp = sleep_state_percentages_expAW["data"][R_row[1], :] ./ 100

    # Plot AW experimental data in the first panel
    #p1 = subplot(3, 2, 1)
    
    # Create stacked area plot using fillrange
    rem  = REM_percentage_meansAW_exp[1:length(window_times)]
    sws  = SWS_percentage_meansAW_exp[1:length(window_times)]
    wake = wake_percentage_meansAW_exp[1:length(window_times)]
    
    # Plot layers from bottom to top
    p1=plot(window_times, rem, fillrange=0, fillalpha=1.0, linewidth=0, 
          color=RGB(0.2863, 0, 0.5725), label=false)
    plot!(p1, window_times, rem .+ sws, fillrange=rem, fillalpha=1.0, linewidth=0, 
          color=RGB(0.4275, 0.7137, 1), label=false)
    plot!(p1, window_times, rem .+ sws .+ wake, fillrange=rem .+ sws, fillalpha=1.0, linewidth=0, 
          color=RGB(0.8588, 0.4275, 0), label=false)
    
    # Add sleep deprivation rectangles
    # for i in 1:length(sleep_dep_start_timesAW)
    #     plot!(p1, [sleep_dep_start_timesAW[i], sleep_dep_end_timesAW[i]], [0, 0], [1, 1], 
    #           seriestype=:shape, color=RGB(0.5725, 0.2863, 0), alpha=0.7, linewidth=0)
    # end
    
    # # Add light/dark cycle rectangles
    # for i in 0:12:120
    #     if i % 24 == 0
    #         color = RGB(1, 1, 0)  # yellow for light
    #     else
    #         color = RGB(0, 0, 0)  # black for dark
    #     end
    #     plot!(p1, [i, i+12], [1, 1], [1.1, 1.1], seriestype=:shape, 
    #           color=color, linewidth=0,legend=false)
    # end
    
    # Format plot
    # yticks!(p1, 0:0.2:1, ["0%", "20%", "40%", "60%", "80%", "100%"])
    # xticks!(p1, 0:24:t[end])
    xlims!(p1, 0, 140)
    ylims!(p1, 0, 1.1)
    ylabel!(p1, "% of total time", fontsize=axFontSize)
    
    # Add baseline/day labels
    day_labels = ["Baseline", "Day1", "Day2", "Day3", "Day4"]
    day_positions = [8.5, 34, 58, 82, 106]
    # for (pos, label) in zip(day_positions, day_labels)
    #     annotate!(p1, pos, -0.15, text(label, text_fontsize))
    # end
    
    # Add "experimental data" label
    #annotate!(p1, 136, 0.5, text("Experimental Data", exp_sim_label_fontsize))
    #annotate!(p1, -14, 1.3, text("A", panel_label_fontsize))
    
    # ------ RW EXPERIMENTAL DATA -----------------------------------------------------------------------------------
    W_row = findfirst(x -> x == "WAKE", sleep_state_percentages_expRW["labels"])
    S_row = findfirst(x -> x == "SWS", sleep_state_percentages_expRW["labels"])
    R_row = findfirst(x -> x == "REMS", sleep_state_percentages_expRW["labels"])

    wake_percentage_meansRW_exp = sleep_state_percentages_expRW["data"][W_row[1], :] ./ 100
    SWS_percentage_meansRW_exp = sleep_state_percentages_expRW["data"][S_row[1], :] ./ 100
    REM_percentage_meansRW_exp = sleep_state_percentages_expRW["data"][R_row[1], :] ./ 100
    RW_length = length(wake_percentage_meansRW_exp)

    # Plot RW experimental data in the third panel
    #p2 = subplot(3, 2, 3)
    
    # Create stacked area plot using fillrange
    rem = REM_percentage_meansRW_exp
    sws = SWS_percentage_meansRW_exp
    wake = wake_percentage_meansRW_exp
    
    # Plot layers from bottom to top
    p2=plot(window_times[1:RW_length], rem, fillrange=0, fillalpha=1.0, linewidth=0, 
          color=RGB(0.2863, 0, 0.5725), label=false)
    plot!(p2, window_times[1:RW_length], rem .+ sws, fillrange=rem, fillalpha=1.0, linewidth=0, 
          color=RGB(0.4275, 0.7137, 1), label=false)
    plot!(p2, window_times[1:RW_length], rem .+ sws .+ wake, fillrange=rem .+ sws, fillalpha=1.0, linewidth=0, 
          color=RGB(0.8588, 0.4275, 0), label=false)
    
    # Add sleep deprivation rectangles
    # for i in 1:length(sleep_dep_start_timesRW)
    #     plot!(p2, [sleep_dep_start_timesRW[i], sleep_dep_end_timesRW[i]], [0, 0], [1, 1], 
    #           seriestype=:shape, color=RGB(0.5725, 0.2863, 0), alpha=0.7, linewidth=0,label=false)
    # end
    
    # # Add light/dark cycle rectangles
    # for i in 0:12:120
    #     if i % 24 == 0
    #         color = RGB(1, 1, 0)  # yellow for light
    #     else
    #         color = RGB(0, 0, 0)  # black for dark
    #     end
    #     plot!(p2, [i, i+12], [1, 1], [1.1, 1.1], seriestype=:shape, 
    #           color=color, linewidth=0,label=false)
    # end
    
    # Format plot
    # yticks!(p2, 0:0.2:1, ["0%", "20%", "40%", "60%", "80%", "100%"])
    # xticks!(p2, 0:24:t[end])
    xlims!(p2, 0, 140)
    ylims!(p2, 0, 1.1)
    ylabel!(p2, "% of total time", fontsize=axFontSize)
    
    # Add baseline/day labels
    # for (pos, label) in zip(day_positions, day_labels)
    #     annotate!(p2, pos, -0.15, text(label, text_fontsize))
    # end
    
    # # Add "experimental data" label
    # annotate!(p2, 136, 0.5, text("Experimental Data", exp_sim_label_fontsize))
    # annotate!(p2, -14, 1.3, text("B", panel_label_fontsize))
    
    # -------- AW SIMULATION OUTPUT ----------------------------------------------------------------------
    num_windows = 0
    for i in 1:window_length_in_elements:length(t)-window_length_in_elements
        num_windows += 1
    end
    
    # Initialize matrices with proper dimensions
    wake_percentageAW_sim = zeros(size(sleep_stateAW_sim, 2), num_windows)
    SWS_percentageAW_sim = zeros(size(sleep_stateAW_sim, 2), num_windows)
    REM_percentageAW_sim = zeros(size(sleep_stateAW_sim, 2), num_windows)
    
    for j in 1:size(sleep_stateAW_sim, 2)
        index = 1
        for i in 1:window_length_in_elements:length(t)-window_length_in_elements
            window_indices = i:i+window_length_in_elements-1
            wake_percentageAW_sim[j, index] = count(c -> c == 'W', sleep_stateAW_sim[window_indices, j]) / window_length_in_elements
            SWS_percentageAW_sim[j, index] = count(c -> c == 'S', sleep_stateAW_sim[window_indices, j]) / window_length_in_elements
            REM_percentageAW_sim[j, index] = count(c -> c == 'R', sleep_stateAW_sim[window_indices, j]) / window_length_in_elements
            index += 1
        end
    end
    
    
    
    
    # Average over the trials
    wake_percentage_meansAW_sim = mean(wake_percentageAW_sim, dims=1)[:]
    SWS_percentage_meansAW_sim = mean(SWS_percentageAW_sim, dims=1)[:]
    REM_percentage_meansAW_sim = mean(REM_percentageAW_sim, dims=1)[:]
    
    # Plot AW simulation data
    #p3 = subplot(3, 2, 2)
    
    # Create stacked area plot using fillrange
    rem = REM_percentage_meansAW_sim
    sws = SWS_percentage_meansAW_sim
    wake = wake_percentage_meansAW_sim
    
    # Plot layers from bottom to top
    p3=plot(window_times, rem, fillrange=0, fillalpha=1.0, linewidth=0, 
          color=RGB(0.2863, 0, 0.5725), label="REMS")
    plot!(p3, window_times, rem .+ sws, fillrange=rem, fillalpha=1.0, linewidth=0, 
          color=RGB(0.4275, 0.7137, 1), label="SWS")
    plot!(p3, window_times, rem .+ sws .+ wake, fillrange=rem .+ sws, fillalpha=1.0, linewidth=0, 
          color=RGB(0.8588, 0.4275, 0), label="Wake")
          
    # Add legend below the plot
    #plot!(p3, legend=:outerright)
    
    # Add sleep deprivation rectangles
    # for i in 1:length(sleep_dep_start_timesAW)
    #     plot!(p3, [sleep_dep_start_timesAW[i], sleep_dep_end_timesAW[i]], [0, 0], [1, 1], 
    #           seriestype=:shape, color=RGB(0.5725, 0.2863, 0), alpha=0.7, linewidth=0,label=false)
    # end
    
    # # Add light/dark cycle rectangles
    # for i in 0:12:120
    #     if i % 24 == 0
    #         color = RGB(1, 1, 0)  # yellow for light
    #     else
    #         color = RGB(0, 0, 0)  # black for dark
    #     end
    #     plot!(p3, [i, i+12], [1, 1], [1.1, 1.1], seriestype=:shape, 
    #           color=color, linewidth=0,label=false)
    # end
    
    # Format plot
    # yticks!(p3, 0:0.2:1, ["0%", "20%", "40%", "60%", "80%", "100%"])
    # xticks!(p3, 0:24:t[end])
    xlims!(p3, 0, 140)
    ylims!(p3, 0, 1.1)
    ylabel!(p3, "% of total time", fontsize=axFontSize)
    
    # Add baseline/day labels
    # for (pos, label) in zip(day_positions, day_labels)
    #     annotate!(p3, pos, -0.15, text(label, text_fontsize))
    # end
    
    # Add legend
    #plot!(p3, label=["REMS" "SWS" "Wake"])
    
    # Add "simulation output" label
    #annotate!(p3, 136, 0.5, text("Simulation Output", exp_sim_label_fontsize))
    
    # -------- RW SIMULATION OUTPUT ----------------------------------------------------------------------
    num_windows = 0
    for i in 1:window_length_in_elements:length(t)-window_length_in_elements
        num_windows += 1
    end
    
    # Initialize matrices with proper dimensions
    wake_percentageRW_sim = zeros(size(sleep_stateRW_sim, 2), num_windows)
    SWS_percentageRW_sim = zeros(size(sleep_stateRW_sim, 2), num_windows)
    REM_percentageRW_sim = zeros(size(sleep_stateRW_sim, 2), num_windows)
    
    for j in 1:size(sleep_stateRW_sim, 2)
        index = 1
        for i in 1:window_length_in_elements:length(t)-window_length_in_elements
            window_indices = i:i+window_length_in_elements-1
            wake_percentageRW_sim[j, index] = count(c -> c == 'W', sleep_stateRW_sim[window_indices, j]) / window_length_in_elements
            SWS_percentageRW_sim[j, index] = count(c -> c == 'S', sleep_stateRW_sim[window_indices, j]) / window_length_in_elements
            REM_percentageRW_sim[j, index] = count(c -> c == 'R', sleep_stateRW_sim[window_indices, j]) / window_length_in_elements
            index += 1
        end
    end

    # wake_percentageRW_sim = zeros(0, size(sleep_stateRW_sim, 2))
    # SWS_percentageRW_sim = zeros(0, size(sleep_stateRW_sim, 2))
    # REM_percentageRW_sim = zeros(0, size(sleep_stateRW_sim, 2))
    
    # for j in 1:size(sleep_stateRW_sim, 2)
    #     index = 1
    #     w_temp = []
    #     s_temp = []
    #     r_temp = []
    #     for i in 1:window_length_in_elements:length(t)-window_length_in_elements
    #         window_indices = i:i+window_length_in_elements-1
    #         push!(w_temp, count(c -> c == 'W', sleep_stateRW_sim[window_indices, j]) / window_length_in_elements)
    #         push!(s_temp, count(c -> c == 'S', sleep_stateRW_sim[window_indices, j]) / window_length_in_elements)
    #         push!(r_temp, count(c -> c == 'R', sleep_stateRW_sim[window_indices, j]) / window_length_in_elements)
    #         index += 1
    #     end
    #     wake_percentageRW_sim = vcat(wake_percentageRW_sim, permutedims(w_temp))
    #     SWS_percentageRW_sim = vcat(SWS_percentageRW_sim, permutedims(s_temp))
    #     REM_percentageRW_sim = vcat(REM_percentageRW_sim, permutedims(r_temp))
    # end
    
    # Average over the trials
    wake_percentage_meansRW_sim = mean(wake_percentageRW_sim, dims=1)[:]
    SWS_percentage_meansRW_sim = mean(SWS_percentageRW_sim, dims=1)[:]
    REM_percentage_meansRW_sim = mean(REM_percentageRW_sim, dims=1)[:]
    
    # Plot RW simulation data
    #p4 = subplot(3, 2, 4)
    
    # Create stacked area plot using fillrange
    rem = REM_percentage_meansRW_sim
    sws = SWS_percentage_meansRW_sim
    wake = wake_percentage_meansRW_sim
    
    # Plot layers from bottom to top
    p4=plot(window_times, rem, fillrange=0, fillalpha=1.0, linewidth=0, 
          color=RGB(0.2863, 0, 0.5725), label=false)
    plot!(p4, window_times, rem .+ sws, fillrange=rem, fillalpha=1.0, linewidth=0, 
          color=RGB(0.4275, 0.7137, 1), label=false)
    plot!(p4, window_times, rem .+ sws .+ wake, fillrange=rem .+ sws, fillalpha=1.0, linewidth=0, 
          color=RGB(0.8588, 0.4275, 0), label=false)
    
    # Add sleep deprivation rectangles
    # for i in 1:length(sleep_dep_start_timesRW)
    #     plot!(p4, [sleep_dep_start_timesRW[i], sleep_dep_end_timesRW[i]], [0, 0], [1, 1], 
    #           seriestype=:shape, color=RGB(0.5725, 0.2863, 0), alpha=0.7, linewidth=0,label=false)
    # end
    
    # # Add light/dark cycle rectangles
    # for i in 0:12:120
    #     if i % 24 == 0
    #         color = RGB(1, 1, 0)  # yellow for light
    #     else
    #         color = RGB(0, 0, 0)  # black for dark
    #     end
    #     plot!(p4, [i, i+12], [1, 1], [1.1, 1.1], seriestype=:shape, 
    #           color=color, linewidth=0,label=false)
    # end
    
    # Format plot
    # yticks!(p4, 0:0.2:1, ["0%", "20%", "40%", "60%", "80%", "100%"])
    # xticks!(p4, 0:24:t[end])
    xlims!(p4, 0, 140)
    ylims!(p4, 0, 1.1)
    ylabel!(p4, "% of total time", fontsize=axFontSize)
    xlabel!(p4,"Time (hours)",fontsize=axFontSize)
    
    # Add baseline/day labels
    # for (pos, label) in zip(day_positions, day_labels)
    #     annotate!(p4, pos, -0.15, text(label, text_fontsize))
    # end
    
    # Add "simulation output" label
    #annotate!(p4, 136, 0.5, text("Simulation Output", exp_sim_label_fontsize))
    
    # put all of the plots together
    #plot(p1, p3, p2, p4, layout = grid(4, 1, heights=[0.25 ,0.25, 0.25, 0.25]))
    
    # display(p1)
    # display(p2)
    # display(p3)
    # display(p4)
    # Delete empty subplots
    # plot!(subplot=5, framestyle=:none, axis=nothing, grid=false)
    # plot!(subplot=6, framestyle=:none, axis=nothing, grid=false)
    
    return p1, p2, p3, p4
end
