import os
import chainlit as cl
import requests
from langfuse.client import Langfuse

# Initialize Langfuse
langfuse = Langfuse(
    public_key=os.environ.get("LANGFUSE_PUBLIC_KEY"),
    secret_key=os.environ.get("LANGFUSE_SECRET_KEY")
)

# Model endpoints
MODELS = {
    "Gemma 2B": "http://vllm-gemma:8000/v1/chat/completions",
    "Qwen 1.8B": "http://vllm-qwen:8000/v1/chat/completions"
}

@cl.on_chat_start
async def start_chat():
    # Set the initial model
    cl.user_session.set("model", "Gemma 2B")
    
    # Create model selection message
    await cl.Message(
        content="Welcome! I'm running on AKS with GPU support. Choose your model:",
        actions=[
            cl.Action(
                name="model_select",
                value="Gemma 2B",
                label="Gemma 2B",
            ),
            cl.Action(
                name="model_select",
                value="Qwen 1.8B",
                label="Qwen 1.8B",
            ),
        ],
    ).send()

@cl.action_callback("model_select")
async def on_model_select(action):
    # Update the model selection
    cl.user_session.set("model", action.value)
    await cl.Message(f"Switched to {action.value}").send()

@cl.on_message
async def main(message: cl.Message):
    # Get current model
    model = cl.user_session.get("model")
    model_url = MODELS[model]

    # Create Langfuse trace
    trace = langfuse.trace(
        name="chat_completion",
        metadata={"model": model}
    )

    # Prepare the message for the API
    payload = {
        "messages": [{"role": "user", "content": message.content}],
        "temperature": 0.7,
        "max_tokens": 1000,
    }

    # Log the prompt
    trace.span(
        name="prompt",
        input={"messages": payload["messages"]}
    )

    try:
        # Make request to vLLM server
        response = requests.post(model_url, json=payload)
        response.raise_for_status()
        
        # Extract the response
        completion = response.json()["choices"][0]["message"]["content"]
        
        # Log the completion
        trace.span(
            name="completion",
            output={"completion": completion}
        )
        
        # Send response to user
        await cl.Message(
            content=completion,
        ).send()
    
    except Exception as e:
        trace.error(error=str(e))
        await cl.Message(
            content=f"Error: {str(e)}",
        ).send()
    
    finally:
        trace.end() 