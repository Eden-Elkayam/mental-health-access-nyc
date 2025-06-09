function loadTable(name, arr){
    FS = "|"
   # load the first field as the key
    while ((getline < name) > 0)
        arr[toupper($1)] = arr[toupper($2)]

    # Make sure file was clsoed properly
    if (close(name)){
        print "Couldn't properly close file: " name > "/dev/stderr"
        return 0
    }

    return 1
}



BEGIN{
    # Load the relevant zip cpdes
    if (!loadTable("./nyc_zips.txt", zipcodes)){
            print "FAILED TO LOAD FILE" > "/dev/stderr"
            exit -1
    }

    # The diseases data (including depression rates) is tab delimited
    FS= "\t"
    # The command for the file
    cmd = "zcat ./PLACES_20241119.gz"
    zip = 2
    measure = 5
    precent_depression = 8
    TotalPop18plus = 13
    # Header line for convinience 
    print "zip|percent_depression|TotalPop18plus|per_capita" > "depression_rates_per_zip.txt"
    # For each line in the CDC data, if the zip code balongs to NYC and the measure is depression
    while ((cmd | getline) > 0){
	if (($zip in zipcodes) && ( $measure ~ /Depression among adults/)){
	    # print the zip, % depressed, total population over 18, and depression per capita, into the new file
	    print $zip "|" $precent_depression "|" $TotalPop18plus "|" $precent_depression/100 > "depression_rates_per_zip.txt"
	}
    }
}
