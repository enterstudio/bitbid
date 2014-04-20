
# this function outputs the current timestamp
timestamp(){
  echo $(date +"%Y%m%d%H%M");
}

echo "Running exporter script"
echo "running bids exporter"
ruby ./trader/bids_exporter.rb > data/bids/bids.csv
echo "running asks exporter"
ruby ./trader/asks_exporter.rb > data/asks/asks.csv
echo "running trades exporter"
ruby ./trader/trades_exporter.rb > data/trades/trades.csv
echo "done"
