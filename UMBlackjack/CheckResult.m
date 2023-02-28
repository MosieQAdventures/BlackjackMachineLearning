function result = CheckResult(stand, playerTotal, dealerTotal, dealerAces, hitCards, usedHitCards)
    if stand == true

        % do dealer moves
        while dealerTotal < 17 % hit until 17
            usedHitCards = usedHitCards + 1;
            dealerTotal = dealerTotal + hitCards(usedHitCards);
            if hitCards(usedHitCards) == 11
                dealerAces = dealerAces + 1;
                [dealerTotal, ~] = AceCheck(dealerTotal, 11);
            end
        end

        % result rules
        if (playerTotal > 21 && dealerTotal <= 21) %player bust
            result = -1;
        elseif (dealerTotal > 21 && playerTotal <= 21) %dealer bust
            result = 1;
        elseif playerTotal > dealerTotal %win total
            result = 1;
        elseif dealerTotal > playerTotal %loose total
            result = -1;
        elseif playerTotal == dealerTotal %push total
            result = 0;
        else
            result = 0; % safe push if sh1t goes bad
        end

    else %stand = false                            % shouldn't happen
        disp("stand == false !ERROR >< >< >< >< ><")
        result = 0;
    end
end