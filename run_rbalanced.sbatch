#!/bin/bash
#SBATCH --job-name=rbalanced
#SBATCH --partition=normal
#SBATCH --time=23:59:00
#SBATCH --output=%x_%A_%a.out
#SBATCH --error=%x_%A_%a.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=16G
#SBATCH --array=0-2
eval "$(/apps/sw/miniconda/bin/conda shell.bash hook)"
conda activate sustaindc
cd /home/jnd06/SustainDC-MARL-Reward-Shaping
ALGOS=(happo mappo haa2c)
ALGO=${ALGOS[$SLURM_ARRAY_TASK_ID]}
echo Start: $(date)
python -u train_sustaindc.py --algo $ALGO --env sustaindc --exp_name ${ALGO}_rbalanced_25M --ls_reward rbalanced_ls_reward --dc_reward rbalanced_dc_reward --bat_reward rbalanced_bat_reward
echo End: $(date)
