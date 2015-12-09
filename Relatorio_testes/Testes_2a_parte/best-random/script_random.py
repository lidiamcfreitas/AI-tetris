#!/usr/bin/env python3

import random
import subprocess
import re

random.seed()

def system_call(command):
	    p = subprocess.Popen([command], stdout=subprocess.PIPE, shell=True)
	    return p.stdout.read()

while True :
	# para valores de heuristicas diferentes
	heur_random_values = [random.random() for i in range(4)]

	out = open("output_random_diff.txt", "a+")
	heuristicas_string = "heuristic values: {}\n".format(heur_random_values)
	out.write(heuristicas_string)
	out.close()

	for num_tabs in range(9):
		out = open("output_random_diff.txt", "a+")
		line = open("tabs_diff.txt", "r")
		tab = line.readlines()[num_tabs]
		line.close()
		
		tabuleiro_string = "tabuleiro numero: {}\n".format(num_tabs)
		out.write(tabuleiro_string)

		cmd="gtimeout 20s ./lispscript_random.lisp {} {} {} {} {}".format(heur_random_values[0], heur_random_values[1], heur_random_values[2], heur_random_values[3], num_tabs)

		cmd_result = system_call(cmd)
		print("running command...    ", cmd)
		print("result: ", cmd_result)

		result = [int(s) for s in cmd_result.split() if s.isdigit()]
		if result:
			out.write("resultado : {}\n".format(result[0]))
		else:
			out.write("resultado : impossivel\n")
		out.close()


