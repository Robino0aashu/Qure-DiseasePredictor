import joblib
import pandas as pd
from fastapi import FastAPI
from pydantic import BaseModel

D=[{'abdominal_pain': 0, 'abnormal_menstruation': 0, 'acidity': 0, 'acute_liver_failure': 0, 'altered_sensorium': 0, 'anxiety': 0, 'back_pain': 0,'belly_pain': 0, 'blackheads': 0, 'bladder_discomfort': 0, 'blister': 0, 'blood_in_sputum': 0, 'bloody_stool': 0, 'blurred_and_distorted_vision': 0, 'breathlessness': 0, 'brittle_nails': 0, 'bruising': 0, 'burning_micturition': 0, 'chest_pain': 0, 'chills': 0, 'cold_hands_and_feets': 0, 'coma': 0, 'congestion': 0, 'constipation': 0, 'continuous_feel_of_urine': 0, 'continuous_sneezing': 0, 'cough': 0, 'cramps': 0, 'dark_urine': 0, 'dehydration': 0, 'depression': 0, 'diarrhoea': 0, 'dischromic_patches': 0, 'distention_of_abdomen': 0, 'dizziness': 0, 'drying_and_tingling_lips': 0, 'enlarged_thyroid': 0, 'excessive_hunger': 0, 'extra_marital_contacts': 0, 'family_history': 0, 'fast_heart_rate': 0, 'fatigue': 0, 'fluid_overload': 0, 'foul_smell_ofurine': 0, 'headache': 0, 'high_fever': 0, 'hip_joint_pain': 0, 'history_of_alcohol_consumption': 0, 'increased_appetite': 0, 'indigestion': 0, 'inflammatory_nails': 0, 'internal_itching': 0, 'irregular_sugar_level': 0, 'irritability': 0, 'irritation_in_anus': 0, 'joint_pain': 0, 'knee_pain': 0, 'lack_of_concentration': 0, 'lethargy': 0, 'loss_of_appetite': 0, 'loss_of_balance': 0, 'loss_of_smell': 0, 'malaise': 0, 'mild_fever': 0, 'mood_swings': 0, 'movement_stiffness': 0, 'mucoid_sputum': 0, 'muscle_pain': 0, 'muscle_wasting': 0, 'muscle_weakness': 0, 'nausea': 0, 'neck_pain': 0, 'nodal_skin_eruptions': 0, 'obesity': 0, 'pain_behind_the_eyes': 0, 'pain_during_bowel_movements': 0, 'pain_in_anal_region': 0, 'painful_walking': 0, 'palpitations': 0, 'passage_of_gases': 0, 'patches_in_throat': 0, 'phlegm': 0, 'polyuria': 0, 'prominent_veins_on_calf': 0, 'puffy_face_and_eyes': 0, 'pus_filled_pimples': 0, 'receiving_blood_transfusion': 0, 'receiving_unsterile_injections': 0, 'red_sore_around_nose': 0, 'red_spots_over_body': 0, 'redness_of_eyes': 0, 'restlessness': 0, 'runny_nose': 0, 'rusty_sputum': 0, 'scurring': 0, 'shivering': 0, 'silver_like_dusting': 0, 'sinus_pressure': 0, 'skin_peeling': 0, 'skin_rash': 0, 'slurred_speech': 0, 'small_dents_in_nails': 0, 'spinning_movements': 0, 'spotting_urination': 0, 'stiff_neck': 0, 'stomach_bleeding': 0, 'stomach_pain': 0, 'sunken_eyes': 0, 'sweating': 0, 'swelled_lymph_nodes': 0, 'swelling_joints': 0, 'swelling_of_stomach': 0, 'swollen_blood_vessels': 0, 'swollen_extremeties': 0, 'swollen_legs': 0, 'throat_irritation': 0, 'toxic_look_(typhos)': 0, 'ulcers_on_tongue': 0, 'unsteadiness': 0, 'visual_disturbances': 0, 'vomiting': 0, 'watering_from_eyes': 0, 'weakness_in_limbs': 0, 'weakness_of_one_body_side': 0, 'weight_gain': 0, 'weight_loss': 0, 'yellow_crust_ooze': 0, 'yellow_urine': 0, 'yellowing_of_eyes': 0, 'yellowish_skin': 0, 'itching': 0}]

model=joblib.load("DiseasePrdictor.joblib")
prec=pd.read_csv("Disease_precaution.csv")

precautions={}
for i in prec.Disease.unique():
    l = []
    l.extend(list(prec.Precaution_1[prec.Disease==i]))
    l.extend(list(prec.Precaution_2[prec.Disease==i]))
    l.extend(list(prec.Precaution_3[prec.Disease==i]))
    precautions[i]=l

class newList(BaseModel):
    data: list

app = FastAPI()

@app.get("/")
def home():
    return {"Page":"This is the homepage"}

@app.post("/pred/")
def pred(x: newList):
    for i in x.data:
        D[0][i] = 1

    d=pd.DataFrame.from_dict(D)
    p=model.predict(d)

    for i in x.data:
        D[0][i] = 0

    n=[i.capitalize() for i in  precautions[p[0]]]
    print(d)
    
    return {"Prediction":p[0],"Precaution":n}