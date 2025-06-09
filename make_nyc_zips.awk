#! /usr/bin/gawk -f

BEGIN{
    # uszipz.txt is tab delimited
    FS = "\t"
    OFS = "|"
    file = "uszips.txt"
    # fields of interest
    zipcode = 1
    state = 5
    county = 12
    # For each line in the zip codes file
    while (getline< file){
	# If the current zip code belongs to NY state and to one of the NYC borrows, print the zip code to the new file
	if ($state == "NY"){
	    if( ($county == "New York") || ($county == "Bronx") || ($county == "Queens") || ($county == "Kings") || ($county == "Richmond")){
	 
	    print $1 "|" $12 > "nyc_zips.txt"
	}
	}
    }

}
