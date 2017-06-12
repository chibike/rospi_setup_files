#!/usr/bin/env python

#Setup import files from the manifest file
PKG = "test_package"
import roslib; roslib.load_manifest(PKG)
import rospy

#Import support libraries for the Camera and other generic functions
import numpy as np
import matplotlib.pyplot as plt
import cv2
import math

#Import the necessary message formats needed
from test_package.msg import Int32Array

class ColorImageDataPublisher(object):
    def __init__(self, fps=10):
        self.capture_device = None

        #Initialize this module as a ros node
        rospy.init_node('ColorImageDataPublisher')

        #Setup publishers
        self.color_data_pub = rospy.Publisher("ColorData_1", Int32Array, queue_size=10)

        #Setup refresh rate variables
        self.fps = min(max(1, fps), 30)
        self.rate = rospy.Rate(self.fps)

        self.color_data_2_send = Int32Array()

    def start(self):
        self.capture_device = cv2.VideoCapture(0)

    def run(self):
        while True:
            ret, frame = self.capture_device.read()
            print np.shape(frame)

    def publishData(self):
        if type(self.frame) == type(None):
            return False

        self.color_data_2_send.data = self.frame.ravel().tolist()
        self.color_data_pub.publish(self.color_data_2_send)

        return True

    def end(self):
        self.capture_device.release()

def main():
    #Create a publisher object with framerate = 5
    my_data_publisher = ColorImageDataPublisher(5)

    #Start publisher
    my_data_publisher.start()

    #Run publisher
    my_data_publisher.run()

    #End publisher
    my_data_publisher.end()

#If code is running directly run the main function
if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass
    
