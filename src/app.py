from ai_assistant import Assistant
from ollama import ask_ollama

if __name__ == "__main__":
    assistant = Assistant()
    assistant.greet()
    while True:
        query = assistant.listen()
        if query == "":
            continue
        else:
            assistant.speak("Oh Wait")
            response = ask_ollama(query,model="gemma3:1b")
            assistant.speak(response)