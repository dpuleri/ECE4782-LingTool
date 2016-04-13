function plot_words(word_inds)
% function plot_words(word_inds)
% utility function to plot vertical lines at those indices
% on a plot that is already on screen
hold on
for i = 1:length(word_inds)
    yl = get(gca,'ylim');
    plot([word_inds(i) word_inds(i)], yl, 'r-');
end
hold off
end