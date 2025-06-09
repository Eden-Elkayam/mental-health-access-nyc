function loadTable(name, arr){
    FS = "|"
   # Add every first field into the new array
    while ((getline < name) > 0)
        arr[$1] = 0   # Only the first field is needed, will be used to count later in the code so initialized with 0

    # Make sure file was clsoed properly
    if (close(name)){
        print "Couldn't properly close file: " name > "/dev/stderr"
        return 0
    }
    return 1
}

BEGIN{
    # Load the nyc zip codes
    if (!loadTable("./nyc_zips.txt", zipcodes)){
            print "FAILED TO LOAD FILE" > "/dev/stderr"
            exit -1
    }
    # Load the mental health taxonomy codes
    if (!loadTable("./mental_health_taxonomy_codes.txt", taxonomy)){
            print "FAILED TO LOAD FILE" > "/dev/stderr"
            exit -1
    }

    FS= "|"
    # command to open the NPI data
    cmd = "zcat ./npidata_pfile_20050523-20231112.pipe.gz"
    # Relevant fields in the NPI data
    zip = 33
    first_code = 48   # 15 fields that potentially contain a taxonomy code, in intervals of 4
    last_code = 104

    # For each provider
    while ((cmd | getline) > 0){
	curZip = substr($zip,1,5)    # isolate the zipcode in the 5 digit format

	# If the provider's zipcode is a nyc zipcode 
	if (curZip in zipcodes){
	    # Go through the fields that could contain a taxonomy number
	    for (i = first_code; i <=last_code; i += 4) {
		# if the provider has a code that exists in the taxonomy list
		if ($i in taxonomy){
		    # increment the count of providers for that zip code
		    zipcodes[curZip]+=1
		    # Break so you don't count the same doctor twice
		    break
		}
	    }
	}
    }
    # After counting all relevant doctors, print the count into a new list  
    for (i in zipcodes){
	print i "|"  zipcodes[i] > "provider_count_per_zip.txt"
    }
}
