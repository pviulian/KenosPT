/**
 * @description       : TRIGGER QUE LANZA LA CLASE "PT_insertarProductoAlmacen" UNA VEZ QUE EL PRODUCTO PASA A APROBADO.
 * @author            : IULIAN PREDA VLASCEANU
 * @group             : 
 * @last modified on  : 26-05-2023
 * @last modified by  : IULIAN PREDA VLASCEANU
 * Modifications Log
 * Ver   Date         Author                   Modification
 * 1.0   26-05-2023   IULIAN PREDA VLASCEANU   Initial Version
**/
trigger PT_insertarProductosAlmacen on PT_productoProvisional__c(after update){

    Set<Id> productoIds = new Set<Id>();
    for (PT_productoProvisional__c producto : Trigger.new ){
        productoIds.add(producto.Id);
    }

    Map<String, PT_productoProvisional__c> productoAprobadoAnteriormenteMap = new Map<String, PT_productoProvisional__c>();

    for (PT_productoProvisional__c producto : [SELECT PT_cantidad__c, PT_almacenDestino__c, PT_codProducto__c, PT_descripcion__c, PT_fechaEnvio__c, PT_producto__c, PT_estadoAprobacion__c
                                               FROM PT_productoProvisional__c
                                               WHERE PT_estadoAprobacion__c = :PT_constantes.STATUS_APROBADO AND Id IN:productoIds]){
        productoAprobadoAnteriormenteMap.put(producto.PT_codProducto__c, producto);
    }

    PT_insertarProductoAlmacen instanciaInsert = new PT_insertarProductoAlmacen();

    instanciaInsert.insertProductosAlmacen(productoAprobadoAnteriormenteMap);
} 