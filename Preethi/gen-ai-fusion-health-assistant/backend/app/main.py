
from fastapi import FastAPI, UploadFile, File, Form
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from typing import Optional
from PIL import Image
import io

from .schemas import AnalysisResult
from .nlp.symptom_extractor import extract_symptoms
from .vision.model import vision_model
from .fusion.late_fusion import fuse

app = FastAPI(title="Gen AI Fusion: Smart Healthcare Assistant", version="0.1.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/analyze", response_model=AnalysisResult)
async def analyze(
    image: UploadFile = File(..., description="Medical image (e.g., chest X-ray)"),
    symptoms_text: str = Form("", description="Free-text symptom description")
):
    # NLP
    nlp_out = extract_symptoms(symptoms_text or "")

    # Vision
    content = await image.read()
    pil_img = Image.open(io.BytesIO(content)).convert("RGB")
    vision_out = vision_model.predict(pil_img)

    # Fusion
    fused = fuse(nlp_out, vision_out)

    return AnalysisResult(**fused)
