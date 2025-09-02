
from typing import Dict, Any, List

def fuse(nlp: Dict[str, Any], vision: Dict[str, Any]) -> Dict[str, Any]:
    """Very simple rule-based late fusion.
    Combine NLP symptoms + Vision stub findings to produce a preliminary report.
    """
    symptoms: List[str] = nlp.get("symptoms", [])
    categories: List[str] = nlp.get("categories", [])
    v_findings: List[str] = vision.get("findings", [])

    # Risk scoring based on naive heuristics (demo only)
    risk_score = 0
    if "chest pain" in symptoms:
        risk_score += 2
    if "shortness of breath" in symptoms:
        risk_score += 2
    if any("opacity" in f for f in v_findings):
        risk_score += 2
    if "fever" in symptoms and "cough" in symptoms:
        risk_score += 1

    if risk_score >= 4:
        risk = "high"
    elif risk_score >= 2:
        risk = "moderate"
    else:
        risk = "low"

    findings = list(set(v_findings))
    if symptoms:
        findings += [f"reported_symptom:{s}" for s in symptoms]

    recommendations = []
    if risk == "high":
        recommendations.append("Seek urgent medical attention or ER evaluation.")
    if "cough" in symptoms:
        recommendations.append("Consider chest X-ray review and viral testing as clinically appropriate.")
    if any("opacity" in f for f in v_findings):
        recommendations.append("Recommend radiologist review for possible consolidation/opacity.")

    summary = (
        f"Preliminary analysis suggests {risk} risk based on symptoms "
        f"({', '.join(symptoms) if symptoms else 'none reported'}) "
        f"and vision signals ({', '.join(v_findings)})."
    )

    return {
        "summary": summary,
        "risk_level": risk,
        "findings": findings,
        "recommendations": recommendations,
        "details": {
            "nlp": nlp,
            "vision": vision
        }
    }
