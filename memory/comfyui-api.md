# COMFYUI NOTE

## API Approach (Always Use This)

For video generation via ComfyUI, ALWAYS use the REST API, NOT exec:

1. **URL**: `http://127.0.0.1:8188`
2. **Method**: `POST /prompt` to queue workflow
3. **Monitor**: Poll `GET /history/{prompt_id}` every 5s
4. **Why**: Long-running tasks (video) timeout via exec and get killed (SIGTERM)

### Available Models
- Wan 2.2 I2V (image-to-video): `wan2.2_i2v_high_noise_14B_fp8_scaled.safetensors`, `wan2.2_i2v_low_noise_14B_fp8_scaled.safetensors`
- VAE: `wan_2.1_vae.safetensors`
- Loras: `wan2.2_i2v_lightx2v_4steps_lora_v1_high/low_noise`
- Text encoder: `umt5_xxl_fp8_e4m3fn_scaled.safetensors`

### Output
- Saves to: `~/Documents/ComfyUI/output/`
