# gettingandcleaningdata
Getting and Cleaning data course assignment

Project scripts:
- run_analysis.R is the only one script in this project. 

In order to succesfully run the script it is necessary to create on
the same directory of the script another directory called UCIDataset with all the 
datasource with the following structure:

- UCIDataset
  - activity_labels.txt
  - features_info.txt
  - features.txt
  - README.txt
  - test
    - subject_test.txt
    - X_test.txt
    - y_test.txt
    - Inertial Signals
      - body_acc_x_test.txt
      - body_acc_y_test.txt
      - body_acc_z_test.txt
      - body_gyro_x_test.txt
      - body_gyro_y_test.txt
      - body_gyro_z_test.txt
      - total_acc_x_test.txt
      - total_acc_y_test.txt
      - total_acc_z_test.txt
  - train
    - subject_train.txt
    - X_train.txt
    - y_train.txt
    - Inertial Signals
      - body_acc_x_train.txt
      - body_acc_y_train.txt
      - body_acc_z_train.txt
      - body_gyro_x_train.txt
      - body_gyro_y_train.txt
      - body_gyro_z_train.txt
      - total_acc_x_train.txt
      - total_acc_y_train.txt
      - total_acc_z_train.txt
    
Dplyer package is required