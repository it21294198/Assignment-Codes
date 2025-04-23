Create virtual ENV(only for first time)

python3 -m venv project_env
Activate virtual ENV

source project_env/bin/activate
for windows

project_env\Scripts\activate
Install all packages

pip3 install -r requirements.txt
for windows

pip install -r requirements-windows.txt
Run the server

fastapi dev main.py 
