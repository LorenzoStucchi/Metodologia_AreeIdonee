mkdir -p all_zip/zip
if [ -e "3_download_TINITALY_list.txt" ]; then
    while IFS= read -r url; do
        main_url="http://tinitaly.pi.ingv.it/data_1.1/${url}/${url}.zip"
        echo $main_url
        wget -nc $main_url
        mv -f ${url}.zip all_zip/zip
        unzip all_zip/zip/${url}.zip -d all_zip
        mv all_zip/${url}/${url}.tif all_zip
        rm -rf all_zip/${url}
    done < "3_download_TINITALY_list.txt"
else
    echo "File '3_download_TINITALY_list.txt' not found."
fi