#!/bin/bash
#SBATCH --job-name=mappo_rewards
#SBATCH --output=logs/reward_%A_%a.out
#SBATCH --error=logs/reward_%A_%a.err
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --array=0-2

# activate environment
source sustaindc_env/bin/activate

# go to project folder (important if not already there)
cd SustainDC-MARL-Reward-Shaping

# create logs folder
mkdir -p logs

# correct reward names
REWARDS=("reward1" "reward2" "reward3")

# debug print
echo "Running job $SLURM_ARRAY_TASK_ID with reward: ${REWARDS[$SLURM_ARRAY_TASK_ID]}"

# run training
python train_sustaindc.py \
  --algo mappo \
  --reward_type ${REWARDS[$SLURM_ARRAY_TASK_ID]}
