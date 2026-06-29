# Reproducing selected WindCube 100S observations of Kelvin--Helmholtz billows during LOLLEX

This repository contains a MATLAB Live Script illustrating selected processing steps for ship-borne Doppler wind lidar observations from the LOLland offshore Lidar EXperiment (LOLLEX). The example focuses on the Kelvin--Helmholtz billow (KHB) event observed on 22 February 2023 above the Rødsand II offshore wind farm and analysed by Malekmohammadi et al. (2025a).

The repository is intended as a lightweight companion example for data exploration and visualisation. It is **not** the original analysis code used in the KHB paper and does **not** reproduce the full processing chain, quality-control procedure, stationarity assessment, spectral analysis, or contextual meteorological analysis described in the publication. The scientific results, methodology, and interpretation should be taken from the paper itself.

This example was prepared by E. Cheynet. It should not be interpreted as documenting the full analysis work carried out for the KHB paper or the LOLLEX campaign paper. The primary data processing, campaign data curation, scientific analysis, and thesis-related work associated with these studies are described in Malekmohammadi et al. (2025a,b) and in the associated PhD work.

## Repository content

```text
.
├── Documentation.mlx
├── data/
│   ├── 20251218_eww_opendatabase.csv
│   ├── gebco_2025_n57.0_s53.0_w9.0_e14.0.nc
│   ├── NORA3_2022_2023_locationMatching_filled.mat
│   ├── WLS100s-37_2023-02-22_12-30-02_dbs_229_25m.nc
│   └── WLS100s-37_2023-02-22_12-35-04_fixed_228_25m.nc
└── functions/
    ├── plotLollexTopography.m
    ├── dem.m
    └── other helper functions used by the Live Script
```

## What the Live Script does

`Documentation.mlx` demonstrates how to:

1. plot the topography and bathymetry around the LOLLEX measurement area;
2. read one WindCube 100S DBS scan preceding the KHB event;
3. read one WindCube 100S fixed vertical line-of-sight scan spanning the KHB event;
4. apply basic filtering based on carrier-to-noise ratio (CNR);
5. compare the DBS mean wind-speed profile with NORA3 data;
6. correct the fixed-LOS velocity for a static beam tilt of 2.7 degrees;
7. visualise the KHB event using time-height plots of CNR, static-tilt-corrected vertical velocity, and the 60 s moving standard deviation of vertical velocity;
8. estimate vertical profiles of standard deviation and kurtosis, and PSD estimates at approximately 650 m.

The processing is intentionally simplified to keep the example readable.

## Data

The repository uses the following data files.

### WindCube 100S example files

The two NetCDF files correspond to the KHB case study on 22 February 2023:

* `WLS100s-37_2023-02-22_12-30-02_dbs_229_25m.nc`
* `WLS100s-37_2023-02-22_12-35-04_fixed_228_25m.nc`

The first file contains the DBS scan used to estimate the mean horizontal wind-speed profile. The second file contains the fixed vertical-stare scan used to visualise the KHB event.

### NORA3 data

`NORA3_2022_2023_locationMatching_filled.mat` contains atmospheric hindcast data used as a large-scale reference for the mean wind-speed profile around the event.

### GEBCO data

`gebco_2025_n57.0_s53.0_w9.0_e14.0.nc` contains GEBCO 2025 topography and bathymetry data for the region around Lolland, Denmark.

Recommended citation:

GEBCO Bathymetric Compilation Group 2025 (2025). *The GEBCO_2025 Grid - a continuous terrain model for oceans and land at 15 arc-second intervals*. NERC British Oceanographic Data Centre. doi:10.5285/37c52e96-24ea-67ce-e063-7086abc05f29

### Offshore wind-farm database

`20251218_eww_opendatabase.csv` is derived from the Open European offshore wind turbine database.

Recommended citation:

Fischereit, J., Vollmer, L., & Hansen, A. (2025). *Open European offshore wind turbine database* [Data set]. Zenodo. doi:10.5281/zenodo.17311571

## MATLAB requirements

The Live Script was written for MATLAB and uses standard MATLAB functions for reading NetCDF files, handling datetime arrays, and plotting.

The following MATLAB toolboxes may be required depending on the installed MATLAB version:

* Signal Processing Toolbox, for `pwelch`;
* Statistics and Machine Learning Toolbox, for `kurtosis`.

The script also uses several external or custom functions.

## External MATLAB functions

The Live Script uses the following File Exchange functions:

* `cmocean`: perceptually uniform colormaps by Chad Greene, based on the cmocean colormaps.

  * File Exchange: https://www.mathworks.com/matlabcentral/fileexchange/57773-cmocean-perceptually-uniform-colormaps

* `imagescn`: a modified `imagesc`-like function that handles NaN values transparently.

  * File Exchange: https://www.mathworks.com/matlabcentral/fileexchange/61293-imagescn

* `dem`: shaded relief image plot for digital elevation models by François Beauducel.

  * File Exchange: https://www.mathworks.com/matlabcentral/fileexchange/36380-dem-shaded-relief-image-plot-digital-elevation-model

This repository may include a modified version of `dem.m`. If redistributed, the original attribution and license information should be preserved.

The Live Script also uses helper functions such as `plotLollexTopography`, `fillgaps`, and `label`. These should be available in the `functions/` folder or otherwise added to the MATLAB path.

## How to run

1. Clone or download this repository.
2. Open MATLAB.
3. Set the repository root as the current working directory.
4. Open `Documentation.mlx`.
5. Run the Live Script section by section.

The script assumes the following relative paths:

```matlab
addpath('./functions')
addpath('./data')
```

Large data files should remain in the `data/` folder unless the paths are updated in the Live Script.

## Notes on reproducibility

The objective is to reproduce selected visual features and turbulence statistics from the KHB case study using minimal processing. Numerical values may differ slightly from the published paper because the full processing chain is not implemented here. In particular, this example does not reproduce the full data-quality control, motion-correction discussion, stationarity assessment, EPSD analysis, or multi-source meteorological contextualisation from Malekmohammadi et al. (2025a).

The full LOLLEX lidar dataset is planned to be made available in 2026. The exact release date will depend on the publication timeline of the companion LOLLEX paper.

## References

Malekmohammadi, S., Cheynet, E., & Reuder, J. (2025a). *Observation of Kelvin--Helmholtz billows in the marine atmospheric boundary layer by a ship-borne Doppler wind lidar*. Scientific Reports, 15, 5245. doi:10.1038/s41598-025-89554-4

Malekmohammadi, S., Cheynet, E., Reuder, J., Linnemann, C., Sjöholm, M., Mann, J., & Giebel, G. (2025b). *The LOLland offshore Lidar EXperiment (LOLLEX): A novel observational approach for the study of wind farm flow and entrainment*. EGUsphere [preprint]. doi:10.5194/egusphere-2025-3148

Fischereit, J., Vollmer, L., & Hansen, A. (2025). *Open European offshore wind turbine database* [Data set]. Zenodo. doi:10.5281/zenodo.17311571

GEBCO Bathymetric Compilation Group 2025 (2025). *The GEBCO_2025 Grid - a continuous terrain model for oceans and land at 15 arc-second intervals*. NERC British Oceanographic Data Centre. doi:10.5285/37c52e96-24ea-67ce-e063-7086abc05f29

## License
The repository-specific MATLAB Live Script and helper functions are released under the BSD 3-Clause License.
