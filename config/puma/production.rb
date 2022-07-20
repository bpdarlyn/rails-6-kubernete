# directory '/var/app/current'
# threads 8, 32
# workers %x(grep -c processor /proc/cpuinfo)
# bind 'unix:///var/run/puma/my_app.sock'

directory '/app'
# rackup "/app/config.ru"

# tag ''

pidfile "/app/tmp/pids/puma.pid"
state_path "/app/tmp/pids/puma.state"
stdout_redirect '/app/log/production.log', '/app/log/puma.error.log', true
activate_control_app

threads 0, 6



bind 'unix:///app/tmp/puma/my_app.sock'

workers %x(grep -c processor /proc/cpuinfo)

preload_app!

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end
#
on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
