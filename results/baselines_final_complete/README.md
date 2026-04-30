# Baseline Reproduction Results

This folder contains the baseline runs used for the SustainDC-MARL reward-shaping project.

Included algorithms:
- HAA2C
- HAPPO
- MAPPO

Setup:
- Environment: SustainDC
- Location: CA
- Agents: load shifting, data center cooling, and battery
- Reward functions: default_ls_reward, default_dc_reward, default_bat_reward
- Training budget: 25,000,000 environment steps
- Seed: 1

Each run includes:
- config.json: saved experiment configuration
- progress.txt: evaluation reward over training steps
- logs/events.out.tfevents.*: TensorBoard logs with the evaluation metrics
- models/: saved model checkpoints

To view the TensorBoard metrics, run this command from the repository root:

tensorboard --logdir .\results\baselines_final_complete

Then open:

http://localhost:6006
