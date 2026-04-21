# Installation Guide 
 
## Step 1 - Clone the base SustainDC repo 
git clone https://github.com/HewlettPackard/dc-rl.git 
cd dc-rl 
 
## Step 2 - Create virtual environment (Windows) 
python -m venv sustaindc_env 
sustaindc_env\Scripts\activate 
 
## Step 3 - Install all packages 
python -c "lines=[l for l in open('requirements.txt') if 'ray' not in l.lower() and 'tensorflow-io-gcs' not in l.lower() and 'pygame' not in l.lower()]; open('requirements_fixed.txt','w').writelines(lines)" 
pip install -r requirements_fixed.txt --ignore-requires-python 
pip install ray==2.20.0 tensorflow-io-gcs-filesystem==0.31.0 
pip install numpy==1.23.5 pandas==1.5.3 torch==2.1.0 torchvision==0.16.0 --force-reinstall --no-deps 
pip install gymnasium==0.29.1 setproctitle absl-py tensorboardX 
pip install pettingzoo==1.22.3 supersuit==3.7.0 --no-deps 
pip install PsychroLib matplotlib --no-deps 
pip install flask importlib-metadata nest-asyncio plotly retrying dash-bootstrap-components 
 
## Step 4 - Verify 
python -c "import gymnasium; import numpy; import pandas; import torch; print('All OK')" 
 
## Step 5 - Test training 
python train_sustaindc.py --algo mappo --env sustaindc --exp_name test_run 
