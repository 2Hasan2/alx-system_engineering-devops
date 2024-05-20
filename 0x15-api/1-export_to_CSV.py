#!/usr/bin/python3
"""Returns to-do list information for a given
employee ID and exports it to CSV."""
import csv
import requests
import sys

if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com/"
    user = requests.get(url + "users/{}".format(sys.argv[1])).json()
    todo = requests.get(url + "todos", params={"userId": sys.argv[1]}).json()

    done = [task.get("title") for task in todo if task.get("completed")]
    name = user.get("name")

    with open("{}.csv".format(sys.argv[1]), "w") as csvFile:
        writer = csv.writer(csvFile, quoting=csv.QUOTE_ALL)
        [
            writer.writerow([sys.argv[1], name, task]) for task in todo
        ]
