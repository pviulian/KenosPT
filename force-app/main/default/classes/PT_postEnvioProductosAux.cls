/**
 * @description       : CLASE AUXILIAR DÓNDE SE ENCUENTRAN LOS MÉTODOS QUE EJECUTAN LA LÓGICA DEL SERVICIO REST.
 * @author            : IULIAN PREDA VLASCEANU
 * @group             :
 * @last modified on  : 26-05-2023
 * @last modified by  : IULIAN PREDA VLASCEANU
 * Modifications Log
 * Ver   Date         Author                   Modification
 * 1.0   26-05-2023   IULIAN PREDA VLASCEANU   Initial Version
 **/
public with sharing class PT_postEnvioProductosAux{
    public Map<String, PT_postEnvioProductos.envios> crearMapaProductosRecibidos(List<PT_postEnvioProductos.envios> lstDetalleArticulos){

        Map<String, PT_postEnvioProductos.envios> mapaArticulosRecibidos = new Map<String, PT_postEnvioProductos.envios>();

        for (PT_postEnvioProductos.envios articulos : lstDetalleArticulos){
            mapaArticulosRecibidos.put(articulos.id_producto, articulos);
        }

        return mapaArticulosRecibidos;
    }

    public List<Product2> comprobarProductos(Map<String, PT_postEnvioProductos.envios> mapCodigosProducto){
        List<Product2> lstAltaNuevoProducto = new List<Product2>();

        Set<String> codigosExistenteSet = new Set<String>(mapCodigosProducto.keySet());

        for (Product2 checkProduct : [SELECT Id, PT_codProducto__c, Description
                                      FROM Product2
                                      WHERE PT_codProducto__c IN:codigosExistenteSet]){
            codigosExistenteSet.remove(checkProduct.PT_codProducto__c);
        }

        if (!codigosExistenteSet.isEmpty()){
            for (String codigoProducto : codigosExistenteSet){
                PT_postEnvioProductos.envios nuevoProducto = mapCodigosProducto.get(codigoProducto);

                Product2 nuevoProduct2 = new Product2();
                nuevoProduct2.Name = nuevoProducto.descripcion_producto;
                nuevoProduct2.PT_codProducto__c = nuevoProducto.id_producto;
                nuevoProduct2.Description = nuevoProducto.descripcion_producto;

                lstAltaNuevoProducto.add(nuevoProduct2);
            }
        }

        if (!lstAltaNuevoProducto.isEmpty()){
            insert lstAltaNuevoProducto;
        }

        return lstAltaNuevoProducto;
    }

    public Map<String, PT_productoProvisional__c> insertProductosProvisionales(Map<String, PT_postEnvioProductos.envios> mapProductosAlmacen){

        Map<String, PT_productoProvisional__c> mapProductosAInsertar = new Map<String, PT_productoProvisional__c>();
        Map<String, Product2> mapProductoParent = new Map<String, Product2>();

        for (Product2 productoParent : [SELECT Id, PT_codProducto__c, Description, Name
                                        FROM Product2
                                        WHERE PT_codProducto__c IN:mapProductosAlmacen.keyset()]){
            mapProductoParent.put(productoParent.PT_codProducto__c, productoParent);
        }

        for (String key : mapProductosAlmacen.keySet()){

            PT_productoProvisional__c nuevoProducto = new PT_productoProvisional__c();
            nuevoProducto.PT_producto__c = mapProductoParent.get(key).Id;
            nuevoProducto.PT_fechaEnvio__c = Date.valueOf(mapProductosAlmacen.get(key).fecha_envio);
            nuevoProducto.PT_codProducto__c = mapProductoParent.get(key).PT_codProducto__c;
            nuevoProducto.PT_descripcion__c = mapProductoParent.get(key).Description;
            nuevoProducto.PT_cantidad__c = Integer.ValueOf(mapProductosAlmacen.get(key).cantidad);
            nuevoProducto.PT_almacenDestino__c = mapProductosAlmacen.get(key).almacen_destino;
            nuevoProducto.Name = mapProductoParent.get(key).Name;
            nuevoProducto.PT_estadoAprobacion__c = PT_constantes.STATUS_PENDIENTE;
            mapProductosAInsertar.put(key, nuevoProducto);

        }
        insert mapProductosAInsertar.values();
        return mapProductosAInsertar;
    }

}