# OSMNoiseEstimation
With the development of urbanization, **noise pollution** is a major issue in many big cities. One major source of urban noise is traffic-related noise, which is mainly caused by traffic flows. Besides traffic noise, urban noise can also be generated from other sources, e.g., industrial areas and construction sites. This work is inspired by the work of https://github.com/lukasmartinelli/osm-noise-pollution, and here we focus on using PostGIS (https://postgis.net/) to generate noise pollution maps from OpenStreetMap (https://www.openstreetmap.org/).  

Traffic noise            |  Industry noise
:-------------------------:|:-------------------------:
<img width="600" height="500"  src="https://github.com/wzy19840102/OSMNoiseEstimation/blob/main/fig/noise.jpg" /> |  <img width="600" height="500"   src="https://github.com/wzy19840102/OSMGreenBlueSpace/blob/main/fig/green.jpg" />
photo from https://unsplash.com/ |  photo from https://unsplash.com/ 



####  1. Defing noise levels
The noise levels are defined 
and totally there are four noise levels. Note that the order of levels are reversed to make data processing easier.
Zone dB <br>
L3 ≥ 65 <br>
L2 55 - 64.9 <br>
L1 45 - 54.9 <br>
L0 <45 <br>

####  2. Considered Tags
1\). Roads: <br>
highway= motorway, motorway_link, 60m (L3), 220m (L2), 550m (L1) <br>
highway= trunk, trunk_link, 50m (L3), 190m (L2), 400m (L1) <br>
highway=primiary, primary_link, 35m (L3), 160m (L2), 300m (L1) <br>
highway=secondary, secondary_link, 80m (L2), 125m (L1) <br>
highway=tertiary, tertiary_link， 35m (L2), 65m (L1) <br>
2\). Areas <br>
industry= industrial 50m(L2) 100m(L1) <br>
landuse=retail 70m(L2) 180m(L1) <br>
3\). railways <br>
rail=[rail, narrow_gauge, preserved] 30m(L3) 60m(L2) 100m(L1) <br>
rail=[light_rail, tram, funicular, monorail] 30m(L2) 60m(L1) <br>

#### 3. Sql for noise data extraction
The provided sql can  <br>
1). create noise buffers with different distances, taking into account the considered tags  <br>
2). do intersection operations between ways and buffers to get the noise level  <br>

#### 4. Some preliminary results (from osm data of Berlin)
A generated noise map can be found below.
<p align="center"">
   <img src="https://github.com/wzy19840102/OSMNoiseEstimation/blob/main/fig/berlin.PNG" width="50%" />
</p>
