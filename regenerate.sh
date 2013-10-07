#!/bin/bash

# For postgresql
echo "-> Remove greenmine DB"
dropdb greenmine
echo "-> Create greenmine DB"
createdb greenmine

echo "-> Remove the search index"
rm -rf greenmine/search/index/*
rm -f database.sqlite


echo "-> Run syncdb"
python manage.py syncdb --migrate --noinput --traceback
echo "-> Load initial user"
python manage.py loaddata initial_user --traceback
echo "-> Load initial roles"
python manage.py loaddata initial_role --traceback
echo "-> Generate sample data"
python manage.py sample_data --traceback
echo "-> Generate initial versions of objects"
python manage.py createinitialrevisions --traceback
