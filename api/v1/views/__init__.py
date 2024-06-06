#!/usr/bin/python3
"""Create a flask application for the API"""

from flask import Blueprint
import json


def format_response(data=None, status=200):
    """ Format responses as pretty json"""
    return (json.dumps(data, indent=4), status)


app_views = Blueprint("app_views", __name__, url_prefix="/api/v1")

from api.v1.views.index import *
from api.v1.views.sessions import *
from api.v1.views.subjects import *
from api.v1.views.exams import *
from api.v1.views.candidates import *
from api.v1.views.centers import *
from api.v1.views.registrations import *
