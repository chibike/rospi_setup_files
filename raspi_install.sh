#!/bin/bash

#opencv, pip, numpy
echo -e "\n\n\n\n************** Installing OpenCV, PIP, Numpy *******************"

sudo apt-get purge wolfram-engine
sudo apt-get update
sudo apt-get upgrade

sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo rm -rf ~/.cache/pip
sudo pip install numpy

echo -e "\n\n\n\n************** Installing OpenCV *******************"
sudo wget https://raw.githubusercontent.com/chibike/rospi_setup_files/master/install_opencv.sh
sudo chmod +x install_opencv.sh
sudo ./install_opencv.sh

#delete install file
sudo rm -rf install_opencv.sh

#matplotlib
echo -e "\n\n\n\n************** Installing Matplotlib *******************"
sudo apt-get install libblas-dev        ## 1-2 minutes
sudo apt-get install liblapack-dev      ## 1-2 minutes
sudo apt-get install python-dev        ## Optional]
sudo apt-get install libatlas-base-dev ## Optional speed up execution]
sudo apt-get install gfortran           ## 2-3 minutes
sudo apt-get install python-setuptools  ## ?
sudo easy_install scipy                 ## 2-3 hours
sudo apt-get install python-matplotlib  ## 1 hour

#ros
echo -e "\n\n\n\n************** Installing Ros *******************"
sudo wget https://raw.githubusercontent.com/chibike/rospi_setup_files/master/install_ros.sh
sudo chmod +x install_ros.sh
sudo ./install_ros.sh

#delete install file
sudo rm -rf install_ros.sh
