echo "setting up ruby"
source ~/.rvm/scripts/rvm
type rvm | head -n 1
rvm requirements
rvm use ruby-2.4.0 --default
