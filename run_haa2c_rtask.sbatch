#!/bin/bash
#SBATCH --job-name=haa2c_rtask
#SBATCH --partition=normal
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=12
#SBATCH --mem=32G
#SBATCH --output=logs/haa2c_rtask_%j.log

cd $SLURM_SUBMIT_DIR
source sustaindc_venv/bin/activate
mkdir -p logs

echo "=== HAA2C + RTASK ==="
echo "Start: $(date)"

python -u train_sustaindc.py --algo haa2c --env sustaindc --exp_name haa2c_rtask_25M --ls_reward rtask_ls_reward --dc_reward rtask_dc_reward --bat_reward rtask_bat_reward

echo "End: $(date)"