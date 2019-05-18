#!/usr/bin/env bash
# Optionally declare here custom functions/variables to use in commands and hooks
# Prefix them in order to avoid conflicts
# You can also source other external files

matrix_dir="./raspberry-matrix-creator"

json_field_value(){
  # @1: field to get the value
  # @2: json file
  # ==> output filter to 2 decimal
  printf "%.2f\n" `cat "${2}" | awk -F"${1}" '{print $2}' | sed 's/[":}]//g' | awk -F',' '{print $1}'`
}

my_ok(){
  say "c'est fait"
}

# -- Light
my_light_off(){
  say "arrêt en cours"
  ./${matrix_dir}/main.sh black
  my_ok
}
my_light_on(){
  say "allumage en cours"
  ./${matrix_dir}/main.sh everloop #loop
  my_ok
}

# -- Clock
my_clock(){
  say "il est $(date +%H) heures et $(date +%M) minutes"
}
my_clock_off(){
  say "arrêt de l'horloge"
  ./${matrix_dir}/main.sh clock
}
my_clock_on(){
  say "allumage de l'horloge"
  ./${matrix_dir}/main.sh clock #loop
}

# -- Sensors
my_sensor_humidity(){
  ./${matrix_dir}/main.sh humidity
  say "L'humidité est de $(json_field_value 'humidity' '/tmp/matrix_humidity.sig') pour cent"
}
my_sensor_temperature(){
  ./${matrix_dir}/main.sh humidity
  say "La température est de $(json_field_value 'temperature' '/tmp/matrix_humidity.sig') degrée"
}
my_sensor_uv(){
  ./${matrix_dir}/main.sh uv
  say "L'ultra violet est $(json_field_value 'omsRisk' '/tmp/matrix_uv.sig') et l'indice de valeur est de $(json_field_value 'uvIndex' '/tmp/matrix_uv.sig')"
}
my_sensor_pressure(){
  ./${matrix_dir}/main.sh pressure
  say "La pression athmosphérique est de $(json_field_value 'pressure' '/tmp/matrix_pressure.sig')"
}
my_sensor_altitude(){
  ./${matrix_dir}/main.sh pressure
  say "Nous somme à une altitude de $(json_field_value 'altitude' '/tmp/matrix_pressure.sig') mètres"
}
my_sensor_accelerometer(){
  ./${matrix_dir}/main.sh imu
  say "Accélération en X de $(json_field_value 'accelX' '/tmp/matrix_imu.sig')"
  say "Accélération en Y de $(json_field_value 'accelY' '/tmp/matrix_imu.sig')"
  say "Accélération en Z de $(json_field_value 'accelZ' '/tmp/matrix_imu.sig')"
}
my_sensor_gyroscope(){
  ./${matrix_dir}/main.sh imu
  say "Rotation en X de $(json_field_value 'gyroX' '/tmp/matrix_imu.sig')"
  say "Rotation en Y de $(json_field_value 'gyroY' '/tmp/matrix_imu.sig')"
  say "Rotation en Z de $(json_field_value 'gyroZ' '/tmp/matrix_imu.sig')"
}
my_sensor_magnetometer(){
  ./${matrix_dir}/main.sh imu
  say "Magnitude en X de $(json_field_value 'magX' '/tmp/matrix_imu.sig')"
  say "Magnitude en Y de $(json_field_value 'magY' '/tmp/matrix_imu.sig')"
  say "Magnitude en Z de $(json_field_value 'magZ' '/tmp/matrix_imu.sig')"
}
my_sensor_yaw(){
  ./${matrix_dir}/main.sh imu
  say "Embardée de $(json_field_value 'yaw' '/tmp/matrix_imu.sig') de degré"
}
my_sensor_pitch(){
  ./${matrix_dir}/main.sh imu
  say "Pas de $(json_field_value 'pitch' '/tmp/matrix_imu.sig')"
}
my_sensor_roll(){
  ./${matrix_dir}/main.sh imu
  say "Rouleau de $(json_field_value 'roll' '/tmp/matrix_imu.sig') degré"
}

