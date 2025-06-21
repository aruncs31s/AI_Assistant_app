# AI Voice Assistant

## Requirements
1. [wyoming-piper](https://github.com/rhasspy/wyoming-piper)

The quickest way to install Wyoming Piper is to use Docker. 

```bash
sudo pacman -S docker
sudo systemctl start docker
docker run -it -p 10200:5000 -v /home/aruncs/docker/piper/data:/data rhasspy/wyoming-piper --voice en_US-lessac-medium
```
Check out [this](https://docs.docker.com/get-started/) to learn more about Docker.
 
2. Ollama 

```bash
# install it using yay , pacman or apt , apk etc.
yay -S ollama
OLLAMA_HOST=0.0.0.0 ollama serve
```

```bash
# Install the model
ollama run gemma3:1b
```
*any model is fine but if you want to use the existing model*
- list the models
```bash
ollama list
```
And update the following with your model name.
```python
ask_ollama(query,model="gemma3:1b")
```

## Usage
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python src/app.py
```

![alt text](/images/working.png?raw=true)
## Trubleshooting
1. Check if docker is running using
```bash
sudo systemctl status docker
docker ps
```
3. Ensure the firewall is not blocking the ports.
port 10200 for Wyoming Piper and 11434 for Ollama.
2. Verify the ollama is running. 
You shoul see something like this when running queries. 

![](/images/ollama.png?raw=true)

4. Verify the piper is running. 


