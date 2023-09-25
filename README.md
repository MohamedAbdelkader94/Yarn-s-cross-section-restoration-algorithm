# Yarn-s-cross-section-restoration-algorithm
The algorithm redraws the yarn's cross-section low-resolution images from the micro-computed tomography machines, as the diameter of a single fiber is around 10 um, and the CT scanner doesn't give clear high-resolution cross-sections. 

The algorithm consists of two steps/two files; the first step is to allocate and measure the diameter of the low-resolution distorted fibers in the cross-section image. The second step creates a new cross-section image with clear and high-resolution fibers using the information extracted in the first step (the location and diameter of every fiber). 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          1- Yarn diameter algorithm: 
              1. Prompt the user to select an image file from a directory.
              2. Get the list of image files in the directory.
              3. Count the number of images in the directory.
              4. Iterate over each image in the directory:
                 a. Read the image.
                 b. Perform preprocessing operations on the image.
                 c. If it is the first iteration:
             •	Ask the user to measure an approximate diameter for one cross-section using the prompt measuring tool.
                 d. Ask the user whether all the images belong to the same sample and magnification level.
                 e. Perform thresholding on the image to convert it into a binary image.
                 f. Identify the connected regions in the binary image.
                 g. Calculate the threshold value for filtering out small noisy components.
                 h. Filter out small components based on the threshold value.
                 i. Apply morphology operations, such as dilation, to enhance the detected regions.
                 j. Perform additional area filtration if necessary.
                 k. Detect circles (the fiber’s cross sections) in the processed image using appropriate parameters.
                 l. Visualize the detected circles on the original image.
                 m. Save the output image with the overlaid circles in the same directory.
                 n. Save the detected circle parameters (centers and radii) to a file in the same directory.
             5. End of the algorithm.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
        2- Regen cross-section algorithm: 
             1. Input: Directory containing a reference image and cross-section images in XLSX format.
             2. Let 'ref_image' be the reference image read from the file path provided by the user.
             3. Get the list of XLSX files in the cross-section directory.
             4. Count the number of XLSX files in the directory.
             5. Initialize 'index' variable to 1.
             6. Iterate over each XLSX file in the directory:
                 a. Read the XLSX sheet.
                 b. Extract the x and y coordinates of each individual fiber cross-section points.
                 c. Extract the diameter values that matches each individual fiber cross-section points.
                 d. Create a logical image with the same size as the reference image.
                 e. For each cross-section point:
                       i. Calculate the circle's center and radius based on the coordinates and diameter.
                       ii. Create a logical image of the circle in the reference image.
                       iii. Accumulate the circle image into the cross-section image.
                f. Save the cross-section image as a JPG file.
           7. End of the algorithm
---------------------------------------------------------------------------------------------------------------------------------------------------------------

