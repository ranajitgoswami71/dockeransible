#!/bin/bash

docker_install ()
{
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker "${SCRIPT_FOR}"
docker -v
}

index_file_check ()
{
##Check if required html file exists
ls -lrt "${PROJECT_DIR}"/index.html
if [ $? -gt 0 ]
then
        echo "index.html file does not exist"
        exit 1
else
        echo "File exist"
fi
}

index_file_nginx ()
{
echo "<html>" > "${PROJECT_DIR}"/index.html
echo " " >> "${PROJECT_DIR}"/index.html
echo "<!--" >> "${PROJECT_DIR}"/index.html
echo "Author: Ranajit Goswami" >> "${PROJECT_DIR}"/index.html
echo "Date:   March 8, 2019" >> "${PROJECT_DIR}"/index.html
echo "-->" >> "${PROJECT_DIR}"/index.html
echo " ">> "${PROJECT_DIR}"/index.html
echo " " >> "${PROJECT_DIR}"/index.html
echo " " >> "${PROJECT_DIR}"/index.html
echo "<h3><center>Ranajit Goswami's Homepage<center></h3>" >> "${PROJECT_DIR}"/index.html
echo " ">> "${PROJECT_DIR}"/index.html
echo "<hr>" >> "${PROJECT_DIR}"/index.html
echo " " >> "${PROJECT_DIR}"/index.html
echo "<center><IMG SRC=\"http://www.servtech.com/public/newt/elway.gif\"></center>" >> "${PROJECT_DIR}"/index.html
echo " " >> "${PROJECT_DIR}"/index.html
echo "<hr>" >> "${PROJECT_DIR}"/index.html
echo " ">> "${PROJECT_DIR}"/index.html
echo " " >> "${PROJECT_DIR}"/index.html
echo " " >> "${PROJECT_DIR}"/index.html
echo "<b>Important TCS links!" >> "${PROJECT_DIR}"/index.html
echo "<br>" >> "${PROJECT_DIR}"/index.html
echo " " >> "${PROJECT_DIR}"/index.html
echo "<hr>" >> "${PROJECT_DIR}"/index.html
echo " " >> "${PROJECT_DIR}"/index.html
echo "<H2>Links here</H2>" >> "${PROJECT_DIR}"/index.html
echo "<A HREF=\"https://www.ultimatix.net/\">TCS Ultimatix</A>" >> "${PROJECT_DIR}"/index.html
echo "<br>" >> "${PROJECT_DIR}"/index.html
echo " " >> "${PROJECT_DIR}"/index.html
echo "<hr>" >> "${PROJECT_DIR}"/index.html
echo " " >> "${PROJECT_DIR}"/index.html
echo "<H2>Ranajit's Oracle Link</H2>" >> "${PROJECT_DIR}"/index.html
echo "<A HREF=\"http://java.sun.com/applets/applets/TumblingDuke/example1.html\">Oracle-Tumbling Duke" >> "${PROJECT_DIR}"/index.html
echo "Duke</A>" >> "${PROJECT_DIR}"/index.html
echo "<br>" >> "${PROJECT_DIR}"/index.html
echo "<A HREF=\"http://java.sun.com/applets/applets/Hangman/index.html\">Oracle Hangman</A>" >> "${PROJECT_DIR}"/index.html
echo "<br>" >> "${PROJECT_DIR}"/index.html
echo "<hr>" >> "${PROJECT_DIR}"/index.html
echo "<br>" >> "${PROJECT_DIR}"/index.html
echo " " >> "${PROJECT_DIR}"/index.html
echo "</html>" >> "${PROJECT_DIR}"/index.html

}

dockerfile_creation_nginx ()
{
echo "# Pull base image." > "${PROJECT_DIR}"/Dockerfile
echo "FROM ubuntu:latest" >> "${PROJECT_DIR}"/Dockerfile
echo " " >> "${PROJECT_DIR}"/Dockerfile
echo "# Install Nginx." >> "${PROJECT_DIR}"/Dockerfile
echo "RUN apt-get update" >> "${PROJECT_DIR}"/Dockerfile
echo "RUN apt-get install -y nginx" >> "${PROJECT_DIR}"/Dockerfile
echo "RUN rm -rf /var/lib/apt/lists/*" >> "${PROJECT_DIR}"/Dockerfile
echo "RUN echo \"\\\ndaemon off;\" >> /etc/nginx/nginx.conf" >> "${PROJECT_DIR}"/Dockerfile
echo "RUN chown -R www-data:www-data /var/lib/nginx" >> "${PROJECT_DIR}"/Dockerfile
echo " " >> "${PROJECT_DIR}"/Dockerfile
echo "# Define mountable directories." >> "${PROJECT_DIR}"/Dockerfile
echo "VOLUME [\"/etc/nginx/sites-enabled\", \"/etc/nginx/certs\", \"/etc/nginx/conf.d\", \"/var/log/nginx\", \"/var/www/html\"]" >> "${PROJECT_DIR}"/Dockerfile
echo " " >> "${PROJECT_DIR}"/Dockerfile
echo "ADD index.html /var/www/html/index.html" >> "${PROJECT_DIR}"/Dockerfile
echo " " >> "${PROJECT_DIR}"/Dockerfile
echo "# Define working directory." >> "${PROJECT_DIR}"/Dockerfile
echo "WORKDIR /etc/nginx" >> "${PROJECT_DIR}"/Dockerfile
echo " " >> "${PROJECT_DIR}"/Dockerfile
echo "# Define default command." >> "${PROJECT_DIR}"/Dockerfile
echo "CMD [\"nginx\"]" >> "${PROJECT_DIR}"/Dockerfile
echo " " >> "${PROJECT_DIR}"/Dockerfile
echo "# Expose ports." >> "${PROJECT_DIR}"/Dockerfile
##echo "EXPOSE 9090" >> "${PROJECT_DIR}"/Dockerfile
##echo "EXPOSE 443" >> "${PROJECT_DIR}"/Dockerfile
}

docker_container_create ()
{
sudo docker build -t autosample:1.1 "${PROJECT_DIR}"/.
sudo docker run --name autosamplecont -d -p 9090:80 autosample:1.1
}


##Check if Ubuntu machine

PROJECT_DIR=`pwd`

MACHINE=`uname -v|cut -d " " -f1|cut -d "-" -f2`
SCRIPT_FOR=Ubuntu
if [ "${MACHINE}" = "${SCRIPT_FOR}" ]
then
        echo "This is an Ubuntu machine.Proceeding for docker installation."
	docker_install
        index_file_nginx
	echo "Creating html file"
	index_file_check
        dockerfile_creation_nginx
	echo "Proceeding for docker container creation."
        docker_container_create
else
        echo "Not an Ubuntu machine.Docker container creation terminated."
        exit 1
fi
