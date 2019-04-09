#!/bin/basha
cd /var/www/html/OGNRANGE
date
#
echo "Stop de OGNRANGE daemon, in order to improve performance"
#
killall perl
#
echo "Deleting the phantom STATIONS"
#
bash deletephantoms.sh NAVITER
bash deletephantoms.sh FLYMASTER
bash deletephantoms.sh SPOT
bash deletephantoms.sh SPIDER
bash deletephantoms.sh INREACH
bash deletephantoms.sh SKYLINES
bash deletephantoms.sh LT24
bash deletephantoms.sh CAPTURS
bash deletephantoms.sh RELAY
bash deletephantoms.sh 0
bash deletephantoms.sh Test
bash deletephantoms.sh N0CALL
bash deletephantoms.sh Home
bash deletephantoms.sh MyStation
bash deletephantoms.sh abcde
#
echo "deleting the pseudo STATIONS"
#
bash deleteFNB.sh      FNB
bash deleteFNB.sh      XCG
bash deleteFNB.sh      XCC
bash deleteFNB.sh      OGN
bash deleteFNB.sh      ICA
bash deleteFNB.sh      FLR
bash deleteFNB.sh      bSkyN
bash deleteFNB.sh      AIRS
bash deleteFNB.sh      AIRS-
bash deleteFNB.sh      TEST
#
echo "deleting the data before January 2018"
#
#mysql --login-path=ognrange ognrange <config/deleteoldata.sql
#
echo "Check and delete stations with no location and data with no station in the ognrange database"
#
bash deloldstations.sh
bash delzombies.sh
#
echo "Check and optimize the ognrange database"
#
mysql        --login-path=ognrange -e "reset query cache;"           ognrange
mysqlcheck   --login-path=ognrange                                   ognrange
mysql        --login-path=ognrange -e "reset query cache;"           ognrange
#mysqlcheck --optimize --skip-write-binlog      --login-path=ognrange ognrange
date
#
echo "Start de OGNRANGE daemon ..."
#
bash /home/angel/src/OGNrangecheck.sh
