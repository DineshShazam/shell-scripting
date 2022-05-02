# Bash-Scripting

### FILE SYSTEM

* List the Directory
  * **ls -a** ⇒ lists the hidden files
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
* Writing content to a text file
  * **echo "hello-world" > file.txt**
  * To append the text
  * **echo "hello-world" >> file.txt**
* To merge two files to a single file
  * **cat file1.txt,file2.txt > total.txt**
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
  * **sudo apt-get install zip**
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
* Find the location of the installed package
  * **which python3**
* List the Installed packages
  * **dpkg --list** 
* List the Typed commands
  * **history** 

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

### DEVOPS COMMANDS
* Mainly used for testing and trouble shooting the DNS servers
  * **nslookup URL**
  * [nslookup query examples](https://www.thegeekstuff.com/2012/07/nslookup-examples/)
* List the Network connections on the system
  * **netstat**
  * To list only the active connection and the listening port
    * **netstat -ntlp**
  * To know which process listening on the specific port 
    * **netstat -lp | grep $port**
* Alias is a command line shortcut  
  * Navigate to your .bashrc
  * **alias cdkv2="cd cdk/v2/code/"**
  * will navigate to the code folder
* tee copies the STOUT of a process to a file
  * **wc -l file1.txt|tee -a file2.txt**
* SSH
* ssh used to connect to a remote server basically its a network communication protocol that enables two computer to communicate. 
  * To connect to a remote server
    * **ssh remoteUserName@ServerIP**
  * Connecting to an ec2 server via SSH
    * **ssh /path/to/pemFile ubuntu@server-public-ip**
* CURL
* curl is a command line utility used to transfer data to a server without user interaction
  * The below command will print the source code of the home page for the mentioned website
    * **curl URL (i.e curl https://www.google.com/)**
  * To fetch only the http headers
    * **curl -I --http2 URL** 
    * -I flag prints only the headers
  * Print the output to a file  
    * **curl -o temp.txt URL**
    * -o flag will write the output to the mentioned file
  * Test if the website supports http2
    * **curl -I --http2 -s https://www.google.com/ | grep HTTP**
    * HTTP/2 200 means it supports http/2
    * HTTP/1.1 200 OK means it is not supporting http/2
  * To follow the redirects by the main URL
    * **curl -L URL**
    * -L flag mention on the redirection
  * GET request using curl 
    * **curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET https://hostname/resource**
  * POST request using curl
    * **curl -X POST -H "Content-Type: application/json" -d '{"username":"abc","password":"abc"}' https://domain.com**
* SED
* sed is used like find and replace tool 
  * Replace text globally in the file
    * **sed 's/old-text/new-text/g' fileName**
  * Replace only the first and second occurrence
    * **sed 's/old-text/new-text/2' fileName**
  * Replace string of a specific line no 
    * **sed '3 s/old-text/new-text/' fileName**
  * Printing the replaced line
    * **sed -n 's/old-text/new-text/g' fileName**

### CONDITIONAL STATEMENTS
* Integer Comparison
  * -eq => is equal to   -- i.e  if [  "$1"  -eq 10 ] 
  * -ne => is not equal to --i.e if [ $a -ne 10 ]
  * -gt => is greater than
  * -ge => is greater than or equal to 
  * -le => is less than or equal to  
  * < is less than --i.e if (($a < 10 ))
  * <= less than or equal to 
  * > greater than
  * >= greater than or equal
* String Comparison 
  * if [ $a == "e" ]


### TERMINAL OPERATORS
* When the first command is executed successfully the second command will get executed
  * **echo "hello" && echo "world"**
* Execute multiple commands in single line (semi-colon operator)
  * **git add .;git commit -m "";git origin push**
* Only when the first command fails the second command gets executed its like a else statement
  * **echo "hello" || echo "world"**
* Combination Operator
  * **echo "hello" && {echo "world"; echo "worked"}**

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

### REDIRECT STDOUT AND STDERR IN BASH
```sh
1> redirect the STDOUT
1>> redirect the STDOUT in append mode
2> redirect the STDERR
2>> redirect the STDERR in append mode
&> redirect both STDERR and STDOUT
&>> redirect both STDERR and STDOUT in append mode
2>&1 redirect STDERR to STDOUT
```

### DNS RECORD TYPES
```sh
- A record --> Indicates an IP address of the domain 
- NS record --> Name Server record indicates which DNS server is authoritative for that domain ( Where the actual DNS entries are)
- CNAME --> conical name for one domain to another domain
- MX record --> mail exchange, its a list of mail exchange servers used by the domain
- SOA record --> State of Authority and is easily one of the most important DNS records because stores information like when the domain was last updated
- SRV record --> Service Record, is a record that specifies hostname and port number for a specific service, it can be used for service discovery
```

