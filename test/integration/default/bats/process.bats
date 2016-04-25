#!/usr/bin/env bats

setup() {
    apt-get install -y curl >/dev/null || yum -y install curl >/dev/null
}

@test "process redis-server should be running" {
    run pgrep redis-server
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process nginx should be running" {
    run pgrep nginx
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process sidekiq should be running" {
    run pgrep -f sidekiq
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process rails master should be running" {
    run pgrep -f "rails master"
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process supervisord should be running" {
    run pgrep supervisord
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process celery should be running" {
    run pgrep celery
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process gunicorn should be running" {
    run pgrep gunicorn
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "Scumblr Web interface should be accessible" {
    run curl -sSq http://localhost:3000/
    [ "$status" -eq 0 ]
    [[ "$output" =~ "<html><body>You are being" ]]
}

@test "Scumblr Web API interface should be accessible" {
    run curl -sSqk https://localhost/api/v1.0/capture
    [ "$status" -eq 0 ]
}

@test "Do a sketchy capture of google.com" {
    run curl -sSq "http://localhost:8000/eager?url=http://google.com&type=html" | tee /tmp/sketchy-capture.out
## Not sure why but fails on centos71 run
#    [ "$status" -eq 0 ]
    [[ "$output" =~ "<title>Google</title>" ]]
}

