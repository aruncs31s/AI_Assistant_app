import subprocess

from ai_assistant import Assistant


def ask_ollama(prompt, model):
    try:
        result = subprocess.run(
            f"ollama run {model}",
            input=prompt,
            capture_output=True,
            text=True,
            shell=True,
        )
        if result.returncode != 0:
            print("Ollama Error", result.stderr)
            return assistant.faild_message()
        lines = [
            line.strip() for line in result.stdout.strip().split("\n") if line.strip()
        ]
        return " ".join(lines[:3])
    except Exception as e:
        return f"Error communicating with TinyLlama: {e}"


if __name__ == "__main__":
    # Example usage
    assistant = Assistant()
    prompt = "What is the capital of France?"
    response = ask_ollama(prompt)
    print("Ollama response:", response)
    assistant.speak(response)
