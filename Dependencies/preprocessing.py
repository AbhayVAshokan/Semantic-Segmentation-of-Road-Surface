import os
import numpy as np
from tqdm.notebook import tqdm_notebook
from Dependencies.getMask import create_mask

def get_data(path, train=True):
    ids = next(os.walk(path + "/image"))[2]
    X = np.zeros((len(ids), im_height, im_width, 1), dtype=np.float32)
    if train:
        y = np.zeros((len(ids), im_height, im_width, 1), dtype=np.float32)
    print('Getting and resizing images ... ')
    for n, id_ in tqdm_notebook(enumerate(ids), total=len(ids)):
        # Load images
        img = load_img(path + '/image/' + id_, color_mode = "grayscale")
        x_img = img_to_array(img)
        x_img = resize(x_img, (128, 128, 1), mode='constant', preserve_range=True)

        # Load annotation
        if train:
            an_ = id_[:6] + "_gtFine_polygons.json"
            with open(path_train + "/annotation/" + an_) as f:
                data = json.load(f)
            mask = img_to_array(create_mask(data))
            mask = resize(mask, (128, 128, 1), mode='constant', preserve_range=True)

        # Save images
        X[n, ..., 0] = x_img.squeeze() / 255
        if train:
            y[n] = mask / 255
    print('Done!')
    if train:
        return X, y
    else:
        return X