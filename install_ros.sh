#!/bin/bash

echo "************** Installing Ros *******************"

#define global variables
WORKSPACE_NAME="mdxbot_workspace"

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
