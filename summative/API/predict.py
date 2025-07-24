from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib
import numpy as np
import os

import uvicorn

# Load pipeline
pipeline = joblib.load("./decision_tree_pipeline.pkl")

class StartupFeatures(BaseModel):
    relationships: int = Field(..., ge=1, le=100, description="Number of team members (1-100)")
    has_roundB: int = Field(..., ge=0, le=1, description="Has Series B funding (0 or 1)")
    funding_rounds: int = Field(..., ge=0, le=50, description="Number of funding rounds (0-50)")
    has_roundA: int = Field(..., ge=0, le=1, description="Has Series A funding (0 or 1)")
    has_roundC: int = Field(..., ge=0, le=1, description="Has Series C funding (0 or 1)")
    has_roundD: int = Field(..., ge=0, le=1, description="Has Series D funding (0 or 1)")
    funding_total_usd: int = Field(..., ge=0, description="Total funding in USD (>= 0)")

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],       
    allow_credentials=True,
    allow_methods=["*"],         
    allow_headers=["*"],         
)


@app.get("/")
def root():
    return {"message": "Startup Success Predictor API is running!"}

@app.post("/predict")
def predict_status(features: StartupFeatures):
    data = np.array([[
    features.relationships,
    features.has_roundB,
    features.funding_rounds,
    features.has_roundA,
    features.has_roundC,
    features.has_roundD,
    features.funding_total_usd
]])

    raw_prediction = pipeline.predict(data)[0]
    predicted_class = 1 if raw_prediction >= 0.5 else 0

    return {
        "predicted_status": predicted_class,
        "raw_score": round(raw_prediction, 3)
    }

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run("predict:app", host="0.0.0.0", port=port)