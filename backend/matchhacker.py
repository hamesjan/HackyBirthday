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
    col = db.matches
    col2 = db.teams
    results = []
    maxid = 1
    tmaxid = 1
    for z in col2.find():
        tmaxid +=1

    for x in col.find():
        maxid +=1
        if request_json['id'] == x["id"]:
            if request_json['otherid'] == x["otherid"]:
                # this match already exists
                if x['status'] == 'teamed':
                    retjson = {}

                    # retjson['dish'] = userid
                    retjson['result'] = "team already suggested"
                    return json.dumps(retjson)
                if x['status'] == 'none':
                    retjson = {}

                    # retjson['dish'] = userid
                    retjson['result'] = "match already exists"
                    return json.dumps(retjson)

        if request_json['id'] == x["otherid"]:
            if request_json['otherid'] == x["id"]:
                # its a two sided match!
                if x['status'] == 'teamed':
                    retjson = {}

                    # retjson['dish'] = userid
                    retjson['result'] = "team already suggested"

                    return json.dumps(retjson)
                col.update_one({"mid":str(x['mid'])}, {"$set":{"status":"teamed"}})

                flag = 0
                tid = -1
                for y in col2.find():
                    if request_json['id'] in y['members']:
                        col2.update_one({"teamid":str(y['teamid'])}, {"$push":{"members":str(request_json['otherid'])}})
                        break
                        tid = y['teamid']
                        flag = 1
                    if request_json['otherid'] in y['members']:
                        col2.update_one({"teamid":str(y['teamid'])}, {"$push":{"members":str(request_json['id'])}})
                        flag = 1
                        tid = y['teamid']
                        break
                
                if flag == 0:
                    #  make new team
                    payload = {}
                    payload['teamid'] = str(tmaxid)
                    members = []
                    members.append(request_json['id'])
                    members.append(request_json['otherid'])
                    payload['members'] = members
                    result=col2.insert_one(payload)
                    tid = tmaxid
                
                retjson = {}

                retjson['teamid'] = str(tid)
                retjson['result'] = "team formed/updated"

                return json.dumps(retjson)
    
    # its a new one sided match
    payload = {}
    payload["mid"] = str(maxid)
    payload['id'] = request_json['id']
    payload['otherid'] = request_json['otherid']
    payload['status'] = 'none'
    result=col.insert_one(payload)

    retjson = {}

    # retjson['dish'] = userid
    retjson['mongoresult'] = "successfully added"
    retjson['id'] = str(maxid)

    return json.dumps(retjson)


    retstr = "action not done"

    if request.args and 'message' in request.args:
        return request.args.get('message')
    elif request_json and 'message' in request_json:
        return request_json['message']
    else:
        return retstr
