# Converts the json file to corresponding 

import cv2
import numpy as np
import PIL.ImageDraw as ImageDraw
import PIL.Image as Image

def create_mask(data):
    w = data["imgWidth"]
    h = data["imgHeight"]
    image = np.zeros((w, h))
    
    region = data["objects"]
    for i in range(len(region)):
        if region[i]["label"] == "road":
            road = region[i]["polygon"]
            break

    image = Image.new("1", (w, h))
    draw = ImageDraw.Draw(image)

    shape = tuple(map(tuple, road))
    draw.polygon((shape), fill=200)

    image = np.array(image)
    image = Image.fromarray(np.uint8(plt.cm.gist_earth(image)*255))
    mask = np.array(image)

    mask = 255 - mask[:, :, 2]
    ret,mask = cv2.threshold(mask, 250, 255, cv2.THRESH_BINARY)
    return mask 