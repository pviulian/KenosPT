/**
 * @description       : TRIGGER QUE LANZA EL PROCESO DE APROBACIÓN PARA SU POSTERIOR APROBACIÓN O RECHAZO
 * @author            : IULIAN PREDA VLASCEANU
 * @group             : 
 * @last modified on  : 26-05-2023
 * @last modified by  : IULIAN PREDA VLASCEANU
 * Modifications Log
 * Ver   Date         Author                   Modification
 * 1.0   26-05-2023   IULIAN PREDA VLASCEANU   Initial Version
**/
trigger PT_lanzarProcesoAprobacion on PT_productoProvisional__c(after insert ){
    // Obtener los registros que han sido insertados
    List<PT_productoProvisional__c> productosAProbar = new List<PT_productoProvisional__c>();
    for (PT_productoProvisional__c producto : Trigger.new ){
        // Verificar si el estado de aprobación es "PEND"
        if (producto.PT_estadoAprobacion__c == PT_constantes.STATUS_PENDIENTE){
            productosAProbar.add(producto);
        }
    }

    if (!productosAProbar.isEmpty()){
        // Obtener el ID del proceso de aprobación utilizando el nombre del proceso
        String procesoAprobacionNombre = PT_constantes.APROBACION_PRCS;
        for (Integer i = 0; i < productosAProbar.size(); i++){
            Approval.ProcessSubmitRequest request = new Approval.ProcessSubmitRequest();
            request.setObjectId(productosAProbar[i].Id);
            request.setProcessDefinitionNameOrId(procesoAprobacionNombre);
            Approval.ProcessResult result = Approval.process(request);


        } 


    }
}