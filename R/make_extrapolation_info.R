
#' Build extrapolation grid
#'
#' \code{make_extrapolation_data} builds an object used to determine areas to extrapolation densities to when calculating indices
#'
#' @param Region a character entry that is matched against potential values to determine the region for the extrapolation grid.
#' @param strata.limits an input for determining stratification of indices (see example script)
#' @param observations_LL a matrix with two columns (labeled 'Lat' and 'Lon') giving latitude and longitude for each observation (only used when Region doesn't match known entries)
#' @param input_grid a matrix with three columns (labeled 'Lat', 'Lon', and 'Area_km2') giving latitude, longitude, and area for each cell of a user-supplied grid (only used when \code{Region=="User"})
#' @param ... other objects passed for individual regions (see example script)

#' @return Tagged list used in other functions
#' \describe{
#'   \item{a_el}{The area associated with each extrapolation grid cell (rows) and strata (columns)}
#'   \item{Data_Extrap}{A data frame describing the extrapolation grid}
#'   \item{zone}{the zone used to convert Lat-Long to UTM by PBSmapping package}
#'   \item{flip_around_dateline}{a boolean stating whether the Lat-Long is flipped around the dateline during conversion to UTM}
#'   \item{Area_km2_x}{the area associated with each row of Data_Extrap, in units square-kilometers}
#' }

#' @export
make_extrapolation_info = function( Region, strata.limits, observations_LL=NULL, input_grid=NULL, ... ){

  Extrapolation_List = NULL
  if( tolower(Region) == "california_current" ){
    Extrapolation_List = Prepare_WCGBTS_Extrapolation_Data_Fn( strata.limits=strata.limits, ... )
  }
  if( tolower(Region) %in% c("wcghl","wcghl_domain") ){
    Extrapolation_List = Prepare_WCGHL_Extrapolation_Data_Fn( strata.limits=strata.limits, ... )
  }                      #
  if( tolower(Region) == "british_columbia" ){
    Extrapolation_List = Prepare_BC_Coast_Extrapolation_Data_Fn( strata.limits=strata.limits, ... )
  }
  if( tolower(Region) == "eastern_bering_sea" ){ #
    Extrapolation_List = Prepare_EBS_Extrapolation_Data_Fn( strata.limits=strata.limits, ... )
  }
  if( tolower(Region) == "aleutian_islands" ){ #
    Extrapolation_List = Prepare_AI_Extrapolation_Data_Fn( strata.limits=strata.limits, ... )
  }
  if( tolower(Region) == "gulf_of_alaska" ){
    Extrapolation_List = Prepare_GOA_Extrapolation_Data_Fn( strata.limits=strata.limits, ... )
  }
  if( tolower(Region) == "northwest_atlantic" ){
    Extrapolation_List = Prepare_NWA_Extrapolation_Data_Fn( strata.limits=strata.limits, ... )
  }
  if( tolower(Region) == "south_africa" ){
    Extrapolation_List = Prepare_SA_Extrapolation_Data_Fn( strata.limits=strata.limits, ... )
  }
  if( tolower(Region) == "gulf_of_st_lawrence" ){
    Extrapolation_List = Prepare_GSL_Extrapolation_Data_Fn( strata.limits=strata.limits, ... )
  }
  if( tolower(Region) == "new_zealand" ){
    Extrapolation_List = Prepare_NZ_Extrapolation_Data_Fn( strata.limits=strata.limits, ... )
  }
  if( tolower(Region) == "habcam" ){  #
    Extrapolation_List = Prepare_HabCam_Extrapolation_Data_Fn( strata.limits=strata.limits, ... )
  }
  if( tolower(Region) == "gulf_of_mexico" ){
    Extrapolation_List = Prepare_GOM_Extrapolation_Data_Fn( strata.limits=strata.limits, ... )
  }
  if( tolower(Region) == "user" ){
    if( is.null(input_grid)) message("Because you're using a user-supplied region, please provide 'input_grid' input")
    if( !(all(c("Lat","Lon","Area_km2") %in% colnames(input_grid))) ) message("'input_grid' must contain columns named 'Lat', 'Lon', and 'Area_km2'")
    Extrapolation_List = Prepare_User_Extrapolation_Data_Fn( strata.limits=strata.limits, input_grid=input_grid, ... )
  }
  if( is.null(Extrapolation_List) ){
    if( is.null(observations_LL)) message("Because you're using a new region, please provide 'observations_LL' input")
    Extrapolation_List = Prepare_Other_Extrapolation_Data_Fn( strata.limits=strata.limits, observations_LL=observations_LL, ... )
  }

  # Return
  return( Extrapolation_List )
}
