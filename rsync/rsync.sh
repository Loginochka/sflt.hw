#!/bin/bash
# Резервное копирование домашней дирктории
SRC="/home/vagrant/"
DST="/tmp/backup/"
rsync -a -c $SRC $DST
