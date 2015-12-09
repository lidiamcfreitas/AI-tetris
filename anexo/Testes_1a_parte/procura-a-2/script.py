#!/usr/bin/env python3

import random
import subprocess

random.seed()

heur_random_values = [random.random() for i in range(4)]

print("random values:" , heur_random_values)

def system_call(command):
    p = subprocess.Popen([command], stdout=subprocess.PIPE, shell=True)
    return p.stdout.read()

import glob
ficheiros = glob.glob("./xx*")
for ficheiro in ficheiros:
	cmd="gtimeout 20s ./lispscript.lisp " + ficheiro[2:]
	print("comand....      "+ cmd)
	cmd_result = system_call(cmd)
	#print("result: ", cmd_result)
	result = [int(s) for s in cmd_result.split() if s.isdigit()]
	print  (result)
