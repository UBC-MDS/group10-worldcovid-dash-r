library(dash)
library(dashHtmlComponents)
library(ggplot2)
library(plotly)
library(purrr)
library(dplyr)
library(readr)
library(stringr)
library(RcppRoll)
library(lubridate)

#' Get COVID-19 data as data frame
#'
#' Retrieve covid data in pandas dataframe format witg tge time periods provided
#'
#' @return data.frame
#' @export
#'
#' @examples
#' get_data()
get_data <- function() {
  url <- "https://covid.ourworldindata.org/data/owid-covid-data.csv"
  
  tryCatch(
    {
      df <- read_csv(url)
    },
    error = function(e) {
      stop("The link to the data is broken.")
    }
  )
  
  columns <- c(
    "iso_code",
    "continent",
    "location",
    "date",
    "total_cases",
    "new_cases",
    "total_deaths",
    "new_deaths",
    "total_cases_per_million",
    "new_cases_per_million",
    "total_deaths_per_million",
    "new_deaths_per_million",
    "icu_patients",
    "icu_patients_per_million",
    "hosp_patients",
    "hosp_patients_per_million",
    "weekly_icu_admissions",
    "weekly_icu_admissions_per_million",
    "weekly_hosp_admissions",
    "weekly_hosp_admissions_per_million",
    "total_vaccinations",
    "people_vaccinated",
    "people_fully_vaccinated",
    "new_vaccinations",
    "population"
  )
  
  df <- df %>% select(all_of(columns))
  df <- filter(df, !str_detect(iso_code, "^OWID"))
  df <- df %>% replace(is.na(.), 0)
  
  df
}

#' Get COVID-19 data as data frame
#'
#' Retrieve covid data in pandas dataframe format witg tge time periods provided
#'
#' @param date_from Start date of the data range with format like '2021-10-31'.
#' @param date_to End date of data range with format like '2021-10-31'.
#' @param countries Charactor vector of target country names. By default it retrieves all countries
#'
#' @return data.frame
#' @export
#'
#' @examples
#' get_data(date_from = "2022-01-01", date_to = "2022-01-07", location = c("Canada", "United State"))
filter_data <- function(df, date_from, date_to, countries) {
  if (missing(date_from)) {
    date_from <- df$date %>% min()
  }
  
  if (missing(date_to)) {
    date_to <- df$date %>% max()
  }
  
  df <- df %>%
    filter(date >= date_from, date <= date_to)
  
  if (!missing(countries)) {
    df <- df %>%
      filter(location %in% countries)
  }
  
  df
}

df <- get_data()
df <- filter_data(df, date_from='2021-01-01')


# Feature dropdown functions
feature_labels <- c(
  "Total confirmed cases",
  "Total confirmed cases per million people",
  "Daily confirmed cases",
  "Daily confirmed cases per million people",
  "Total deaths",
  "Total deaths per million people",
  "Daily deaths",
  "Daily deaths per million people"
)

feature_values <- c(
  "total_cases",
  "total_cases_per_million",
  "new_cases",
  "new_cases_per_million",
  "total_deaths",
  "total_deaths_per_million",
  "new_deaths",
  "new_deaths_per_million"
)

feature_mapping <- function(label, value) {
  list(label = label, value = value)
}

data_type_mapping <- function(label, value) {
  list(label = label, value = value)
}
data_type_labels <- c("Linear", "Log")
data_type_values <- c("identity", "log")

# feature dropdown
feature_dropdown <- dccDropdown(
  id = "feature-dropdown",
  value = "total_cases_per_million",
  options = purrr::map2(feature_labels, feature_values, feature_mapping)
)

# feature dropdown2
feature_dropdown2 <- dccDropdown(
  id = "feature-dropdown2",
  value = "total_cases_per_million",
  options = purrr::map2(feature_labels, feature_values, feature_mapping)
)

# Country selector
country <- df["location"] %>%
  unique() %>%
  unlist(use.names = FALSE)

country_selector <- dccDropdown(
  id = "country-selector",
  multi = TRUE,
  options = country %>% purrr::map(function(col) list(label = col, value = col)),
  value = c("Canada", "United States", "United Kingdom", "France", "Singapore"),
)

# Linear/Log Selector (charts)
scale_line_radio <- dbcRadioItems(
  id = "scale-line-radio",
  options = purrr::map2(data_type_labels, data_type_values, data_type_mapping),
  value = "identity",
)

# Linear/Log Selector (line plot)
scale_line_radio2 <- dbcRadioItems(
  id = "scale-line-radio2",
  options = purrr::map2(data_type_labels, data_type_values, data_type_mapping),
  value = "identity",
)

# Date slider
date_unique <- unique(df["date"]) %>% arrange(date)
daterange <- 1:nrow(date_unique)
month_index <- ceiling_date(seq(date_unique$date[[1]], date_unique$date[[nrow(date_unique)]], by = "months"), "month") - days(1)
marks <- list(date_unique[[1, 1]])

for (i in 1:nrow(date_unique)) {
  marks[i] <- list(date_unique[[i, 1]])
}

marks_display <- list()

marks_display["1"] <- list(
  list(
    "label" = format(marks[[1]], format = "%y/%m"),
    "style" = list("color" = "#77b0b1")
  )
)

last_index <- length(marks)

for (i in 2:last_index) {
  if (marks[[i]] %in% month_index & last_index - i > 31 & i - 0 > 31) {
    index <- as.character(i)
    marks_display[index] <- list(list(
      "label" = format(marks[[i]], format = "%y/%m"),
      "style" = list("color" = "#77b0b1")
    ))
  }
}

last_index_char <- as.character(last_index)

marks_display[last_index_char] <- list(
  list(
    "label" = format(marks[[last_index]], format = "%y/%m"),
    "style" = list("color" = "#77b0b1")
  )
)

date_slider <- dccRangeSlider(
  id = "date_slider",
  min = daterange[1],
  max = daterange[length(daterange)],
  value = list(
    daterange[1],
    daterange[length(daterange)]
  ),
  marks = marks_display
)


# Tabs and sidebars
sidebar <- dbcCol(dbcRow(
  list(
    htmlBr(),
    htmlP(" "),
    htmlP(" "),
    htmlH3(
      "World COVID-19 Dashboard",
      style = list("font" = "Helvetica", "font-size" = "25px", "text-align" = "center")
    ),
    htmlP(" "),
    htmlP(" "),
    htmlBr(),
    htmlBr(),
    htmlP(
      "Explore the global situation of COVID-19 using this interactive dashboard. Compare selected countries and indicators across different date ranges and data scales to observe the effect of policy, and vaccination rate.",
      style = list("text-align" = "left")
    ),
    htmlHr(),
    htmlBr(),
    htmlBr(),
    htmlB("Country Filter"),
    htmlP(
      "Use this filter to add or remove a country from the analysis",
    ),
    htmlBr(),
    htmlBr(),
    country_selector
  )
),
width = 2,
style = list(
  "border-width" = "0",
  "backgroundColor" = "#d3e9ff"
),
)

# Map tab
map_tab <- dbcRow(
  list(
    htmlP(" "),
    htmlP(
      "World Map",
      style = list("font-size" = "25px")
    ),
    htmlP(
      "The map below depicts the selected COVID-19 indicator for the selected countries. Displays data as at the most recent date selected by the date slider above.",
    ),
    htmlB("Indicator:"),
    htmlP(
      "Select an indicator to explore on the map and line plot using the dropdown below."
    ),
    htmlBr(),
    htmlBr(),
    feature_dropdown,
    dccLoading(
      dccGraph(
        id = "map-plot",
        style = list("height" = "70vh")
      )
    )
  )
)

# Line tab
line_tab <- dbcRow(
  list(
    htmlP(" "),
    htmlP(
      "Line Plot",
      style = list("font-size" = "25px"),
    ),
    htmlP(
      "The line plot below depicts the selected COVID-19 indicator for the selected countries, over the date range selected by the slider above. Click the legend to highlight particular countries.",
    ),
    htmlB("Indicator:"),
    htmlP(
      "Select an indicator to explore on the map and line plot using the dropdown below.",
    ),
    htmlBr(),
    htmlBr(),
    feature_dropdown2,
    htmlP(
      " ",
    ),
    dbcCol(
      list(
        htmlP(" ", ),
        htmlB(
          "Data Scale",
          span("(?)",
               id = "tooltip-target",
               style = list(textDecoration = "underline",
                            cursor = "pointer")
          ),
        ),
        dbcTooltip(
          htmlP(list(
            "Use these buttons to change the data scale. ",
            "Linear: shows the absolute change in value over time. ",
            "Log: shows the relative change in value over time.")),
          target = "tooltip-target"
        ),
        scale_line_radio2
      ),
      width = 1,
    ),
    dbcCol(
      dccLoading(
        dccGraph(
          id = "line-plot",
          style = list("height" = "70vh"),
        )
      )
    )
  )
)

# Charts Tab
charts_tab <- dbcCol(list(
  dbcRow(list(
    htmlP(" "),
    htmlB("Data Scale:"),
    htmlP(
      "Use the radio buttons below to change the data in the visualizations to a linear or log scale."
    ),
    htmlBr(),
    scale_line_radio,
    htmlP(" "),
    htmlBr(),
    htmlBr()
  )),
  dbcRow(list(
    dbcCol(list(
      htmlB(
        "Total Vaccinations",
        list("font-size" = "25px")
      ),
      htmlP(
        "Shows the total number of people vaccinated for the selected countries, over the date range selected by the slider above."
      ),
      dccLoading(
        dccGraph(
          id = "chart_1"
        )
      )
    ), width = 6),
    dbcCol(list(
      htmlB(
        "New Vaccinations",
        list("font-size" = "25px"),
      ),
      htmlP(
        "Shows the number of people newly vaccinated for the selected countries, over the date range selected by the slider above."
      ),
      dccLoading(
        dccGraph(
          id = "chart_2"
        )
      )
    ), width = 6)
  )),
  dbcRow(list(
    dbcCol(list(
      htmlB(
        "Daily ICU Hospitalizations",
        list("font-size" = "25px")
      ),
      htmlP(
        "Shows the daily number of people per million admitted to the ICU for the selected countries, over the date range selected by the slider above."
      ),
      dccLoading(
        dccGraph(
          id = "chart_3"
        )
      )
    ), width = 6),
    dbcCol(list(
      htmlB(
        "Daily Hospitalizations",
        list("font-size" = "25px"),
      ),
      htmlP(
        "Shows the daily number of people per million admitted to the hospital for the selected countries, over the date range selected by the slider above."
      ),
      dccLoading(
        dccGraph(
          id = "chart_4"
        )
      )
    ), width = 6)
  ))
))


# APP codes
app <- Dash$new(external_stylesheets = dbcThemes$FLATLY)

app$layout(
  dbcContainer(
    dbcRow(
      list(
        sidebar,
        dbcCol(
          list(
            dbcRow(
              list(
                htmlP(" "),
                htmlB(
                  "Date Slider",
                  span("(?)",
                       id = "tooltip-target2",
                       style = list(textDecoration = "underline",
                                    cursor = "pointer")
                  ),
                ),
                dbcTooltip(
                  htmlP("Use this slider to adjust the date range of the visualizations. The dates displayed below, are the boundaries of the timeline."),
                  target = "tooltip-target2"
                ),
                htmlP(id = "date-display"),
                htmlBr(),
                htmlBr(),
                htmlP(" "),
                date_slider,
                htmlBr(),
                htmlBr(),
                htmlP(" "),
                dbcTabs(
                  list(
                    dbcTab(
                      map_tab,
                      label = "Global COVID-19 Map",
                      tab_id = "map_tab"
                    ),
                    dbcTab(
                      line_tab,
                      label = "Global COVID-19 Plot",
                      tab_id = "line_tab"
                    ),
                    dbcTab(
                      charts_tab,
                      label = "Vaccination and Hospitalization Indicators",
                      tab_id = "charts_tab"
                    )
                  )
                )
              )
            )
          ),
          width = 10
        )
      )
    ),
    fluid = TRUE
  )
)

# Date display callback
app$callback(
  output("date-display", "children"),
  list(input("date_slider", "value")),
  function(value) {
    min_date_index <- value[[1]] %>% as.integer()
    max_date_index <- value[[2]] %>% as.integer()
    
    template <- "Date range: "
    output_string <- paste0(template, marks[[min_date_index]], " to ", marks[[max_date_index]])
    output_string
  }
)

# Call-back for line plots in tab 3
app$callback(
  list(
    output("chart_1", "figure"),
    output("chart_2", "figure"),
    output("chart_3", "figure"),
    output("chart_4", "figure")
  ),
  list(
    input("country-selector", "value"),
    input("scale-line-radio", "value"),
    input("date_slider", "value")
  ),
  function(countries, scale_type, daterange) {
    min_date_index <- daterange[[1]] %>% as.integer()
    min_date <- marks[[min_date_index]] %>% as.integer()
    max_date_index <- daterange[[2]] %>% as.integer()
    max_date <- marks[[max_date_index]] %>% as.integer()    
    filter_df <- filter_data(df, date_from = min_date, date_to = max_date, countries = countries)
    
    chart_1 <- ggplot(filter_df, aes(y = people_fully_vaccinated, x = date, color = location)) +
      geom_line(stat = "summary", fun = mean) +
      #scale_y_continuous(labels = scales::label_number_si()) +
      scale_y_continuous(trans = scale_type) +
      ggthemes::scale_color_tableau() +
      labs(y = "People fully vaccinated", color='Country')
    # theme_bw()
    
    
    chart_1 <- ggplotly(chart_1)
    
    filter_df$rolling_new_vac <- roll_mean(filter_df$new_vaccinations, n = 5, align = "right", fill = NA)
    
    
    chart_2 <- ggplot(filter_df, aes(y = rolling_new_vac, x = date, color = location)) +
      geom_line(stat = "summary", fun = mean) +
      #scale_y_continuous(labels = scales::label_number_si()) +
      scale_y_continuous(trans = scale_type) +
      ggthemes::scale_color_tableau() +
      labs(y = "People newly vaccinated", color='Country')
    # theme_bw()
    
    chart_2 <- ggplotly(chart_2)
    
    chart_3 <- ggplot(filter_df, aes(y = icu_patients_per_million, x = date, color = location)) +
      geom_line(stat = "summary", fun = mean) +
      #scale_y_continuous(labels = scales::label_number_si()) +
      scale_y_continuous(trans = scale_type) +
      ggthemes::scale_color_tableau() +
      labs(y = "ICU patients per million", color='Country')
    # theme_bw()
    
    chart_3 <- ggplotly(chart_3)
    
    chart_4 <- ggplot(filter_df, aes(y = hosp_patients_per_million, x = date, color = location)) +
      geom_line(stat = "summary", fun = mean) +
      #scale_y_continuous(labels = scales::label_number_si()) +
      scale_y_continuous(trans = scale_type) +
      ggthemes::scale_color_tableau() +
      labs(y = "Hospitalized patients per million", color='Country')
    # theme_bw()
    
    chart_4 <- ggplotly(chart_4)
    
    list(chart_1, chart_2, chart_3, chart_4)
  }
)

#Map call-back
app$callback(
  output('map-plot', 'figure'),
  list(input('feature-dropdown', 'value'),
       input('country-selector', 'value'),
       input('date_slider', 'value')),
  function(xcol, countries, daterange) {
    
    max_date_index <- daterange[[2]] %>% as.integer()
    max_date <- marks[[max_date_index]] %>% as.integer()
    filter_df <- filter_data(df, date_from = max_date, countries=countries)
    filter_df$hover <- with(filter_df, paste(" Date:", date, '<br>',
                                             "Location: ", location, '<br>'
    ))
    
    map_plot <- plot_geo(filter_df)
    
    map_plot <- map_plot %>%
      add_trace(
        z = as.formula(paste0("~`", xcol, "`")), text = ~hover,
        locations = ~iso_code,
        color = as.formula(paste0("~`", xcol, "`")), colors = 'Purples'
      )
    
    map_plot <- map_plot %>% colorbar(title = "Count")  %>%
      ggplotly(map_plot)
    
  }
)

#Line Plot call back
app$callback(
  output('line-plot', 'figure'),
  list(input('feature-dropdown2', 'value'),
       input('country-selector', 'value'),
       input('scale-line-radio2', 'value'),
       input('date_slider', 'value')),
  
  function(ycol, countries, scale_type, daterange) {
    min_date_index <- daterange[[1]] %>% as.integer()
    min_date <- marks[[min_date_index]] %>% as.integer()
    max_date_index <- daterange[[2]] %>% as.integer()
    max_date <- marks[[max_date_index]] %>% as.integer()
    filter_df <- filter_data(df,
                             date_from = min_date,
                             date_to = max_date,
                             countries=countries)
    
    line_plot <- ggplot(filter_df,
                        aes(x = date,
                            y = !!sym(ycol),
                            color = location)) +
      geom_line(stat = 'summary', fun = mean) +
      #ggtitle(paste0("Country data for ", ycol)) +
      #scale_y_continuous(labels = scales::label_number_si()) +
      scale_y_continuous(trans = scale_type) +
      ggthemes::scale_color_tableau() + 
      labs(color='Country', y='')
    
    line_plot <- line_plot %>%
      ggplotly()
  }
)

app$run_server(host = "0.0.0.0")
