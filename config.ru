require './paymemo'

$stdout.sync = true # for Heroku logging
run PayMemo::App

