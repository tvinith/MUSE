#!/bin/bash


KSWITCH=$1
if [ $KSWITCH == "GRET" ]; then
				echo "RUNNING GRET ON TWO LANG"
				SRC_LANG=$2
        TGT_LANG=$3
				SRC_PATH=$4
				TGT_PATH=$5
				python src/read_vect.py --src_lang $2 --tgt_lang $3 --src_path $4 --tgt_path $5
elif [ $KSWITCH == "UNSUP" ]; then
			echo "RUNNING unsupervised"
			SRC_LANG=$2
			TGT_LANG=$3
			SRC_PATH=$4
			TGT_PATH=$5
      python unsupervised.py   --src_lang $2 --tgt_lang $3 --src_emb data/vect/wiki.$2.vec --tgt_emb data/vect/wiki.es.vec \
		         --cuda True \
						 --dico_build "S2T&T2S" \
			 		 	 --exp_name "en_es" \
	           --exp_id "003" \
			       --n_refinement 0 \
			       --n_epochs 1
