from grass.script import run_command, read_command, parse_command
import datetime
import pandas as pd

# Set the start and end dates
start_date = datetime.datetime(2022, 1, 1, 12, 00, 00)
end_date = datetime.datetime(2022, 1, 1, 12, 59, 59)

path = "C:\\Users\\stucchi\\Calcolo\\CuneoDTM\\"
layer = path +"Cuneo_Int.tif"

run_command("r.in.gdal", input=layer, output="dem", overwrite=True)
run_command('g.region', raster="dem")
xy = read_command('g.region', raster="dem", flags="cp")
xy = xy.replace("\n",":").replace("\r","").replace(" ","")[:-1].split(":")
xy_dict = {xy[i]: xy[i + 1] for i in range(0, len(xy), 2)} 
x_ref = xy_dict["centereasting"] # west, east, centereasting
y_ref = xy_dict["centernorthing"] # north, south, centernorthing

# Loop through each hour using the date command
current_date = start_date
while current_date < end_date:
    y = current_date.strftime("%Y")
    m = current_date.strftime("%m")
    d = current_date.strftime("%d")
    h = current_date.strftime("%H")

    print("\tProcessing hour: " + y + "-" + m + "-" + d + " " + h + ":00:00")

    time_zone = 2 if datetime.datetime(2022, 3, 27) <= current_date <= datetime.datetime(2022, 10, 30) else 1

    sun_pos = parse_command("r.sunmask", flags="gs", elevation="dem", year=y, month=m, day=d, hour=h, minute=0, second=0, timezone=time_zone, east=x_ref, north=y_ref, output="temp_shadow", overwrite=True, verbose=True)

    if float(sun_pos.sunangleabovehorizon) > 0:
        run_command("r.sunmask", flags="g", elevation="dem", year=y, month=m, day=d, hour=h, minute=0, second=0, timezone=0, east=x_ref, north=y_ref, output="temp_shadow", overwrite=True, verbose=True)
        run_command("r.out.gdal", input="temp_shadow", output= path + "Ombre\\Shadow_" + y + "_" + m + "_" + d + "_" + h + "_km6.tif", overwrite=True)
        run_command("g.remove", type="raster", name="temp_shadow", flags="f")
    else:
        print("Night time")

    current_date += datetime.timedelta(hours=1)

run_command("g.remove", type="raster", name="dem", flags="f")