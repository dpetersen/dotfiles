#!/bin/bash

pacman -Qqe > pkglist.txt
pacman -Qet > pkglist-explicit.txt
