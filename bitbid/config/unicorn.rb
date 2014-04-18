# Set the working application directory
working_directory "/var/www/bitbid"

# Unicorn PID file location
pid "/var/www/bitbid/pids/unicorn.pid"

# Path to logs
stderr_path "/var/www/bitbid/log/unicorn.log"
stdout_path "/var/www/bitbid/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.bitbid.sock"

# Number of processes
worker_processes 2

# Time-out
timeout 30
