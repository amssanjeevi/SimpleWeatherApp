#!/bin/bash

. ~/.nvm/nvm.sh
nvm use 12

appcenter distribute release -f artifacts/SellQuick-Adhoc/SellQuick.ipa -g All-users-of-SellQuick --app santu-1jos/SellQuick