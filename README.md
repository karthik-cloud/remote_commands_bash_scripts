The purpose of the bash scripts is to run remote commands from a jumpbox to deploy, install and verify on a list of VMs.
In order to successfully run the scripts, there are 3 files that should be in the jumpbox file directory(home is fine)
1. vmlist that contains lines of VM names and each line MUST end with a space. Example:

devwestoltpvm0 
devwestoltpvm1 
devwestoltpvm2 
devwestoltpvm4 
CoreServices-VM-0 
CoreServices-VM-1 

2. a bash command file. Example:
mkdir /tmp/azcopy
cc /tmp/azcopy
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-trusty-prod trusty main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-get update -y
sudo apt-get install dotnet-sdk-2.0.2 -y
wget -O azcopy.tar.gz https://aka.ms/downloadazcopyprlinux
tar -xf azcopy.tar.gz
sudo ./install.sh
azcopy

Note: the above is just an example. Since this is a generic script, so you can run any bash commands in this file for articular tasks. For the above example, you can add more commands, for example using azcopy to copy files to somewhere.
azcopy \
    --source /mnt/myfiles \
    --destination https://myaccount.file.core.windows.net/myfileshare/ \
    --dest-key <key> \
    --recursive

3. remote_cmds.sh. This is the script to run the bash commands remotely. To run this file, one needs to make sure the file has 
execution permission. To add permission, run "chmod +500 <file_name>"
The syntax to run the script:
./remote_cmds.sh -u <VM_USER_ID> -p "<VM_Password>" -f <Full path of vm list file> -c <Full path of commands file>

Note: some password needs to be quoted by '' or "" as it may contains some special characters. An example of the command 
to run this script:
./remote_cmds.sh -u cassadmin -p 'c&ss#dm*n321!' -f vmlist -c azcopycmd


To verify the installation result, you can check the line with 
azcopy installation is completed on -------------->>>>>>>>>>> as the line is the last command executed in the script.
The actual result should be shown above the line

