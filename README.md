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

**Baseline (default)** — balanced weights across carbon, energy, and task objectives. Used for reproduction.

**R_carbon** — heavily penalizes CO2 emissions across all three agents (3x carbon weight). Agents learn to strongly prefer low-carbon periods even at the cost of task delays.

**R_task** — heavily penalizes task queue buildup and delays (0.5x carbon, higher task penalties). Agents prioritize responsiveness over emissions reduction.

## Results

All 9 experiments (3 algorithms x 3 reward variants) were trained for 25 million timesteps on the California (ca-discrete) environment.

| Algorithm | Variant | Start Reward | End Reward | Improvement |
|-----------|---------|-------------|------------|-------------|
| HAPPO | Baseline | -417 | -138 | yes |
| HAPPO | R_carbon | -3087 | -2596 | +15.9% |
| HAPPO | R_task | -1701 | -1194 | +29.8% |
| MAPPO | Baseline | -580 | +164 | yes |
| MAPPO | R_carbon | -2930 | -2361 | +19.4% |
| MAPPO | R_task | -1175 | -1255 | stable |
| HAA2C | Baseline | -1200 | +352 | yes |
| HAA2C | R_carbon | -2822 | -2509 | +11.1% |
| HAA2C | R_task | -1378 | -1234 | +10.4% |

Reward magnitudes differ across variants by design. R_carbon applies a 3x carbon penalty producing larger negative values. Learning is assessed by improvement trend, not absolute value.

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
├── results/
│   ├── baselines_final_complete/    # Baseline reproduction results
│   └── reward_shaping/             # R_carbon and R_task experiment results
│       ├── rcarbon/
│       └── rtask/
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

### Step 4 — Create and activate virtual environment
```bash
python -m venv /scratch/YOUR_SCRATCH_FOLDER/sustaindc_venv
source /scratch/YOUR_SCRATCH_FOLDER/sustaindc_venv/bin/activate
pip install -r requirements.txt
```

### Step 5 — Update the sbatch scripts with your scratch path
Open each `.sbatch` file and replace `/scratch/8691520-jnd06` with your own scratch path:
```bash
sed -i 's|/scratch/8691520-jnd06|/scratch/YOUR_SCRATCH_FOLDER|g' run_*.sbatch
```
Replace `YOUR_SCRATCH_FOLDER` with your actual scratch folder name.

### Step 6 — Submit experiments
```bash
sbatch run_happo_rcarbon.sbatch
sbatch run_happo_rtask.sbatch
sbatch run_mappo_rcarbon.sbatch
sbatch run_mappo_rtask.sbatch
sbatch run_haa2c_rcarbon.sbatch
sbatch run_haa2c_rtask.sbatch
```

### Step 7 — Monitor jobs
```bash
squeue -u $USER
```

Results are saved automatically to the `results/` directory.
### Step 8 — Visualize training curves 

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
| Algorithms | IPPO, MAPPO, HAPPO | MAPPO, HAPPO, HAA2C |

## Reference

Naug, A., Guillen, A., Luna, R., et al. (2024). SustainDC: Benchmarking for Sustainable Data Center Control. NeurIPS 2024. https://github.com/HewlettPackard/dc-rl
