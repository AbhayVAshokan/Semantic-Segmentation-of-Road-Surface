#! /bin/bash

# Paste this file in the folder containing idd-segmentation folder
# Run the command: bash seperator_segmentation.bash
# Edit array CLASS_NAMES such that it contains your required class only

CURRENT_DIRECTORY=`pwd`;
SOURCE_PATH="${CURRENT_DIRECTORY}/IDD_Segmentation";
DESTINATION_PATH="${CURRENT_DIRECTORY}/Segmentation Dataset";

CLASS_NAMES=("road" "parking" "drivable fallback" "sidewalk" "non-drivable fallback" "rail track" "person" "animal" "rider" "motorcycle" "bicycle" "autorickshaw" "car" "truck" "bus" "caravan" "trailer" "vehicle fallback" "curb" "wall" "fence" "guard rail" "billboard" "traffic sign" "traffic light" "pole" "polegroup" "obs-str-bar-fallback" "building" "bridge" "tunnel" "vegetation" "sky" "fallback background" "out of roi");

# Creating   destination path hierarchy
mkdir "Segmentation Dataset";
cd "Segmentation Dataset";
mkdir train;
mkdir val;
mkdir test;

cd train;
mkdir image;
mkdir annotation;
cd ..;

cd val;
mkdir image;
mkdir annotation;
cd ..;

# TRAINING DATA
PATH_TO_JSON="$SOURCE_PATH/gtFine/train";
PATH_TO_IMAGE="$SOURCE_PATH/leftImg8bit/train";
count=0;

cd "$PATH_TO_JSON";
ls > .temporary_file1.txt;

# Loop each subfolder in train
while read folder_name; do
    SUBFOLDER=$folder_name;
    cd $SUBFOLDER;
    ls > .temporary_file2.txt;

    # Loop each json_file in sub folder
    while read json_name; do
        JSON_FILE=$json_name;
         
        # Loop through all classes
        for class in "${CLASS_NAMES[@]}" ; do
            if [[ `cat $json_name | grep "$class" | wc | sed 's/|/ /' | awk '{print $1, $8}'` -ne 0 ]]
            then 
                destination="$DESTINATION_PATH/train/annotation";
                cp $json_name "$destination";

                image_name=${json_name/gtFine_polygons.json/leftImg8bit.png};
                destination="$DESTINATION_PATH/train/image";
                cd "$PATH_TO_IMAGE/$folder_name";
                cp $image_name "$destination";
                cd "$PATH_TO_JSON/$folder_name";
            fi
        done
        count=$((count + 1));
        clear;
        echo "FILE COUNT: $count/7974      $((count*100/7974))% completed";
        echo "Train:      $count/6993       $((count*100/6993))% completed";
        echo "Validation: 0/981         0% completed";
        # echo "Test:       0/2029        0% completed";


    done <.temporary_file2.txt
    rm .temporary_file2.txt;

    cd "$PATH_TO_JSON";
    
done <.temporary_file1.txt

cd "$PATH_TO_JSON";
rm .temporary_file1.txt;


# VALIDATION DATA
PATH_TO_JSON="$SOURCE_PATH/gtFine/val";
PATH_TO_IMAGE="$SOURCE_PATH/leftImg8bit/val";
count=0;

cd "$PATH_TO_JSON";
ls > .temporary_file1.txt;

# Loop each subfolder in train
while read folder_name; do
    SUBFOLDER=$folder_name;
    cd $SUBFOLDER;
    ls > .temporary_file2.txt;

    # Loop each json_file in sub folder
    while read json_name; do
        JSON_FILE=$json_name;
         
        # Loop through all classes
        for class in "${CLASS_NAMES[@]}" ; do
            if [[ `cat $json_name | grep "$class" | wc | sed 's/|/ /' | awk '{print $1, $8}'` -ne 0 ]]
            then 
                destination="$DESTINATION_PATH/val/annotation";
                cp $json_name "$destination";

                image_name=${json_name/gtFine_polygons.json/leftImg8bit.png};
                destination="$DESTINATION_PATH/val/image";
                cd "$PATH_TO_IMAGE/$folder_name";
                cp $image_name "$destination";
                cd "$PATH_TO_JSON/$folder_name";
            fi
        done

        count=$((count + 1));
        clear;
        echo "FILE COUNT: $((count+6993))/7974     $(((count+6993)*100/7974))% completed";
        echo "Train:      6993/6993     100% completed";
        echo "Validation: $count/981           $((count*100/981))% completed";
        # echo "Test:       0/2029          0% completed";

    done <.temporary_file2.txt
    rm .temporary_file2.txt;

    cd "$PATH_TO_JSON";
    
done <.temporary_file1.txt

cd "$PATH_TO_JSON";
rm .temporary_file1.txt;


# TEST DATA
 PATH_TO_IMAGE="$SOURCE_PATH/leftImg8bit/test";
count=0;

cd "$PATH_TO_IMAGE";
ls > .temporary_file1.txt;

# Loop each subfolder in train
while read folder_name; do
    SUBFOLDER=$folder_name;
    destination="$DESTINATION_PATH/test";
    cd $SUBFOLDER;
    ls > .temporary_file2.txt;

    # Loop each image file in sub folder
    while read image_name; do
        cp $image_name "$destination";

        count=$((count + 1));
        clear;
        echo "FILE COUNT: $((count+6993+981))/7974      $(((count+6993+981)*100/7974))% completed";
        echo "Train:      6993/6993       $((count*100/6993))% completed";
        echo "Validation: 981/981         0% completed";
        echo "Test:       $count/2029        0% completed";


    done <.temporary_file2.txt
    rm .temporary_file2.txt;
    
done <.temporary_file1.txt

cd "$PATH_TO_IMAGE";
rm .temporary_file1.txt;
