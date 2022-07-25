#!/usr/bin/env/env bash
sudo apt update && sudo apt install nodejs npm
# Install pm2 which is a production process manager for Node.js with a built-in load balancer.
sudo npm install -g pm2
# Stop any instance of our application currently running
pm2 stop example_app
# Change Directory into folder where application is downloaded
cd ExampleApplication/
# Install dependencies
npm install
# Start with pm2
pm2 start ./bin/www --name example_app