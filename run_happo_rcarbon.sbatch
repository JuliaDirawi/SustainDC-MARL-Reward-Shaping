#!/bin/bash
#SBATCH --job-name=happo_rcarbon
#SBATCH --partition=normal
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=12
#SBATCH --mem=32G
#SBATCH --output=logs/happo_rcarbon_%j.log

eval "$(/apps/sw/miniconda/bin/conda shell.bash hook)"
conda activate sustaindc

cd $SLURM_SUBMIT_DIR
mkdir -p logs

echo "=== HAPPO + RCARBON ==="
echo "Start: $(date)"

python -u train_sustaindc.py --algo happo --env sustaindc --exp_name happo_rcarbon_25M --ls_reward rcarbon_ls_reward --dc_reward rcarbon_dc_reward --bat_reward rcarbon_bat_reward

echo "End: $(date)"
