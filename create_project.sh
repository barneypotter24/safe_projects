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

if [[ "$#" -ne "1" ]]
then
    echo "Usage: $0 <project_name>"
    exit 1
fi

echo ${REPOSITORY_ROOT}
exit

PROJECT=$1

# Run this command from the project's parent directory.
PROJECT_ROOT=`pwd`

# Place the repository for the new project in the repository root with the full
# path to the project (leading slash removed).
REPOSITORY_ROOT=${REPOSITORY_ROOT}/${PROJECT_ROOT/\//}
REPOSITORY_DIR=${REPOSITORY_ROOT}/${PROJECT}

# Initialize the project with default files.
mkdir -p ${PROJECT}
cd ${PROJECT}
git init
touch README Makefile config.sh

# Commit default files.
git add README Makefile config.sh
git commit -m "initial commit."

# Setup remote repository.
mkdir -p ${REPOSITORY_ROOT}
git clone --bare ${PROJECT_ROOT}/${PROJECT} ${REPOSITORY_DIR}
git remote add origin ${REPOSITORY_DIR}
git fetch origin
