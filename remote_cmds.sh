#!/bin/bash

#Only run this on a jump box VM in a subscription
#command syntax : ./remote_cmds.sh -u <VM_USER_ID> -p "<VM_Password>" -f <Full path of vm list file> -c <Full path of commands file>

echo "Start to scan service versions"

while getopts ":u:p:f:c:" opt; do
  echo "Option $opt set with value $OPTARG"
  case $opt in
    u) 
      # Password to access VMs for the services
      USER_ID=$OPTARG
      ;;
    p) 
      # Password to access VMs for the services
      VM_PASSWORD=$OPTARG
      ;;
    f) 
      # Deploy VM list file path
      VM_LIST_FILE=$OPTARG
      ;;
    c) 
      # Commands bash file path
      COMMANDS_FILE=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done
#echo "password: "$VM_PASSWORD   "vm_list_file: "$VM_LIST_FILE
IFS=$'\n' read -d '' -r -a vmlist < $VM_LIST_FILE

for vm in ${vmlist[@]}
do
echo "install azcopy on $vm"
cat $COMMANDS_FILE | sshpass -p $VM_PASSWORD ssh -o StrictHostKeyChecking=no $USER_ID@$vm
echo "azcopy installation is completed on $vm"

done