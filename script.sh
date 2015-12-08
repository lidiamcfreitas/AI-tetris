#!/bin/sh

valor0=0
valor1=0
valor2=0
valor3=0
max=0
incremento=10000
changed=0
counter=0

#valor0=5000
#valor1=1
#valor2=3
#valor3=250


for i in `seq 1 10000`;
do
# change valor 0
echo "incremento:"
echo $incremento
echo "mudei o 0"
valor0=$((valor0 + $incremento))

variableA=$(gtimeout 20s ./lispscript.lisp $valor0 $valor1 $valor2 $valor3)

# echo $variableA
set -- $variableA
if [ "$1" == "" ]; then
echo "time limit reached"
else

if [ $variableA -gt $max ]; then
echo $max
max=$variableA
changed=1
echo $variableA

fi

fi
# change valor 1
echo "mudei o 1"
valor0=$((valor0 - $incremento))
valor1=$((valor1 + $incremento))

variableA=$(gtimeout 10s ./lispscript.lisp $valor0 $valor1 $valor2 $valor3)

echo $variableA
set -- $variableA
if [ "$1" == "" ]; then
echo "time limit reached"
else

if [ $variableA -gt $max ]; then
echo $max
max=$variableA
changed=2
echo $variableA

fi

fi



# change valor 2
echo "mudei o 2"
valor1=$((valor1 - $incremento))
valor2=$((valor2 + $incremento))

variableA=$(gtimeout 20s ./lispscript.lisp $valor0 $valor1 $valor2 $valor3)

echo $variableA
set -- $variableA
if [ "$1" == "" ]; then
echo "time limit reached"
else

if [ $variableA -gt $max ]; then
echo $max
max=$variableA
changed=3
echo $variableA

fi

fi


# change valor 3
echo "mudei o 3"
valor2=$((valor2 - $incremento))
valor3=$((valor3 + $incremento))

variableA=$(gtimeout 5s ./lispscript.lisp $valor0 $valor1 $valor2 $valor3)

echo $variableA
set -- $variableA
if [ "$1" == "" ]; then
echo "time limit reached"
else

if [ $variableA -gt $max ]; then
echo $max
max=$variableA
changed=4
echo $variableA

fi

fi

echo "changed:"
echo $changed
# correct
valor3=$((valor3 - $incremento))

if [ $changed -eq 0 ] ; then
counter=$(($counter + 1))
incremento=$(($incremento - counter))
fi

if [ $changed -eq 1 ]; then
counter=0
valor0=$((valor0 + $incremento))
fi

if [ $changed -eq 2 ]; then
counter=0
valor1=$((valor1 + $incremento))
fi

if [ $changed -eq 3 ]; then
counter=0
valor2=$((valor2 + $incremento))
fi

if [ $changed -eq 4 ]; then
counter=0
valor3=$((valor3 + $incremento))
fi

changed=0

echo "how it ended this:"
echo "max:"
echo $max
echo "valor 0:"
echo $valor0
echo "valor 1:"
echo $valor1
echo "valor 2:"
echo $valor2
echo "valor 3:"
echo $valor3
done