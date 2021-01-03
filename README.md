# Semantic Segmentation of Road Surface 

[![Open In Collab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1McvTbDIf9xOw4_wy7z5oJutM2J5BJeul?usp=sharing)

**Semantic Segmentation**: Semantic segmentation refers to the process of linking each pixel in an image to a class label. These labels could include a person, car, flower, piece of furniture, etc., just to mention a few. We can think of semantic segmentation as image classification at a pixel level.

It has applications in various algorithms in the field of autonomous vehicles. For instance, in the given image, semantic segmentation is used to classify vehicles, foot-path, pedestrians, buildings and trees.

<img src="https://cdn.analyticsvidhya.com/wp-content/uploads/2019/03/image-segmentation.png" width =75%>

This project implements a semantic segmentation of the road surface using U-Net.

**U-Net**: The UNET was developed by Olaf Ronneberger et al. for Bio Medical Image Segmentation. The architecture contains two paths. First path is the contraction path (also called as the encoder) which is used to capture the context in the image. The encoder is just a traditional stack of convolutional and max pooling layers. The second path is the symmetric expanding path (also called as the decoder) which is used to enable precise localization using transposed convolutions. Thus it is an end-to-end fully convolutional network (FCN), i.e. it only contains Convolutional layers and does not contain any Dense layer because of which it can accept image of any size.

<img src="https://miro.medium.com/max/700/1*OkUrpDD6I0FpugA_bbYBJQ.png" width=75%>

## Indian Driving Dataset
While several datasets for autonomous navigation have become available in recent years, they have tended to focus on structured driving environments. This usually corresponds to well-delineated infrastructure such as lanes, a small number of well-defined categories for traffic participants, low variation in object or background appearance and strong adherence to traffic rules. We propose a novel dataset for road scene understanding in unstructured environments where the above assumptions are largely not satisfied. It consists of 10,000 images, finely annotated with 34 classes collected from 182 drive sequences on Indian roads. The label set is expanded in comparison to popular benchmarks such as Cityscapes, to account for new classes.

The dataset consists of images obtained from a front facing camera attached to a car. The car was driven around Hyderabad, Bangalore cities and their outskirts. The images are mostly of 1080p resolution, but there are also some images with 720p and other resolutions.

The labels/annotations are provided in JSON format with various properties including date, label, and the the set of pixels enclosing the region of interest.

A bash script was used to separate out only those images which has roads.

### Steps
1. Converting labels into masks
Data (label) is available in the IDD dataset in JSON format. Each value represents a coordinate in the image. The coordinates are connected to form a region and it is colored with a color (200, 0, 0). After this operation, binary thresholding is done to get the output as either black or white. The output is called as a mask.
Visually, the mask represents the region of interest (The region that we need to detect).
In the JSON file, there are several classes available (road, car, autorickshaw, etc). As a first step, only the "road" property is extracted from the JSON file.

2. Generating train and test data.

3. Define the CNN

4. Define callbacks
**EarlyStopping**: Stop the training process when the loss function has stopped imporving for 10 continuous epochs.
**ReduceLROnPlateau**: Reduce learning rate when there is no change in metric (for three consequtive epochs).
**ModelCheckpoint**: Save the model whenever the epoch has improved the loss function. Advantage: We can force stop the training mid way and still have a model as ouput.

5. Train

6. Download and test the model using `test.py`.

### Setup 
```
pip install -r requirements.txt
```
