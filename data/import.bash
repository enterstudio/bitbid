
# this function outputs the current timestamp
timestamp(){
  echo $(date +"%Y%m%d%H%M");
}


ruby ./trader/bids_exporter.rb > data/bids/$(timestamp).csv
ruby ./trader/asks_exporter.rb > data/asks/$(timestamp).csv

