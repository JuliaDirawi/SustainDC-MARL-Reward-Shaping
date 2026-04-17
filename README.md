# SustainDC-MARL-Reward-Shaping

Reward shaping and algorithm comparison in multi-agent reinforcement learning for sustainable data center control using SustainDC.

## Project Overview
This project studies cooperative multi-agent reinforcement learning (MARL) for sustainable data center control using SustainDC, an open-source benchmark introduced at NeurIPS 2024.

We reproduce three core MARL algorithms:
- IPPO
- MAPPO
- HAPPO

We then extend the benchmark by comparing three reward shaping variants:
- Carbon-Focused (`Rcarbon`)
- Task-Delay-Focused (`Rtask`)
- Balanced (`Rbalanced`)

## Task and Environment
SustainDC models three interconnected data center control components:
- Workload Scheduling
- Cooling Optimization
- Battery Management

These components are affected by workload traces, weather conditions, and grid carbon intensity.

## Research Goal
We study how cooperative reward design affects:
- system-level performance
- inter-agent coordination
- differences between independent-critic and shared-critic MARL methods

## Evaluation Metrics
We evaluate experiments using the five SustainDC benchmark metrics:
- CO2 Footprint
- HVAC Energy
- IT Energy
- Task Queue
- Water Usage

## Planned Experiments
The main planned experiments follow a 3×3 grid:
- Algorithms: IPPO, MAPPO, HAPPO
- Reward variants: `Rcarbon`, `Rtask`, `Rbalanced`

If time permits, we will also study cross-region generalization by training on New York and testing zero-shot on Texas.

## Repository Structure
- `src/` — source code
- `configs/` — experiment configurations
- `scripts/` — training, evaluation, and reproduction scripts
- `results/` — experiment outputs
- `figures/` — plots for report and presentation
- `docs/` — planning notes and experiment logs
- `report/` — report material

## Team Members
- Julia Dirawi
- Zahraa Hussein
- Buthaina Alabrash
- Fatima Abbas

## Team Responsibilities
- Zahraa Hussein — workload scheduling component
- Fatima Abbas — cooling optimization component and results/figures
- Julia Dirawi — battery management component and repository/README organization
- Buthaina Alabrash — full-system integration and end-to-end experiment coordination

## Current Status
Repository structure initialized. Implementation in progress.

## Setup
Setup instructions and dependency installation steps will be added after the environment configuration is finalized.

## Reproducibility
Commands for reproduction and reward-shaping experiments will be added as implementation is completed.