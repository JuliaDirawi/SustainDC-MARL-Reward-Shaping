#!/bin/bash
#SBATCH --job-name=happo_rtask
#SBATCH --partition=normal
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=12
#SBATCH --mem=32G
#SBATCH --output=logs/happo_rtask_%j.log

eval "$(/apps/sw/miniconda/bin/conda shell.bash hook)"
conda activate sustaindc

cd $SLURM_SUBMIT_DIR
mkdir -p logs

echo "=== HAPPO + RTASK ==="
echo "Start: $(date)"

python -u train_sustaindc.py --algo happo --env sustaindc --exp_name happo_rtask_25M --ls_reward rtask_ls_reward --dc_reward rtask_dc_reward --bat_reward rtask_bat_reward

echo "End: $(date)"
