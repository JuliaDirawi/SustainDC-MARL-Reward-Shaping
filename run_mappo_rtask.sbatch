#!/bin/bash
#SBATCH --job-name=mappo_rtask
#SBATCH --partition=normal
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=12
#SBATCH --mem=32G
#SBATCH --output=logs/mappo_rtask_%j.log
module purge
module load python/3.10
source /scratch/$SLURM_JOB_ID-$USER/sustaindc_venv/bin/activate
cd /scratch/$SLURM_JOB_ID-$USER/SustainDC-MARL-Reward-Shaping
mkdir -p logs
echo "=== MAPPO + RTASK ==="
echo "Start: $(date)"
python -u train_sustaindc.py --algo mappo --env sustaindc --exp_name mappo_rtask_25M --ls_reward rtask_ls_reward --dc_reward rtask_dc_reward --bat_reward rtask_bat_reward
echo "End: $(date)"