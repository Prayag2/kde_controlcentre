cmake_minimum_required(VERSION 3.16)

project(controlcentre)

find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${CMAKE_MODULE_PATH})
find_package(KF5Plasma)

plasma_install_package(package controlcentre)
