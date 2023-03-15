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

temperature_matrix <- matrix( c( temperature_2018, temperature_2019 ), ncol=2, nrow=12, byrow=TRUE )
rownames(temperature_matrix) <- months

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

temperature_levels <- c( "L", "M", "H" )
temperature_breaks <- c( -Inf, 5.0, 15.0, Inf )
temperature_2019_factor <- cut( temperature_2019, breaks = temperature_breaks, labels = temperature_levels )

## Do the same for 2018

temperature_2018_factor <- cut( temperature_2018, breaks = temperature_breaks, labels = temperature_levels )

## Now compare the two factors

summary( temperature_2018_factor )
summary( temperature_2019_factor )

#===============================================================================
# DATA FRAMES - https://www.tutorialspoint.com/r/r_data_frames.htm                                                              
#===============================================================================
# A data frame is like a spreadsheet with labels for rows and columns

