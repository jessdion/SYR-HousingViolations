# Syracuse Housing Code Violations Analysis

## Overview
This project analyzes housing code violations in Syracuse to identify where violations are concentrated, what issues are most common, and how patterns change over time. The goal is to generate insights that support improved housing conditions and more effective resource allocation.

---

## Problem

Housing code violations can indicate unsafe or deteriorating living conditions. Understanding where and when violations occur helps cities identify high-risk areas, address recurring issues, and better allocate enforcement resources.

---

## Dataset

- Source: Syracuse Open Data Portal  
- Dataset: Housing Code Violations  
- Timeframe: 2017–2025  
- Records: 137,000+  

🔗 [Syracuse Open Data – Housing Code Violations](https://data.syr.gov/datasets/107745f070b049feb38273a7ab200487_0/explore?showTable=true)

The dataset includes violation type, location, property status (vacant vs occupied), and inspection dates. Geographic data was cleaned and processed to enable accurate spatial analysis.

---

## Tools Used

- R (tidyverse, dplyr, tidyr, ggplot2, lubridate, sf)  
- Geospatial analysis (geocoding, spatial joins, coordinate validation)  
- Data aggregation and transformation (time-based and neighborhood-level)  
- Adobe Illustrator & Canva (final visualization design)

---

## Methodology

- Cleaned and standardized raw data, including correcting geographic coordinates  
- Performed geospatial analysis to map violations to Syracuse neighborhoods  
- Aggregated data across time (year, month) and location (neighborhood, address)  
- Conducted exploratory data analysis to identify spatial, categorical, and temporal patterns  
- Created visualizations in R and refined final outputs for clarity and presentation  

---

## Key Insights

- Code violations are concentrated in specific neighborhoods, with areas like Northside showing significantly higher activity  
- A small number of violation types account for the majority of cases, including trash, overgrowth, and interior conditions  
- Most violations occur in occupied properties, though vacancy remains an important contextual factor  
- Violations rise over time before leveling off, with a peak around 2022  
- Strong seasonal patterns exist, with violations peaking in late spring and summer months  

---

## Visualizations

The following visualizations highlight key spatial, categorical, and temporal patterns in Syracuse housing code violations.

### Code Violations Vary Significantly Across Syracuse Neighborhoods
![Neighborhood Map](visuals/violations_by_neighborhood_map.png)

Violations are unevenly distributed across the city, with certain neighborhoods experiencing significantly higher activity.

---

### Most Code Violations Occur in Occupied Properties
![Vacant vs Occupied](visuals/vacant_vs_occupied.png)

The majority of violations originate from occupied properties, indicating that housing issues extend beyond vacancy alone.

---

### Code Violations Rise Before Leveling Off
![Time Trend](visuals/violations_over_time.png)

Violations increased over time before stabilizing, with a peak around 2022.

---

### A Small Number of Violation Types Drive Most Housing Issues
![Top Violations](visuals/top_violation_types.png)

A limited number of violation types account for the majority of cases, highlighting recurring housing challenges.

---

### Code Violations Show Strong Seasonal Patterns Across Months
![Monthly Trends](visuals/monthly_code_violations.png)

Violations follow a clear seasonal pattern, peaking in late spring and summer months.

---

## Program Learning Outcomes

This project demonstrates key competencies from the Applied Data Science program:

- **Data Collection and Management:** Processed and structured a large real-world dataset, including cleaning geographic data  
- **Actionable Insight:** Identified spatial, categorical, and temporal patterns to highlight high-risk areas and recurring issues  
- **Visualization and Analysis:** Applied geospatial, categorical, and time-based analysis to uncover meaningful trends  
- **Programming:** Used R and relevant libraries to clean, transform, and analyze data  
- **Communication:** Designed clear, insight-driven visualizations and refined them for non-technical audiences  
- **Ethics and Context:** Interpreted findings within the broader context of housing conditions and neighborhood impact  

---

## Impact

This analysis provides insights that can help city officials prioritize inspections, identify high-risk neighborhoods, and better understand seasonal pressures affecting housing conditions.

---

## Repository Structure
- `data/` – datasets (or sample data)  
- `analysis/` – R scripts used for analysis  
- `visuals/` – final visualizations  
