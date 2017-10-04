#!/bin/sh

echo ""
echo ""

YELLOW='\033[1;33m';
NC='\033[0m'; # No Color

printf "${YELLOW}Please enter your site directory name:${NC} "
read dirname

# make project directory
mkdir $dirname
cd $dirname

# initialize git repo
git init

# .gitignore
touch .gitignore
cat > .gitignore << EOF
.DS_Store
.bundle/
EOF


# PROCFILE
touch Procfile
cat > Procfile << EOF
web: ruby server.rb -p $PORT
EOF

# Gemfile
touch Gemfile
cat > Gemfile << EOF
source "https://rubygems.org"

ruby "2.2.0"

gem "sinatra"
EOF

# config.ru
touch config.ru
cat > config.ru << EOF
require './index'
run Sinatra::Application
EOF

# Server
touch server.rb
cat > server.rb << EOF
require 'sinatra'

set :protection, :except => :frame_options

get '/' do
  File.read(File.join('public', 'index.html'))
end
EOF



# Views
mkdir public
touch public/index.html

cat > public/index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>
<body>
  <h1>hi</h1>
</body>
</html>



# commands
bundle install
ruby server.rb

open http://localhost:4567
