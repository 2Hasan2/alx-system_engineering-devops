#!/usr/bin/python3
"""Returns to-do list information for a given
employee ID and exports it to JSON."""
import json
import requests
import sys

if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com/"
    id = sys.argv[1]
    user = requests.get(url + "users/{}".format(id)).json()
    username = user.get("username")
    todo = requests.get(url + "todos", params={"userId": id}).json()


    data = {
        id: [
                {
                    "task": task.get("title"),
                    "completed": task.get("completed"),
                    "username": username
                } for task in todo
        ]
    }

    jsonData = json.dumps(data, indent=4)

    with open(f"{id}.json", "w", newline="") as file:
        file.write(jsonData)
