from pymongo import MongoClient

uri = "mongodb+srv://junyyeo:Db9FSFcZs5zK3fbv@gamejamsummer2024.4ouryqn.mongodb.net/?retryWrites=true&w=majority"
client = MongoClient(uri)

dbs = client.list_database_names()

times_db = client.times
collections = times_db.list_collection_names()

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
    data = collection.find({"level": level_id})
    return data