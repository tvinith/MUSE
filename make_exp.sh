#!/usr/bin/env bash



vect_src='en'
vect_tgt='es'
vect_src_path='data/vect/wiki.'+$vect_src+'.vec'
vect_tgt_path='data/vect/wiki.'+$vect_tgt+'.vec'
echo "Vect Source: $vect_src_path"
echo "Vect Target: $vect_tgt_path"

bash run_exp.sh UNSUP $vect_src $vect_tgt \
                      $vect_src_path \
                       $vect_tgt_path \
                      $RANDOM
