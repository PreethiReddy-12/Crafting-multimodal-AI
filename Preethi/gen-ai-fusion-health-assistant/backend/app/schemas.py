
from pydantic import BaseModel, Field
from typing import Optional, List

class SymptomInput(BaseModel):
    text: str = Field(..., description="Free-text symptom description from patient.")

class AnalysisResult(BaseModel):
    summary: str
    risk_level: str
    findings: List[str] = []
    recommendations: List[str] = []
    details: Optional[dict] = None
