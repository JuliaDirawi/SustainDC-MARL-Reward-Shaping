#!/bin/bash
#SBATCH --job-name=mappo_reward
#SBATCH --partition=normal
#SBATCH --time=23:59:00
#SBATCH --output=logs/mappo_%A_%a.out
#SBATCH --array=0-2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --distribution=sequential

source sustaindc_env/bin/activate
cd SustainDC-MARL-Reward-Shaping

mkdir -p logs

REWARDS=("REWARD_A" "REWARD_B" "REWARD_C")

REWARD_TYPE=${REWARDS[$SLURM_ARRAY_TASK_ID]}

echo "Running job ${SLURM_ARRAY_TASK_ID} with reward: ${REWARD_TYPE}"

python -u train_sustaindc.py \
  --algo mappo \
  --env sustaindc \
  --reward_type "${REWARD_TYPE}" \
  --exp_name "${REWARD_TYPE}_run"
