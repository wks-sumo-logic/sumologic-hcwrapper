SumoLogic Health Check Wrapper
==============================

This is designed to allow a Customer Service to run Health Checks for a client base

Installing the Project
======================

These scripts are in bash, so installation for a Unix, Windows, or Unix system will be easy.
Currently setup for MacIntosh, the directories can be changed to suite

    1. Download and install git for your platform if you don't already have it installed.
       It can be downloaded from https://git-scm.com/downloads
    
    2. Open a new shell/command prompt. It must be new since only a new shell will include the new python 
       path that was created in step 1. Cd to the folder where you want to install the scripts.
    
    3. Clone this repo using the following command:
    
       git clone git@github.com:wks-sumo-logic/sumologic-hcwrapper.git

       This will create a new folder sumologic-hcwrapper
    
    6. Change into the folder. Type the following to install all the package dependencies 
       Adjust the configuration file to put in credentials and web
        
Dependencies
============

This script will need an access key and id, you can generate them on the Sumologic support 
site and then place those into the config file located in the etc directory.

Script Names and Purposes
=========================

Scripts and Functions:

    1. hcwrapper.sh - This is the main script. you can run this with -h to see options
                      The defaults will walk through all of the clients listed in the config file

To Do List:
===========

* Add a query via curl to get specific clients. Currently the client config is managed manually

License
=======

Copyright 2019 Wayne Kirk Schmidt

Licensed under the GNU GPL License (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    license-name   GNU GPL
    license-url    http://www.gnu.org/licenses/gpl.html

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Support
=======

Feel free to e-mail me with issues to: wschmidt@sumologic.com
I will provide "best effort" fixes and extend the scripts.
/Users/wschmidt/Downloads/sumologictoolbox-master/Pipfile
