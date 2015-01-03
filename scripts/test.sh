#!/bin/bash

sqlite3 ../db/development.sqlite3 "select grading_type from problems where id=1"