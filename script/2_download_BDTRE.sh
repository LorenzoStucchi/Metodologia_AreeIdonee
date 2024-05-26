for i in {4001..4251}; do
    url="https://www.datigeo-piem-download.it/static/regp01/BDTRE2023_VECTOR/BDTRE_DATABASE_GEOTOPOGRAFICO_2023-LIMI_COMUNI_10_GAIMSDWL-00${i}-EPSG32632-SHP.zip"
    wget -nc $url
    unzip -q -o BDTRE_DATABASE_GEOTOPOGRAFICO_2023-LIMI_COMUNI_10_GAIMSDWL-00${i}-EPSG32632-SHP.zip -d 00${i}
    rm -f BDTRE_DATABASE_GEOTOPOGRAFICO_2023-LIMI_COMUNI_10_GAIMSDWL-00${i}-EPSG32632-SHP.zip
    rm -f BDTRE_DATABASE_GEOTOPOGRAFICO_2023_guida.pdf
    cp "00${i}/VIAB/el_str_tp_str_2023.cpg" "el_str_tp_str_2023/00${i}_el_str_tp_str_2023.cpg"
    cp "00${i}/VIAB/el_str_tp_str_2023.dbf" "el_str_tp_str_2023/00${i}_el_str_tp_str_2023.dbf"
    cp "00${i}/VIAB/el_str_tp_str_2023.prj" "el_str_tp_str_2023/00${i}_el_str_tp_str_2023.prj"
    cp "00${i}/VIAB/el_str_tp_str_2023.shp" "el_str_tp_str_2023/00${i}_el_str_tp_str_2023.shp"
    cp "00${i}/VIAB/el_str_tp_str_2023.shx" "el_str_tp_str_2023/00${i}_el_str_tp_str_2023.shx"
done