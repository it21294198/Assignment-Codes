1. Create virtual ENV(only for first time)
```
python3 -m venv project_env
```
2. Activate virtual ENV
```
source project_env/bin/activate
```
for windows
```
project_env\Scripts\activate
```
3. Install all packages
```
pip3 install -r requirements.txt
```
for windows
```
pip install -r requirements-windows.txt
```
4. Run the server
```
fastapi dev main.py 
```
5. Build the Docker image
```
docker build -t fastapi-webapp1 .
```
6. Run the container
```
docker run -p 8000:8000 fastapi-webapp1
```