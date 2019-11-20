#!/bin/bash


KSWITCH=$1
if [ $KSWITCH == "GRET" ]; then
				echo "RUNNING GRET ON TWO LANG"
				SRC_LANG=$2
        TGT_LANG=$3
				SRC_PATH=$4
				TGT_PATH=$5
				DICO_TRAIN=$6
				DICO_TEST=$7
				SAVE_DICT=$8
				python src/read_vect.py --src_lang $2 --tgt_lang $3 \
				 							--src_path $4 --tgt_path $5 \
											--dico_train $6 \
											--dico_test $7 \
											--save_path $8
elif [ $KSWITCH == "UNSUP" ]; then
			echo "RUNNING unsupervised"
			SRC_LANG=$2
			TGT_LANG=$3
			SRC_PATH=$4
			TGT_PATH=$5
			EXP_ID=$6
			EXP_NAME="${SRC_LANG}_${TGT_LANG}_R"
      python unsupervised.py   --src_lang $2 --tgt_lang $3 --src_emb $4 \
			 				--tgt_emb $5 \
		         --cuda True \
						 --dico_build "S2T&T2S" \
			 		 	 --exp_name ${EXP_NAME} \
	           --exp_id $6 \
			       --n_refinement 0 \
			       --n_epochs 5

			tar -cvf "/dumped/"${EXP_NAME}".tar.gz" "/dumped/"${EXP_NAME}"/"
			rm -rf "/dumped/"${EXP_NAME}
elif [ $KSWITCH == "SUP" ]; then
			echo "RUNNING supervised"
			SRC_LANG=$2
			TGT_LANG=$3
			SRC_PATH=$4
			TGT_PATH=$5
			DICO_TRAIN=$6
			DICO_TEST=$7
			EXP_ID=$8
    python supervised.py   --src_lang $2 --tgt_lang $3 --src_emb $4 \
			 				--tgt_emb $5 \
							--dico_train $6
							--dico_test $7
		         --cuda True \
						 --dico_build "S2T&T2S" \
			 		 	 --exp_name "en_es" \
	           --exp_id $8 \
			       --n_refinement 10 \
			       --n_epochs 5
 elif [ $KSWITCH == "EVAL" ]; then
 			echo "RUNNING EVAL"
 			SRC_LANG=$2
 			TGT_LANG=$3
 			SRC_PATH=$4
 			TGT_PATH=$5
 			EXP_ID=$6
      python evaluate.py   --src_lang $2 --tgt_lang $3 --src_emb $4 \
 			 				--tgt_emb $5 \
 		         --cuda True \
 			 		 	 --exp_name "${SRC_LANG}_${TGT_LANG}_R" \
 	           --exp_id $6
fi
