
import streamlit as st
import requests
from PIL import Image
import io

st.set_page_config(page_title="Smart Healthcare Assistant", page_icon="🏥", layout="centered")
st.title("🏥 Gen AI Fusion: Smart Healthcare Assistant")
st.caption("Educational demo — Not for clinical use")

backend_url = st.text_input("Backend URL", "http://localhost:8000")

st.header("1) Upload Medical Image")
uploaded_file = st.file_uploader("Choose an image (e.g., chest X-ray)", type=["png", "jpg", "jpeg"])

st.header("2) Describe Symptoms (optional)")
symptoms = st.text_area("Enter symptoms (e.g., 'cough for two weeks, chest pain')")

analyze = st.button("Run Preliminary Analysis")

if analyze:
    if not uploaded_file:
        st.warning("Please upload an image first.")
    else:
        files = {"image": (uploaded_file.name, uploaded_file.getvalue(), uploaded_file.type)}
        data = {"symptoms_text": symptoms}
        try:
            with st.spinner("Contacting backend..."):
                resp = requests.post(f"{backend_url}/analyze", files=files, data=data, timeout=60)
            if resp.status_code == 200:
                out = resp.json()
                st.subheader("Result")
                st.write(f"**Risk level:** {out.get('risk_level','?').upper()}")
                st.write(f"**Summary:** {out.get('summary','')}")
                st.write("**Findings:**")
                for f in out.get("findings", []):
                    st.write(f"- {f}")
                if out.get("recommendations"):
                    st.write("**Recommendations:**")
                    for r in out["recommendations"]:
                        st.write(f"- {r}")
                if out.get("details"):
                    with st.expander("Debug details"):
                        st.json(out["details"])
            else:
                st.error(f"Backend error: {resp.status_code} — {resp.text}")
        except Exception as e:
            st.error(f"Request failed: {e}")
