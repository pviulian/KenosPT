/**
 * @description       : CLASE REST QUE EJECUTA LA LÓGICA DEL DESARROLLO.
 * @author            : IULIAN PREDA VLASCEANU
 * @group             :
 * @last modified on  : 26-05-2023
 * @last modified by  : IULIAN PREDA VLASCEANU
 * Modifications Log
 * Ver   Date         Author                   Modification
 * 1.0   26-05-2023   IULIAN PREDA VLASCEANU   Initial Version
 **/
@RestResource(urlMapping = '/envioProductos/*')
global with sharing class PT_postEnvioProductos{
    public with sharing class recepcionProductos{
        public List<envios> envios;
    }

    public with sharing class envios{
        public Date fecha_envio;
        public String id_producto;
        public String descripcion_producto;
        public Integer cantidad;
        public String almacen_destino;
    }

    @HttpPost
    global static void recepcionProductos(){
        try{
            PT_postEnvioProductosAux recepcionProdAux = new PT_postEnvioProductosAux();
            List<recepcionProductos> lstArticulosRecibidos = (List<recepcionProductos>)JSON.deserialize(RestContext.request.requestBody.tostring(), List<recepcionProductos>.class);
            System.debug(JSON.serializePretty(lstArticulosRecibidos));
            List<envios> lstDetalleProductos = new List<envios>();

            for (recepcionProductos arts : lstArticulosRecibidos){
                lstDetalleProductos.addAll(arts.envios);
            }

            System.debug(JSON.serializePretty(lstDetalleProductos));

            Map<String, envios> mapProductosRecibidos = recepcionProdAux.crearMapaProductosRecibidos(lstDetalleProductos);
            System.debug(JSON.serializePretty(mapProductosRecibidos));

            List<Product2> lstComprobarProductos = recepcionProdAux.comprobarProductos(mapProductosRecibidos);
            System.debug(JSON.serializePretty(lstComprobarProductos));

            Map<String, PT_productoProvisional__c> mapInsertProductosAlmacen = recepcionProdAux.insertProductosProvisionales(mapProductosRecibidos);
            System.debug(JSON.serializePretty(mapInsertProductosAlmacen));


        } catch (Exception ex){
            System.debug(ex);
        }
    }

}