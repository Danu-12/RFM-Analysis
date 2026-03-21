# RFM-Analysis

Marketing and CRM teams lack clear visibility into which customers drive revenue and which are disengaging, leading to inefficient campaigns and missed opportunities. RFM analysis addresses this by segmenting customers based on purchasing behavior, providing clarity on customer value and engagement.

This enables teams to focus on high-value customers for retention while identifying at-risk users for timely re-engagement. As a result, businesses can shift from generic campaigns to targeted strategies, improving marketing efficiency, customer lifetime value, and overall growth.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Data Structure](#data-structure)
3. [Executive Summary](#executive-summary)
4. [Insights Deep-Dive](#insights-deep-dive)
   - [Campaign Performance](#campaign-performance)
     - [Engagement & CTR Performance](#engagement--ctr-performance)
     - [High vs Low Conversion Campaign Performance](#high-vs-low-conversion-campaign-performance)
   - [Geographic Performance](#geographic-performance)
   - [Ad Format Performance](#ad-format-performance)
5. [Recommendations](#recommendations)
6. [Tech Stack](#tech-stack)
7. [Dashboard Preview](#dashboard-preview)
  
---

## Project Overview

This project builds a **Customer Retention Intelligence Dashboard using RFM analysis** to help marketing and growth teams better understand customer behavior and take targeted actions. By analyzing purchase patterns across **Recency, Frequency, and Monetary value over a yearly dataset,** customers are assigned scores and grouped into meaningful segments such as high-value, potential, and at-risk users. This segmentation enables stakeholders to **identify where to focus retention efforts, reduce customer churn**, and design more effective engagement strategies, ultimately improving customer lifetime value and overall business performance.

To ensure scalability and real-world applicability, the project is implemented using a **cloud-based analytics pipeline**. Data cleaning and transformation are performed in **Google BigQuery using SQL (including CTEs and conditional logic)**, where RFM metrics are computed and structured into analysis-ready datasets. This data is then **connected to Tableau for live, interactive visualization**, enabling real-time exploration of customer segments without manual intervention. T**he end-to-end pipeline is fully automated**, reflecting how modern data teams build efficient, always-updated reporting systems for business stakeholders.

Beyond segmentation, this project is part of a broader effort to **move from analysis to decision-making**. By combining insights from this RFM model with ad performance data and category-level insights, **the goal is to design a behavior-driven loyalty program for an e-commerce business**. This demonstrates the ability to not only analyze data but also translate insights into actionable strategies that drive retention, optimize marketing efforts, and create measurable business impact.
