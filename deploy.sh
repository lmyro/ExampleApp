
#!/usr/bin/env bash
sudo apt update && sudo apt install nodejs npm
 # install pm2 which is production process manager for nodejs w/ built in load balancer
npm install -g pm2
 # stop any instance of application running
pm2 stop example_app
 # change directory into folder where application is downloaded
cd ExampleApp/
 # install app dependencies
sudo npm install
 # start app w/ process name example_app
pm2 start ./bin/www --name example_app 