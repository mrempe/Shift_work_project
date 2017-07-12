 # My Notes to self on shift work project


 # March 10, 2016
 I saved a number of papers that have to do with modeling shift work and the best one seems to be Postnova, Phillips et 
 al JBR 2012.  They use a model involving mutual inhibition between MA and VLPO and a circadian pacemaker that is entrained by light (St. Hilaire et al.).  This looks like exactly the kind of thing I need to do, but they model it in humans, not in rodents. 

 So, the first goal is to understand how (and if) two-process like models can be used for rodent polyphasic sleep and if my JMB model can be modified to work for rodents (and then to tell us something about shift work).

 I found a textbook today Principles and Practice of Sleep Medicine by Kryger, Roth and Dement and it talks about using the two-process model for rodent sleep (this text has its latest copyright of 2011 so it should be recent).  It says that Process C has yet to be incorporated in models of animal sleep.  Try to check out this book and look up references. 

 I talked with Janne:
   The experiments included 4 consecutive work shifts of 8 hours. She said the mice don't sleep at all during the work shift and are only awake 30% of the time during the light phase.  It may be possible to use a phenomenological model and assume that sleep and wake are consolidated.  She has (or can get) the following data:
        circadian
        cortisol (stress) for 4 work days
        gene expression for metabolic
        gene expression for immune
        gene expression for stress (HPA)  
  All gene expression is after the third work day.  

I read through the Postnova Phillips article and made some notes.  Some next steps: modify my model to get rid of REM/NREM dynamics (unless we have data on REM/NREM and we think it would be interesting) and think about how to do light/circadian.  I need to build the framework that we will modify to adjust for shift work. 
Should I code up the Postnova model to make sure I really understand it?  (XPP or MATLAB)

the big textbook says that light exposure can affect both C and S (Tobler et al Room light impairs sleep in the albino rat. Behav Brain Res 1994; Franken, Tobler, Borbely Varying photoperiod in the laboratory rat... Am J Physiol 1995 DeBoer and Tobler,Pflugers Arch 1997)  look these up.  

# Thursday, March 17, 2016
 I have been reading the manuscript and talking to Janne and Greg.  Some thoughts:  It sounds like no one has done the two process model on rodent data (see my comments above)

NO PROCESS C in rodent sleep models: The Neurobiology of Circadian Timing, copyright 2012, contains the following quote: "In both humans and rodents, the circadian process is not incorporated routinely in present-day modeling. There are, however, some indications that the circadian clock may influence sleep homeostatic time constants and that an effort should be made to incorporate circadian time as a variable in modeling sleep homeostasis. "


 Look up Diniz Behn papers for mouse sleep-wake behavior.  It may be relevant to the shift work stuff.  

 # Thursday, March 24, 2016
 Reading Cecilia's 2007 paper: she does not include a process C.
                               brief awakenings are explained without noise due to fixed points 
                               nudging a bit, but the sleep-active population doesn't turn off
                               during brief awakenings.

TO DO: figure out if our data show distinct differences between brief awakenings and non-brief awakenings. Same for sleep.  
        That will affect how I do the modeling. 
        - Re-read Andrew Phillips article about how two-process model and mutually inhibitory models are really the same 

thoughts: In Andrew's Mammalian Sleep Dynamics article, he shows how changing just two parameters in his model can yield results for a huge range of different mammalian sleep patterns.  I could try modifying these parameters in my model to see if I can get polyphasic sleep and then I can start modifying parameters to understand shift work.  He only fits two parameters: average daily sleep duration and average sleep episode length.   

Also, if I get my JMathBio model working for normal rodent sleep, it should be polyphasic, have the right percentages of each state (Figure 4 in shift work manuscript) and it should show nocturnal.  Phillips didn't mention anything about nocturnal or REM/NREM.  Once my model works pretty well on normal rodent data, I can see what I need to change to make it match shift work sleep.  

# Thursday, March 31, 2016
I can get "polyphasic" behaviour (more frequent transitions) out of my flip-flop code by simply changing the tau value for the rising of the homeostat.  This is similar to what Andrew shows.  However, the tau values we measured in Janne's mice shift work data are about a factor of 10 larger than what Andrew shows (3 or 4 instead of 0.3 to 0.4).  Using 0.4 gives more transitions, but it still doesn't look polyphasic to me. 

Another big issue:  Nocturnal vs. diurnal.  How to I get my model to be sleeping at the other circadian phase?  Or is their circadian curve just peaking at night rather than during the day. 

NOTES FROM TALK with Janne:  
Nocturnal:  rodents still sleep during the same phase of their circadian rythm.  It is just that their circadian rhythm is peaking during the dark while humans' peaks during the light.  The trough of rodent circadian is during the light, not during the dark. 

Rodents do the same type of sleep cycle as humans: NREM->REM with cycles lasting 10 minutes or so and several brief awakenings.  In matching model to data, Janne says to focus on timing of sleep episodes (length of sleep episodes), and it is OK to match average daily sleep duration and average sleep episode length (like Andrew Phillips does PLOS 2010), but also make sure sleep during the inactive phase is accurate.  

Figure 6 in the powerpoint showing Ti and Td differences between active phase workers and resting phase workers is a major thing I should reproduce in the model.  Both Ti and Td are higher in the resting phase workers than in the active phase workers. Can this explain the differences in sleep timing between the AW and RW groups?

The amplitude of the circadian curve changes after work for the RW group (figure that Hans made).  This is something that should be in the model:  does changing the circadian rhthym explain the longer-lasting changing in sleep timing?  

I am compiling a list of articles mentioned in Principles and Practice of Sleep Medicine with regard to the two-process model in rodents.  The first paper I'm trying to track down (Franken et al Neuroscience Letters 1991) is hard to find.  even at WSU. 



# Thursday, April 28, 2016
I met with Janne and Jonathan this morning.  We talked about the 5 state model vs. 3 state model for SWA.  We developed the 5 state model for lactate data, not SWA, so does it make sense to use it on SWA?  Does SWA really change during QW like it does during SWS?  Janne (and us) had difficulty interpreting the tau value data for the 5 state vs 3 state and active phase workers vs shift workers.  

Here is the big idea:  We are going to work on a separate manuscript to investigate this idea of the 5 state model vs. the 3-state model.  We will use the data from the shift work experiments.  Check residuals for the 5-state model and the 3-state model and vary the range used for the definition of SWA: 
1-4   2-4   3-4
1-5   2-5   3-5
1-6   2-6   3-6
1-7   2-7   3-7
1-8   2-8   3-8

optimize these individually for the active phase workers vs the resting phase workers.  
CODING:  two approaches:
1) modify my ProcessL code to allow me to define the range of frequencies to be used for finding the data to fit the model to.  Then write a script that calls it using the 5state model and the 3state model and varies the range of frequencies each time.  Do this for Active Phase workers and resting phase workers.  Output the residuals each time so I can plot them and compare between groups.  We want to say definitively that the 3state or 5state model is better, using a particular frequency range. 
2) modify my code to run Nelder-Mead to optimize not just taui and taud but also the choice of range for SWA.  This will be a separate branch of the code.  The issue is that it may choose a range that is way outside of the range that is reasonable.  

In both cases I am still only using two tau values:  one for rising (W, AW, REMS), and one for falling (SWS,QW).  

Some other thoughts:  I would like to understand what actually changes tau values and can they change with anything except genetics.  I could cook up some fake data (with noise) to see if, for instance, does shorter SWS episodes lead to faster tau values? (Set up data in a noisy exponential whose tau values I know and then remove some.  Do I see a change in tau?  The length of the SWS episode only matters in the sense of whether it is at least 5 min long or not.)  Does removing QW from the rising part of the homeostat necessarily make taui smaller?  We sometimes say these things to explain the data, but we don't really know.  

TO DO:
1) change signal to a struct that has fields .name and .freq_range.  Make .freq_range a two-element vector.  This will require changing code in PROCESSLBATCHMODE.m, DONE

2) Write code in ProcessLBatchMode.m to use signal.freq_range to find the correct columns in the .txt file to read into PhysioVars (then to construct the signal_data variable).
I started this today.  Keep going by changing lines 356 or so of ProcessLBatchmode.m to find the columns with frequencies that start or end with the requested frequencies in signal.freq_range.  


# Wednesday, June 1
I got back into coding and it looks like PROCESSLBATCHMODE is working with 1-4 Hz as the frequency range.  I should make sure that the output really matches what I had before.  It uses signal.freq_range and I cleaned up stuff related to PhysioVars.  
I'm using data from \\FS1\WisorData\Gronli\Night work, animal model\txt files\Work period\Baseline and workdays\txt files
Maybe test it with the non-GUI version of the code since I haven't updated that yet.  
I set up a little directory to test the old version and the new.  Most files look exactly the same, but 3 files look different: 4, 6 and 12.  It may be an issue of filtering.  There are some SWS episodes with large values of SWA that do not appear in the new version of the code, but do in the non-GUI version.  Check this. 


Tomorrow:  read section of textbook that I marked with post-it. READ. and I took notes.    Now read the chapter before.


# Thursday, June 2
I still can't figure out what is different between the two versions.  For file 6_AW_LD_Workday1.txt using my new version SWA goes up to 160 and in the nonGUI version it only goes up to 
1:07:  Now it works, it was some filtering I was doing in the GUI version and not the new version: exclude artifacts in EEG that were not marked as X, but are at least 3 SDs away from the mean for this animal.  I can always uncomment this code if I want.  

So at this point, PROCESSLBATCHMODE works as expected with 1-4 Hz as the frequency range.  I removed all references to PhysioVars.  

Keep checking using EEG2.  I found one bug, but I'm still not convinced EEG2 is working correctly. 
Soon start implementing it on the NOGUI version.  

NOTES FROM TALK WITH JANNE:
- Use EEG1 for all the shift work simulatons. 
- Hans believes that modeling won't tell us anything that wasn't already known (like from his paper in 2013 McCauley et. al. "Dynamic Circadian Modulation...")
  Janne doesn't think so.  She thinks there is a lot that modeling can do with regard to Active Wake and Quiet Wake.  The figure from the proposal showing SWE (slow wave energy) during quiet wake between AW and RW is pretty striking.  
- Janne will email me the location of the files I should use. 

# Friday, June 3
plan for today: 1) test PROCESSLBATCHMODE vs NOGUI using beta to make sure I am doing the frequency ranges correctly. 
                SEEMS TO WORK. I COMPUTED AVERAGES IN EXCEL AVERAGES AND   COMPARED.   
                1a) ReCheck the calculation of UA and LA.  UA doesn't seem high enough. I THINK THERE ARE LARGE TAILS SOMETIMES. 90TH PERCENTILE IS MUCH LOWER THAN MAX VALUE.  FOR NOW I WILL STICK WITH IT AS IS SINCE THIS IS WHAT FRANKEN DID.    
                2) copy NOGUI to NOGUI_BACKUP and make the same changes to NOGUI that I made to PROCESSLBATCHMODE.  DONE
                3) write the script to call NOGUI for all the different freq. ranges.  Set up a vector of strings: ['1-4' '2-5' ] etc.  That way it will 
                be easy to change which frequency ranges we use  DONE.  it is called FiveStateVsThreeStateScript.m Run this over the weekend
                3a) write another script to plot the data.  DONE and TESTED
                4) Re-read the McCauley paper from 2013
                5) Finish my profile for the SPRC website


# Monday, June 6
Notes from talk with Janne:  things to check:
1) Is Find_all_SWS_episodes.m using the custom frequency range for SWA?  YES (checked)
2)  What is L?  It seems like the model should be going down lower.  Understand why Franken computed L the way he did.  Maybe we should use a different definition of L.  OUR MODEL ISN'T GOING LOWER BECAUSE THERE IS A LOT OF WAKE EPOCHS WHEN SWA IS GETTING SMALL JUST BEFORE THE NEXT SLEEP DEPRIVATION.  I NOW PLOT UA AND LA ON THE GRAPH OF THE SWA DATA.  
3) If using the 5 state model, include 5 minute episodes of SWS and/or QW as data points, not just SWS. 

I coded up the basic two-process model in XPP today and changed the circadian curves to get something like rodent sleep in figure 18 of the Daan et al paper.  Decide if I want to keep going in XPP or switch to MATLAB.  MAtlab would make it easier to measure things like total time in each sleep stage and 


# Tuesday, June 7
Ideas:  approach this with three models: 
1) The basic homeostatic model that I have been doing (like Franken).  Add Circadian curves to this to see if it helps fit the Baseline + Workday data.  If so, run it on the whole thing: baseline+work week + recovery to see if it helps explain the long-lasting changes in sleep timing. Here is an idea of how to do that: run it by fitting it to data on the baseline+work week data.  Then just let it run after that (without fitting it to SWA data, but letting the model do what it would.  Then compare the predicted amounts of SWS and wake to what Janne actually saw in the recovery data. Before I do this, I will need a good model for the baseline data: two process with some stochastic feature (or circadian curves that are close together like Figure 18 in Daan et al) that gives the right percentages of each state at the right times (like figure 4).  Then I think the rest of this will work.  
1a) To do the stochastic version of the two process model: Come up with a stochastic function that takes in the homeostat value (as in the basic two-process model) and the light level to give a probability of each state.  The actual state will be the output of this random variable at each 10-second interval.  
2) Another idea with the basic homeostatic model (and fitting to SWA data).  Normalize the SWA data to be between 0 and 1.  Use 0 and 1 for the LA and UA respectively.  Then include circadian curves for the transitions between states.  Use NM to optimize the location and amplitude of these two curves.  The problem with this approach is that currently the model never actually reaches LA or UA so the places where the curve changes direction are determined by the sleep state at that time, not by the interaction of the homeostat with the circadian rhythm.  
3) Another idea: fit the SWA data to a basic two-process model formulation: two circadian curves and a homeostat.  Then, using data to find starting values for the homeostat and circadian curve (just after baseline day) run the two-process model for the rest of the simulation and 
All of these approaches are unlikely to explain the long-lasting changes that Janne is seeing in her data.  That is OK, it is still worth doing and worth pointing out (in my talk and in a paper)

4) To understand the long-lasting changes, I will probably need a longer-lasting variable.  Maybe something like SWE.  Think of ways to incorporate this in the modeling above.
5) With my post-doc model, modify it so it gives the baseline behavior in Janne's data (by changing C and/or stochastic).  Then do the sleep deprivation and see how the model responds.  I am guessing that it will quickly equilibriate (which is OK, we can present that too).  Then think of an additional variable that we can include that would explain the longer-lasting changes (stochastic parameters?, constant inputs to AMIN or VLPO?, changes to C?)

 All of the above approaches assume that Taui and Taud don't actually change over the course of the experiment.  If we can show that with a basic two-process model (without changing Tau values) it is impossible to predict the longer-lasting changes in sleep, then something else must be changing.  We can test which one fits the data best: changing Tau values, changing probabilities of state changes, changing C curves.   

 The paper says that 6 days were required to recover SWS.  Try to model this.  

 # Friday, June 10, 2016
 I read the McCauley Van Dongen SLEEP2013 paper and it is helpful.  They have two variables: p for performance impairment, and u for increasing the upper asymptote to which p rises during Wake, and u lowers the asymptote toward which p falls during sleep.  U simply increases during wakefulness and falls during sleep.  This is like saying the upper circadian rhythm toward which process S rises is itself increasing during wakefulness and L falls during sleep.  Why would you do that?  Also, they have the amplitude of C rising during wakefulness and exponentially falling during sleep. KEEP IN MIND THIS DID NOT FIT THE SHIFT WORK DATA WELL AT ALL.  FIGURE 2 IS THE COMPARISON TO SHIFT WORK DATA AND THE FIT IS REALLY BAD.

 IDEA:  Include SWE in the model as an output since it is the product of the # of epochs in a particular state times the average EEG power in 1-4 Hz range across all epochs of that state (measured per hour).  I can estimate this from the model if I have a prediction of sleep state from the model (with noise) and an estimate of the homeostat (process S).  
 Now, focus on how to get state changes from process S for polyphasic sleep.  Have sleep state as a separate stochastic variable that goes with S, (more likely to be in wake when S is high for instance) 
 2:36: I have a primitive model of sleep state.  I model the probability of being in a sleep state (SWS or REMS) using the sleepiness variable S-C and then shifting and scaling it so the numbers come out about right.  This pretty closely tracks the percentages of sleep states vs wake states in the baseline data.  
 Think about actually coding up a sleep state that uses these percentages to choose (stochastically) a sleep state.    
 This is almost done.  Make the plotting a little better by using fill.m to make it look like Janne's figure.  check what I have too. It may not be quite right.  

 # Monday, June 13, 2016
 It looks like wake_percentage and sleep_percentage are working correctly.  Now work on making the plot using fill.m  I have a version of this working now, but the colors aren't great. 

 # Tuesday, June 14, 2016
 I am reading papers today.  I printed the paper that Postnova cited in her shift work modeling paper in 2012.  The paper is by St. Hilaire et al. and includes Ken Wright, Czeisler, and Kronauer as co-authors.  This may be a good thing to use (or modify and use) in my modeling of Janne's shift work data since it includes a term for non-photic influences like meals and locomotor activity.  Read this paper. 

 Also read Postnova et al 2013 PLOS One paper.  They do 4 days of shift work in a model.

 One problem:  implementing the active phase protocol in my model, there is quite a bit of sleep intruding during the later part of the shift.
 major problem: implementing the resting phase work schedule gives me very little wakefulness during the scheduled work time because S-C is fairly small during during this time.  I need another way to force the system to be awake during work.  
 I added a line to force the system to be awake if working.  This helps, but the graphs still don't look great.  Keep working on this 

 # Wednesday, June 15, 2016
 I'm working on understanding the Circadian model from St. Hilaire et al.  
 The model goes all the way down to photoreceptors and is therefore light-dependent.  Janne says in our shift work experimental manuscript:  in rodents sleep/wake doesn't change much during constant darkness so it isn't a passive response to light and dark.  So we shouldn't use the same model for C. 
 However, in earlier papers by Phillips where he models sleep across many species (2010) he uses a basic model for C and calls it "well-entrained".  I think we clearly need something that is not well-entrained, like what Postnova et al used in their shift work model, but not depending on light input. 
 Will activity input be enough to set the circadian rhtym?  Ask Janne.

# Friday, June 17, 2016
Notes to self from Journal Club presentation:
Michelle said that the reason most people don't include a process C when it comes to rodents is because they keep them at 12-12 Light dark schedule.  This 12-12 schedule imposes a constant C value.  (Ask her more details about this.  I don't quite understand how it works)
Jonathan had a potentially really good idea for getting polyphasic sleep out of the two-process model: ask how far process S is from process C.  For instance, during the normal "sleep" episode the distance from the lower circadian curve could dictacte the length of the sleep episode.  This may be a good way to implement polyphasic sleep.  
Janne likes the circadian model by St Hilaire et al.  She thinks that light input is very important for mice/rats.  Talk to Ilia about C in mice.  That can help me build a model like the one from St Hilaire et al, but for rodents, not humans.  Ilia switched mice from a 12/12 Light/dark schedule to a 10/10 light/dark schedule and it really messed up sleep.  Total sleep times were not affected, but if you looked at when they slept, the sleep patterns were all messed up.  
 

# Tuesday, June 28, 2016
I'm working on coding up the circadian model of St. Hilaire et al. I was not able to get it to run in MATLAB using rk4.m or my own runge-kutta 4 step.  I am now coding it up in XPP and it initially didn't work there either. 

11:23: I was able to get a simpler version oscillating (Forger et al. 1999).  Keep going with this and try to find the typos in the more advanced versions.  equations (1) and (2) seems to work in Danny's paper.  

I was finally able to get it running in both XPP and matlab.  But when I give a nonzero light level in matlab, the computation blows up.  Now in XPP.  See what the difference is.  


FOR THE POSTER (ITALY):  In Hilaire's 2007 paper, she uses a Akaike Information Criterion to determine the goodness of fit of two different models with different numbers of parameters.  I should use this to compare the 3-state model vs. the 5-state model.  There is a penalty for adding more parameters.  See page 591 of the Hilaire paper.  Except we don't add any parameters, just states.  Still have taui and taud.    

# Monday, July 4, 2016
It looks like I finally got it running.  For a long time, it ran, but changing I did nothing.  Comparing the St Hilaire paper to the Postnova papers, it looks like Postnova left out a factor of 60 in the dn/dt equation.  I carefully worked through what the alpha0 and beta parameter values should be (considering units) and the Postnova paper was still missing a factor of 60.  Now when I change light intensity it changes the circadian curve.  

When I try to convert to hours, I'm not getting complete agreement.  Close, but not exact.  This may be a convergence issue.  Try running RK4 with smaller timesteps to make sure I have actually converged to the correct solution.  This wasn't the issue.  There was a strange little blip where the solution (when using hours, rather than seconds) would go in the wrong direction for a bit before correcting.  This would mean that the peak value would be off as compared to the version using seconds. 

I found and fixed the error:  G needs to be adjusted if alpha changes units.  the equations for dx/dt and dxc/dt are scaled by changing Omega, so everything else is those equations should be the same when you change units.  Changing the units of alpha changed the scale of B (which changed dx/dt and dxc/dt)  I divided G by 60 two times to make B have the same magnitude as when I used seconds.  This made it match up exactly with the simulation done using seconds. 

Now check the Ns parameter (so far rho=0, which turns off the non-photic input) and it that seems to be working, incorporate this circadian model into my two-process model (with the actual values of I and sleep state and think about nocturnal).  Think about which parameters I would like to optimize, etc.  

# Tuesday, July 5, 2016
I had a meeting with Janne and Jonathan this morning. Here are some outputs:
    Homestatic modeling approach for the shift work data:
      * Check the percentage of time in quiet wake (maybe not very much) around 16% or 17% one file had 32% QW for AW. 15-17% for RW so it is a significant portion of the recording.   
      * Include 5min intervals if SWS and/or QW collectively make up 90% of the 5 minutes.  Use these as data points.
        I implemented this in find_all_SWS_episodes5.m and make_freq_plot.m 
      * To determine L, the lower asymptote: try 10th percentile of SWA for L instead of the intersection with REM histogram
                                            * include SWS and QW in histogram and do the intersection with REMS histogram
                                            * include SWS and QW in histogram and do the 10th percentile
      It seems that the fit of the model is pretty dependent on the choice of UA, it is probably true of the choice of LA as well.  Should I optimize these somehow?  Either run through a set of options for UA and LA or let NM optimize? For those files where the fit of the model looks good, usually the histogram also looks good.  When the fit isn't great, the histogram doesn't look like Franken's. 23RW looks terrible with 99% for U.  It still looks bad with 90% for U. 
      I did this for U=90%,95% or 99% and L is the intersect of the two histograms or just the 10th percentile.  I made a plot of the residuals in each case (where I pooled the data from AW and RW).  It seems that the residuals are more sensitive to the choice of U than the choice of L.  For a given value of U, choosing L as 10th percentile or intersection doesn't change residuals. Using U as 99th percentile had the lowest residuals of all for both 5state model and the 3state model.  In each case the 3state model has lower residuals than the 5state model. Show this plot to Jonathan and Janne.   
      * Keep going with the idea of a variable range for SWA.  Range it up to 30Hz.  There seems to be a decline in residuals with SWA definition going up to 8 Hz.  Keep going.  Compare AW and RW on the same graph.  
      I have the code for this ready to go. Just kick it off on Friday morning.  

    Two process modeling of shift work data:
    (For the two panels I circled on my journal club powerpoint)
    * The recovery data is only for the normal resting phase.  Since the DD data show no difference between AW and RW, but the LD do, this is a process S effect, not a process C effect.  Now that I write this, I am confused.  Talk to Janne about this again.  Since removing the light, (which helps set the circadian process), neutralizes the effect between AW and RW, doesn't that imply that the difference we see in the LD case is circadian dependent? 
    * To understand the changes seen in the LD recovery panel, Janne said that it could be long-lasting changes in the MA or VLPO.  Use a mutual inhibition model for this.  
    * The new circadian model (St. Hilaire ) could be very helpful for understanding the left panel: long-lasting changes in SWS episode duration between AW and RW.
    * Implement Jonathan's idea of using the distance between S and C to determine liklihood of particular states.   
    * A BIG and IMPORTANT TO DO: I need to get actual SWS episodes into my model so I can see if they change between AW and RW.  This is the main metric I will use to compare the two (like the two figure panels)
    Also: temperature mirrors activity of SCN, so temperature activity is a good metric for circadian rhythm.   
    * Focus now on testing the 5-state model vs. the 3-state model in mouse EEG data.  I think we have only used the 5state model for lactate data.  It could be that for polysomnography, the 5-state model just doesn't work as well.  It is better for metabolic processes in sleep, but not in polysomnography.  If the 5-state model is also worse in the mouse data, we can put it to rest.  
    I found a spreadsheet with residuals for the 3-state model and 5-state model that we used in the beta paper.  Residuals are lower in the 5state model if lactate is used, but not if EEG1 or EEG2 are used.  Residuals are a bit higher in the 5state model if EEG1 is used and the same if EEG2 is used.  
    * Using shift work data, try changing the 5-min requirement for SWS episode length (try 3 and 4)  It may be that residuals go down if we use a shorter duration for SWS.  Is the 5-state model still a worse fit?  Once we have a nice fit of the model to the data, then compare shift workers and non-shift workers.  
    using RW data, and a 3 minutes requirement for SWS episode length, the 3 state model has lower residuals
    using RW data, and a 4 minute requirement for SWS episode length, changed both residuals very little.  the 3 state model still has lower residuals. 
    using AW data, and a 4 minute requirement for SWS episode length, the 3 state model has significantly lower residuals than the 5 state model
    using AW data, and a 3 minute requirement for SWS episode length, the 3 state model has lower residuals than the 5 state model
    * After comparing 5-state and 3-state, keep going on the real two process idea.  Keep trying the approach where the two C curves are very close together to see if we can get reasonable polyphasic sleep. 
    What to shoot for: Looking at the shift work manuscript, If I combine the active phases (Wake and REMS) the breakdown should be the following:
    Light:  42% W+REMS, 58% NREM
    Dark:   71% W+REMS, 29% NREM
     


    # Wednesday, July 6, 2016
    I think I found a bug: when I run the code on file 25_AW_DD_workday1.txt there are several sections where all the EEG data are 0 and the state is scored as W.  However, my model is putting data points there representing 5-min episodes of SWS.  How is this happening? This is not a bug, this is because we are using a 5 state model and these epochs were considered quiet wake (since EMG was low: 0!). 

    Don't forget to uncomment the artifact removal in both PROCESSLBATCHMODE and PROCESSLBATCHMODE_nogui that removes epocs where SWA is 0.DONE!
    
    # Thursday, July 7, 2016
    We had a journal club today on the 2016 Borbely 2-process paper. 

    # Tuesday, July 12, 2016
    Looking at the shift work data.  Two issues:  1) Right now I am using normalized RMSE since the EEG signal changes from animal to animal.  However, since I was dividing by the range of the data, that meant that recordings with higher range gave me a lower residual.  I have changed this to divide by the mean of the data, not the range. 
    2) Looking at file 8_RW_DD_workday1.txt it really seems like the delta power just after the second, third, and fourth workdays is significantly higher than after the first workday (check this in all recordings).  Does this idea lend credence to the thought that taui must change after the first work shift?  How can I quantify this to find out?  This would only work if the starting value was about the same after each work session.   
    Looking at all the files, this didn't seem to pan out, at least eye-balling it.  It did for several, but not for all. 

    I am now trying to normalize the EEG data to the average of the EEG during SWS during the first 24 hours of the recording.  I think this may get rid of the need to use NRMSE and it may make the model fit better.  I did this and it looks fine. 

    Problem files:  17_RW_DD_workday1.txt  (scattered) 

    Even using my best version of the model where the model fits the data well, and I leave out the problem files, a t-test comparing AW and RW shows no differences in either tau value between groups when I used epochs 1 to 43200.  Looking back at my emails with Janne, we separated the baseline day from the 4 work days.  Looking at the data more closely today I think that makes sense, except that the model doesn't fit the baseline data all that well.  I did seem to see faster rising during work (after the first night) than during baseline.

    I have saved all 4 spreadsheets. Check:  1) are the tau values the same between AW and RW during baseline? (i hope so) 2) are the taui and taud values different between baseline and work for both AW and QW? (we claim this in our abstract. taui for both, td for one) 3) Are the tau values different between AW and RW during the work time? Are there any differences between the groups?  

    baseline:   Ti equal
                Td equal

    I got the same results that we claim in the abstract, although with slightly higher p-values (0.005 instead of 0.001).  Still no difference between the groups during the working period.  

    # Friday, July 15
    Running the two-process model with the circ curves close together gives me a baseline average SWS episode duration that is in the right ballpark: 88.7 minutes and Janne reports about 95 minutes for the baseline in Figure 6 panel B.  I think this may be a mistake.  Make sure this is correct before I move forward. Yes, this was a typo.  Actual SWS episodes are about 90-120 seconds.  How can I get this level of detail into the two process framework?  +C curves closer together+?  C curves close together and stochastic model?  
    One issue: It seems that even with moving the C curves closer together, the sleep episodes are still way too long.  For our data, aren't the SWS episodes much shorter? 
    
    Will I need to have REMS in a model if I am doing SWS durations?   

    I requested a 1993 Achermann article that uses 2proc and does REM/NREM. 

    I tried putting the two curves close together to get polyphasic sleep and I have to get them really really close together to get anywhere near the right average SWS episode duration. I don't think this is a good approach.  For one thing, the SWS episodes are very regular since the homeostat just doesn't move that far each time.  
     
