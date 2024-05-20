#!/usr/bin/python3
"""Returns to-do list information for a given
employee ID and exports it to CSV."""
import csv
import requests
import sys

if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com/"
    id = sys.argv[1]
    user = requests.get(url + f"users/{id}").json()
    todo = requests.get(url + "todos", params={"userId": id}).json()

    username = user.get("username")

    with open(f"{id}.csv", "w", newline="") as csvFile:
        writer = csv.writer(csvFile, quoting=csv.QUOTE_ALL)
        [
            writer.writerow([id, username, task.get("completed"),
                            task.get("title")])
            for task in todo
        ]
