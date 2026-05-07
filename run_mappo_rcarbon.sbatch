#!/bin/bash
#SBATCH --job-name=mappo_rcarbon
#SBATCH --partition=normal
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=12
#SBATCH --mem=32G
#SBATCH --output=logs/mappo_rcarbon_%j.log

REPO_DIR=$SLURM_SUBMIT_DIR
VENV_DIR=$REPO_DIR/../sustaindc_venv

cd $REPO_DIR
mkdir -p logs
source $VENV_DIR/bin/activate

echo "=== MAPPO + RCARBON ==="
echo "Start: $(date)"

python -u train_sustaindc.py --algo mappo --env sustaindc --exp_name mappo_rcarbon_25M --ls_reward rcarbon_ls_reward --dc_reward rcarbon_dc_reward --bat_reward rcarbon_bat_reward

echo "End: $(date)"
