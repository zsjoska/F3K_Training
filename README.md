# F3K TRAINING

Actual version 3.03B2 with some implements of X7 Views.
Original project on: https://www.rcgroups.com/forums/showthread.php?2298914-F3K-training-script-for-the-Taranis-Q-and-Horus/page22

1. Manage some missing view task on X7 folder and errors.
    - view_k.lua
    - view_l.lua
    - view_d.lua
    - view_d2.lua
2. Modify f3k.lua for select last task FF too.

## INSTALL IN OPENTX Radio
1. Open SD card of your openTX Radio
2. Copy this folder F3K_TRAINING in folder 'SDVolume':\SCRIPTS
3. Copy the f3k.lua in folder 'SDVolume':\SCRIPTS\TELEMETRY

## CUSTOMIZE SWITCH
This you can manage the prestet swicth to start / stop timer correctly.
1. open the 'sdVolume':\SCRIPTS\F3K_TRAINING folder
2. Open the Custom.lua file.
3. search this line local PRELAUNCH_SWITCH = 'se' and change 'se' with your preset switch if it is not equal.

## HOW TO SET F3K TRAINING
Select in the radio the F3K model, go to model setting on section "DISPLAY", in a one empty screen select "script" and then select "f3k.lua".
Now you can go in the corresponding page of the telemetry, select your task, toggle the sc switch and play with f3k training!!

