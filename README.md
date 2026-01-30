# 🌊 Asset-Level Flood Risk Data Processing  
*AI Camp Project · WieldMore*


## 📌 Project Overview

This project focuses on **preparing high-quality, site-level data** to support flood risk assessment.  

Instead of working only at a regional level, the aim is to enable **asset-level analysis** by combining multiple environmental and risk-related datasets.  

The project was completed as part of an **AI Camp** in collaboration with **WieldMore**, a risk management investment firm.


## 👤 My Role

I was responsible for the **data collection and data processing** components of the project.


**My contributions included:**

- 🌍 Collecting data from public geospatial and environmental databases  
- 🧹 Cleaning and validating asset location data  
- ⚠️ Handling missing, invalid, and inconsistent values  
- 🗺️ Extracting terrain, climate, and water risk features at site level  
- 📊 Producing a clean, analysis-ready dataset  


> **Note:** I did not develop or train the machine learning models used later in the project.


## 🗂️ Data Types Used

The processed dataset integrates multiple types of data:

- 📍 **Asset locations** (latitude, longitude)  
- 🗺️ **Terrain data** (elevation / DTM / DSM)  
- 🌧️ **Climate data** (rainfall, soil moisture)  
- 💧 **Water risk indicators** (WRI Aqueduct)  

All datasets are spatially aligned to individual asset locations.


## 🔄 Data Processing Workflow

The data processing pipeline followed these steps:

1. Read and validate raw site location data  
2. Remove missing or invalid coordinates  
3. Spatially join environmental and water risk datasets  
4. Standardise variables for downstream analysis  
5. Export a clean, site-referenced dataset  


## 📤 Outputs

- ✔ Clean, site-level dataset  
- ✔ Environmental and water risk features ready for analysis or modelling  


## ⚠️ Limitations

- Some datasets are limited to **England only**  
- Data quality depends on the resolution and coverage of public sources  
- This repository focuses on **data preparation**, not risk prediction  


## 📝 Notes

- Raw datasets are not included due to size and licensing constraints  
- This repository documents the **data processing component** of a larger group project  


## ⭐ Why This Project Matters

High-quality data preparation is critical for reliable risk analysis.  

This project demonstrates how raw geospatial and environmental data can be transformed into **usable, site-level features** to support better decision-making.
