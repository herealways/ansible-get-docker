#!/bin/bash
# Create vagrant directory outside Jenkins workspace
if [ ! -d "$VAGRANT_PROJECT_PATH" ]; then
    mkdir -p $VAGRANT_PROJECT_PATH
fi

if [ ! -f "$VAGRANT_PROJECT_PATH/Vagrantfile" ]; then
    cp Vagrant/Vagrantfile $VAGRANT_PROJECT_PATH
fi

# Determine if Vagrantfile has changed
diff Vagrant/Vagrantfile $VAGRANT_PROJECT_PATH/Vagrantfile >/dev/null
if [ "$?" != 0 ]; then
    # \cp:  ignore alias cp="cp -i"
    \cp Vagrant/Vagrantfile $VAGRANT_PROJECT_PATH -f
fi

# Refresh state. Check if the vm is aborted
cd $VAGRANT_PROJECT_PATH && vagrant status
aborted=$(vagrant global-status | awk '{if ($4=="aborted") {print $1}}')
if [ -n "$aborted" ]; then
    for id in "$aborted"; do
        vagrant halt "$id"
    done

cd $VAGRANT_PROJECT_PATH && vagrant up