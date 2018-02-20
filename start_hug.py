import hug
import subprocess

@hug.get('/searchinfo')
def searchinfo(name, option):
    information = subprocess.check_output("perl search_github_api.pl " + name + " " + option, shell=True)
    return { "information": information }

