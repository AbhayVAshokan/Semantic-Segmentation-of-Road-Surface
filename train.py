from Dependencies.preprocessing import get_data

# Set some parameters
im_width = 128
im_height = 128
border = 5
path_train = 'Road-Segmentation-Dataset/train'
path_test = 'Road-Segmentation-Dataset/test'

X, y = get_data(path_train, train=True)
X_train, X_valid, y_train, y_valid = train_test_split(X, y, test_size=0.15, random_state=2018)