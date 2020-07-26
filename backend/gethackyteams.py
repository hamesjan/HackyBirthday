import os
import pymongo
import json
import random

def dummy(request):
    """Responds to any HTTP request.
    Args:
        request (flask.Request): HTTP request object.
    Returns:
        The response text or any set of values that can be turned into a
        Response object using
        `make_response <http://flask.pocoo.org/docs/1.0/api/#flask.Flask.make_response>`.
    """
    if request.method == 'OPTIONS':
        # Allows GET requests from origin https://mydomain.com with
        # Authorization header
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST',
            'Access-Control-Allow-Headers': '*',
            'Access-Control-Max-Age': '3600',
            'Access-Control-Allow-Credentials': 'true'
        }
        return ('', 204, headers)

    # Set CORS headers for main requests
    headers = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true'
    }

    request_json = request.get_json()
    mongostr = os.environ.get('MONGOSTR')
    client = pymongo.MongoClient(mongostr)
    db = client["hackyteambuilder"]
    col = db.teams
    results = []
    maxid = 0
    
    if request_json['id'] == "-1":
        for x in col.find():

            results.append(x['teamid'])
            results.append(x['members'])

            maxid +=1
        retjson = {}

        retjson['teams'] = results
        retjson['mongoresult'] = str(maxid)

        return json.dumps(retjson)


    for x in col.find():
        if request_json['id'] not in x['members']:
            continue 
        results.append(x['teamid'])
        results.append(x['members'])
        maxid +=1


    random.shuffle(results) 
    # do the ml magic here
        
    retjson = {}

    retjson['teams'] = results
    retjson['mongoresult'] = str(maxid)

    return json.dumps(retjson)


    retstr = "action not done"

    if request.args and 'message' in request.args:
        return request.args.get('message')
    elif request_json and 'message' in request_json:
        return request_json['message']
    else:
        return retstr
