% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make_map_info.R
\name{make_map_info}
\alias{make_map_info}
\title{Get information for adequate mapping for regions}
\usage{
make_map_info(Region, NN_Extrap, Extrapolation_List,
  Include = (Extrapolation_List[["Area_km2_x"]] > 0 &
  Extrapolation_List[["a_el"]][, 1] > 0))
}
\description{
Function provides information to be used when plotting results
}
