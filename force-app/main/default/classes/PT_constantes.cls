/**
 * @description       : CLASE QUE ALMACENA TODAS LAS CONSTANTES PARA EVITAR CÓDIGO HARDCODEADO.
 * @author            : IULIAN PREDA VLASCEANU
 * @group             : 
 * @last modified on  : 26-05-2023
 * @last modified by  : IULIAN PREDA VLASCEANU
 * Modifications Log
 * Ver   Date         Author                   Modification
 * 1.0   26-05-2023   IULIAN PREDA VLASCEANU   Initial Version
**/
public with sharing class PT_constantes{

    //Códigos de error para comprobar si los datos están rellenos.
    public static final String COD_ERR_PRODUCTO                 = '110';
    public static final String DESC_ERR_ARTICULO                = 'El código del articulo no está informado.';
    public static final String COD_ERR_ID_PROD                  = '111';
    public static final String DESC_ERR_ID_PROD                 = 'El identificador del producto no está informado.';
    public static final String COD_ERR_FECHA_ENVIO              = '112';
    public static final String DESC_ERR_FECHA_ENVIO             = 'La fecha de envío no está informada.';
    public static final String COD_ERR_DESCRIPCION_PRODUCTO     = '113';
    public static final String DESC_ERR_DESCRIPCION_PRODUCTO    = 'La descripción del artículo no está informada.';
    public static final String COD_ERR_CANTIDAD                 = '114';
    public static final String DESC_ERR_CANTIDAD                = 'La cantidad del artículo no está informada.';
    public static final String COD_ERR_ALMACEN                  = '115';
    public static final String DESC_ERR_ALMACEN                 = 'No se ha informado del almacén del producto.';
    
    public static final String COD_ERR_OK                       = '200';
    public static final String DESC_ERR_OK                      = '';

    public static final String COD_ERR_KO                       = '300';
    public static final String DESC_ERR_KO                      = 'Uno o varios artículos no cumple con las validaciones necesarias para ser recibidos. Por favor, revisalos y vuelve a procesar el envío.'

    public static final String ARTICULO                         = ' Artículo: ';
    //Constantes para evitar código hardcodeado
    public static final String STATUS_APROBADO                  = 'APR';
    public static final String STATUS_RECHAZADO                 = 'RECH';
    public static final String STATUS_PENDIENTE                 = 'PEND';
    //Constantes proceso aprobacion
    public static final String APROBACION_PRCS                  = 'PT_altaArticulos';
    public static final String RECEPCION_PRODUCTOS              = 'recepcionProductos';
    public static final String ENDPOINT                         = 'funcion';


  

} 