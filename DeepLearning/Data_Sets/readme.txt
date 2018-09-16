"KIT Dataset for Tracking People in Aerial Image Sequences"
http://www.ipf.kit.edu/downloads_People_Tracking.php

(C) http://creativecommons.org/licenses/by/3.0/ "KIT AIS Dataset"

2012-10-01

Image Sequence
=================================================================

The available image sequence has been created by cutting out a predefined region of interest in a sequence of aerial images. The sequence was captured from a plane flying at an altitude of about 1500 m. The camera system consists of three cameras which are looking in front, nadir and back direction. 
Every Image has been orthorectified with a ditigal elevation model and directly georeferenced with GPS/IMU system. Afterwards all images taken at the same time are fused in a mosaique to form a single image. These preprocessing steps contain small errors which become visible in the frame alignment.
The number of frames in a sequence depends on the overlap in flight direction and the configuration of the camera.


Labeling Procedure
=================================================================

The labeling of the position of individuals has been done manually by researches and students. Therefor the reference data contains a small amount of errors.
The center position of the person's head has been marked in all frames, in which the person is present.
There are frames and crowded situations in which a single person is hardly visible. Yet we still tried to estimate the track as good as possible.
A person's track does not have to be labeled continously. A specific person can therefor vanish and reappear.


Syntax of XML Reference File
=================================================================

The syntax of the xml files follows the proposals of 
Thor List and Robert B. Fisher: "CVML - an XML-based computer vision markup language" (2004), http://homepages.inf.ed.ac.uk/tlist/papers/list-fisher-icpr04-cvml.pdf
and the dataset format of the CAVIAR project (http://homepages.inf.ed.ac.uk/rbf/CAVIAR/).

<?xml version="1.0" ?>
<dataset name="Munich01">
    <frame number="0" file="XON0143.png" utc="2009-Oct-24 13:11:14.386000" color="rgb" depth="byte" gsd="0.15" x="694878" y="5.34382e+006" latitude="48.2144" longitude="11.6228" sunny="1">
        <objectlist>
            <object id="0">
                <box xc="63" yc="127" w="4" h="4" />
                <representation type="Circle" xc="63" yc="127" r="2" />
            </object>
            <object id="1">
                <box xc="69" yc="129" w="4" h="4" />
                <representation type="Circle" xc="69" yc="129" r="2" />
            </object>
			...
			
frame
-number		: consequtive frame number which does not have to start with 0 
-file		: file name
-utc		: recording time
-color		: color space
-depth		: data type
-gsd		: pixel size in [m]
-x			: x-coordinate (UTM/WGS84) of the top left image corner
-y			: y-coordinate (UTM/WGS84) of the top left image corner
-latitude	: lat-coordinate (WGS84) of camera during recording
-longitude	: lon-coordinate (WGS84) of camera during recording
-sunny		: 1=sunny (persons have shadow), 0=cloudy (persons have no shadow)

objectlist	: contains all objects that have been manually labeled in the current frame

object
-id				: object id stays constant over all frames
-box			: object bounding box with center in image coordinates and size in pixel
-representation	: (Geometric) representation of the object in the image