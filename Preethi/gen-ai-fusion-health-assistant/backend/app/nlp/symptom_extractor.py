
import re
from typing import List, Dict

COMMON_SYMPTOMS = [
    "fever", "cough", "shortness of breath", "chest pain", "fatigue",
    "headache", "sore throat", "nausea", "vomiting", "diarrhea",
    "dizziness", "loss of smell", "loss of taste"
]

KEYWORD_TO_CATEGORY = {
    "fever": "infectious",
    "cough": "respiratory",
    "shortness of breath": "respiratory",
    "chest pain": "cardio-respiratory",
    "fatigue": "general",
    "headache": "neurological",
    "sore throat": "respiratory",
    "nausea": "gastrointestinal",
    "vomiting": "gastrointestinal",
    "diarrhea": "gastrointestinal",
    "dizziness": "neurological",
    "loss of smell": "respiratory",
    "loss of taste": "respiratory",
}

def extract_symptoms(text: str) -> Dict[str, List[str]]:
    t = text.lower().strip()
    found = []
    for s in COMMON_SYMPTOMS:
        # match whole words loosely
        pattern = r"\b" + re.escape(s) + r"\b"
        if re.search(pattern, t):
            found.append(s)

    categories = sorted({KEYWORD_TO_CATEGORY[s] for s in found}) if found else []
    return {
        "symptoms": found,
        "categories": categories,
    }
