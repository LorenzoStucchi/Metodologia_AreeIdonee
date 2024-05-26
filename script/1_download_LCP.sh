for i in {0..702}; do
    url="https://www.datigeo-piem-download.it/static/regp01/LCP2021_vector/LCP_2021-GRUPPI_COMUNI-${i}-EPSG32632-GPKG.zip"
    wget -q -nc $url
    unzip -q -o LCP_2021-GRUPPI_COMUNI-${i}-EPSG32632-GPKG.zip 
    rm -f LCP_2021-GRUPPI_COMUNI-${i}-EPSG32632-GPKG.zip
    rm -f LandCoverPiemonte_2021_guida.pdf
    rm -f QML.zip
done