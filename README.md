# World COVID-19 Dashboard (R)

## Welcome :microbe: :earth_asia:

Thank you for visitng the World COVID-19 Dashboard app project repository. Link to our app here: [World COVID-19 Dashboard-R](https://worldcovid-dashr.herokuapp.com/)

### Run the app locally

Coming soon!

## The Problem

- The COVID-19 pandemic has greatly impacted the lives of all people.
- Access to open source data that delivers information on the current state of the pandemic through data alone is key to informing both policy makers and regular citizens alike with the least bias possible. While there are resources out there, few sources are very engaging or intuitive.

Many COVID related policies such as strict travel measures, testing procedures, and large scale vaccination roll-out and uptake have varied between nations and have caused conversation. Their impact is difficult to assess without easily interpretable and accurately presented data.

## The Solution
To address this challenge, we have built the World COVID-19 Dashboard app that:
- visualizes key data indicators about COVID 19 such as deaths, hospitalizations and vaccination numbers, allowing users to explore and quickly understand the current state of the pandemic situation globally;
- allows for comparison across nations, and adjustable timelines to suit the curiosity of the user;
- and visualizes data over time and across different countries in an engaging and tangible way with customization and animations.

## Who are we?

We are group 10 from DSCI 532. Please read the contributors section for more information on our team.

## The App and Design
For a full story on our app and design, please read our :books: [proposal document](https://github.com/UBC-MDS/group10-worldcovid-dash-r/blob/main/docs/proposal.md)

Our app consists of three main tabs: Global COVID-19 Map, Global COVID-19 Plot, and Vaccination and Hospitalization Indicators.

**Global COVID-19 Map**:
 - This tab aims to give a "global overview" of the COVID-19 situation through the lens of an animated map that highlights selected countries for a selected indicator. This visualization is filtered using the "Indicator" drop down, the "Country Filter" to select which countries are showcased, and the "Date range" slider at the top of the screen that limits or expands the visualized timeline. A main focus of this tab is the animation in the map, which when "played" shows the change in data over time by country. This element is especially important as it tells a story of where the world started, where it went, and how far it has come in a very tangible way.

**Global COVID-19 Plot**:  
- This tab allows the user to explore an indicator of interest in the form of a line plot. This visualization is filtered using the "Indicator" drop down, the "Country Filter" to select which countries are showcased, and the "Date range" slider at the top of the screen that limits or expands the visualized timeline. The data type can be shown as either linear or log using the "Data Scale" radio buttons to suit the curiosity of the user. Countries within the plot can be highlighted be selecting them in the legend.

**Vaccination and Hospitalization**:
- This tab aims to give a quick understanding of the movement of vaccination rates and hospitalizations, and how that differed between nations throughout the pandemic. It consists of four line charts; "Total Vaccinations", "New Vaccinations", "Current ICU", and "Current Hospitalizations". Similar to the first tab, the charts are filtered by the "Country Filter" to select which countries are showcased, and the "Date range" slider at the top of the screen that limits or expands the visualized timeline. The data type can be shown as either linear or log using the "Data Scale" radio buttons to suit the curiosity of the user.

## Usage
- Per the GIF below, our app is meant to be highly filterable and interactive and can be used multiple ways to suit the data needs of policy makers, public health communicators, and regular folks alike in the best way they see fit for the impacts they want to understand or the message they want to convey.

Coming Soon!

## The Data

The complete COVID-19 dataset used in our dashboard can be downloaded in:
- :bar_chart: [CSV](https://covid.ourworldindata.org/data/owid-covid-data.csv)
- :chart_with_upwards_trend: [XLSX](https://covid.ourworldindata.org/data/owid-covid-data.xlsx)
- :chart_with_downwards_trend: [JSON](https://covid.ourworldindata.org/data/owid-covid-data.json)

This is a collection of the COVID-19 data maintained by :earth_africa: [_Our World in Data_](https://ourworldindata.org/coronavirus).

## License

The World COVID-19 Dashboard was created by Adam Morphy, Kingslin Lv, Thomas Siu, and Kristin Bunyan. It is licensed under the terms of the MIT license.

## Contributing
### Development Lead

| Member        | Github                                            |
|---------------|---------------------------------------------------|
| Adam Morphy   | [adammorphy](https://github.com/adammorphy)       |
| Kingslin Lv   | [Kingslin0810](https://github.com/Kingslin0810)   |
| Kristin Bunyan| [khbunyan](https://github.com/khbunyan)           |
| Thomas Siu    | [thomassiu](https://github.com/thomassiu)         |

We welcome and recognize all contributions! Please find the guide for contribution in our [Contributing Document](https://github.com/UBC-MDS/group10-worldcovid-dash-r/blob/main/CONTRIBUTING.md). Please note that this project is released with a Code of Conduct. By contributing to this project, you agree to abide by its terms.

## References

COVID-19 Data Repository by [Our World Data](https://ourworldindata.org/coronavirus) at University of Oxford. This data has been collected, aggregated, and documented by Cameron Appel, Diana Beltekian, Daniel Gavrilov, Charlie Giattino, Joe Hasell, Bobbie Macdonald, Edouard Mathieu, Esteban Ortiz-Ospina, Hannah Ritchie, Lucas Rodés-Guirao, and Max Roser.
