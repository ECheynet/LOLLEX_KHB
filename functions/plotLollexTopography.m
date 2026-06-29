function plotLollexTopography(gebcoFile, databaseFile, bbox)
% plotLollexTopography  Plot topography/bathymetry near Rødsand II.
%
% Inputs
%   gebcoFile    GEBCO NetCDF file with variables lon, lat and elevation
%   databaseFile CSV file with lidar/database positions, including columns
%                latitude and longitude
%   bbox         [lonMin lonMax latMin latMax]

G = readtable(databaseFile);

lat = ncread(gebcoFile,'lat');
lon = ncread(gebcoFile,'lon')';
z = ncread(gebcoFile,'elevation')';

indLat = find(lat > bbox(3) & lat < bbox(4));
indLon = find(lon > bbox(1) & lon < bbox(2));

figure
dem(lon(indLon),lat(indLat),z(indLat,indLon), ...
    'interp','Legend','LatLon','LakeZmin',500, ...
    'LCut',0,'Decim',1,'ZLim',[-80 200]);

title('')
set(gcf,'color','w')
hold on

xlim([bbox(1) bbox(2)])
ylim([bbox(3) bbox(4)])

% City locations
cityNames = {'Copenhagen','Rødbyhavn'};
latCities = [55.6761 54.65072604518744];
lonCities = [12.5683 11.348484765504157];

plot(lonCities,latCities,'ko', ...
    'MarkerFaceColor','y','MarkerSize',6)

% Database positions
ind = G.latitude > bbox(3) & G.latitude < bbox(4) & ...
      G.longitude > bbox(1) & G.longitude < bbox(2);

plot(G.longitude(ind),G.latitude(ind),'r.','MarkerSize',4)

% City labels
text(lonCities(1)-0.1,latCities(1)-0.1,cityNames{1}, ...
    'FontSize',12,'Color','k', ...
    'HorizontalAlignment','left', ...
    'VerticalAlignment','middle', ...
    'FontWeight','bold');

text(lonCities(2)+0.1,latCities(2),cityNames{2}, ...
    'FontSize',12,'Color','k', ...
    'HorizontalAlignment','left', ...
    'VerticalAlignment','middle', ...
    'FontWeight','bold');

axis tight
grid on
set(findall(gcf,'-property','FontSize'), ...
    'FontSize',12,'FontName','Times')
end