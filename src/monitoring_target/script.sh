wget -P . https://github.com/prometheus/node_exporter/releases/download/v1.12.1/node_exporter-1.12.1.linux-arm64.tar.gz
tar xvf node_exporter-*.tar.gz && rm node_exporter-*.tar.gz
cd node_exporter-* && sudo mv node_exporter /usr/local/bin 
sudo chmod +x /usr/local/bin/node_exporter
sudo useradd --no-create-home --shell /usr/sbin/nologin node_exporter && id node_exporter

sudo mv node_exporter.service /etc/systemd/system/ && sudo systemctl daemon-reload
sudo systemctl enable node_exporter && sudo systemctl start node_exporter && sudo systemctl status node_exporter

sudo wget -O /usr/local/bin/cadvisor https://github.com/google/cadvisor/releases/download/v0.60.5/cadvisor-v0.60.5-linux-arm64
sudo chmod +x /usr/local/bin/cadvisor
sudo useradd --no-create-home --shell /usr/sbin/nologin cadvisor && id cadvisor

sudo mv cadvisor.service /etc/systemd/system/ && sudo systemctl daemon-reload
sudo systemctl enable cadvisor && sudo systemctl start cadvisor && sudo systemctl status cadvisor

sudo usermod -aG docker cadvisor
sudo systemctl restart cadvisor

sudo groupadd cadvisor-docker
sudo chgrp -R cadvisor-docker /mnt/dietpi_userdata/docker-data
sudo chmod -R g+rx /mnt/dietpi_userdata/docker-data
sudo systemctl status cadvisor

sudo systemctl restart cadvisor
ls -ld /mnt/dietpi_userdata/docker-data