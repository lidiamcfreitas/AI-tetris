#!/usr/bin/env python3

import random
import subprocess

random.seed()

heur_random_values = [random.random() for i in range(4)]

print("random values:" , heur_random_values)

batcmd="./lispscript.lisp {} {} {} {}".format(heur_random_values[0], heur_random_values[1], heur_random_values[2], heur_random_values[3])
print("running command...    ", batcmd)
result = subprocess.check_output(batcmd, shell=True)
print  (result)