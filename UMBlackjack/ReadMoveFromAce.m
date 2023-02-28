function [move, returnIndex] = ReadMoveFromAce(AceArray, dealerCard, playerCard1, playerCard2)
    moveH = 72;
    moveS = 83;
    returnIndex = 0;

    if (playerCard1 == 11 && playerCard2 == 11) % check for 2 aces
        move = moveH;
        return
    end

    if playerCard1 == 11        %1st card ace
        card = playerCard2;
    elseif playerCard2 == 11    %2nd card Ace
        card = playerCard1;
    end

    % TODO
    % dealerCard + card => AceArray ===> move

    for index = 2:length(AceArray)
        if (AceArray(index,2) == dealerCard && AceArray(index,3) == card)
            move = AceArray(index,4); % if matched dealercard with player card 
                                      % => index in move column (4)
            returnIndex = index;
            return
        end
    end

    disp("Safety point in ReadMoveFromAce reached. - D:" +dealerCard+" / P:"+card)
    move = moveS; 
end