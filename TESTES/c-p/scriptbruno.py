#!/usr/bin/env python3

import random
import subprocess

random.seed()

heur_random_values = [random.random() for i in range(4)]

print("random values:" , heur_random_values)

def system_call(command):
    p = subprocess.Popen([command], stdout=subprocess.PIPE, shell=True)
    return p.stdout.read()

#tabs_txt = open("tabs.txt", "wb+")

import glob 
ficheiros = glob.glob("./xx*")
for ficheiro in ficheiros:
	cmd="gtimeout 20s ./lispscriptbruno.lisp " + ficheiro[2:]
	print("comand....      "+ cmd)
	cmd_result = system_call(cmd)
	#print("result: ", cmd_result)
	result = [int(s) for s in cmd_result.split() if s.isdigit()]
	print  (result)

#cmd=" for f in xx*; do gtimeout 20s ./lispscriptbruno.lisp $f ; done "
#cmd_result = subprocess.check_output(cmd, shell=True)
#cmd_result = subprocess.check_output([cmd], stderr=subprocess.STDOUT)
#print("running command...    ", cmd)
#print("result: ", cmd_result)

#result = [int(s) for s in cmd_result.split() if s.isdigit()]
#print  (result)

#import re

#line = "Cats are smarter than dogs"

#matchObj = re.match( r'(.*) are (.*?) .*', line, re.M|re.I)

#if matchObj:
 #  print ("matchObj.group() : ", matchObj.group())
 #  print ("matchObj.group(1) : ", matchObj.group(1))
 #  print ("matchObj.group(2) : ", matchObj.group(2))
#else:
#   print ("No match!!")

#tabs_txt.close()
