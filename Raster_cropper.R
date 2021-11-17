#library(rstudioapi)
#rstudioapi::restartSession()
library(raster)
library(startup)

################# Variable Part ##########################
start_time<-Sys.time()
year='2040'    # change the input year
input_folder='D:/Thakur/Arcmap_data/IC400_RCP45_skorea_HadGEM3RA_tavg_daily_2031_2040_sub_esr/'       # input layer folder

output_dir=dir.create(paste('D:/Thakur/Cropped_files/',year))
output_folder=paste('D:/Thakur/Cropped_files/',year,collapse = NULL)    # output save folder

############# Fixed part #################################
filenames <- list.files(path = file.path(input_folder,year), pattern="*.esr")
length(filenames)   # check no of files in folder
for (lr in filenames)
  {print(lr)

ne=raster(file.path(input_folder,year,lr))
#plot(ne)
# create a random raster over the space:        
r= raster(xmn=126.314262126,xmx=127.264411495,ymn=37.147152703,ymx=37.624311237,nrow=294,ncol=469)
r[]=1:ncell(r)

rr <- crop(ne, r)
save_raster<-resample(rr, r)
writeRaster(save_raster,filename = file.path(output_folder,lr),format="GTiff",overwrite=TRUE)
# plot, and overlay:
#plot(rr);
#plot(ne,add=TRUE)
plot(save_raster)
}
end_time<-Sys.time()
end_time-start_time
# about 4 min per year

