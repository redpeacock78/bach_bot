#! /bin/bash

function main() {
  # MySQLが立ち上がるまで待つ処理
  echo 'waiting for mysqld to be connectable...' &&
    until python3 libs/db_check.py 2>/dev/null; do
      sleep 10
    done &&
    echo 'connected!' &&
    {
      # メイン
      if [[ -n "$(cat /etc/debian_version 2>/dev/null)" ]]; then
        # Debian
        echo 'Start Debian version...' &&
          crontab cron.conf &&
          service cron start
      elif [[ -n "$(cat /etc/alpine-release 2>/dev/null)" ]]; then
        # Alpine
        echo 'Start Alpine version...' &&
          crontab cron.conf &&
          crond -l 8
      fi &&
        ./build/main
    }
}

main
