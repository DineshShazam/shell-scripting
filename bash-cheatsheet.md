# Bash-Scripting

### FILE SYSTEM

* List the Directory
  * **ls -a **⇒ lists the hidden files
  * **ls -l** ⇒ list the folder permission and timestamp created.
* List the path of the working directory
  * **pwd**
* create a file
  * **touch fileName**
* Create a directory
  * **mkdir folderName**
* Copy file to the mentioned folder
  * **cp -rf *file* *folderName***
* Move File to a Folder
  * **mv /filePath/ /folderPath/**
* To remove a file or directory 
  * **rm -rf /directory** --> will remove both file and directory
  * **rmdir /directory** --> will remove the directory 
* To list the size of the files 
  * **du -h**
* To List the free space in the disk
  * **df -h**
* To change the owner of the file 
  * **chown *userName* *fileName***
* List the difference between two files 
  * **diff file1.txt file2.txt**
* Find Directories and Files
  * **find /directory to search**
  * **find /directory to search -type d** --> will list only the directory 
  * **find /file to search -type f** --> will list only the files
  * **find /path -empty** --> will list the empty text file 
  *  **find /path -type f -iname "*.txt"** --> will list files that has extension .txt
  *  **find /path -type f -iname "*.txt" -exec rm -rf {} +** --> will delete all the files with extension .txt

### GREP 
* Search for a particular string in a file
  * **grep "string to search" file**
* List only when the complete string is found
  * **grep -w "string" file** 
* Will display the line no of the string. 
  * **grep -n "string" file**
* For case insensitive search
  * **grep -i "string" file** 
* To search the string in all files
  * **grep -win "string" ./docker/*txt**
* To list the file path that contains the string 
  * **grep -wirl "string"** 
* To export the values in a file 
  * **export $(grep -v '^#.*' .env | xargs)**

### ZIP
* To Install Zip
  * sudo apt-get install zip
* To zip a directory
  * **zip -r zipName.zip folder**
* To unzip a file 
  * **unzip zipName.zip**
* To create a tar file 
  * **tar -cvf tarName.tar folder**
* Extract tar file
  * **tar -xvf tarName.tar**
* Compress the tar
  * **gzip -v tarName.tar**
* Un-Compress the tar
  * **gunzip -v tarName.tar.gz**  

### PACKAGE MANAGEMENT
* Update the packages in the distro 
  * **sudo apt-get update**
* Update a particular package 
  * **sudo apt-get upgrade *packageName***
* Install a package 
  * **sudo apt-get install *packageName*** 
* Remove un-used packages
  * **sudo apt-get autoremove**
* Remove a particular package 
  * **sudo apt-get remove *packageName***
* List the Installed packages
  * dpkg --list 
* List the Typed commands
  * history 

### SYSTEM MANAGEMENT & ENVIRONMENTAL VARIABLE
* Switch to ROOT user
  * **sudo bash & sudo -s**
* Switch to root user and use the env variables of the logged in user 
  * **sudo -E su**
* Back to normal user from root user 
  * **exit or su *username***
* Display memory and ram consumption 
  * **htop & top**
* List the processes in the machine 
  * **ps**
* Provides Information on how long the system is up 
  * **uptime**
* Store a env value for a temporary session 
  * **export KEYNAME=value**
* Store a env value permanently
  * Open the .bashrc file
    * **vim .bashrc**
    * click **i** for insert mode 
    * add this text in the .bashrc file **export PATH=value**
    * click on **esc** & **:wq** to save and exit 
  * For nano editor 
    * **ctrl + o** for saving the text
    * **ctrl + x** for exiting the editor  

### CHMOD PERMISSIONS 
* To change the permission of a file 
  * **chmod 777 *fileName***
  * **chmod read(+r)write(+w)executable(+x) *fileName***
```sh
0 = 0 => no permissions
1 = 1 => execute(x)
2 = 2 => write(w)
3 = 2+1 => w+x (write and execute)
4 = 4 => read(r)
5 = 4+1 => r+x (read and execute)
6 = 4+2 => r+w (read and write)
7 = 4+2+1 = r+w+x (read and write and execute)
```

