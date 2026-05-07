# Reward Shaping and Algorithm Comparison in MARL for Sustainable Data Center Control

This project studies how reward function design affects cooperative multi-agent reinforcement learning (MARL) in sustainable data center control. We use [SustainDC](https://github.com/HewlettPackard/dc-rl), an open-source benchmark introduced at NeurIPS 2024, and evaluate two custom reward shaping variants across three MARL algorithms.

## Environment

SustainDC models three interconnected data center control tasks trained jointly as a cooperative MARL system:

- **Workload Scheduling (AgentLS)** — shifts compute jobs to low-carbon time windows
- **Cooling Optimization (AgentDC)** — adjusts CRAC setpoint to reduce HVAC energy
- **Battery Management (AgentBAT)** — decides when to charge or discharge an on-site battery

## Algorithms

We evaluate three algorithms from the [HARL](https://github.com/PKU-MARL/HARL) framework:

- **MAPPO** — Multi-Agent PPO with a centralized shared critic
- **HAPPO** — Heterogeneous-Agent PPO with per-agent critics
- **HAA2C** — Heterogeneous Agent Advantage Actor-Critic

## Reward Variants

All reward functions are defined in `utils/reward_creator.py`.

**Baseline (default)** — original SustainDC reward. Used as the baseline for comparison.

**R_carbon** — heavily penalizes CO2 emissions across all three agents (3x carbon weight). Agents learn to strongly prefer low-carbon periods even at the cost of task delays.

**R_task** — heavily penalizes task queue buildup and delays (0.5x carbon, higher task penalties). Agents prioritize responsiveness over emissions reduction.

## Results

All 9 experiments (3 algorithms x 3 reward conditions) were trained for 25 million timesteps on the California (ca-discrete) environment. All runs showed learning progress over training.

Full results including CO₂ footprint, energy consumption, task queue, dropped tasks, and water usage are reported in the paper. Training curves for all 9 experiments are available via TensorBoard in the `results/` directory.

Note: Evaluation reward values are not directly comparable across reward variants since different penalty scales produce different reward magnitudes by design.

## Repository Structure

```
SustainDC-MARL-Reward-Shaping/
├── utils/reward_creator.py          # Default + custom reward functions
├── train_sustaindc.py               # Main training script
├── eval_sustaindc.py                # Evaluation script
├── run_happo_rcarbon.sbatch         # HPC job script - HAPPO + R_carbon
├── run_happo_rtask.sbatch           # HPC job script - HAPPO + R_task
├── run_mappo_rcarbon.sbatch         # HPC job script - MAPPO + R_carbon
├── run_mappo_rtask.sbatch           # HPC job script - MAPPO + R_task
├── run_haa2c_rcarbon.sbatch         # HPC job script - HAA2C + R_carbon
├── run_haa2c_rtask.sbatch           # HPC job script - HAA2C + R_task
├── run_rbalanced.sbatch             # HPC job script - R_balanced (not run, future work)
├── results/
│   ├── baselines_final_complete/    # Baseline results (folders named *_ny_medium but trained on California)
│   └── reward_shaping/             # R_carbon and R_task experiment results
│       ├── rcarbon/
│       └── rtask/
├── experiment_logs/                 # Full HPC training logs for all 9 experiments
├── SETUP.md                         # Installation guide
└── requirements.txt
```

## How to Reproduce on AUB HPC (Octopus)

### Step 1 — SSH into the cluster
```bash
ssh username@octopus.aub.edu.lb
```

### Step 2 — Find your scratch directory
```bash
ls /scratch/ | grep $USER
```
This will show your scratch folder name, for example: `8691520-jnd06`

### Step 3 — Clone the repository into your scratch folder
```bash
cd /scratch/YOUR_SCRATCH_FOLDER
git clone https://github.com/JuliaDirawi/SustainDC-MARL-Reward-Shaping.git
cd SustainDC-MARL-Reward-Shaping
```
Replace `YOUR_SCRATCH_FOLDER` with the folder name from Step 2.

### Step 4 — Create and activate conda environment
```bash
eval "$(/apps/sw/miniconda/bin/conda shell.bash hook)"
conda create -n sustaindc python=3.10 -y
conda activate sustaindc
pip install --upgrade pip
pip install -r requirements.txt
pip install matplotlib dash dash-bootstrap-components flask plotly nest-asyncio retrying
```

### Step 5 — Submit experiments
```bash
sbatch run_happo_rcarbon.sbatch
sbatch run_happo_rtask.sbatch
sbatch run_mappo_rcarbon.sbatch
sbatch run_mappo_rtask.sbatch
sbatch run_haa2c_rcarbon.sbatch
sbatch run_haa2c_rtask.sbatch
```

### Step 6 — Monitor jobs
```bash
squeue -u $USER
```

Results are saved automatically to the `results/` directory.

### Step 7 — Visualize training curves

To view learning curves for all experiments:

```bash
pip install tensorboard
tensorboard --logdir results/
```

Then open http://localhost:6006 in your browser.

## Deviations from Original Setup

| Aspect | Original SustainDC | This Project |
|--------|-------------------|--------------|
| Timesteps | ~2 billion | 25 million |
| Reason | 24-hour HPC time limit | Fixed budget ensures fair cross-variant comparison |
| Location | Multiple | California (ca-discrete) |
| Seeds | 5 | 1 |

## Reference

Naug, A., Guillen, A., Luna, R., et al. (2024). SustainDC: Benchmarking for Sustainable Data Center Control. NeurIPS 2024. https://github.com/HewlettPackard/dc-rl
