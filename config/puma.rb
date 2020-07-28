max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

port        ENV.fetch("PORT") { 3000 }
# bind "unix://#{Rails.root}/tmp/sockets/puma.sock" # socketの設定  
# daemonize # デーモン化  
# stdout_redirect "#{Rails.root}/log/stdout", "#{Rails.root}/log/stderr" # 標準主力とエラー出力先を指定  

environment ENV.fetch("RAILS_ENV") { ENV['RACK_ENV'] || "production" }
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }
preload_app!
plugin :tmp_restart