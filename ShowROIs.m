%% Josh Barrios 4/6/2019
% Visualize ROIs from an entry in fluo_data

function plot_fig = ShowROIs(fluo_data,trial_ind)

plot_fig = figure;
imagesc(fluo_data(trial_ind).template);

hold on
for k = 1:length(fluo_data(trial_ind).ROI_locs)
    plot(fluo_data(trial_ind).ROI_locs{k}(1,:),fluo_data(trial_ind).ROI_locs{k}(2,:),'LineWidth',3)
end