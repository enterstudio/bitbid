function [ output ] = find_arbit( bids, asks, trades )
%FIND_ARBIT Summary of this function goes here
%   bids represent the current sale offers that are open in the market
%   asks represent the current buy offers that are open in the market

    num_bids = size(bids,1);
    num_asks = size(asks,1);
    
    fprintf('Bids and Asks\n\n')
    disp(strcat('Bids: ',num2str(num_bids)));
    disp(strcat('Asks: ',num2str(num_asks)));
    fprintf('Asks/Bids: %5.5f\n',num_asks/num_bids);
    
    % calculate volumes 
    sum_bids_vol = sum(bids(:,1).*bids(:,2));
    sum_asks_vol = sum(asks(:,1).*asks(:,2));
    sum_trades_vol = sum(trades(:,1).*trades(:,2));

    fprintf('\nVolumes\n')
    fprintf('Bids Volume: %10.10f\n',sum_bids_vol);
    fprintf('Asks Volume: %10.10f\n',sum_asks_vol);
    fprintf('Trad Volume: %10.10f\n',sum_trades_vol);
    
    % prices
    min_bid_price = min(bids(:,1));
    max_bid_price = max(bids(:,1));
    min_ask_price = min(asks(:,1));
    max_ask_price = max(asks(:,1));
    min_trades_price = min(trades(:,1));
    max_trades_price = max(trades(:,1));
    
    fprintf('\nPrices\n')
    fprintf('Min bid price: %20.20f\n',min_bid_price);
    fprintf('Max bid price: %20.20f\n',max_bid_price);
    fprintf('Min ask price: %20.20f\n',min_ask_price);
    fprintf('Max ask price: %20.20f\n',max_ask_price);
    fprintf('Min ask price: %20.20f\n',min_trades_price);
    fprintf('Max ask price: %20.20f\n',max_trades_price);
    
    
    plot(unique(sort(bids(:,1))));
    hold on;
    %plot(unique(sort(trades(:,1))),'-g');
    %hold on;
    plot(unique(sort(asks(1:end-50,1))),'-r');
    hold off;
    legend('bids (buy)','asks(sell)');
    
    
end

