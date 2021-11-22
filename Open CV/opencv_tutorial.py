import  cv2
import numpy as np

#Reading an image
img = cv2.imread('./resources/bbking.jpg')
cv2.imshow("Output",img)
cv2.waitKey(0)


#Reading a video.
cap = cv2.VideoCapture('resources/acordes.mp4')
while True:
    success,img = cap.read()
    cv2.imshow('Video',img)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break


    
#Reading video from webcam.    
cap = cv2.VideoCapture(0)
cap.set(3,640)
cap.set(4,480)
while True:
    success,img = cap.read()
    cv2.imshow('Video',img)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break


# Grey scale image. 
img = cv2.imread('resources/bbking.jpg')  
kernel = np.ones((5,5),np.uint8)
imgGray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) 

# Edge detector 
imgCanny = cv2.Canny(img,100,100)
imgDialation = cv2.dilate(imgCanny,kernel,iterations=5)
imgEroded = cv2.erode(imgDialation,kernel,iterations=1)

# Show the images. 
cv2.imshow('Gray',imgGray)
cv2.imshow('Canny',imgCanny)
cv2.imshow('Dialation Image',imgDialation)
cv2.imshow('Erotion Image',imgEroded)
cv2.waitKey(0)

Width : # Columnas
Height : # Filas

img = cv2.imread('resources/bbking.jpg') 
print(img.shape) 
imgResize = cv2.resize(img,(300,200)) # width , height 
imgCropped = imgResize[0:200,100:] # height, width (filas,columnas)
#cv2.imshow('Image',img)
cv2.imshow('Resize',imgResize)
cv2.imshow('Cropped',imgCropped)
cv2.waitKey(0)


# Chapter 4 
img = np.zeros((512,512,3),np.uint8)
img[200:300,100:200] = 255,0,0
cv2.imshow('img',img)
cv2.waitKey(0) 


#Detect colors
img = cv2.imread('resources/bbking.jpg') 
print(img.shape) 
imgResize = cv2.resize(img,(300,200)) # width , height 


imgHSV = cv2.cvtColor(imgResize,cv2.COLOR_BGR2HSV)

cv2.imshow('Resize',imgResize)
cv2.imshow('HSV img',imgHSV)
cv2.waitKey(0)



img = cv2.imread('resources/bbking.jpg') 
print(img.shape) 
imgResize = cv2.resize(img,(300,200)) # width , height 
cv2.imshow('Resize',imgResize) 

faceCascade = cv2.CascadeClassifier('resources/haarcascade_frontal')