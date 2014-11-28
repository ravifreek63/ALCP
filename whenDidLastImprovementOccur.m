
function lastImp=whenDidLastImprovementOccur(iterations)
lastValue=iterations(end);      % lastValue = End Row 
ixLastImp=length(find(iterations~=lastValue)); % ixLastImp = Index of the second last element
lastImp=length(iterations)-ixLastImp ;          % always 1. 