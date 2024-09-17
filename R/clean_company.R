#' Clean company name
#'
#' @description Because the company name is a free text field and there is often
#' no one standard way to writing Public Sector names, this function cleans the
#' errors that have occurred in the data by creating a new column called
#' `company_cleaned`. Corrections are based on data from HACA 2024 Conference.
#' @param data
#'
#' @return
#' @export
#'
clean_company <- function(data) {
  data |>
    dplyr::mutate(company_cleaned = dplyr::case_when(company == "BNSSG I" ~ "BNSSG ICB",
      company == "B" ~ "NHS Birmingham and Solihull ICB",
      company %in% c(
        "NHSE", "NHS ENGLAND", "NHS England Midlands",
        "NHS E", "nhs england", "NHSEI",
        "NHs England"
      ) ~ "NHS England",
      company %in% c("OHID", "Office for Health Improvement & Disparities - Midlands") ~ "Office for Health Improvement and Disparities",
      company %in% c(
        "AGEM", "AGEMCSU", "NHS Arden & GEM", "AGEM CSU", "NHS  AGEM CSU",
        "Arden and GEM CSU"
      ) ~ "NHS Arden & GEM CSU",
      str_detect(company, pattern = "Health and Social Care") ~ "DHSC",
      company == "Civil service" ~ "DHSC",
      str_detect(company, pattern = "trategy") ~ "The Strategy Unit",
      company == "SU" ~ "The Strategy Unit",
      company %in% c("NHS South, Central and West", "NHS South Central and West", "NHS SCW CSU", "NHS SCW") ~ "NHS South, Central and West CSU",
      company %in% c("NHS lothian", "NHS Lothian") ~ "NHS Lothian - Scotland",
      company %in% c("Her", "Hertfordshi") ~ "Hertfordshire County Council",
      company %in% c(
        "ML", "ML CSU", "MLCSU", "ML CSS", "MLCS",
        "NHS MLCSU",
        "Midlands And Lancashire CSU",
        "Mids & Lancs CSU",
        "Midlands & Lancashire",
        "NHS Midlands and Lancashire",
        "NHS Midlands and Lancashire CSU",
        "Midlands and Lancashire Commissioning Support Unit",
        "Midlands & Lancashire Commissioning Support Unit"
      ) ~ "Midlands and Lancashire CSU",
      str_detect(company, pattern = "Shropshire") ~ "NHS Shropshire, Telford and Wrekin ICB",
      company == "STW ICB" ~ "NHS Shropshire, Telford and Wrekin ICB",
      # companies with single corrections
      company == "Northern Care Alliance" ~ "Northern Care Alliance NHS Foundation Trust",
      company == "DHSC - OHID" ~ "DHSC",
      company == "NDRS" ~ "National Disease Registration Service",
      str_detect(company, pattern = "Countess") ~ "Countess of Chester NHS FT",
      str_detect(company, pattern = "Epsom") ~ "Epsom & St Helier University Hospitals NHS Trust",
      str_detect(company, pattern = "Health Innovation Network") ~ "Health Innovation Network",
      str_detect(company, pattern = "Blood") ~ "NHS Blood and Transplant",
      str_detect(company, pattern = "Walsall Coun") ~ "Walsall Council",
      str_detect(company, pattern = "University of Exeter") ~ "University of Exeter",
      str_detect(company, pattern = "Princess") ~ "The Princess Alexandra Hospital NHS Trust",
      str_detect(company, pattern = "Health Economics Unit") ~ "Health Economics Unit",
      str_detect(company, pattern = "Health Foundation") ~ "The Health Foundation",
      str_detect(company, pattern = "Christie") ~ "The Christie NHS Foundation Trust",
      str_detect(company, pattern = "Public Health Agency") ~ "Public Health Agency Northern Ireland",
      str_detect(company, pattern = "Nottingham University") ~ "Nottingham University Hospitals NHS FT",
      str_detect(company, pattern = "Suffolk and North East Essex") ~ "Suffolk and North East Essex ICB",
      str_detect(company, pattern = "Lincolnshire") ~ "NHS Lincolnshire ICB",
      str_detect(company, pattern = "Nottshc") ~ "Nottinghamshire Healthcare NHS Foundation Trust",
      str_detect(company, pattern = "PHA") ~ "Public Health Agency Northern Ireland",
      str_detect(company, pattern = "Public Health Agency") ~ "Public Health Agency Northern Ireland",
      company == "Southern Health & Social Care Trust" ~ "Public Health Agency Northern Ireland",
      company == "NHS STW" ~ "NHS Shropshire, Telford and Wrekin ICB",
      company == "Gloucestershire Integrated Care Board" ~ "Gloucestershire ICB",
      company == "Alder Hey NHS Foundation Trust" ~ "Alder Hey Children's NHS Foundation Trust",
      # company == "Coventry and Warwickshire ICB" ~ "Coventry & Warwickshire ICB",
      company == "ESNEFT" ~ "East Suffolk North Essex NHS Foundation Trust",
      company == "GENOMICS ENGLAND" ~ "Genomics England",
      company == "HIN" ~ "Health Innovation Network",
      company == "kent and medway ICB" ~ "Kent and Medway ICB",
      company == "UKLLC" ~ "UK Longitudinal Linkage Collaboration",
      company == "UK Health Security Agency" ~ "UKHSA",
      company == "Royal Cornwall" ~ "Royal Cornwall Hospitals NHS Trust",
      company == "UCLPartners" ~ "UCL Partners",
      company == "TGICFT" ~ "Tameside and Glossop Integrated Care",
      company == "NHS Transformation Unit - MLCSU" ~ "NHS Transformation Unit",
      company == "Northumbria Healthcare" ~ "Northumbria Healthcare NHS Foundation Trust",
      company == "DGFT" ~ "Dudley Group NHS Foundation Trust",
      company == "UHCW" ~ "University Hospitals Coventry and Warwickshire",
      company == "NHS Lincolnshire Integrated Care Board" ~ "NHS Lincolnshire ICB",
      # company == "Staffordshire & Stoke-on-Trent ICB" ~ "Staffordshire and Stoke-on-Trent ICB",
      company == "CQC" ~ "Care Quality Commission",
      company == "Royal Cornwall Hospitals Trust" ~ "Royal Cornwall Hospitals NHS Trust",
      company == "Yorkshire Ambulance Service Trust" ~ "Yorkshire Ambulance Service NHS Trust",
      company == "Central and North West London NHS Foundation Trust" ~ "Central and North West London NHS Foundation Trust",
      company == "NHS Borders" ~ "NHS Borders - Scotland",
      company == "LLR ICB" ~ "Leicester, Leicestershire and Rutland ICB",
      company == "NHSBSA" ~ "NHS Business Services Authority",
      company == "NHSE North East and NHCT" ~ "Northumbria Healthcare NHS Foundation Trust",
      company == "SECAmb" ~ "South East Coast Ambulance Service",
      company == "south east london ics" ~ "South East London ICS",
      company == "UHB  NHS FT" ~ "University Hospitals Birmingham NHS Foundation Trust",
      company == "National Institute for Health and Care Excellence (NICE)" ~ "NICE",
      company == "Yorkshire Ambulance Service" ~ "Yorkshire Ambulance Service NHS Trust",
      company == "N/A" ~ "Public",
      company == "CNWL NHS Foundation Trust" ~ "Central and North West London NHS Foundation Trust",
      company == "NHS Executive" ~ "NHS Executive Wales",
      company == "Hywel Dda Health Board" ~ "Hywel Dda Health Board Wales",
      company == "Uob" ~ "University of Birmingham",
      company == "Dudley Group Foundation Trust" ~ "Dudley Group NHS Foundation Trust",
      company == "East Suffolk and North Essex NHS Foundation Trust" ~ "East Suffolk North Essex NHS Foundation Trust",
      company == "Medgen and LSE" ~ "Medgen and London School of Economics",
      .default = company
    )) |>
    dplyr::mutate(company_cleaned = stringr::str_replace(company_cleaned, "&", "and"))
}
