function [result, returnIndex, returnIndexAce] = BlackjackGame(BSArray, AceArray)
%% Preparation

% talia
talia = zeros(52,1);
index = 1;
for card = 2:10         % 2 - 10
    for amount = 1:4
        talia(index,1) = card;
        index = index+1;
    end
end
for figure = 1:3        % J Q K 
    for amount = 1:4
        talia(index,1) = 10;
        index = index+1;
    end
end
for amount = 1:4        % A     
    talia(index,1) = 11;
    index = index+1;
end
%disp(talia);

% table
cardsOnTableIndexes = zeros(4,1);

playerAces = 0;
dealerAces = 0;

% player cards
playerCard1Index = randi(52);
while ismember(playerCard1Index,cardsOnTableIndexes)
    playerCard1Index = randi(52);
end
cardsOnTableIndexes(1,1) = playerCard1Index;

playerCard2Index = randi(52);
while ismember(playerCard2Index,cardsOnTableIndexes)
    playerCard2Index = randi(52);
end
cardsOnTableIndexes(2,1) = playerCard2Index;

% dealer cards
dealerCard1Index = randi(52);
while ismember(dealerCard1Index,cardsOnTableIndexes)
    dealerCard1Index = randi(52);
end
cardsOnTableIndexes(3,1) = dealerCard1Index;

dealerCard2Index = randi(52);
while ismember(dealerCard2Index,cardsOnTableIndexes)
    %disp("XXXXXXXXXXXX " + dealerCard2Index)
    dealerCard2Index = randi(52);    
end
cardsOnTableIndexes(4,1) = dealerCard2Index;
% disp(cardsOnTableIndexes);

% indexes to cards - cardsOnTable (values)
cardsOnTable = zeros(4,1);
cardsOnTable(1,1) = talia(cardsOnTableIndexes(1,1)); % player1
cardsOnTable(2,1) = talia(cardsOnTableIndexes(2,1)); % player2
cardsOnTable(3,1) = talia(cardsOnTableIndexes(3,1)); % dealer1
cardsOnTable(4,1) = talia(cardsOnTableIndexes(4,1)); % dealer2
% count nr of aces
if cardsOnTable(1,1) == 11
    playerAces = playerAces + 1;
end
if cardsOnTable(2,1) == 11
    playerAces = playerAces + 1;
end
if cardsOnTable(3,1) == 11
    dealerAces = dealerAces + 1;
end
if cardsOnTable(4,1) == 11
    dealerAces = dealerAces + 1;
end

%disp("Player: " + cardsOnTable(1,1) + " / " + cardsOnTable(2,1));
%disp("Dealer: " + cardsOnTable(3,1) + " / hidden card" ); %+ cardsOnTable(4,1));
%disp(cardsOnTable(1,1) + "/" + cardsOnTable(2,1) + " vs " + cardsOnTable(3,1));


% next 20 hitCards
hitCardsIndexes = zeros(20,1);
for i = 1:20
    tempHitCardIndex = randi(52);
    while (ismember(tempHitCardIndex,cardsOnTableIndexes) || ismember(tempHitCardIndex,hitCardsIndexes))
        tempHitCardIndex = randi(52);
    end
    hitCardsIndexes(i,1) = tempHitCardIndex;
end
% disp(hitCardsIndexes);

hitCards = zeros(20,1);
for i = 1:20
    hitCards(i,1) = talia(hitCardsIndexes(i,1));
end
% disp(hitCards);

%

%

%

% some stuff with indexes for MWL tables
returnIndex = 0;
returnIndexAce = 0;

%% BASIC RULES

isAceTable = false;
totalPlayer = cardsOnTable(1,1)+cardsOnTable(2,1);
if playerAces > 0
    [totalPlayer, ~] = AceCheck(totalPlayer, 11);
end
totalDealer = cardsOnTable(3,1)+cardsOnTable(4,1);
if dealerAces > 0
    [totalDealer, ~] = AceCheck(totalDealer, 11);
end
stand = false;
usedHitCards = 0;

% instant result
if totalPlayer == 21 && totalDealer ~= 21
    % only you hit blackjack
    result = 1;
    return
end
if totalDealer == 21 && totalPlayer ~= 21
    % only dealer hit blackjack
    result = -1;
    return
end
if totalPlayer == 21 && totalDealer == 21
    result = 0;
    return
end

% 100% moves
if totalPlayer < 8
    % hit
    usedHitCards = usedHitCards + 1;
    totalPlayer = totalPlayer + hitCards(usedHitCards);
    if hitCards(usedHitCards) == 11
        playerAces = playerAces + 1;
        [totalPlayer, ~] = AceCheck(totalPlayer, hitCards(usedHitCards));
    end
end
if (totalPlayer > 17 && cardsOnTable(1,1) ~= 11 && cardsOnTable(2,1) ~= 11)
    % stand (if not having ace)
    stand = true;
    result = CheckResult(stand, totalPlayer, totalDealer, dealerAces, hitCards, usedHitCards);
    return
end

% choose table
if (cardsOnTable(1,1) == 11 || cardsOnTable(2,1) == 11)
    % use Ace table
    isAceTable = true;
else
    % use BS table
    isAceTable = false;
end




% make a move(s) - H (72) / S (83)
% TODO - AceCheck

% jesli acearray to wykonaj odpowiedni ruch i przejdz do sprawdzenia
% kolejnego ruchu w bsarray
if isAceTable == true
    [move, returnIndexAce] = ReadMoveFromAce(AceArray, cardsOnTable(3,1), ...
                           cardsOnTable(1,1), cardsOnTable(2,1));
    if move == 83 
        % stand
        stand = true;
        result = CheckResult(stand, totalPlayer, totalDealer, dealerAces, hitCards, usedHitCards);
        return
    elseif move == 72
        % hit
        usedHitCards = usedHitCards + 1;
        totalPlayer = totalPlayer + hitCards(usedHitCards);
        if hitCards(usedHitCards) == 11
            playerAces = playerAces + 1;
            [totalPlayer, ~] = AceCheck(totalPlayer, hitCards(usedHitCards));
        end
    else
        disp("wtf move");
    end
end

% TODO jesli bsarray to sprawdzaj kolejne ruchy w petli poki nie wypluje S (83)

if totalPlayer < 18
    [move, returnIndex] = ReadMoveFromBS(BSArray, cardsOnTable(3,1), ...
                          totalPlayer);
    while (move == 72) % petla dopoki odczytujemy hity 
        % hit
        usedHitCards = usedHitCards + 1;
        totalPlayer = totalPlayer + hitCards(usedHitCards);
        if hitCards(usedHitCards) == 11
            playerAces = playerAces + 1;
            [totalPlayer, ~] = AceCheck(totalPlayer, hitCards(usedHitCards));
        end

        [move, ~] = ReadMoveFromBS(BSArray, cardsOnTable(3,1), ...
                          totalPlayer);
    end
    
    if move == 83
        % stand
        stand = true;
        result = CheckResult(stand, totalPlayer, totalDealer, dealerAces, hitCards, usedHitCards);
        return
    else
        disp('rip, sth wrong in BlackjackGame with move')
    end
else
    % stand
    stand = true;
    result = CheckResult(stand, totalPlayer, totalDealer, dealerAces, hitCards, usedHitCards);
    return
end

result = CheckResult(stand, totalPlayer, totalDealer, dealerAces, hitCards, usedHitCards);
% (1) - win / (0) - push / (-1) - loose

end