#!/usr/bin/env bash


function runExperiment {
  #statements

<<<<<<< HEAD
<<<<<<< HEAD
function runExperiment {
  #statements

=======
>>>>>>> 2cb535d85d13a292ea14e34b66566a0f4a56da93
=======
=======
function runExperiment {
  #statements

>>>>>>> 67dd169f7eae63983d94891ef18d1446df2f2663
>>>>>>> 980fe5ec7da51e2e01ddbd0a4281c322d6a891ef
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
<<<<<<< HEAD


=======
>>>>>>> 2cb535d85d13a292ea14e34b66566a0f4a56da93
=======
=======


>>>>>>> 67dd169f7eae63983d94891ef18d1446df2f2663
>>>>>>> 980fe5ec7da51e2e01ddbd0a4281c322d6a891ef
