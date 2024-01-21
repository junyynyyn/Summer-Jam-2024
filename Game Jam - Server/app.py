from flask import Flask, request
from flask_restful import Resource, Api, reqparse, fields, marshal_with
from pymongo import MongoClient
import json
from bson.json_util import dumps

app = Flask(__name__)
api = Api(app)

level_post_args = reqparse.RequestParser()
level_post_args.add_argument("username", type=str, help="Player Name")
level_post_args.add_argument("time", type=float, help="Player Time")

resource_fields = {
    'username': fields.String,
    'time': fields.Float
}

# =======================================================
uri = "mongodb+srv://junyyeo:Db9FSFcZs5zK3fbv@gamejamsummer2024.4ouryqn.mongodb.net/?retryWrites=true&w=majority"
client = MongoClient(uri)
dbs = client.list_database_names()
times_db = client.times

def insert_timing(level_id, username, time):
    collection = times_db.times
    data = {"level": level_id, "username": username, "time": time}
    inserted_id = collection.insert_one(data).inserted_id

def update_timing(level_id, username, time):
    collection = times_db.times
    update_info = {
        "$set": {"time": time}
    }

    collection.update_one({"level": level_id, "username": username}, update_info)

def get_timings(level_id):
    collection = times_db.times
    data = dumps(list(collection.find({"level": level_id})))
    print(type(data))
    return data

def get_timing(level_id, username):
    collection = times_db.times
    data = collection.find_one({"level": level_id, "username": username})
    return data

# =======================================================

class Level(Resource):
    def get(self, level_id):
        data = get_timings(level_id)
        print(data)
        return data
    
    def post(self, level_id):
        args = level_post_args.parse_args()
        level_timings = get_timing(level_id, args["username"])
        if (level_timings):
            if (level_timings["time"] > args["time"]):
                print("Updating timing")
                update_timing(level_id, args["username"], args["time"])
        else:
            insert_timing(level_id, args["username"], args["time"])
        return args

api.add_resource(Level, "/level/<int:level_id>")

if __name__ == "__main__":
    app.run(debug=False, host="0.0.0.0", ssl_context='adhoc'
)
