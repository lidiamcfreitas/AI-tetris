#!/bin/sh

valor0=0
valor1=0
valor2=0
valor3=0
max=0
incremento=1
changed=0

#valor0=1000.35
#valor1=0.18
#valor2=0.51
#valor3=50.24


for i in `seq 1 10`;
do
valor0=$((valor0 + $incremento))
echo $valor0
echo $valor1
echo $valor2
echo $valor3

variableA=$(gtimeout 20s ./lispscript.lisp $valor0 $valor1 $valor2 $valor3)

echo $variableA
set -- $variableA
if [ "$1" == "" ]; then
echo "time limit reached"
else
echo $1

fi
done