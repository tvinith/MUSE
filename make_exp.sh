#!/usr/bin/env bash


function runExperiment {
  #statements

<<<<<<< HEAD
function runExperiment {
  #statements

=======
>>>>>>> 2cb535d85d13a292ea14e34b66566a0f4a56da93
  vect_src=$1
  vect_tgt=$2
  vect_src_path='data/vect/wiki.'$vect_src'.vec'
  vect_tgt_path='data/vect/wiki.'$vect_tgt'.vec'
  echo "Vect Source: $vect_src_path"
  echo "Vect Target: $vect_tgt_path"

  bash run_exp.sh UNSUP $vect_src $vect_tgt \
                        $vect_src_path \
                        $vect_tgt_path \
                        $RANDOM
}

declare -a lang
lang=('en' 'es' 'it' 'fr' 'de')
for i in {0..5}
  do
  for j in {1..4}
    do
    if [ $i -lt $j ]
      then
        runExperiment ${lang[$i]} ${lang[$j]}
      fi
    done
  done
<<<<<<< HEAD


=======
>>>>>>> 2cb535d85d13a292ea14e34b66566a0f4a56da93
