/**
 * @description       : CLASE QUE INSERTA LOS PRODUCTOS EN EL ALMACÉN UNA VEZ APROBADOS.
 * @author            : IULIAN PREDA VLASCEANU
 * @group             : 
 * @last modified on  : 26-05-2023
 * @last modified by  : IULIAN PREDA VLASCEANU
 * Modifications Log
 * Ver   Date         Author                   Modification
 * 1.0   26-05-2023   IULIAN PREDA VLASCEANU   Initial Version
**/
public with sharing class PT_insertarProductoAlmacen{
    public void insertProductosAlmacen(Map<String, PT_productoProvisional__c> mapProductosAlmacen){

        Map<String, PT_almacenes__c> mapProductosAInsertar = new Map<String, PT_almacenes__c>();
        Map<String, Product2> mapProductoParent = new Map<String, Product2>();

        for (Product2 productoParent : [SELECT Id, PT_codProducto__c, Description, Name
                                        FROM Product2
                                        WHERE PT_codProducto__c IN:mapProductosAlmacen.keyset()]){
            mapProductoParent.put(productoParent.PT_codProducto__c, productoParent);
        }

        for (String key : mapProductosAlmacen.keySet()){

            PT_almacenes__c altaProductoAlmacen = new PT_almacenes__c();
            altaProductoAlmacen.PT_producto__c = mapProductoParent.get(key).Id;
            altaProductoAlmacen.PT_fechaEnvio__c = Date.valueOf(mapProductosAlmacen.get(key).PT_fechaEnvio__c);
            altaProductoAlmacen.PT_codProducto__c = mapProductoParent.get(key).PT_codProducto__c;
            altaProductoAlmacen.PT_descripcion__c = mapProductoParent.get(key).Description;
            altaProductoAlmacen.PT_cantidad__c = Integer.ValueOf(mapProductosAlmacen.get(key).PT_cantidad__c);
            altaProductoAlmacen.PT_almacenDestino__c = mapProductosAlmacen.get(key).PT_almacenDestino__c;
            altaProductoAlmacen.Name = mapProductoParent.get(key).Name;
            mapProductosAInsertar.put(key, altaProductoAlmacen);

        }
        insert mapProductosAInsertar.values();
    } 

}