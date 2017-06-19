#!bin/bash

#opencv, pip, numpy
sudo apt-get purge wolfram-engine
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install build-essential cmake pkg-config
sudo apt-get install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install libxvidcore-dev libx264-dev
sudo apt-get install libgtk2.0-dev
sudo apt-get install libatlas-base-dev gfortran
sudo apt-get install python2.7-dev python3-dev

sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo rm -rf ~/.cache/pip

cd ~
sudo wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.1.0.zip
sudo unzip opencv.zip

sudo wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.1.0.zip
sudo unzip opencv_contrib.zip

sudo pip install numpy
cd ~/opencv-3.1.0/
sudo mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.1.0/modules \
    -D BUILD_EXAMPLES=ON ..

sudo make -j4
sudo make clean
sudo make

sudo make install
sudo ldconfig

sudo rm -rf opencv-3.1.0 opencv_contrib-3.1.0

#matplotlib
sudo apt-get install libblas-dev        ## 1-2 minutes
sudo apt-get install liblapack-dev      ## 1-2 minutes
sudo apt-get install python-dev        ## Optional]
sudo apt-get install libatlas-base-dev ## Optional speed up execution]
sudo apt-get install gfortran           ## 2-3 minutes
sudo apt-get install python-setuptools  ## ?
#sudo easy_install scipy                 ## 2-3 hours
sudo apt-get install python-matplotlib  ## 1 hour

#ros
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential cmake
sudo rosdep init
rosdep update
mkdir -p ~/ros_catkin_ws
cd ~/ros_catkin_ws

rosinstall_generator ros_comm --rosdistro kinetic --deps --wet-only --tar > kinetic-ros_comm-wet.rosinstall
wstool init src kinetic-ros_comm-wet.rosinstall

mkdir -p ~/ros_catkin_ws/external_src
cd ~/ros_catkin_ws/external_src
sudo wget http://sourceforge.net/projects/assimp/files/assimp-3.1/assimp-3.1.1_no_test_models.zip/download -O assimp-3.1.1_no_test_models.zip
sudo unzip assimp-3.1.1_no_test_models.zip
cd assimp-3.1.1
sudo cmake .
sudo make
sudo make install

cd ~/ros_catkin_ws
sudo rosdep install -y --from-paths src --ignore-src --rosdistro kinetic -r --os=debian:jessie

sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/kinetic

sudo source /opt/ros/kinetic/setup.bash

sudo echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc


#setting-up ros_catkin_ws
WORKSPACE_NAME = "mdxbot_workspace"

cd ~/ros_catkin_ws/src
sudo catkin_create_pkg $WORKSPACE_NAME std_msgs rospy roscpp

cd ~/ros_catkin_ws
sudo catkin_make -j2

sudo . ~/ros_catkin_ws/devel/setup.bash

mkdir build
cd build
sudo cmake ..
sudo make
sudo make install

sudo catkin_make -j2
sudo catkin_make install

cd ~/ros_catkin_ws/
sudo catkin_make -j2
