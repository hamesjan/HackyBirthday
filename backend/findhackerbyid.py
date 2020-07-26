import os
import pymongo
import json

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
    col = db.hackers
    results = []
    payload = {}
    maxid = 0
    
    if request_json:
        id = request_json['id']
        retjson = {}
        for x in col.find():
            if id == x["id"]:
                payload["username"] = x['username']
                payload["age"] = x['age']
                payload["gender"] = x['gender']
                payload["major"] = x['major']
                payload["school"] = x['school']
                payload["year"] = x['year']
                payload["backend"] = x['backend']
                payload["frontend"] = x['frontend']
                payload["fullstack"] = x['fullstack']
                payload["hardware"] = x['hardware']       
                payload["mobile"] = x['mobile']
                payload["react"] = x['react']
                payload["javascript"] = x['javascript']
                payload["python"] = x['python']
                payload["angular"] = x['angular']
                payload["java"] = x['java']
                payload["c"] = x['c']
                payload["c++"] = x['c++']
                payload["gcp"] = x['gcp']
                payload["aws"] = x['aws']
                payload["mongodb"] = x['mongodb']
                payload["firebase"] = x['firebase']
                payload["tagline"] = x['tagline']
                retjson['mongoresult'] = "successfully retrieved"
                retjson['details'] = payload

                return json.dumps(payload)
                
        

        # retjson['dish'] = userid
        retjson['mongoresult'] = "not found in database"
        retjson['details'] = payload
        retjson['id'] = id

        return json.dumps(retjson)


    retstr = "action not done"

    if request.args and 'message' in request.args:
        return request.args.get('message')
    elif request_json and 'message' in request_json:
        return request_json['message']
    else:
        return retstr
