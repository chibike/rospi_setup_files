#ros

cd ~/ros_catkin_ws/src/
catkin_create_pkg $PKGNAME std_msgs rospy roscpp
cd ~/ros_catkin_ws/
catkin_make
catkin_make install
. ~/ros_catkin_ws/devel/setup.bash
source /opt/ros/kinetic/setup.bash
source ~/ros_catkin_ws/devel/setup.bash

rospack depends1 $PKGNAME

roscd $PKGNAME
echo "Making dir in" && pwd
mkdir msg
cd msg
wget https://raw.githubusercontent.com/chibike/rospi_setup_files/master/ColorImageData.msg
wget https://raw.githubusercontent.com/chibike/rospi_setup_files/master/Float64Array.msg
wget https://raw.githubusercontent.com/chibike/rospi_setup_files/master/Float32Array.msg
wget https://raw.githubusercontent.com/chibike/rospi_setup_files/master/Int32Array.msg
wget https://raw.githubusercontent.com/chibike/rospi_setup_files/master/UInt32Array.msg
wget https://raw.githubusercontent.com/chibike/rospi_setup_files/master/UInt16Array.msg
wget https://raw.githubusercontent.com/chibike/rospi_setup_files/master/UInt8Array.msg

roscd $PKGNAME
echo "<?xml version=\"1.0\"?>" > package.xml
echo "<package>" >> package.xml
echo "  <name>$PKGNAME</name>" >> package.xml
echo "  <version>$VERSION</version>" >> package.xml
echo "  <description>The $PKGNAME package</description>" >> package.xml
echo "  <maintainer email=$EMAIL>pi</maintainer>" >> package.xml
echo "  <license>TODO</license>" >> package.xml
echo "  <buildtool_depend>catkin</buildtool_depend>" >> package.xml
echo "  <build_depend>roscpp</build_depend>" >> package.xml
echo "  <build_depend>rospy</build_depend>" >> package.xml
echo "  <build_depend>std_msgs</build_depend>" >> package.xml
echo "  <build_depend>message_generation</build_depend>" >> package.xml
echo "  <run_depend>message_runtime</run_depend>" >> package.xml
echo "  <run_depend>roscpp</run_depend>" >> package.xml
echo "  <run_depend>rospy</run_depend>" >> package.xml
echo "  <run_depend>std_msgs</run_depend>" >> package.xml
echo "  <export>" >> package.xml
echo "  </export>" >> package.xml
echo "</package>" >> package.xml

mkdir scripts
cd scripts
wget https://raw.githubusercontent.com/chibike/rospi_setup_files/master/publish_video_data.py
chmod +x publish_video_data.py
