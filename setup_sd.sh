#!/bin/bash

# Function to check if Stable Diffusion is already installed
check_sd_installed() {
    if [ -d "extensions/sd-webui-controlnet" ] && [ -f "models/Stable-diffusion/sdxl_unstable_diffusers.safetensors" ]; then
        return 0  # SD is installed
    else
        return 1  # SD is not installed
    fi
}

# Main installation function
install_sd() {
    echo "Setting up Stable Diffusion..."

    # Clone ControlNet repository
    git clone https://github.com/Mikubill/sd-webui-controlnet.git extensions/sd-webui-controlnet

    # Download ControlNet model (QR Code Monster) from Hugging Face
    wget https://huggingface.co/monster-labs/control_v1p_sdxl_qrcode_monster/blob/main/diffusion_pytorch_model.safetensors \
        -O extensions/sd-webui-controlnet/models/control_v1p_sdxl_qrcode_monster.safetensors

    # Download the Stable Diffusion model from Civitai
    wget "https://civitai.com/api/download/models/395107?type=Model&format=SafeTensor&size=pruned&fp=fp16" \
        -O models/Stable-diffusion/sdxl_unstable_diffusers.safetensors

    # Download the VAE for the model from Civitai
    wget "https://civitai.com/api/download/models/395107?type=VAE&format=SafeTensor" \
        -O models/VAE/sdxl_unstable_diffusers_vae.safetensors

    echo "Stable Diffusion setup completed."
}

# Main execution
if ! check_sd_installed; then
    install_sd
else
    echo "Stable Diffusion is already installed. Skipping installation."
fi

export COMMANDLINE_ARGS="--api"