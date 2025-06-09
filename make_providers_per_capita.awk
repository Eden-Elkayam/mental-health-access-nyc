function loadTable(name, arr){
    FS = "|"
   # load zip and its count
    while ((getline < name) > 0)
        arr[$1] = $2

    # Make sure file was clsoed properly                                                                                                                                                                   
    if (close(name)){
        print "Couldn't properly close file: " name > "/dev/stderr"
        return 0
    }

    return 1
}

BEGIN{
    # Load provider count by zip                                                                                                                                                                            
    if (!loadTable("provider_count_per_zip.txt", providers_count)){
            print "FAILED TO LOAD FILE" > "/dev/stderr"
            exit -1
    }
    FS= "|"
    # the file to be opened and its relevant fields
    file = "./depression_rates_per_zip.txt"
    zip = 1
    precent = 2
    population = 3
    # Go through the depression rate file                                                                                                                                                                   
    while ((getline < file) > 0){
        # for each zip code in the depression file, print it along with the providers per capita                                                                                                            
        if ($zip in providers_count){
            print $zip "|" $precent "|" providers_count[$zip]/$population > "providers_per_capita.txt"
        }
    }
}

