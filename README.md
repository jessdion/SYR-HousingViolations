# Syracuse Housing Code Violations Analysis

## Overview
This project analyzes housing code violations in Syracuse to identify high-risk areas, common violation types, and trends over time. The goal is to generate insights that can support improved housing safety and resource allocation.

## Dataset
- Source: Syracuse Open Data Portal  
- Key features:
  - Location  
  - Violation type  
  - Date  
  - Status  

## Tools Used
- R (tidyverse, ggplot2)
- Adobe Illustrator (final visualization design)

## Methodology
- Data cleaning and preprocessing in R  
- Exploratory data analysis (EDA)  
- Creation of initial visualizations using ggplot2  
- Refinement and design of final visuals in Adobe Illustrator  

## Key Insights
- Certain areas experience higher concentrations of violations  
- Some violation types occur more frequently than others  
- Trends over time suggest recurring or seasonal patterns  

## Visualizations

### Code Violations Vary Significantly Across Syracuse Neighborhoods
![Neighborhood Map](visuals/violations_by_neighborhood_map.png)

Code violations are unevenly distributed across the city, with certain neighborhoods experiencing significantly higher activity. Areas such as Northside emerge as clear hotspots, indicating localized housing challenges.

---

### Most Code Violations Occur in Occupied Properties
![Vacant vs Occupied](visuals/vacant_vs_occupied.png)

The majority of violations originate from occupied properties, suggesting that housing issues are not limited to vacancy alone. However, vacant properties still play an important role in shaping neighborhood conditions.

---

### Code Violations Rise Before Leveling Off
![Time Trend](visuals/violations_over_time.png)

Violations increased steadily over time before stabilizing, with a peak around 2022. This trend may reflect changes in enforcement, reporting, or underlying housing conditions.

---

### A Small Number of Violation Types Drive Most Housing Issues
![Top Violations](visuals/top_violation_types.png)

A limited set of violation types accounts for the majority of cases, including issues such as trash, overgrowth, and interior conditions. This concentration highlights recurring patterns in housing challenges.

---

### Code Violations Show Strong Seasonal Patterns Across Months
![Monthly Trends](visuals/monthly_code_violations.png)

Violations follow a clear seasonal pattern, with activity peaking in late spring and summer months. May consistently shows higher-than-average violations, suggesting seasonal pressures on housing conditions.

## Impact
These insights can help city officials prioritize inspections and better allocate resources to improve housing conditions.

## Repository Structure
- data/: datasets  
- notebooks/: R scripts or notebooks  
- visuals/: final charts and graphics  
