function [move, returnIndex] = ReadMoveFromBS(BSArray, dealerCard, playerTotal)
    moveH = 72;
    moveS = 83;
    returnIndex = 0;

    % TODO
    % dealerCard + playerTotal => BSArray ===> move

    for index = 2:length(BSArray)
        if (BSArray(index,2) == dealerCard && BSArray(index,3) == playerTotal)
            move = BSArray(index,4); % if matched dealercard with player card 
                                     % => index in move column (4)
            returnIndex = index;
            return
        end
    end

    % this disp will also pop if player has < 17, and it works
    % disp("Safety point in ReadMoveFromBS reached. - D:" +dealerCard+" / P:"+playerTotal)

    move = moveS;
end