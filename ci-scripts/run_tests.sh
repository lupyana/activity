#!/bin/bash

set +ex

#@--- install and setup python ---@#
setup_python() {
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt-get update -y 
    sudo apt-get install gdal-bin -y
    sudo apt-get install software-properties-common python-software-properties -y 
    sudo apt-get install python3.6 -y 
    sudo apt-get install python3-pip python3-setuptools -y
    sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 2
    sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 10
    pip3 install --upgrade pip
}

#@--- Install and activate virtualenv ---@#
install_activate_virtualenv() {
    pip3 install pipenv
    pipenv install
    source $(python3 -m pipenv --venv)/bin/activate
}

#@--- run linter ---@#
run_linter() {
    flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
    # exit-zero treats all errors as warnings. The GitHub editor is 127 chars wide
    flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics
}

#@--- run tests --- @#
run_tests() {
    echo "++++++++++++++++ Run tests ++++++++++++++++"
    coverage run --source=activity manage.py test
    coverage report
    coveralls
}

#@--- Main function ---@#
main() {

    #@--- run Setup finction ---@#
    setup_python

    #@--- start virtualenv ---@#
    install_activate_virtualenv

    #@--- Run linter ---@#
    run_linter

    #@--- Run tests ---@#
    run_tests
}

#@--- Run main function ---@#
main