#!/usr/bin/python3
"""Returns to-do list information for a given employee ID."""
import requests
import sys

if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com/"
    user = requests.get(url + "users/{}".format(sys.argv[1])).json()
    todo = requests.get(url + "todos", params={"userId": sys.argv[1]}).json()

    done = [task.get("title") for task in todo if task.get("completed")]
    name = user.get("name")

    print(
        f"Employee {name} is done with tasks({len(done)}/{len(todo)}):"
        )

    [print("\t {}".format(task)) for task in done]
