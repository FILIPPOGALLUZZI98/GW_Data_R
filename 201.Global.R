# Il dataset 'gw_data_g' contiene le seguenti variabili: region, geometry, variable, value
#  Quindi per ogni regione (di tutti i paesi) abbiamo l'anno (variable) e il valore
# del raster mediato nelle regioni

###  MANCA DA RINOMINARE VARIABLE --> ANNO (CIOE DA MEAN.X1 A 1901 PER TUTTI I VALORI)  ###


##############################################################################################
##############################################################################################

# Scegliere quale raster usare (rs, rt, rq)
r <- rs
# Selezionare l'anno
y <- 1901


# Unisco direttamente i valori di GW direttamente sulle regioni
gw_data_g <- exactextractr::exact_extract(r, shp, fun="mean")
gw_data_g$region <- shp$ADMIN_NAME
gw_data_g <- reshape2::melt(gw_data_g, id.vars="region")
gw_data_g <- left_join(shp, gw_data_g, by=c("ADMIN_NAME"="region")) 

ggplot(gw_data_g, aes(fill=gw_data_g[[paste0("mean.X", y - 1900)]])) + 
  geom_sf(col="black") +
  theme_bw() +
  labs(fill=paste("groundwstrg", y)) +
  scale_fill_viridis_c(option="viridis", end=0.8)




















