driverZaid
==========

Unleashed 2014 entry for team On The Spot

.h2 About the Application

This application builds on Open Data and Open Source Software to provide an aid to road users.

The central idea is that drivers generally use the roads in good faith
but that mistakes happen and often simple mistakes leak to serious problems.
Various levels of Government provide the roads for use by the population but
there are issues that are difficult for the Government to resolve with 
current technology. In particular:

* people speed; despite road signs and penalties, people still make mistakes
* roads gradually deteriate, sometimes disastrously and although users often see the problem it is hard for them to get the information
to the correct place in Government.

DriverZaid attempts to address this by providing continuous speed-zone information to drivers and to provide
crowd sourced data from drivers to help Government with maintenance of the roads.

.h2 About the Data

This project uses datasets from http://data.sa.gov.au and from http://data.gov.au

Some datasets are loaded into SQLite database files within this repository, please refer to the documentation at the above sites 
for copyright and usage information.

ACT Emergency Services data is licensed under: http://creativecommons.org/licenses/by/3.0/au/

The data.sa.gov.au website licence is at: http://data.sa.gov.au/copyright

Specific datasets may have additional licence restrictions. Please inform us by email to onthespot@driverzaid.com if you find
any problems with our use of the data.

Datasets used by the application (not all datasets are included within this code repository)

* http://data.sa.gov.au/dataset/road-crashes-in-sa
* http://data.sa.gov.au/dataset/rest-areas
* http://data.sa.gov.au/dataset/roadside-significant-sites
* http://data.sa.gov.au/dataset/pedestrian-crossings
* http://data.sa.gov.au/dataset/school-crossings
* http://data.sa.gov.au/dataset/bike-direct-network
* http://data.sa.gov.au/dataset/roads
* http://data.sa.gov.au/dataset/statewide-rail-network
* http://data.sa.gov.au/dataset/adelaide-public-transport-stop-data
* http://www.data.sa.gov.au/dataset/south-australian-country-fire-service-current-incidents-rss-feed
* http://www.data.sa.gov.au/dataset/expiation-notice-system-data

In addition, this application is intended to use data from other sources once the issues are resolved. In particular, the application is 
expected to use:

* http://www.openstreetmap.org
* RAA road quality data (tbd)
