#! /bin/bash
echo
echo "#################################"
echo `date`
echo "---------------------------------"
echo "stop web server"
/etc/runscript/h2o stop
#PID=`ps x | grep -v grep | grep "h2o" | awk '{ print $1 }'`
#kill -9 $PID
/etc/init.d/apache2 stop

echo "---------------------------------"
echo "update key"
cd /home/seijiro/
# . /home/seijiro/venv27/bin/activate
which python
python --version
cd /home/seijiro/certbot/
## ./certbot-auto certonly --standalone --email modeverv@gmail.com --domain modeverv.aa0.netvolante.jp --renew-by-default
./certbot-auto certonly --standalone --email modeverv@gmail.com --domain mastdn.lovesaemi.daemon.asia --domain www.mastdn.lovesaemi.daemon.asia  --renew-by-default
./certbot-auto certonly --standalone --email modeverv@gmail.com --domain glassfish.lovesaemi.daemon.asia --domain www.glassfish.lovesaemi.daemon.asia  --renew-by-default
./certbot-auto certonly --standalone --email modeverv@gmail.com --domain lovesaemi.daemon.asia --domain www.lovesaemi.daemon.asia --renew-by-default


echo "---------------------------------"
echo "start web server"
/etc/init.d/apache2 start
/etc/runscript/h2o start

echo "end of script"
echo "#################################"
echo

TER=`openssl x509 -in /etc/letsencrypt/live/lovesaemi.daemon.asia/fullchain.pem -noout -dates`
echo $TER | mail -s "SSL更新終了" modeverv@gmail.com
