# Mental Health Provider Access in NYC by ZIP Code

This project explores the correlation between the number of mental health providers per capita and the prevalence of depression across ZIP codes in New York City.

A data analysis pipeline built for the Linux environment using AWK, Python, and Makefile.

### Hypothesis

Areas with higher depression rates will have more mental health providers per capita, suggesting that provider distribution aligns with population needs.

---

## Data Sources

1. **uszips.txt**  
   Contains all ZIP codes in the U.S., including state and county information.

2. **PLACES_20241119.gz**  
   CDC dataset containing health indicators for each ZIP code, including:
   - Percent of adults (18+) diagnosed with depression
   - Total adult population per ZIP code

3. **mental_health_taxonomy_codes.txt**  
   A manually edited list of healthcare provider taxonomy codes relevant to mental health and depression treatment. Based on the full taxonomy (`nucc_taxonomy_230.txt`, not included).

4. **npidata_pfile_20050523-20231112.pipe.gz**  
   NPI registry data containing provider ZIP codes and taxonomy codes.

---

## Processing Workflow (via Linux environment)

1. **Filter NYC ZIP Codes**  
   From `uszips.txt`, extract ZIP codes within New York City.

2. **Filter Depression Data for NYC**  
   Extract depression rates and adult population sizes for NYC ZIP codes from the CDC dataset.

3. **Filter and Count Relevant Providers**  
   From the NPI data:
   - Keep providers in NYC ZIPs
   - Match against mental health taxonomy codes
   - Count providers per ZIP code

4. **Merge Datasets**  
   Combine depression and provider counts per ZIP code.  
   Calculate **providers per capita**.

5. **Visualize**  
   Use Python to generate a scatterplot:
   - X-axis: % of adults with depression
   - Y-axis: providers per capita  
   - Includes a regression line

---

## Results & Conclusion

The scatterplot shows a **moderate positive correlation** between depression rates and provider-per-capita across NYC ZIP codes.

**Interpretation**:
- Areas with higher depression rates tend to have more mental health providers.
- This could reflect:
  - Targeted resource allocation by city health agencies
  - Market-driven provider response to demand

**Future Use**:
- Depression data could inform where to open new clinics.
- Optimizing distribution may improve care access and provider efficiency.

---

## Tools Used

- AWK
- Python (matplotlib)
- Makefile
- Bash/Linux command-line utilities

---

## How to Run

Requires a Linux environment.

```bash
make
