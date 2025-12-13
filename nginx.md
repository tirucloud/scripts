```
sudo apt install unzip nginx -y
sudo wget -O /tmp/lugx_temp.zip https://templatemo.com/download/templatemo_589_lugx_gaming
sudo unzip -q /tmp/lugx_temp.zip -d /var/www/
sudo mv /var/www/templatemo_589_lugx_gaming/* /var/www/html/
sudo rm -rf /tmp/lugx_temp.zip /var/www/templatemo_589_lugx_gaming
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
sudo systemctl restart nginx
```
