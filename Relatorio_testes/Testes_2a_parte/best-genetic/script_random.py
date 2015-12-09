#!/usr/bin/env python3

import random
import subprocess

random.seed()

def system_call(command):
	    p = subprocess.Popen([command], stdout=subprocess.PIPE, shell=True)
	    return p.stdout.read()

class TesteHeuristica:
	def __init__(self):
		self.soma = 0
		self.heuristicas = [random.random() for i in range(4)]
		self.tabuleiros = []

	def set_heuristicas(self, valor0, valor1, valor2, valor3):
		self.heuristicas = [valor0, valor1, valor2, valor3]


# MELHORES VALORES DO RANDOM
melhor0 = TesteHeuristica()
melhor0.tabuleiros = [0.00 , 100.00	, 100.00, 200.00, 100.00 , 200.00, 0.00 , -500.00, 0.00]
melhor0.soma = sum(melhor0.tabuleiros)
print(melhor0.soma)
melhor0.set_heuristicas(0.06252293039487711, 0.6169685981711657	, 0.5869438219752874 , 0.04369354680040316 )

melhor1 = TesteHeuristica()
melhor1.tabuleiros = [0.00,100.00,100.00,200.00,100.00,200.00,0.00,-500.00,0.00]
melhor1.soma = sum(melhor1.tabuleiros)
print(melhor1.soma)
melhor1.set_heuristicas(0.9128518893940584 , 0.4226895567776138	, 0.9134927770474299 , 0.06251677931489352 )

melhor2 = TesteHeuristica()
melhor2.tabuleiros = [0.00,100.00,100.00,200.00,100.00,200.00,0.00,-500.00,0.00]
melhor2.soma = sum(melhor2.tabuleiros)
print(melhor2.soma)
melhor2.set_heuristicas(0.25373280159762823	, 0.9310757885884794 , 0.7614826005183634 , 0.06311617522444746 )

melhor3 = TesteHeuristica()
melhor3.tabuleiros = [0.00,100.00,100.00,200.00,100.00,200.00,0.00,-500.00,0.00]
melhor3.soma = sum(melhor3.tabuleiros)
print(melhor3.soma)
melhor3.set_heuristicas(0.016441216301480432 , 0.3383680738360155 , 0.2703857247354139 , 0.06780098767615228 )

melhor4 = TesteHeuristica()
melhor4.tabuleiros = [-500.00,100.00,100.00,200.00,200.00,200.00,0.00,-500.00,0.00]
melhor4.soma = sum(melhor4.tabuleiros)
print(melhor4.soma)
melhor4.set_heuristicas(0.4646313036167071 , 0.6984126477276682	, 0.7304445618597235	, 0.3358555934538632  )

"""
# VALORES ALEATORIOS DA TABELA DE RANDOM : POSICOES 7, 26, 3, 18, 32
# 7
melhor0 = TesteHeuristica()
melhor0.tabuleiros = [-500, 100, 100, 200,200,200,0, -500, 0]
melhor0.soma = sum(melhor0.tabuleiros)
print(melhor0.soma)
melhor0.set_heuristicas(0.6320113610652446	, 0.23774505062086482	, 0.3896260285128641	, 0.31688890332578057 )

# 26
melhor1 = TesteHeuristica()
melhor1.tabuleiros = [-500	,-500	,-500	,-500	,200	,-500	,-500	,-500	,0]
melhor1.soma = sum(melhor1.tabuleiros)
print(melhor1.soma)
melhor1.set_heuristicas(0.6967214914316192	, 0.4590693755810894	, 0.8810443170478817	, 0.9046305523290941 )

# 3
melhor2 = TesteHeuristica()
melhor2.tabuleiros = [0	,100	,100	,200	,100	,200	,0	,-500	,0]
melhor2.soma = sum(melhor2.tabuleiros)
print(melhor2.soma)
melhor2.set_heuristicas(0.9128518893940584	, 0.4226895567776138	, 0.9134927770474299	, 0.06251677931489352 )

# 18
melhor3 = TesteHeuristica()
melhor3.tabuleiros = [-500	,-500	,100	,200	,200	,200	,0	,-500	,0]
melhor3.soma = sum(melhor3.tabuleiros)
print(melhor3.soma)
melhor3.set_heuristicas(0.3004545202440063	, 0.3134478279297872	, 0.9469545628226209	, 0.4561657774418265 )

# 32
melhor4 = TesteHeuristica()
melhor4.tabuleiros = [-500	,-500	,-500	,-500	,-500	,-500	,-500	,-500	,0]
melhor4.soma = sum(melhor4.tabuleiros)
print(melhor4.soma)
melhor4.set_heuristicas(0.03756083107618147	, 0.48359416947564826	, 0.7362826615434248	, 0.9692574232437191 )

"""

melhores = [melhor0, melhor1, melhor2, melhor3, melhor4]

class Genetico:
	def __init__(self, melhores):
		self.melhores = melhores
		self.totais = melhores

	def crossover(self):
		"retorna um filho dos melhores"
		heuristica0 = [teste.heuristicas[0] for teste in self.melhores]
		heuristica1 = [teste.heuristicas[1] for teste in self.melhores]
		heuristica2 = [teste.heuristicas[2] for teste in self.melhores]
		heuristica3 = [teste.heuristicas[3] for teste in self.melhores]

		filho = TesteHeuristica()
		filho.set_heuristicas(heuristica0[random.randint(0,4)], heuristica1[random.randint(0,4)], heuristica2[random.randint(0,4)], heuristica3[random.randint(0,4)])
		return filho

iteracoes_genetico = 0

while True :
	# para valores de heuristicas diferentes
	iteracoes_genetico += 1
	print("iteracao: ", iteracoes_genetico)
	
	out = open("output_random_diff.txt", "a+")
	heuristicas_string = "\niteracao: {}\n".format(iteracoes_genetico)
	#out.write(heuristicas_string)
	out.close()

	genetico = Genetico(melhores)

	gerados = [genetico.crossover() for i in range(9)] # cria 9 filhos dos melhores
	#print ("gerados:",gerados)

	random_filho = TesteHeuristica() # cria um random
	#print (randoms)

	# calcula a soma dos valores nos 9 tabuleiros para uma dada heuristica
	# penalizando o facto de nao acabar em -500

	for filho in gerados:
		heur_random_values = filho.heuristicas

		out = open("output_random_diff.txt", "a+")
		heuristicas_string = "heuristic values: {}\n".format(heur_random_values)
		#out.write(heuristicas_string)
		out.close()

		for num_tabs in range(9):
			out = open("output_random_diff.txt", "a+")
			line = open("tabs_diff.txt", "r")
			tab = line.readlines()[num_tabs]
			# out.write("{}".format(tab))
			line.close()
			
			tabuleiro_string = "tabuleiro numero: {}\n".format(num_tabs)
			#out.write(tabuleiro_string)

			cmd="gtimeout 20s ./lispscript_random.lisp {} {} {} {} {}".format(heur_random_values[0], heur_random_values[1], heur_random_values[2], heur_random_values[3], num_tabs)

			cmd_result = system_call(cmd)
			#print("running command...    ", cmd)
			#print("result: ", cmd_result)

			result = [int(s) for s in cmd_result.split() if s.isdigit()]
			if result:
				#out.write("resultado : {}\n".format(result[0]))
				filho.tabuleiros += [result[0]]
				filho.soma += result[0]
			else:
				#out.write("resultado : impossivel\n")
				filho.tabuleiros += [-500]
				filho.soma -= 500
			out.close()
		
		filho_string = "filho: {} , soma: {} , heuristicas: {}\n".format(filho.tabuleiros,filho.soma, filho.heuristicas)
		#print("filho:", filho.tabuleiros,", soma:", filho.soma,", heuristicas:", filho.heuristicas)
		print(filho_string)
		#out = open("output_random_diff.txt", "a+")
		#out.write(filho_string)
		#out.close()
		genetico.totais += [filho]


	# RANDOM
	heur_random_values = random_filho.heuristicas

	out = open("output_random_diff.txt", "a+")
	heuristicas_string = "heuristic values: {}\n".format(heur_random_values)
	#out.write(heuristicas_string)
	out.close()

	for num_tabs in range(9):
		out = open("output_random_diff.txt", "a+")
		line = open("tabs_diff.txt", "r")
		tab = line.readlines()[num_tabs]
		line.close()
		
		tabuleiro_string = "tabuleiro numero: {}\n".format(num_tabs)
		#out.write(tabuleiro_string)

		cmd="gtimeout 20s ./lispscript_random.lisp {} {} {} {} {}".format(heur_random_values[0], heur_random_values[1], heur_random_values[2], heur_random_values[3], num_tabs)

		cmd_result = system_call(cmd)

		result = [int(s) for s in cmd_result.split() if s.isdigit()]
		if result:
			#out.write("resultado : {}\n".format(result[0]))
			random_filho.tabuleiros += [result[0]]
			random_filho.soma += result[0]
			print(result[0])
		else:
			#out.write("resultado : impossivel\n")
			random_filho.tabuleiros += [-500]
			random_filho.soma -= 500
			print(-500)
		out.close()

	random_filho_string = "filho: {} , soma: {} , heuristicas: {}\n".format(random_filho.tabuleiros, random_filho.soma, random_filho.heuristicas)
	print(random_filho_string)
	#out = open("output_random_diff.txt", "a+")
	#out.write(random_filho_string)
	#out.close()

	genetico.totais += [random_filho]

	#for elem in genetico.totais:
	#	print("tabuleiros:",elem.tabuleiros, "\n", "soma:",elem.soma, "\n", "heuristicas:", elem.heuristicas, "\n")	

	# ordena por somas
	genetico.totais = sorted(genetico.totais, key=lambda elem: elem.soma)

	#for elem in genetico.totais:
	#	print("tabuleiros:",elem.tabuleiros, "\n", "soma:",elem.soma, "\n", "heuristicas:", elem.heuristicas, "\n")	

	print("melhores 5:")
	genetico.melhores = genetico.totais[-5:]
	out = open("output_random_diff.txt", "a+")
	for elem in genetico.melhores:
		print("tabuleiros:",elem.tabuleiros, "\n", "soma:",elem.soma, "\n", "heuristicas:", elem.heuristicas, "\n")	
		out.write("filho: {} , soma: {} , heuristicas: {}\n".format(elem.tabuleiros, elem.soma, elem.heuristicas))
	out.close()


