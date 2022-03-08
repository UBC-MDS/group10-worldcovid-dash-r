# Covid-19 World Data Dashboard

## Motivation and purpose

Our role: Data scientist consultancy firm.

Target audience: Canadian public health communicators, such as the chief public health officer for Canada and Health Canada employees etc.

The COVID-19 pandemic has greatly impacted the lives of all Canadians. Almost overnight, Canadians shifted their behaviours and actions in response to government direction advised by public health officials in Canada. Towards the beginning of the pandemic, Canada was seen as a global leader in COVID-19 outcomes, which was largely attributed to policies such as strict travel measures, testing procedures, and large scale vaccination roll-out and uptake. More recently however, Canada has been in the news for large scale protests criticizing the government response, drawing comparisons with other nations. 

If we could compare Canada to its global counterparts using daily COVID-19 statistics, we could obtain a better understanding of Canada's relative successes in its handling of the pandemic. To address this challenge, our group proposes building a data visualization app that would allow Canadian public health communicators and officials to assess the impact of current policy, and also inform future policy decisions by visually exploring Canada's COVID-19 indicators relative to other nations.
 
Our app will show features such as case counts, number of deaths, number of hospitalizations, and number of people fully vaccinated, and allow users to explore different aspects of this data by filtering for country, and time frame. Our app will also allow users to decide which scale they would like to view the data on, such as logarithmic, and also what level of data they would like to observe; daily, weekly or monthly. We feel that these tools will be an effective way to compare COVID-19 indicators across nations.


## Description of the data

We will utilize the dataset which contains the important COVID-10 statistics around the world from [Our World In Data](https://ourworldindata.org/coronavirus). Till now, the dataset contains over 150,000 entries from Jan 2020 that covers four key areas per country on a daily basis:

- Number of cases: `total_cases`, `new_cases`
- Number of deaths: `total_deaths`, `new_deths`
- Number of hospitalizations: `hosp_patients`, `icu_patients`
- Number of people vaccinated: `people_vaccinated`, `people_fully_vaccinated`

By default, our app shows the above statistics in Canada against other countries via several interactive dashboards. Besides, it will have user-friendly functions to filter the entries by other demographics  (`country`, `continent`) and date that users are interested in.

`Table 1` illustrates sample records with some features we are visualizing as charts.

|Country|Date|Total cases|Total deaths|Hospitalization patients|Fully vaccinated|
|-------|----|-----------|------------|------------------|----------------|
|Canada|2022-02-01|3066278|34032|1167|30182561|
|Japan|2022-02-01|2820053|18882|22653|99824114|
|United Kingdom|2022-02-01|17470395|157005|502|48467140|

**Table 1: Sample of the features in dataset**

## Research questions and usage scenarios

Mary is a doctor with the Canadian Ministry of Health and she wants to understand the current state of the COVID-19 pandemic globally, in order to communicate these results with other government officials. Specifically, she wants to answer the question, how has Canada's approach to the pandemic compared to the world with regards to key COVID-19 metrics and trends over time? This will provide context for the situation in Canada, the insights from which can go towards informing policies and recommendations within the Ministry of Health, as well as communication to the public.

When Mary logs on to the “World COVID-19 dashboard”, she will see an overview of all the available variables in her data set, according to the current global data collected by University of Oxford. Specifically, data in Canada will be displayed prominently, with options to add other countries to compare in the visualizations. COVID-19 cases will be displayed on a map by default, with options to display deaths, vaccination numbers, hospitalizations, ICU admissions etc. She can filter out variables by time using a slider, in order to view data for specific time periods by month. When she does so, Mary may notice that at the beginning of the pandemic, Canada faced lower rates of ICU admissions than the United States. She may also see that North American and European Countries were the first to receive vaccines, and may use this to communicate to the Ministry which other countries are in need of vaccine supply. She hypothesizes that lower income countries have higher case counts and lower vaccines, and decides to conduct additional research into the identified countries that have higher cases of COVID-19.

Research questions may also consider how vaccine rates have influenced hospitalisation rates around the world. 

Mary may see that countries with higher vaccine rates experience lower COVID-19 cases per capita, but only for a limited period of time. She hypothesizes that the vaccine rollout has a significant effect on hospitalization and ICU admissions, and decides to use additional data and analysis to gain statistical evidence on how long vaccines can be expected to influence hospitalization rates. The results from which may inform public health timelines for covid measures.

Our design and description of the World COVID-19 dashboard can be read more in [here](https://github.com/UBC-MDS/group10-worldcovid-dashpython)
