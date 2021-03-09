![](https://github.com/EmpireDemocratiqueDuPoulpe/VoiceMeeterCracklingFixer/blob/main/IconSet/128.png)

# VoiceMeeter Crackling Fixer
This little script can help you to fixed a bug where VoiceMeeter microphone suddently sutter at every word you pronounce. The solution came from [this video](https://www.youtube.com/watch?v=71HrZfR_Fro) and I just made a runnable script of it. The advantage is that it's simpliest to fix the problem and you can set a task to run this script every time you start your computer.

> This script require administrator privileges.

**Warning: This script isn't signed. Use it at your own risk or if you really sure what you're doing.**

## Installation

1. Download the entire repository or, at least, [the script file](https://github.com/EmpireDemocratiqueDuPoulpe/VoiceMeeterCracklingFixer/blob/main/VoiceMeeterFixer.ps1).
2. Put the script in a safe directory that you will not delete/move later.
3. That's it for the minimal installation. But you can make your life even more easier by following the instructions below.

## Adding a shorcut
Without a shortcut, double clicking the file doesn't run the script. And you can't run it with elevated privileges simply by right clicking it. The shortcut will make all of this much simpler.

1. Right click your Desktop or whatever folder you'd like to have a shortcut.
2. In the menu: New > Shortcut
3. A window open asking you a path. Put: `powershell.exe -ExecutionPolicy Bypass SCRIPT_PATH` where `SCRIPT_PATH` is the path to the script.
    - Example: `powershell.exe -ExecutionPolicy Bypass C:\Users\name\Documents\VoiceMeeterFixer\VoiceMeeterFixer.ps1`
4. Press next and give a name to the shortcut _(choose anything you want)_.
5. Right click the newly created shortcut and click Properties.
7. Click the "Advanced" button the check the first box. It will automaticaly run the script as administrator.
8. (Optional: Add a beautiful icon to the shortcut)
    1. Download the [ico file](https://github.com/EmpireDemocratiqueDuPoulpe/VoiceMeeterCracklingFixer/blob/main/IconSet/icon.ico).
    2. Put it in the same folder as the script.
    3. Right click your shortcut and press "Change icon".
    4. Select the ico file you just downloaded and press "Ok".
    5. Press again "Ok" to close shortcut properties.

## Auto-start at computer startup
If you're reading this, you want to make your life even nicer than before. And this is possible by simply let Windows start the script each time you turn on your computer. Without this incredible feature, you'll be forced to manually start the script/shortcut everytime the problem occurs. Can you imagine a world like that?

1. Search and open "Task Scheduler" in your Windows search bar.
    - If nothing shows up you can press Windows + R then write `taskschd.msc` and press Enter. 
2. In the left panel, click on the first folder you see. This will show somes tasks already registered.
3. Right click the same folder in the left panel and:
    - **Easy way:** Click on "Import task".
        - Import [this task file](https://github.com/EmpireDemocratiqueDuPoulpe/VoiceMeeterCracklingFixer/blob/main/VoiceMeeterFixerTask.xml).
        - Check the user account used to run the task.
    - **Long way:** Click on "New task".
        - In the "General" panel:
            - Set a name.
            - Check the user.
            - Click on "Run whether user is logged on or not".
            - Click on "Run with highest privileges".
        - In the "Triggers" panel:
            - Create a new trigger and make select "On startup".
        - In the "Actions" panel:
            - Create a new action.
            - Select "Run a program".
            - In the Program box, put `powershell.exe`.
            - In the Arguments box, put `-ExecutionPolicy Bypass SCRIPT_PATH` where `SCRIPT_PATH` is the path to the script.
            - In the last box, put `SCRIPT_PATH` where `SCRIPT_PATH` is the same as before without the script name.
        - In the "Conditions" panel:
            - Uncheck "Start the task only if the computer is on AC power".
