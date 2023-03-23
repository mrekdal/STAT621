# STAT621
# Book: https://r4ds.had.co.nz/
# Dataøving 1

#===============================================================================
# INTRODUCTION
#===============================================================================


# Exercise 1
# Simple arithmetic stored to objects

first <- 23 + 16
second <- 11 - 45
third <- first / second

#===============================================================================
# VECTORS - https://www.tutorialspoint.com/r/r_vectors.htm
#===============================================================================

# Exercise 2
# Vectors/arrays 

## Part 1: Naming elements in the array

temperature_2019 <- c( 2.6, 5.3, 4.6, 9.8, 9.4, 14.1, 16.2, 16.4, 11.6, 8.0, 3.0, 5.0 )
months <- c( "Jan", "Feb", "Mar", "Apr", "Mai", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Des" )
names(temperature_2019) <- months
plot( temperature_2019 )

## Part 2: Copying slices from the array

first_half <- temperature_2019[c(1:6)]
second_half <- temperature_2019[c(7:12)]

# Exercise 3
# Extract only high temperatures

high_temperature <- c(temperature_2019[ temperature_2019 > 10 ] )

# Exercise 4
# Convert to Fahrenheit

temperature_2019_fahr = temperature_2019 * 1.8 + 32

#===============================================================================
# MATRICES
#===============================================================================

# Exercise 5
# Create a two-dimensional matrix from 2018 and 2019
# Combine the two into a single vector and slice it into columns and rows

temperature_2018 = c( 2.7, 0.9, 0.8, 7.5, 14.7, 14.6, 17.3, 14.5, 12.0, 8.4, 6.7, 4.2 )
names(temperature_2018) <- months

temperature_matrix <- matrix( c( temperature_2018, temperature_2019 ), ncol=2, nrow=12, byrow=FALSE )
rownames(temperature_matrix) <- months
temperature_matrix

# Exercise 6 (rerun from 5)
# Use the function mean to calculate the average temperature for 2018 and 2018 separately

mean_2018 <- mean( temperature_2018 )
mean_2019 <- mean( temperature_2019 )
mean_year <- c( mean_2018, mean_2019 )
temperature_matrix <- rbind( temperature_matrix, mean_year ) # Rerun Exercise 5 or this will be accumulated 

# Exercise 7
# Transform values into Fahrenheit

temperature_matrix_fahr <- temperature_matrix * 1.8 + 32

#===============================================================================
# FACTORS - https://www.tutorialspoint.com/r/r_factors.htm                                                              
#===============================================================================

# Exercise 8
# Construct a factor for temperatures in 2019 with these levels, <5, 5-15, 15 and above
# Not sure if we were meant to create the factor from the numeric data?
# I use the cut function to categorize the data with cutoffs, must include endpoints to make three groups.
# The intervals are closed on the right by default (includes the limit in the left interval).  We don't want that.


temperature_levels <- c( "L", "M", "H" )
temperature_breaks <- c( -Inf, 5.0, 15.0, Inf )

## Create a test set, to make that we have two values in each category, i.e. the intervals are closed on the left.

test_values =  c( 0, 4.9, 5, 5.1, 15, 15.1 )
test_factor <- cut( test_values, right=FALSE, breaks = temperature_breaks, labels = temperature_levels )
summary( test_factor )

## Create a factor for 2019 temperatures

factor_temperature_2019 <- cut( temperature_2019, breaks = temperature_breaks, labels = temperature_levels, right = FALSE )
factor_temperature_2019


## Do the same for 2018

factor_temperature_2018 <- cut( temperature_2018, breaks = temperature_breaks, labels = temperature_levels, right = FALSE )
factor_temperature_2018

## Now compare the two factors

summary( factor_temperature_2018 )
summary( factor_temperature_2019 )

#===============================================================================
# DATA FRAMES - https://www.tutorialspoint.com/r/r_data_frames.htm                                                              
#===============================================================================

# A data frame is like a spreadsheet with labels for rows and columns
# The length of the vectors need to be the same when constructing a data frame

# Exercise 9
# Construct a data set (data frame) with the factors from 2018 and 2019
# We need to exclude the mean from the matrix to make it 12 rows long like the other ones.

  data_frame <- data.frame( head(temperature_matrix,12), factor_temperature_2018, factor_temperature_2019 )
  
## Make names for the columns in the frame for better readability

  names(data_frame)[1] <- "temp_2018"
  names(data_frame)[2] <- "temp_2019"

## Order the dataset according to temperature 2019 and save it to increasing_2019

    increasing_2019 <- data_frame[order( data_frame$temp_2019 ),]

## Do the same for 2018
  
  increasing_2018 <- data_frame[order( data_frame$temp_2018 ),]
  
## Then in both these datasets, select only the elements where factor_temperature_YYYY is H
  
subset( increasing_2019, subset=factor_temperature_2019=="H" )
subset( increasing_2018, subset=factor_temperature_2018=="H" )

#===============================================================================
# LISTS - https://www.tutorialspoint.com/r/r_lists.htm                                                              
#===============================================================================

# List are key-value pairs that can have anonymous keys (just indexed by position)
# The lists can contain any type of data, it is like an ordered collection of objects and/or scalars.
# The behavior is very similar to a JSON object from what I can see.
# The individual parts of the list seems to be called an "element" and sometimes a "component".

# Exercise 10
# Construct a list containing temperature_matrix, factor_temperature_2019, and factor_temperature_2018

temperature_list <- list( temperature_matrix, factor_temperature_2019, factor_temperature_2018 )

# Extract from the list the temperature of May 2019 and, separately, its respective factor. 

temp_may_2019 <- temperature_list[[1]][5,2]
temp_may_2019_factor <- temperature_list[[2]][5]
sprintf( "May 2019: %.1f\U00B0 C (%s)", temp_may_2019, temp_may_2019_factor )

# Do the same for May 2018.

temp_may_2018 <- temperature_list[[1]][5,1]
p_may_2018_factor <- temperature_list[[3]][5]
sprintf( "May 2018: %.1f\U00B0 C (%s)", temp_may_2018, temp_may_2018_factor )


