function [ res] = plot_trades( trades )
%PLOT_TRADES Summary of this function goes here
%   Detailed explanation goes here

    prices = trades(:,2);

    plot(prices,'--b');
    hold on;
    plot(tsmovavg(prices,'e',100,1),'-m');
    hold on;
    plot(tsmovavg(prices,'e',500,1),'-r');
    hold on;
    plot(tsmovavg(prices,'e',1000,1),'-g');
    hold off;
end

