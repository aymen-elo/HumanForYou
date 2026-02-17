# HumanForYou — Employee Attrition Prediction

Projet de Machine Learning visant a predire le depart volontaire des employes de l'entreprise pharmaceutique HumanForYou (~4000 employes, ~15% de turnover annuel).

## Contexte

HumanForYou fait face a un taux de rotation eleve qui impacte :
- La **continuite des projets** (retards, reputation client)
- Les **couts RH** (recrutement, formation des nouveaux arrivants)
- La **productivite** (temps d'integration)

L'objectif est d'identifier les facteurs cles de l'attrition et de construire un modele predictif pour permettre des actions de retention ciblees.

## Structure du projet

```
HumanForYou/
├── data/
│   ├── raw/                          # Donnees brutes (CSV)
│   │   ├── general_data.csv          # Donnees RH (age, salaire, poste...)
│   │   ├── employee_survey_data.csv  # Enquete satisfaction employes
│   │   ├── manager_survey_data.csv   # Evaluation par les managers
│   │   ├── in_time.csv              # Horaires d'arrivee (badge)
│   │   └── out_time.csv             # Horaires de depart (badge)
│   └── README.md                     # Description des variables
├── notebooks/
│   ├── 00_Environment_Check.ipynb         # Verification de l'environnement
│   ├── 01_Data_Validation_Pipeline.ipynb  # Validation, nettoyage, fusion
│   ├── 02_EDA_Explorer.ipynb              # Analyse exploratoire
│   ├── 03_Feature_Engineering.ipynb       # Feature engineering, encoding, SMOTE
│   ├── 04_Model_Benchmark.ipynb           # Comparaison de 9 algorithmes
│   └── 05_Model_Optimization.ipynb        # Tuning, SHAP, equite, recommandations
├── outputs/                          # Resultats generes (non versionnes)
├── requirements.txt                  # Dependances Python
├── setup.sh                          # Script d'installation (Linux/macOS)
├── setup.bat                         # Script d'installation (Windows)
├── .gitignore
└── README.md
```

## Installation rapide

### Prerequis

- Python 3.10 ou superieur
- pip

### Setup avec environnement virtuel

**Windows :**
```bash
setup.bat
```

**Linux / macOS :**
```bash
chmod +x setup.sh
./setup.sh
```

**Ou manuellement :**
```bash
python -m venv .venv

# Activation
# Windows:
.venv\Scripts\activate
# Linux/macOS:
source .venv/bin/activate

# Installation des dependances
pip install -r requirements.txt

# Enregistrement du kernel Jupyter
python -m ipykernel install --user --name humanforyou --display-name "Python (HumanForYou)"
```

## Pipeline d'analyse

Les notebooks doivent etre executes **dans l'ordre** :

| # | Notebook | Description |
|---|----------|-------------|
| 00 | Environment Check | Verification des dependances et des fichiers de donnees |
| 01 | Data Validation Pipeline | Validation des schemas, audit qualite, fusion des 4 sources, extraction de features badge |
| 02 | EDA Explorer | Distributions, tests statistiques (Mann-Whitney, Chi2), correlations, analyse d'equite |
| 03 | Feature Engineering | Imputation, creation de features, encodage, scaling, SMOTE |
| 04 | Model Benchmark | Comparaison de 9 modeles (LR, RF, XGB, SVM, KNN, DT, AdaBoost, GB, MLP) |
| 05 | Model Optimization | GridSearch/RandomizedSearch, calibration de seuil, SHAP, analyse d'equite, recommandations |

## Donnees

Les donnees proviennent du dataset [HR Analytics Case Study](https://www.kaggle.com/vjchoudhary7/hr-analytics-case-study) sur Kaggle. Elles ont ete anonymisees.

- **general_data.csv** : 24 variables RH par employe
- **employee_survey_data.csv** : satisfaction (environnement, travail, equilibre)
- **manager_survey_data.csv** : evaluation manageriale (implication, performance)
- **in_time.csv / out_time.csv** : horaires de badge sur l'annee 2015

## Algorithmes evalues

- Logistic Regression
- Random Forest
- Gradient Boosting
- XGBoost
- SVM (RBF)
- K-Nearest Neighbors
- Decision Tree
- AdaBoost
- MLP (Neural Network)

## Metriques

Le projet utilise plusieurs metriques adaptees au contexte de classification desequilibree :
- **F1-Score** (metrique principale de selection)
- **Recall** (prioritaire : ne pas rater un employe a risque)
- **Precision**, **AUC-ROC**, **Accuracy**
- **Analyse d'equite** : Disparate Impact (regle des 4/5)

## Considerations ethiques

Le projet integre une demarche ethique conforme aux recommandations ALTAI de la Commission Europeenne :
- Analyse du biais sur les variables sensibles (genre, statut marital, age)
- Transparence via SHAP (explicabilite des predictions)
- Supervision humaine : le modele genere des alertes, pas des decisions

## Technologies

- **Python 3.10+**
- **Jupyter Notebook**
- pandas, numpy, scipy
- matplotlib, seaborn, plotly
- scikit-learn, XGBoost, imbalanced-learn
- SHAP, statsmodels
