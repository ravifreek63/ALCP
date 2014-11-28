
function result=improvementsOccur(iterations,piUpdateTime)
    n=30;
    currentTime = length(iterations(:,1)); % In Terms Of Iterations Done.
    timeSinceLastPiUpdate = currentTime-piUpdateTime; %
    if(currentTime <= n || timeSinceLastPiUpdate <= n)
    result = 1;
    else
        lastImpForLB=whenDidLastImprovementOccur(iterations(end-n:end,3));
        lastImpForUB=whenDidLastImprovementOccur(iterations(end-n:end,5));
        if(lastImpForLB <= n || lastImpForUB <= n)
        result = 1;
        else
        result = 0;
        end
    end