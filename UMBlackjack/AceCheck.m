function [ht, av] = AceCheck(handTotal, aceValue)
    
    if (handTotal + 10 < 22 && aceValue == 1)
        aceValue = 11;
        handTotal = handTotal + 10;
        % for now unreachable - no cards of value 1
    elseif (handTotal > 21 && aceValue == 11)
        aceValue = 1;
        handTotal = handTotal - 10;
        %disp("Changed A - 11 to 1")
    end
    
    ht = handTotal;
    av = aceValue;
end