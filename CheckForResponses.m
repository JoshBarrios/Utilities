%% Josh Barrios 11/29/18 
% Takes a set of stimulus and behavior frames for a particular neuron and
% determines which stimuli evoked a behavior

function responseBool = CheckForResponses(stims,bhavs)

for l = 1:length(stims)
    window = [stims(l)-3:stims(l)+3];
    if ~isempty(intersect(window, bhavs))
        responseBool(l) = 1;
    else
        responseBool(l) = 0;
    end
end