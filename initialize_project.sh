#!/bin/bash

if [[ ! -e "${HOME}/.projects" ]]
then
    echo "Error: Projects configuration file doesn't exist."
    echo
    echo "Create ~/.projects with an exported REPOSITORY_ROOT variable pointing"
    echo "where you'd like to store your repositories. Your file should look like"
    echo "the following line:"
    echo
    echo "export REPOSITORY_ROOT=${HOME}/repositories"
    exit 1
fi

# Load projects configuration.
. ${HOME}/.projects

if [[ -z "${REPOSITORY_ROOT}" ]]
then
    echo "REPOSITORY_ROOT is not defined in ~/.projects. Make sure this file contains a line like the following:"
    echo
    echo "export REPOSITORY_ROOT=${HOME}/repositories"
    exit 1
fi

if [[ "$#" -ne "0" ]]
then
    echo "Usage: $0"
    exit 1
fi

# Get the current directory for this script.
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Run this command from the project's directory.
PROJECT=`pwd`

# Place the repository for the new project in the repository root with the full
# path to the project (leading slash removed).
REPOSITORY_DIR=${REPOSITORY_ROOT}/${PROJECT/\//}

echo "Project: ${PROJECT}"
echo "Repository dir: ${REPOSITORY_DIR}"

# Setup remote repository.
mkdir -p ${REPOSITORY_DIR}
git clone --bare ${PROJECT} ${REPOSITORY_DIR}
git remote add origin ${REPOSITORY_DIR}
git fetch origin
git merge origin/master
