#!/bin/bash 

source ../zero_shot_config.sh

export model_checkpoint="$checkpoint_folder/esm/esm_if1_gvp4_t16_142M_UR50.pt"
export DMS_output_score_folder=${DMS_output_score_folder_subs}/ESM-IF1/

cd ../../

for ((i=$1; i<=$2; i++))
do
    echo "Evaluating DMS index $i"
    export DMS_index=$i

    start_time=$(date +%s.%N)
    
    python baselines/esm/compute_fitness_esm_if1.py \
        --model_location ${model_checkpoint} \
        --structure_folder ${DMS_structure_folder} \
        --DMS_index $DMS_index \
        --DMS_reference_file_path ${DMS_reference_file_path_subs} \
        --DMS_data_folder ${DMS_data_folder_subs} \
        --output_scores_folder ${DMS_output_score_folder} 
    
    end_time=$(date +%s.%N)
    elapsed_time=$(echo "$end_time - $start_time" | bc)
    echo "Time taken for $i: $elapsed_time seconds"
done
