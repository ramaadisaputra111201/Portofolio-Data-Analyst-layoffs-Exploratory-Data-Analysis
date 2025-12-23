# Portofolio Data Analyst : layoffs Exploratory Data Analysis

**Project Overview**

The **Layoffs** dataset contains information about employee layoffs that occurred across various global companies.The dataset used contains 2361 records, where each row represents a single layoff event and includes details such as company, location, industry, total laid off, percentage laid off, date, stage, and funds raised (in millions).

After the data has gone through a cleansing and standardization process, the Exploratory Data Analysis (EDA) phase is conducted with the primary goal of exploring patterns, trends, and relationships between variables related to global layoffs. This EDA is designed to ensure that each insight generated is not only descriptive but also able to answer analytical questions relevant to business and economic conditions.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Dataset Information**

Source : Global layoffs dataset

Records : Company-level layoff events

Key Columns :

* company
* location
* industry
* total_laid_off
* percentage_laid_off
* date
* stage
* country
* funds_raised_millions

**Tools & Skills Used**

* SQL (MySQL)
* Excel Visualization
* Analytical Thinking

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Exploratory Data Analysis**

In recent years, mass layoffs have become a global issue with significant impacts on workforce stability and the economy. Many companies, particularly in the technology sector, are reducing their workforce on a large scale. However, without proper data analysis, it is difficult to understand when layoffs are most common, which sectors and countries are most affected, and which company characteristics are most at risk. Therefore, an exploratory analysis was conducted to identify patterns, trends, and key factors driving mass layoffs.

1. Analysis of Time Patterns and Peaks of Layoff Waves

<img width="473" height="290" alt="image" src="https://github.com/user-attachments/assets/05a02f19-305f-44e1-aee2-d441a17b0e52" />  <img width="501" height="301" alt="image" src="https://github.com/user-attachments/assets/0a3bf545-5453-4c23-a719-d4381c527c54" />

The largest spike in mass layoffs occurred in 2022 (160,661 layoffs), which was 915.36% higher than the previous year. On a monthly basis, layoffs increased consistently from mid-2022 to early 2023. This finding suggests that layoffs are occurring as a sustained response to economic pressures, rather than as a temporary event.

2. Geographic Concentration Analysis of Layoffs

<img width="501" height="298" alt="image" src="https://github.com/user-attachments/assets/0eb7ca64-8f98-4263-9ecf-ac808817fd11" />

The analysis shows that the United States dominates global layoffs. This dominance aligns with the high concentration of large-scale technology companies and startups in the region, making changes in economic policy and financial markets in the United States have a significant impact on the global labor market.

3. Identifying Industries Most Vulnerable to Mass Layoffs

<img width="577" height="343" alt="image" src="https://github.com/user-attachments/assets/4c230647-cc2f-4c30-bef2-fea3524c9e97" />

The analysis shows that the Consumer, Retail, Transportation, Finance, and Other industries were the sectors with the highest number of layoffs. This indicates that these industries tend to be more sensitive to changes in macroeconomic conditions and consumer behavior, thus facing a greater risk of workforce adjustment. In terms of funding, Consumer and Transportation are in the high-funding category, while retail, finance, and healthcare are in the medium-funding category.

4. Analysis of Companies with the Largest Contribution to Layoffs

<img width="573" height="341" alt="image" src="https://github.com/user-attachments/assets/40a5146b-f90c-4af6-93fd-eaa38deb9d5d" />

These findings indicate that large-scale layoffs are often concentrated in companies with large operational scales. This suggests that mass layoffs do not necessarily reflect corporate failure but may instead be part of a restructuring and resource reallocation strategy.
The top five companies that carried out the largest layoffs were Amazon, Google, Meta, Salesforce, and Philips. The analysis shows that companies in the post-IPO and Series B-C stage experienced the highest number of layoffs. This finding indicates that mature companies often resort to layoffs as a strategic correction after an aggressive growth phase, primarily to meet profitability demands from public investors.

5. Analysis of the Relationship between Funding Amount and Layoff Risk

<img width="573" height="343" alt="image" src="https://github.com/user-attachments/assets/87500371-db46-4f89-a136-b43f26881286" />

Funding is considered low if the funding is less than $100, moderate if it is between $100 and $600, and high if it is above $600. The results showed that many high-funding companies continued to conduct large-scale layoffs. 390 high-funding companies laid off 146,550 employees, with an average of 485.26 per company. Meanwhile, 934 medium-funding companies laid off 105,941 employees, with an average of 166.05. In the low-funding category, there were 828 companies with 85,588 layoffs and an average of 155.33. Therefore, it can be concluded that the amount of funding does not affect the number of layoffs.

The analysis shows that companies with high funding still contribute significantly to layoffs. This finding indicates that the amount of funding does not always directly correlate with workforce stability, but rather reflects the growth strategy and operational efficiency implemented by the company.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Conclusion**

Overall, this Exploratory Data Analysis aims to provide a comprehensive understanding of the key factors influencing global layoffs. The analysis shows that layoffs are not solely influenced by funding levels, but rather by a combination of industry factors, geographic location, economic cycle, and company growth stage. With this understanding, the dataset is ready for further analysis and the development of data-driven strategic recommendations.
