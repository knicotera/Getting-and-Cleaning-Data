#Introduction 

Assuming the user has already:
<ul>
<li>downloaded and unzipped the file containing the data from the <a href="http://archive.ics.uci.edu/ml/index.html">UCI Machine Learning Repository</a>, and</li>
<li>set the working directory in the location of that unzipped data file</li></ul> 

The script <code> run_analysis.R </code> will:
<ul>
<li>read in and assign column names to the data from all required <code>.txt</code> files</li>
<li>merge the training and the test data sets to create one single data set</li>
<li>extract the measurements on the mean and standard deviation for each measurement as required by the course project instructions, subsetting the data to keep only the necessary columns</li>
<li>merge the existing data set with  <code>acitivityType</code> data to descriptively name the activities in the data set</li>
<li>appropriately label the data set with descriptive variable names, making the original variable names much easier to interpret</li>
<li>create an independent tidy data set with the average of each variable for each activity and subject</li>
<li>reorder the data to make it easier to read</li>
<li>export the tidy data set to a <code>.txt</code> file</li>
</ul>

# Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Source: <a href="http://archive.ics.uci.edu/ml/index.html">UCI Machine Learning Repository</a>

# Raw Data 

The original data set is divided into test data and training data containing: 
<ul>
<li>accelerometer measurements</li>
<li>gyroscope measurements</li>
<li>time and frequency variables</li>
<li>activity labels</li>
<li>subject identifiers</li>
</ul>

# Replacing Variables

Original variable names were modified in the following way:

<ul>
<li>Replaced <code>-std$</code> with <code>StdDev</code></li>
<li>Replaced <code>-mean</code> with <code>Mean</code></li>
<li>Replaced <code>^(t)</code> with <code>Time</code></li>
<li>Replaced <code>^(f)</code> with <code>Freq</code></li>
<li>Replaced <code>([Gg]ravity)</code> with <code>Gravity</code></li>
<li>Replaced <code>([Bb]ody[Bb]ody|[Bb]ody)</code> with <code>Body</code></li>
<li>Replaced <code>[Gg]yro</code> with <code>Gyro</code></li>
<li>Replaced <code>AccMag</code> with <code>AccMagnitude</code></li>
<li>Replaced <code>[Bb]odyaccjerkmag</code> with <code>BodyAccJerkMagnitude</code></li>
<li>Replaced <code>JerkMag</code> with <code>JerkMagnitude</code></li>
<li>Replaced <code>GyroMag</code> with <code>GyroMagnitude</code></li>
</ul>