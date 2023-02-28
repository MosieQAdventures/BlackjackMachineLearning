clearvars; 
clc;

%% Prepare tables
REAL_BS_ARRAY = zeros(101,4);
outputBSarray = zeros(101,4);
REAL_ACE_BS_ARRAY = zeros(81,4);
outputAceBSarray = zeros(81,4);
REAL_BS_ARRAY(1,:) = 111;
outputBSarray(1,:) = 111;
REAL_ACE_BS_ARRAY(1,:) = 111;
outputAceBSarray(1,:) = 111;

%disp(outputBSarray);
%disp(outputAceBSarray);

%                                      % only needed for first run
BsMoveWinLooseAiArray = zeros(101,4); %here
AceMoveWinLooseAiArray = zeros(81,4); %and here

BsMoveWinLooseAiArray(1,1) = 111;
BsMoveWinLooseAiArray(1,2) = 1;
BsMoveWinLooseAiArray(1,3) = -1;
BsMoveWinLooseAiArray(1,4) = 111;
AceMoveWinLooseAiArray(1,1) = 111;
AceMoveWinLooseAiArray(1,2) = 1;
AceMoveWinLooseAiArray(1,3) = -1;
AceMoveWinLooseAiArray(1,4) = 111;


%% OTHER STUFF

% H char
Hnumber = 72;
H = char(Hnumber);
% S char
Snumber = 83;
S = char(Snumber);

%% REAL BASIC STRATEGY - PREPARATION
for i = 2:length(REAL_BS_ARRAY)
    REAL_BS_ARRAY(i,1) = i;
end

dealerCardValue = 2;
for i = 1:length(REAL_BS_ARRAY)/10
    for j = 1:10
        index = 10*(i-1)+j+1;
        REAL_BS_ARRAY(index,2) = dealerCardValue;
        REAL_BS_ARRAY(index,3) = j+7;
    end
    dealerCardValue = dealerCardValue+1;
end

 %disp(REAL_BS_ARRAY);

 %% REAL BASIC STRATEGY ACES - PREPARATION

for i = 2:length(REAL_ACE_BS_ARRAY)
    REAL_ACE_BS_ARRAY(i,1) = i;
end

dealerCardValue = 2;
for i = 1:length(REAL_ACE_BS_ARRAY)/8
    for j = 1:8
        index = 8*(i-1)+j+1;
        REAL_ACE_BS_ARRAY(index,2) = dealerCardValue;
        REAL_ACE_BS_ARRAY(index,3) = j+1;
    end
    dealerCardValue = dealerCardValue+1;
end

%disp(REAL_ACE_BS_ARRAY);

%% BASIC STRATEGY - PREPARATION
for i = 2:length(outputBSarray)
    outputBSarray(i,1) = i;
end

dealerCardValue = 2;
for i = 1:length(outputBSarray)/10
    for j = 1:10
        index = 10*(i-1)+j+1;
        outputBSarray(index,2) = dealerCardValue;
        outputBSarray(index,3) = j+7;
    end
    dealerCardValue = dealerCardValue+1;
end

%disp(outputBSarray);

%% BASIC STRATEGY ACES - PREPARATION

for i = 2:length(outputAceBSarray)
    outputAceBSarray(i,1) = i;
end

dealerCardValue = 2;
for i = 1:length(outputAceBSarray)/8
    for j = 1:8
        index = 8*(i-1)+j+1;
        outputAceBSarray(index,2) = dealerCardValue;
        outputAceBSarray(index,3) = j+1;
    end
    dealerCardValue = dealerCardValue+1;
end

%disp(outputAceBSarray);

%% POPULATE MOVES - H(72) / S(83)

% R E A L B A S I C S T R A T E G Y - - - - - - - - - - - - - -

for i = 1:1 % REAL BS 
REAL_BS_ARRAY(1,4) = 111;
REAL_BS_ARRAY(2,4) = 72;
REAL_BS_ARRAY(3,4) = 72;
REAL_BS_ARRAY(4,4) = 72;
REAL_BS_ARRAY(5,4) = 72;
REAL_BS_ARRAY(6,4) = 72;
REAL_BS_ARRAY(7,4) = 83;
REAL_BS_ARRAY(8,4) = 83;
REAL_BS_ARRAY(9,4) = 83;
REAL_BS_ARRAY(10,4) = 83;
REAL_BS_ARRAY(11,4) = 83;
REAL_BS_ARRAY(12,4) = 72;
REAL_BS_ARRAY(13,4) = 72;
REAL_BS_ARRAY(14,4) = 72;
REAL_BS_ARRAY(15,4) = 72;
REAL_BS_ARRAY(16,4) = 72;
REAL_BS_ARRAY(17,4) = 83;
REAL_BS_ARRAY(18,4) = 83;
REAL_BS_ARRAY(19,4) = 83;
REAL_BS_ARRAY(20,4) = 83;
REAL_BS_ARRAY(21,4) = 83;
REAL_BS_ARRAY(22,4) = 72;
REAL_BS_ARRAY(23,4) = 72;
REAL_BS_ARRAY(24,4) = 72;
REAL_BS_ARRAY(25,4) = 72;
REAL_BS_ARRAY(26,4) = 83;
REAL_BS_ARRAY(27,4) = 83;
REAL_BS_ARRAY(28,4) = 83;
REAL_BS_ARRAY(29,4) = 83;
REAL_BS_ARRAY(30,4) = 83;
REAL_BS_ARRAY(31,4) = 83;
REAL_BS_ARRAY(32,4) = 72;
REAL_BS_ARRAY(33,4) = 72;
REAL_BS_ARRAY(34,4) = 72;
REAL_BS_ARRAY(35,4) = 72;
REAL_BS_ARRAY(36,4) = 83;
REAL_BS_ARRAY(37,4) = 83;
REAL_BS_ARRAY(38,4) = 83;
REAL_BS_ARRAY(39,4) = 83;
REAL_BS_ARRAY(40,4) = 83;
REAL_BS_ARRAY(41,4) = 83;
REAL_BS_ARRAY(42,4) = 72;
REAL_BS_ARRAY(43,4) = 72;
REAL_BS_ARRAY(44,4) = 72;
REAL_BS_ARRAY(45,4) = 72;
REAL_BS_ARRAY(46,4) = 83;
REAL_BS_ARRAY(47,4) = 83;
REAL_BS_ARRAY(48,4) = 83;
REAL_BS_ARRAY(49,4) = 83;
REAL_BS_ARRAY(50,4) = 83;
REAL_BS_ARRAY(51,4) = 83;
REAL_BS_ARRAY(52,4) = 72;
REAL_BS_ARRAY(53,4) = 72;
REAL_BS_ARRAY(54,4) = 72;
REAL_BS_ARRAY(55,4) = 72;
REAL_BS_ARRAY(56,4) = 72;
REAL_BS_ARRAY(57,4) = 72;
REAL_BS_ARRAY(58,4) = 72;
REAL_BS_ARRAY(59,4) = 72;
REAL_BS_ARRAY(60,4) = 72;
REAL_BS_ARRAY(61,4) = 83;
REAL_BS_ARRAY(62,4) = 72;
REAL_BS_ARRAY(63,4) = 72;
REAL_BS_ARRAY(64,4) = 72;
REAL_BS_ARRAY(65,4) = 72;
REAL_BS_ARRAY(66,4) = 72;
REAL_BS_ARRAY(67,4) = 72;
REAL_BS_ARRAY(68,4) = 72;
REAL_BS_ARRAY(69,4) = 72;
REAL_BS_ARRAY(70,4) = 72;
REAL_BS_ARRAY(71,4) = 83;
REAL_BS_ARRAY(72,4) = 72;
REAL_BS_ARRAY(73,4) = 72;
REAL_BS_ARRAY(74,4) = 72;
REAL_BS_ARRAY(75,4) = 72;
REAL_BS_ARRAY(76,4) = 72;
REAL_BS_ARRAY(77,4) = 72;
REAL_BS_ARRAY(78,4) = 72;
REAL_BS_ARRAY(79,4) = 72;
REAL_BS_ARRAY(80,4) = 72;
REAL_BS_ARRAY(81,4) = 83;
REAL_BS_ARRAY(82,4) = 72;
REAL_BS_ARRAY(83,4) = 72;
REAL_BS_ARRAY(84,4) = 72;
REAL_BS_ARRAY(85,4) = 72;
REAL_BS_ARRAY(86,4) = 72;
REAL_BS_ARRAY(87,4) = 72;
REAL_BS_ARRAY(88,4) = 72;
REAL_BS_ARRAY(89,4) = 72;
REAL_BS_ARRAY(90,4) = 72;
REAL_BS_ARRAY(91,4) = 83;
REAL_BS_ARRAY(92,4) = 72;
REAL_BS_ARRAY(93,4) = 72;
REAL_BS_ARRAY(94,4) = 72;
REAL_BS_ARRAY(95,4) = 72;
REAL_BS_ARRAY(96,4) = 72;
REAL_BS_ARRAY(97,4) = 72;
REAL_BS_ARRAY(98,4) = 72;
REAL_BS_ARRAY(99,4) = 72;
REAL_BS_ARRAY(100,4) = 72;
REAL_BS_ARRAY(101,4) = 83;
end


for i = 1:1 % REAL ACE 
REAL_ACE_BS_ARRAY(1,4) = 111;
REAL_ACE_BS_ARRAY(2,4) = 72;
REAL_ACE_BS_ARRAY(3,4) = 72;
REAL_ACE_BS_ARRAY(4,4) = 72;
REAL_ACE_BS_ARRAY(5,4) = 72;
REAL_ACE_BS_ARRAY(6,4) = 72;
REAL_ACE_BS_ARRAY(7,4) = 83;
REAL_ACE_BS_ARRAY(8,4) = 83;
REAL_ACE_BS_ARRAY(9,4) = 83;
REAL_ACE_BS_ARRAY(10,4) = 72;
REAL_ACE_BS_ARRAY(11,4) = 72;
REAL_ACE_BS_ARRAY(12,4) = 72;
REAL_ACE_BS_ARRAY(13,4) = 72;
REAL_ACE_BS_ARRAY(14,4) = 72;
REAL_ACE_BS_ARRAY(15,4) = 83;
REAL_ACE_BS_ARRAY(16,4) = 83;
REAL_ACE_BS_ARRAY(17,4) = 83;
REAL_ACE_BS_ARRAY(18,4) = 72;
REAL_ACE_BS_ARRAY(19,4) = 72;
REAL_ACE_BS_ARRAY(20,4) = 72;
REAL_ACE_BS_ARRAY(21,4) = 72;
REAL_ACE_BS_ARRAY(22,4) = 72;
REAL_ACE_BS_ARRAY(23,4) = 83;
REAL_ACE_BS_ARRAY(24,4) = 83;
REAL_ACE_BS_ARRAY(25,4) = 83;
REAL_ACE_BS_ARRAY(26,4) = 72;
REAL_ACE_BS_ARRAY(27,4) = 72;
REAL_ACE_BS_ARRAY(28,4) = 72;
REAL_ACE_BS_ARRAY(29,4) = 72;
REAL_ACE_BS_ARRAY(30,4) = 72;
REAL_ACE_BS_ARRAY(31,4) = 83;
REAL_ACE_BS_ARRAY(32,4) = 83;
REAL_ACE_BS_ARRAY(33,4) = 83;
REAL_ACE_BS_ARRAY(34,4) = 72;
REAL_ACE_BS_ARRAY(35,4) = 72;
REAL_ACE_BS_ARRAY(36,4) = 72;
REAL_ACE_BS_ARRAY(37,4) = 72;
REAL_ACE_BS_ARRAY(38,4) = 72;
REAL_ACE_BS_ARRAY(39,4) = 83;
REAL_ACE_BS_ARRAY(40,4) = 83;
REAL_ACE_BS_ARRAY(41,4) = 83;
REAL_ACE_BS_ARRAY(42,4) = 72;
REAL_ACE_BS_ARRAY(43,4) = 72;
REAL_ACE_BS_ARRAY(44,4) = 72;
REAL_ACE_BS_ARRAY(45,4) = 72;
REAL_ACE_BS_ARRAY(46,4) = 72;
REAL_ACE_BS_ARRAY(47,4) = 83;
REAL_ACE_BS_ARRAY(48,4) = 83;
REAL_ACE_BS_ARRAY(49,4) = 83;
REAL_ACE_BS_ARRAY(50,4) = 72;
REAL_ACE_BS_ARRAY(51,4) = 72;
REAL_ACE_BS_ARRAY(52,4) = 72;
REAL_ACE_BS_ARRAY(53,4) = 72;
REAL_ACE_BS_ARRAY(54,4) = 72;
REAL_ACE_BS_ARRAY(55,4) = 83;
REAL_ACE_BS_ARRAY(56,4) = 83;
REAL_ACE_BS_ARRAY(57,4) = 83;
REAL_ACE_BS_ARRAY(58,4) = 72;
REAL_ACE_BS_ARRAY(59,4) = 72;
REAL_ACE_BS_ARRAY(60,4) = 72;
REAL_ACE_BS_ARRAY(61,4) = 72;
REAL_ACE_BS_ARRAY(62,4) = 72;
REAL_ACE_BS_ARRAY(63,4) = 72;
REAL_ACE_BS_ARRAY(64,4) = 83;
REAL_ACE_BS_ARRAY(65,4) = 83;
REAL_ACE_BS_ARRAY(66,4) = 72;
REAL_ACE_BS_ARRAY(67,4) = 72;
REAL_ACE_BS_ARRAY(68,4) = 72;
REAL_ACE_BS_ARRAY(69,4) = 72;
REAL_ACE_BS_ARRAY(70,4) = 72;
REAL_ACE_BS_ARRAY(71,4) = 72;
REAL_ACE_BS_ARRAY(72,4) = 83;
REAL_ACE_BS_ARRAY(73,4) = 83;
REAL_ACE_BS_ARRAY(74,4) = 72;
REAL_ACE_BS_ARRAY(75,4) = 72;
REAL_ACE_BS_ARRAY(76,4) = 72;
REAL_ACE_BS_ARRAY(77,4) = 72;
REAL_ACE_BS_ARRAY(78,4) = 72;
REAL_ACE_BS_ARRAY(79,4) = 72;
REAL_ACE_BS_ARRAY(80,4) = 83;
REAL_ACE_BS_ARRAY(81,4) = 83;
end


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

% Hit - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

for i = 2:length(outputBSarray)
    %outputBSarray(i,4) = Hnumber;       % Hit
end

for i = 2:length(outputAceBSarray)
    %outputAceBSarray(i,4) = Hnumber;    % Hit
end

% Stand - - - - - - - - - - - - - - - - - - - - - - - - - - - -

for i = 2:length(outputBSarray)
    %value = Snumber;
    %outputBSarray(i,4) = value;       % Stand
    %BsMoveWinLooseAiArray(i,1) = value;  % pop that as 1st column of MWL
end

for i = 2:length(outputAceBSarray)
    %value = Snumber;
    %outputAceBSarray(i,4) = value;    % Stand
    %AceMoveWinLooseAiArray(i,1) = value;  % pop that as 1st column of MWL
end

% Random - - - - - - - - - - - - - - - - - - - - - - - - - - - -

% randi(100);    % (1-50) - H / (51-100) - S
for i = 2:length(outputBSarray)
    rand = randi(100);
    if rand <= 50
        value = Hnumber;
    else
        value = Snumber;
    end

    outputBSarray(i,4) = value;          % Random
    BsMoveWinLooseAiArray(i,1) = value;  % pop that as 1st column of MWL
end

for i = 2:length(outputAceBSarray)
    rand = randi(100);
    if rand <= 50
        value = Hnumber;
    else
        value = Snumber;
    end

    outputAceBSarray(i,4) = value;        % Random
    AceMoveWinLooseAiArray(i,1) = value;  % pop that as 1st column of MWL
end

%% Previous from variables

for i = 2:length(outputBSarray)
    value = BsMoveWinLooseAiArray(i,1);

    %outputBSarray(i,4) = value;          
    %BsMoveWinLooseAiArray(i,1) = value;  % pop that as 1st column of MWL
end

for i = 2:length(outputAceBSarray)
    value = AceMoveWinLooseAiArray(i,1);

    %outputAceBSarray(i,4) = value;        
    %AceMoveWinLooseAiArray(i,1) = value;  % pop that as 1st column of MWL
end

%% Blackjack

disp("Rules:") 
disp("1) Always from clean shuffled 52-card deck.")
disp("2) Dealer stands at 17+.")
disp("3) Sum >21 you bust and loose.")
disp("4) Just get more than a dealer. 5head");
disp("- - - - -");

% BlackjackGame();

gamesToPlay = 500000; %change to big number
winsAI = 0;
pushesAI = 0;
loosesAI = 0;
winsBS = 0;
pushesBS = 0;
loosesBS = 0;

for game = 1:gamesToPlay
    
    % play one game from clean deck - BS table
    [resultBS,~,~] = BlackjackGame(REAL_BS_ARRAY, REAL_ACE_BS_ARRAY); 
    
    if resultBS == 1
        winsBS = winsBS+1;
    elseif resultBS == -1
        loosesBS = loosesBS+1;
    else
        pushesBS = pushesBS+1;
    end

    % play one game from clean deck - AI table
    [resultAI,returnIndex,returnIndexAce] = BlackjackGame(outputBSarray, outputAceBSarray);
    
    if resultAI == 1
        winsAI = winsAI+1;
    elseif resultAI == -1
        loosesAI = loosesAI+1;
    else
        pushesAI = pushesAI+1;
    end

    % working with MWL tables
    if resultAI == 1
        if returnIndex ~= 0
            BsMoveWinLooseAiArray(returnIndex,2) = BsMoveWinLooseAiArray(returnIndex,2) + 1;
        end
        if returnIndexAce ~= 0
            AceMoveWinLooseAiArray(returnIndexAce,2) = AceMoveWinLooseAiArray(returnIndexAce,2) + 1;
        end
    elseif resultAI == -1
        if returnIndex ~= 0
            BsMoveWinLooseAiArray(returnIndex,3) = BsMoveWinLooseAiArray(returnIndex,3) + 1;
        end
        if returnIndexAce ~= 0
            AceMoveWinLooseAiArray(returnIndexAce,3) = AceMoveWinLooseAiArray(returnIndexAce,3) + 1;
        end
    else
        % dont count when 0 - push
    end
end

winsPercentAI = (winsAI / (gamesToPlay-pushesAI) )*100; % just count wins and looses (pushes are neutral for winrate)
winsPercentBS = (winsBS / (gamesToPlay-pushesBS) )*100; % just count wins and looses (pushes are neutral for winrate)
disp("- - - - -")
disp("BS: Games:"+gamesToPlay+" -> W:"+winsBS+"/L:"+loosesBS+"/P:"+pushesBS+" -> Win(%): "+winsPercentBS+"%");
disp("- - - - -")
disp("AI: Games:"+gamesToPlay+" -> W:"+winsAI+"/L:"+loosesAI+"/P:"+pushesAI+" -> Win(%): "+winsPercentAI+"%");



%% Win Percentage of every move

BsMoveWinLooseAiArray(1,4) = 111;
AceMoveWinLooseAiArray(1,1) = 111;

for i = 2:length(BsMoveWinLooseAiArray)
    if BsMoveWinLooseAiArray(i,3) == 0
        BsMoveWinLooseAiArray(i,4) = 100; % 100% WR if no looses
    else
        BsMoveWinLooseAiArray(i,4) = 100* BsMoveWinLooseAiArray(i,2)/(BsMoveWinLooseAiArray(i,2)+BsMoveWinLooseAiArray(i,3));
    end
end

for i = 2:length(AceMoveWinLooseAiArray)
    if AceMoveWinLooseAiArray(i,3) == 0
        AceMoveWinLooseAiArray(i,4) = 100; % 100% WR if no looses
    else
        AceMoveWinLooseAiArray(i,4) = 100* AceMoveWinLooseAiArray(i,2)/(AceMoveWinLooseAiArray(i,2)+AceMoveWinLooseAiArray(i,3));
    end
end




%% break
















%% Blackjack AGAIN IN A LOOP

    % SWAPPING WORST PERFORMING GUESSES (1/4 every time)

repairNumber = 30;

for repair = 1:repairNumber
% petla 10x - find the worst (count) of results, swap them and populate table again

    % CreateNewBsTable
    number = 2;
    worstFromBS = zeros(number,2);
    temp = BsMoveWinLooseAiArray;
    [worstFromBS(:,2),worstFromBS(:,1)] = mink(temp(:,4),number);
    
    for i = 1:length(worstFromBS)
        for j = 1:length(outputBSarray)
            if j == worstFromBS(i,1) %if indexes match
                if outputBSarray(j,4) == 83
                    outputBSarray(j,4) = 72;
                else
                    outputBSarray(j,4) = 83;
                end
            end
        end
    end

    % CreateNewAceTable
    number = 3;
    worstFromAce = zeros(number,2);
    temp = AceMoveWinLooseAiArray;
    [worstFromAce(:,2),worstFromAce(:,1)] = mink(temp(:,4),number);
    
    for i = 1:length(worstFromAce)
        for j = 1:length(outputAceBSarray)
            if j == worstFromAce(i,1) %if indexes match
                if outputAceBSarray(j,4) == 83
                    outputAceBSarray(j,4) = 72;
                else
                    outputAceBSarray(j,4) = 83;
                end
            end
        end
    end

    % gamesToPlay = 100000; % it is set earlier no need to set here too
    winsAI = 0;
    pushesAI = 0;
    loosesAI = 0;
    
    for game = 1:gamesToPlay
            
        % play one game from clean deck - AI table
        [resultAI,returnIndex,returnIndexAce] = BlackjackGame(outputBSarray, outputAceBSarray);
        
        if resultAI == 1
            winsAI = winsAI+1;
        elseif resultAI == -1
            loosesAI = loosesAI+1;
        else
            pushesAI = pushesAI+1;
        end

        % working with MWL tables
        if resultAI == 1
            if returnIndex ~= 0
                BsMoveWinLooseAiArray(returnIndex,2) = BsMoveWinLooseAiArray(returnIndex,2) + 1;
            end
            if returnIndexAce ~= 0
                AceMoveWinLooseAiArray(returnIndexAce,2) = AceMoveWinLooseAiArray(returnIndexAce,2) + 1;
            end
        elseif resultAI == -1
            if returnIndex ~= 0
                BsMoveWinLooseAiArray(returnIndex,3) = BsMoveWinLooseAiArray(returnIndex,3) + 1;
            end
            if returnIndexAce ~= 0
                AceMoveWinLooseAiArray(returnIndexAce,3) = AceMoveWinLooseAiArray(returnIndexAce,3) + 1;
            end
        else
            % dont count when 0 - push
        end
    end

    winsPercentAI = (winsAI / (gamesToPlay-pushesAI) )*100; % just count wins and looses (pushes are neutral for winrate)
    disp("- - - - -")
    disp("AI: Games:"+gamesToPlay+" -> W:"+winsAI+"/L:"+loosesAI+"/P:"+pushesAI+" -> Win(%): "+winsPercentAI+"%");

    % Win Percentage of every move

    BsMoveWinLooseAiArray(1,4) = 111;
    AceMoveWinLooseAiArray(1,1) = 111;
    
    for i = 2:length(BsMoveWinLooseAiArray)
        if BsMoveWinLooseAiArray(i,3) == 0
            BsMoveWinLooseAiArray(i,4) = 100; % 100% WR if no looses
        else
            BsMoveWinLooseAiArray(i,4) = 100* BsMoveWinLooseAiArray(i,2)/(BsMoveWinLooseAiArray(i,2)+BsMoveWinLooseAiArray(i,3));
        end
    end
    
    for i = 2:length(AceMoveWinLooseAiArray)
        if AceMoveWinLooseAiArray(i,3) == 0
            AceMoveWinLooseAiArray(i,4) = 100; % 100% WR if no looses
        else
            AceMoveWinLooseAiArray(i,4) = 100* AceMoveWinLooseAiArray(i,2)/(AceMoveWinLooseAiArray(i,2)+AceMoveWinLooseAiArray(i,3));
        end
    end

end





%% break


















%% Output to CSV

% BASIC STRATEGY AI generated
BS = arrayfun(@num2str, char(outputBSarray(:,4)), 'UniformOutput', 0);
BS = cell2mat(BS);
outputBSarray = [outputBSarray(:,1),outputBSarray(:,2),outputBSarray(:,3)];

% writematrix([],'BlackjackBasicAI.csv');
% writematrix(outputBSarray,'BlackjackBasicAI.csv','WriteMode','append');
% type 'BlackjackBasicAI.csv'

fileID = fopen('BlackjackBasicAIoutput.csv','w');

fprintf(fileID,'%s,',"DEALER");
fprintf(fileID,'%s,',"TOTAL");
fprintf(fileID,'%s,',"MOVE");
fprintf(fileID,'%s\n',"OTHER");

i=2;
for row = 2:(length(outputBSarray)-1)
    fprintf(fileID,'%d,',outputBSarray(row,2));
    fprintf(fileID,'%d,',outputBSarray(row,3));
    fprintf(fileID,'%c,',BS(row));
    fprintf(fileID,'%c\n',BS(row)); % other not implemented, just copy prev column
    i = i+1;
end

fprintf(fileID,'%d,',outputBSarray(i,2));
fprintf(fileID,'%d,',outputBSarray(i,3));
fprintf(fileID,'%c,',BS(i));
fprintf(fileID,'%c',BS(i)); % other not implemented, just copy prev column

fclose(fileID);

% BASIC STRATEGY ACES
BSA = arrayfun(@num2str, char(outputAceBSarray(:,4)), 'UniformOutput', 0);
BSA = cell2mat(BSA);
outputAceBSarray = [outputAceBSarray(:,1),outputAceBSarray(:,2),outputAceBSarray(:,3)];

% writematrix([],'BlackjackIfAceAI.csv');
% writematrix(outputAceBSarray,'BlackjackIfAceAI.csv','WriteMode','append');
% type 'BlackjackIfAceAI.csv'

fileID = fopen('BlackjackIfAceAIoutput.csv','w');

fprintf(fileID,'%s,',"DEALER");
fprintf(fileID,'%s,',"CARD");
fprintf(fileID,'%s,',"MOVE");
fprintf(fileID,'%s\n',"OTHER");

i=2;
for row = 2:(length(outputAceBSarray)-1)
    fprintf(fileID,'%d,',outputAceBSarray(row,2));
    fprintf(fileID,'%d,',outputAceBSarray(row,3));
    fprintf(fileID,'%c,',BSA(row));
    fprintf(fileID,'%c\n',BSA(row)); % other not implemented, just copy prev column
    i = i+1;
end

fprintf(fileID,'%d,',outputAceBSarray(i,2));
fprintf(fileID,'%d,',outputAceBSarray(i,3));
fprintf(fileID,'%c,',BSA(i));
fprintf(fileID,'%c',BSA(i)); % other not implemented, just copy prev column

fclose(fileID);

disp("done")
