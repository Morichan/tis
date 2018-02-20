import hug
import subprocess

@hug.get('/hello')
def hello(name, option):
    """Says Hello to a user"""
    version = subprocess.check_output("perl search_github_api.pl " + name + " " + option, shell=True)
    return { "ripository": version }

