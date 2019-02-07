workspace = pwd()
f = openxl(string(workspace,"/tsp/roadtrip_quebec.xls"))

data_cities = readxl(f, "Donnees!A9:A17")

cities = map(strip, data_cities)

data_distances = readxl(f, "Donnees!C9:K17")

nb_row, nb_col = size(data_distances)
distances = zeros(Int, nb_row, nb_col)
for i = 1:nb_row
    for j = 1:nb_col
        distances[i,j] = Int(data_distances[i,j])
    end
end

save(string(workspace,"/tsp/distances_quebec.jld"),"distances",distances)
save(string(workspace,"/tsp/cities_quebec.jld"),"cities",cities)

f2 = openxl(string(workspace,"/tsp/roadtrip_usa.xls"))

data_cities2 = readxl(f2, "Feuille1!A4:A53")

cities2 = map(strip, data_cities2)

data_distances2 = readxl(f2, "Feuille1!B4:B53")
string_distances2 = map(strip, data_distances2)
n = length(string_distances2)
latitude = zeros(n)
longitude = zeros(n)
for i = 1:n
	string_distances2[i] = string_distances2[i][2:end-1]
	latlon = split(string_distances2[i], ",")
	latitude[i] = parse(Float64, latlon[1])
	longitude[i] = parse(Float64, latlon[2])
end

function distance_earth(lat1, lon1, lat2, lon2)
    # approximate radius of earth in km
    R = 6371.0

    rlat1 = 2 * pi * lat1 / 360
    rlon1 = 2 * pi * lon1 / 360
    rlat2 = 2 * pi * lat2 / 360
    rlon2 = 2 * pi * lon2 / 360

    dlon = (lon2 - lon1) * 2 * pi / 360
    dlat = (lat2 - lat1) * 2 * pi / 360

    a = sin(dlat/2)^2 + cos(rlat1)*cos(rlat2)*sin(dlon/2)^2
    c = 2 * atan(sqrt(a), sqrt(1 - a))

    return R * c
end

distances2 = zeros(n,n)
for i = 1:n
	for j = 1:n
		distances2[i,j] = distance_earth(latitude[i], longitude[i], latitude[j], longitude[j])
	end
end

save(string(workspace,"/tsp/cities_usa.jld"),"cities2",cities2)
save(string(workspace,"/tsp/distances_usa.jld"),"distances2",distances2)