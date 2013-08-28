# 
#
# iPhone Software Engineering
# Assignment 1
# Daniel Carrion (3349681)
#
#

About the app
--------------

This apps links into an API for a community science project called theSkyNet POGS. The
project has users volunteering computer power for astronomy science. The app will allow
users to view their contribution, trophies, news, and other information.

See http://production-test.theskynet.org for more information on the project.


Important notes to marker
--------------------------

To test the app, you must provide a user ID at the login screen. These IDs are integer 
values > 1. 

Example accounts are ID "1", which contains galaxy data and ID "25", which does not.

The app has a logout feature under the "profile" tab. The app persists login info on
exit - See additional features.

The app is still in very early stage, but meets requirements for assignment 1.

Additional feature for 15 marks:
--------------------------------

There are a couple of technical features.

1. When the user views galaxy detail, the image view is gesture enabled allowing switch
between the different type of filter images. Use the swipe gesture on the hidden images
to the left and right to see this in action. You will also note the labels change.

2. In the galaxy detail view, there is a "NED" logo button that opens the web page 
associated with the galaxy with more details - provided by Caltech service.

3. The app uses iOS keychain to store persistent user id. Currently implemented using a 
third party keychain wrapper. To eventually store user password when app switches to
provide authenticated only data as well. See TSNShared implementation.