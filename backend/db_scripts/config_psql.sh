#!/bin/bash

sudo -u postgres psql \
  -c "CREATE USER todolist;" \
  -c "CREATE DATABASE todolistdb OWNER todolist;"
