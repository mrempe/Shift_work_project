% estimate_state_transition_probabilities.m script

[files,directory] = uigetfile('Multiselect','on','\\FS1\WisorData\Gronli\Night work, animal model\txt files\Work period\Baseline and workdays\txt files\*.txt','PROCESS_L   Please Select .txt file(s)');  %last parameter sent to uigetfile ('*.edf*) specifies that only edf files will be displayed in the user interface.
if ~iscell(files), files = {files}; end

'\\FS1\WisorData\Gronli\Night work, animal model\txt files\Work period\Baseline and workdays\txt files\*.txt'





for FileCounter=1:length(files)


[data,textdata]=importdatafile(files{FileCounter},directory,4320,8640);%


 
  sleep_state = zeros(size(data,1),1);  % Sleep state contains 0 for Wake, 1 for SWS, 2 for REMS, 5 for artifact

  missing_values=0;
  for i = 1: size(data,1)  
    
    if isempty(textdata{i,2})==1        % call unscored epochs wake
      missing_values=missing_values+1;
      sleep_state(i)=0;  

    elseif textdata{i,2}=='W' 
      sleep_state(i)=0;
    elseif textdata{i,2}=='S'
      sleep_state(i)=1;
    elseif textdata{i,2}=='P'
      sleep_state(i)=2;
    elseif textdata{i,2}=='R'
      sleep_state(i)=2;
    elseif sum(textdata{i,2}=='Tr')==2
      sleep_state(i)=0;                 % call transitions wake
    elseif textdata{i,2}=='T'
      sleep_state(i)=5;
    elseif textdata{i,2}=='X'            %artefact
      sleep_state(i)=5; 
        else   
          error('I found a sleep state that wasn''t W,S,P,R,Tr, or X');
    end
  end
  disp(['There were ',num2str(missing_values), ' epochs that were not scored.'])


% --- First look at all the Wake epochs and what happens right after them -----
  wake_epochs = find(sleep_state==0);
  if wake_epochs(end) == length(sleep_state)
  	wake_epochs = wake_epochs(1:end-1);
  end
  states_following_wake = sleep_state(wake_epochs+1);
  wake2wake_transitions = length(find(states_following_wake==0));
  wake2wake_percentage(FileCounter) = wake2wake_transitions/length(states_following_wake);

  wake2SWS_transitions = length(find(states_following_wake==1));
  wake2SWS_percentage(FileCounter) = wake2SWS_transitions/length(states_following_wake);

  wake2REM_transitions = length(find(states_following_wake==2));
  wake2REM_percentage(FileCounter) = wake2REM_transitions/length(states_following_wake);


% --- Next look at all the SWS epochs and what happens right after them -----
  SWS_epochs = find(sleep_state==1);
  if SWS_epochs(end) == length(sleep_state)
  	SWS_epochs = SWS_epochs(1:end-1);
  end
  states_following_SWS = sleep_state(SWS_epochs+1);
  SWS2wake_transitions = length(find(states_following_SWS==0));
  SWS2wake_percentage(FileCounter) = SWS2wake_transitions/length(states_following_SWS);

  SWS2SWS_transitions = length(find(states_following_SWS==1));
  SWS2SWS_percentage(FileCounter) = SWS2SWS_transitions/length(states_following_SWS);

  SWS2REM_transitions = length(find(states_following_SWS==2));
  SWS2REM_percentage(FileCounter) = SWS2REM_transitions/length(states_following_SWS);


% --- Finally look at all the REM epochs and what happens right after them -----
  REM_epochs = find(sleep_state==2);
  if REM_epochs(end) == length(sleep_state)
  	REM_epochs = REM_epochs(1:end-1);
  end
  states_following_REM = sleep_state(REM_epochs+1);
  REM2wake_transitions = length(find(states_following_REM==0));
  REM2wake_percentage(FileCounter) = REM2wake_transitions/length(states_following_REM);

  REM2SWS_transitions = length(find(states_following_REM==1));
  REM2SWS_percentage(FileCounter) = REM2SWS_transitions/length(states_following_REM);

  REM2REM_transitions = length(find(states_following_REM==2));
  REM2REM_percentage(FileCounter) = REM2REM_transitions/length(states_following_REM);


end 

disp(['Average wake2wake_percentage: ' num2str(mean(wake2wake_percentage))])
disp(['Average wake2SWS_percentage: ' num2str(mean(wake2SWS_percentage))])
disp(['Average wake2REM_percentage: ' num2str(mean(wake2REM_percentage))])


disp(['Average SWS2wake_percentage: ' num2str(mean(SWS2wake_percentage))])
disp(['Average SWS2SWS_percentage: ' num2str(mean(SWS2SWS_percentage))])
disp(['Average SWS2REM_percentage: ' num2str(mean(SWS2REM_percentage))])


disp(['Average REM2wake_percentage: ' num2str(mean(REM2wake_percentage))])
disp(['Average REM2SWS_percentage: ' num2str(mean(REM2SWS_percentage))])
disp(['Average REM2REM_percentage: ' num2str(mean(REM2REM_percentage))])
