#!/usr/bin/python3
"""Returns to-do list information for all employees and exports it to JSON."""
import json
import requests


if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com/"
    users = requests.get(url + "users")

    def getTodo(u):
        return requests.get(url + "todos", params={"userId": u.get("id")})

    with open("todo_all_employees.json", "w") as file:
        json.dump(
            {
                user.get("id"): [
                    {
                        "task": todo.get("title"),
                        "completed": todo.get("completed"),
                        "username": user.get("username")
                    }
                    for todo in getTodo(user).json()
                ]
                for user in users.json()
            },
            file, indent=4
        )
