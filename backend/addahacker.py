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
    maxid = 0
    for x in col.find():
        id = x["id"]
        maxid +=1
    id = str(maxid+1)
    payload = {}
    if request_json:
        payload["id"] = id
        payload["username"] = request_json['username']
        payload["tagline"] = request_json['tagline']
        payload["age"] = request_json['age']
        payload["gender"] = request_json['gender']
        payload["major"] = request_json['major']
        payload["school"] = request_json['school']
        payload["year"] = request_json['year']
        payload["backend"] = request_json['backend']
        payload["frontend"] = request_json['frontend']
        payload["fullstack"] = request_json['fullstack']
        payload["hardware"] = request_json['hardware']       
        payload["mobile"] = request_json['mobile']
        payload["react"] = request_json['react']
        payload["javascript"] = request_json['javascript']
        payload["python"] = request_json['python']
        payload["angular"] = request_json['angular']
        payload["java"] = request_json['java']
        payload["c"] = request_json['c']
        payload["c++"] = request_json['c++']
        payload["gcp"] = request_json['gcp']
        payload["aws"] = request_json['aws']
        payload["mongodb"] = request_json['mongodb']
        payload["firebase"] = request_json['firebase']
        
        result=col.insert_one(payload)

        retjson = {}

        # retjson['dish'] = userid
        retjson['mongoresult'] = "successfully added"
        retjson['id'] = id

        return json.dumps(retjson)


    retstr = "action not done"

    if request.args and 'message' in request.args:
        return request.args.get('message')
    elif request_json and 'message' in request_json:
        return request_json['message']
    else:
        return retstr
