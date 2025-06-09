# The final objective is constructing the scatterplot for depression vs providers per capita
all: final_project_scatterplot.pdf

# Filter the file of all us zip codes to extract only the NYC zip codes
nyc_zips.txt: uszips.txt make_nyc_zips.awk
	gawk -f make_nyc_zips.awk

# Use the generated NYC zipcodes list to filter the CDC data to get the depression rates for each zip code in NYC
depression_rates_per_zip.txt: nyc_zips.txt PLACES_20241119.gz make_nyc_depression_rates.awk
	gawk -f make_nyc_depression_rates.awk

# Use the generated NYC zipcodes list, the NPI data, and the list of relevant taxonomy codes to generate a providers count per NYC zipcode
provider_count_per_zip.txt: mental_health_taxonomy_codes.txt nyc_zips.txt npidata_pfile_20050523-20231112.pipe.gz make_provider_count_per_zip.awk
	gawk -f make_provider_count_per_zip.awk

# Cross the provider count per zip with the depression rates per zip to construct a providers per capita list (depression rates include population size)
providers_per_capita.txt: depression_rates_per_zip.txt provider_count_per_zip.txt make_providers_per_capita.awk
	gawk -f make_providers_per_capita.awk

# Use the providers per capita data to generate a graph plottting the level of depresion (% depressed in population) and mental health providers per capita
final_project_scatterplot.pdf: providers_per_capita.txt make_graph.py
	python3 make_graph.py

# Clean all intermediate files
clean:
	rm nyc_zips.txt depression_rates_per_zip.txt provider_count_per_zip.txt providers_per_capita.txt






