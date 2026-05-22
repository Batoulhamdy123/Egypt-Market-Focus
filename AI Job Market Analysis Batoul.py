#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns


# In[2]:


#ٌRead all sheets and the seperator is (;) not(,)
jobs_ai = pd.read_csv("jobs_ai.csv", sep=";")

skills_demand = pd.read_csv("skills_demand.csv", sep=";")

country_trends = pd.read_csv("country_trends.csv", sep=";")

job_title_mapping = pd.read_csv("job_title_mapping.csv", sep=";")


# In[3]:


jobs_ai.head()


# In[4]:


skills_demand.head()


# In[5]:


country_trends.head()


# In[6]:


job_title_mapping.head()


# In[7]:


jobs_ai.columns


# In[8]:


skills_demand.columns


# In[9]:


country_trends.columns


# In[10]:


job_title_mapping.columns


# In[11]:


jobs_ai.info()


# In[12]:


jobs_ai.isnull().sum()


# In[13]:


skills_demand.isnull().sum()


# In[14]:


jobs_ai = jobs_ai.drop_duplicates()

skills_demand = skills_demand.drop_duplicates()

country_trends = country_trends.drop_duplicates()

job_title_mapping = job_title_mapping.drop_duplicates()


# In[15]:


jobs_ai.describe


# In[16]:


skills_demand.describe


# In[17]:


country_trends.describe


# In[18]:


job_title_mapping.describe


# In[26]:


#convert columns numbric columns
jobs_ai["Salary_Min_Usd"] = pd.to_numeric(
    jobs_ai["Salary_Min_Usd"],
    errors="coerce"
)

jobs_ai["Salary_Max_Usd"] = pd.to_numeric(
    jobs_ai["Salary_Max_Usd"],
    errors="coerce"
)

jobs_ai["Average Salary_Usd"] = pd.to_numeric(
    jobs_ai["Average Salary_Usd"],
    errors="coerce"
)


# In[27]:


#KPI: Total Jobs
jobs_ai["Job_Id"].nunique()


# In[28]:


#AVG Salaries
jobs_ai["Average Salary_Usd"].mean()


# In[29]:


#Top Country
jobs_ai["Country"].value_counts().head()


# In[30]:


#Top Job_Title
jobs_ai["Job_Title"].value_counts().head()


# In[31]:


#Jobs By Country
jobs_by_country = jobs_ai["Country"].value_counts()

jobs_by_country


# In[32]:


#Salary By Experience
salary_by_exp = jobs_ai.groupby(
    "Experience_Level"
)["Average Salary_Usd"].mean()

salary_by_exp


# In[33]:


#Top Skills
top_skills = skills_demand["Skill"].value_counts().head(10)

top_skills


# In[34]:


#Jobs By Country Chart
jobs_by_country.head(10).plot(kind="bar")

plt.title("Jobs by Country")

plt.xlabel("Country")

plt.ylabel("Number of Jobs")

plt.show()


# In[35]:


#Salary by Experience Chart
salary_by_exp.plot(kind="bar")

plt.title("Salary by Experience Level")

plt.ylabel("Average Salary")

plt.show()


# In[36]:


#Top Skills Chart
top_skills.plot(kind="bar")

plt.title("Top Skills")

plt.ylabel("Demand Count")

plt.show()


# In[37]:


#Merge jobs with skills
jobs_skills = jobs_ai.merge(
    skills_demand,
    on="Job_Id",
    how="left"
)

jobs_skills.head()


# In[38]:


#Merge jobs with title mapping
jobs_roles = jobs_ai.merge(
    job_title_mapping,
    on="Job_Title",
    how="left"
)

jobs_roles.head()


# In[39]:


#Export Cleaned File
jobs_roles.to_csv(
    "cleaned_ai_jobs.csv",
    index=False
)


# In[42]:


#Job Distribution by Experience Level
experience_counts = jobs_ai["Experience_Level"].value_counts()

experience_counts.plot(
    kind="pie",
    autopct="%1.1f%%",
    figsize=(7,7)
)

plt.title("Job Distribution by Experience Level")

plt.ylabel("")

plt.show()


# In[43]:


#Employment Type 
employment_counts = jobs_ai["Employment_Type"].value_counts()

employment_counts.plot(
    kind="pie",
    autopct="%1.1f%%",
    figsize=(7,7)
)

plt.title("Employment Type Distribution")

plt.ylabel("")

plt.show()


# In[20]:


# Count jobs by company type
company_type = jobs_ai.groupby('Company_Type')['Job_Id'].count().reset_index()

company_type.columns = ['Company_Type', 'Jobs_Count']

# Donut Chart
plt.figure(figsize=(6, 6))

plt.pie(
    company_type['Jobs_Count'],
    labels=company_type['Company_Type'],
    autopct='%1.1f%%',
    startangle=90,
    wedgeprops={'width': 0.4}
)

plt.title('Jobs by Company Type', fontsize=14, fontweight='bold')

plt.tight_layout()
plt.show()


# In[27]:


# Average salary by company type
company_salary = jobs_ai.groupby('Company_Type')['Average Salary_Usd'].mean().reset_index()

# Colors similar to the image
colors = ['#1E90FF', '#E84393', '#1B1BB3']

# Create donut chart
fig, ax = plt.subplots(figsize=(6,6))

wedges, texts, autotexts = ax.pie(
    company_salary['Average Salary_Usd'],
    labels=company_salary['Company_Type'],
    autopct=lambda pct: f"{pct:.2f}%\n({pct/100*company_salary['Average Salary_Usd'].sum()/1000:.2f}K)",
    startangle=90,
    colors=colors,
    wedgeprops=dict(width=0.40)
)

# Title
ax.set_title(
    'AVG Salary by Company Type',
    fontsize=14,
    fontweight='bold'
)

plt.tight_layout()
plt.show()


# In[24]:


import streamlit as st

st.title("AI Job Market Analysis Dashboard")


# In[45]:


import streamlit as st
import pandas as pd
import plotly.express as px

st.set_page_config(page_title="AI Job Market Analysis", layout="wide")

st.title("AI Job Market Analysis Dashboard")
st.success("The new dashboard code is running now ✅")

jobs_ai = pd.read_csv("jobs_ai.csv", sep=";")
skills_demand = pd.read_csv("skills_demand.csv", sep=";")

jobs_ai["Average Salary_Usd"] = pd.to_numeric(jobs_ai["Average Salary_Usd"], errors="coerce")

total_jobs = jobs_ai["Job_Id"].nunique()
avg_salary = jobs_ai["Average Salary_Usd"].mean()
top_country = jobs_ai["Country"].value_counts().idxmax()
top_job = jobs_ai["Job_Title"].value_counts().idxmax()

c1, c2, c3, c4 = st.columns(4)
c1.metric("Total Jobs", total_jobs)
c2.metric("Avg Salary USD", round(avg_salary, 2))
c3.metric("Top Country", top_country)
c4.metric("Top Job", top_job)

jobs_by_country = jobs_ai["Country"].value_counts().head(10).reset_index()
jobs_by_country.columns = ["Country", "Total Jobs"]

fig1 = px.bar(jobs_by_country, x="Country", y="Total Jobs", title="Top 10 Countries by AI Jobs")
st.plotly_chart(fig1, use_container_width=True)

jobs_by_title = jobs_ai["Job_Title"].value_counts().head(10).reset_index()
jobs_by_title.columns = ["Job_Title", "Total Jobs"]

fig2 = px.bar(jobs_by_title, x="Job_Title", y="Total Jobs", title="Top 10 Job Titles")
st.plotly_chart(fig2, use_container_width=True)

employment_type = jobs_ai["Employment_Type"].value_counts().reset_index()
employment_type.columns = ["Employment_Type", "Count"]

fig3 = px.pie(employment_type, names="Employment_Type", values="Count", title="Employment Type Distribution")
st.plotly_chart(fig3, use_container_width=True)

top_skills = skills_demand["Skill"].value_counts().head(10).reset_index()
top_skills.columns = ["Skill", "Demand Count"]

fig4 = px.bar(top_skills, x="Skill", y="Demand Count", title="Top 10 In-Demand Skills")
st.plotly_chart(fig4, use_container_width=True)


# In[ ]:




