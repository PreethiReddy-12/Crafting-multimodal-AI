
from typing import Dict, Any, Optional
from PIL import Image
import numpy as np

class VisionModelStub:
    """A placeholder vision 'model' that inspects basic image stats.
    Replace with a real model (e.g., DenseNet for chest X-rays).
    """
    def __init__(self) -> None:
        pass

    def predict(self, image: Image.Image) -> Dict[str, Any]:
        # Example heuristic: brightness & contrast stats
        arr = np.array(image.convert("L"))
        mean = float(arr.mean())
        std = float(arr.std())

        # Fake findings based on naive thresholds (demo only)
        findings = []
        if mean < 60:
            findings.append("low_lung_aeration_suspected")
        if std > 70:
            findings.append("possible_opacity_variation")

        return {
            "mean_intensity": mean,
            "std_intensity": std,
            "findings": findings or ["no_salient_findings_stub"]
        }

# Singleton stub
vision_model = VisionModelStub()
