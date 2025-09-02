
# Gen AI Fusion: Smart Healthcare Assistant

A reference implementation scaffold for a **multimodal** (text + image + voice-ready) Smart Healthcare Assistant. 
It performs **preliminary analysis** by fusing symptom descriptions (text) with medical images (e.g., chest X-rays).

> ⚠️ Educational prototype only. Not for clinical use.

## Features
- Upload a medical image (e.g., X-ray) + enter symptoms
- Server performs:
  - Symptom extraction (NLP)
  - Vision analysis (placeholder model)
  - Late fusion of signals
- Returns a **preliminary report** with suggested next steps
- Streamlit frontend, FastAPI backend
- Easy to extend with real models (ViT / DenseNet / Whisper, etc.)

## Quickstart

### 1) Create & activate env
```bash
python -m venv .venv
source .venv/bin/activate   # on Windows: .venv\Scripts\activate
```

### 2) Install dependencies
Backend:
```bash
pip install -r backend/requirements.txt
```
Frontend:
```bash
pip install -r frontend/requirements.txt
```

### 3) Run backend (FastAPI + Uvicorn)
```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000 --app-dir backend
```
Open docs at: http://localhost:8000/docs

### 4) Run frontend (Streamlit)
```bash
streamlit run frontend/streamlit_app.py
```
Open app at: http://localhost:8501

## Project Structure
```
gen-ai-fusion-health-assistant/
├─ backend/
│  ├─ app/
│  │  ├─ main.py                # FastAPI app + routes
│  │  ├─ schemas.py             # Pydantic models
│  │  ├─ nlp/
│  │  │  └─ symptom_extractor.py # Simple rule-based extractor (replace with real LLM)
│  │  ├─ vision/
│  │  │  └─ model.py            # Placeholder CNN/ViT wrapper (stub)
│  │  ├─ fusion/
│  │  │  └─ late_fusion.py      # Combine NLP + Vision signals
│  ├─ requirements.txt
│  └─ tests/
│     └─ test_smoke.py
├─ frontend/
│  ├─ streamlit_app.py          # Simple UI to upload image + symptoms
│  └─ requirements.txt
├─ scripts/
│  ├─ train_vision.py           # Training scaffold (placeholder)
│  └─ evaluate_fusion.py        # Offline fusion evaluation (placeholder)
├─ data/
│  └─ samples/                  # Place sample images here
└─ README.md
```

## Notes
- Swap the rule-based NLP with your LLM or clinical NLP.
- Replace the vision stub with a trained model (e.g., fine-tuned DenseNet on NIH CXR).
- Late fusion is modular: try early fusion (feature-level) or multimodal transformers.
- Add speech with Whisper for voice input/output.

## License
MIT
