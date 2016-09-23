#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://localhost:8090/UBTDNTVIEW.apw?WSDL
Gerado em        09/20/16 16:23:27
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _KROPAEG ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSUBTDNTVIEW
------------------------------------------------------------------------------- */

WSCLIENT WSUBTDNTVIEW

    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD RESET
    WSMETHOD CLONE
    WSMETHOD GETTABLE
    WSMETHOD GETTABLEBYFIELDSNAME
    WSMETHOD GETTALIAS
    WSMETHOD GETTBYWHERE
    WSMETHOD GETTBYWHEREANDFIELDSNAME
    WSMETHOD GETTDATA
    WSMETHOD GETTDATABYFIELDSNAME
    WSMETHOD GETTDATABYRECNOS
    WSMETHOD GETTDATABYRECNOSANDFIELDSNAME
    WSMETHOD GETTFIELDSNAME
    WSMETHOD GETTRECNOS
    WSMETHOD GETTRECNOSBYWHERE
    WSMETHOD GETTRMAX
    WSMETHOD GETTSTRUCT
    WSMETHOD GETTSTRUCTBYFIELDSNAME

    WSDATA   _URL                      AS String
    WSDATA   _HEADOUT                  AS Array of String
    WSDATA   _COOKIES                  AS Array of String
    WSDATA   cALIAS                    AS string
    WSDATA   nRINIT                    AS integer
    WSDATA   nREND                     AS integer
    WSDATA   lRDELETED                 AS boolean
    WSDATA   lRRECNO                   AS boolean
    WSDATA   oWSGETTABLERESULT         AS UBTDNTVIEW_UTABLEVIEW
    WSDATA   oWSFIELDSNAME             AS UBTDNTVIEW_UFIELDSNAME
    WSDATA   oWSGETTABLEBYFIELDSNAMERESULT AS UBTDNTVIEW_UTABLEVIEW
    WSDATA   oWSGETTALIASRESULT        AS UBTDNTVIEW_UTALIASES
    WSDATA   cWHERE                    AS string
    WSDATA   oWSGETTBYWHERERESULT      AS UBTDNTVIEW_UTABLEVIEW
    WSDATA   oWSGETTBYWHEREANDFIELDSNAMERESULT AS UBTDNTVIEW_UTABLEVIEW
    WSDATA   oWSGETTDATARESULT         AS UBTDNTVIEW_ARRAYOFFIELDVIEW
    WSDATA   oWSGETTDATABYFIELDSNAMERESULT AS UBTDNTVIEW_ARRAYOFFIELDVIEW
    WSDATA   oWSTABLERECNOS            AS UBTDNTVIEW_UTABLERECNOS
    WSDATA   oWSGETTDATABYRECNOSRESULT AS UBTDNTVIEW_ARRAYOFFIELDVIEW
    WSDATA   oWSGETTDATABYRECNOSANDFIELDSNAMERESULT AS UBTDNTVIEW_ARRAYOFFIELDVIEW
    WSDATA   oWSGETTFIELDSNAMERESULT   AS UBTDNTVIEW_UFIELDSNAME
    WSDATA   oWSGETTRECNOSRESULT       AS UBTDNTVIEW_UTABLERECNOS
    WSDATA   oWSGETTRECNOSBYWHERERESULT AS UBTDNTVIEW_UTABLERECNOS
    WSDATA   nGETTRMAXRESULT           AS integer
    WSDATA   oWSGETTSTRUCTRESULT       AS UBTDNTVIEW_ARRAYOFUFIELDSTRUCT
    WSDATA   oWSGETTSTRUCTBYFIELDSNAMERESULT AS UBTDNTVIEW_ARRAYOFUFIELDSTRUCT

    // Estruturas mantidas por compatibilidade - NÃO USAR
    WSDATA   oWSUFIELDSNAME            AS UBTDNTVIEW_UFIELDSNAME
    WSDATA   oWSUTABLERECNOS           AS UBTDNTVIEW_UTABLERECNOS

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSUBTDNTVIEW
::Init()
If !FindFunction("XMLCHILDEX")
    UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20160707 NG] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSUBTDNTVIEW
    ::oWSGETTABLERESULT  := UBTDNTVIEW_UTABLEVIEW():New()
    ::oWSFIELDSNAME      := UBTDNTVIEW_UFIELDSNAME():New()
    ::oWSGETTABLEBYFIELDSNAMERESULT := UBTDNTVIEW_UTABLEVIEW():New()
    ::oWSGETTALIASRESULT := UBTDNTVIEW_UTALIASES():New()
    ::oWSGETTBYWHERERESULT := UBTDNTVIEW_UTABLEVIEW():New()
    ::oWSGETTBYWHEREANDFIELDSNAMERESULT := UBTDNTVIEW_UTABLEVIEW():New()
    ::oWSGETTDATARESULT  := UBTDNTVIEW_ARRAYOFFIELDVIEW():New()
    ::oWSGETTDATABYFIELDSNAMERESULT := UBTDNTVIEW_ARRAYOFFIELDVIEW():New()
    ::oWSTABLERECNOS     := UBTDNTVIEW_UTABLERECNOS():New()
    ::oWSGETTDATABYRECNOSRESULT := UBTDNTVIEW_ARRAYOFFIELDVIEW():New()
    ::oWSGETTDATABYRECNOSANDFIELDSNAMERESULT := UBTDNTVIEW_ARRAYOFFIELDVIEW():New()
    ::oWSGETTFIELDSNAMERESULT := UBTDNTVIEW_UFIELDSNAME():New()
    ::oWSGETTRECNOSRESULT := UBTDNTVIEW_UTABLERECNOS():New()
    ::oWSGETTRECNOSBYWHERERESULT := UBTDNTVIEW_UTABLERECNOS():New()
    ::oWSGETTSTRUCTRESULT := UBTDNTVIEW_ARRAYOFUFIELDSTRUCT():New()
    ::oWSGETTSTRUCTBYFIELDSNAMERESULT := UBTDNTVIEW_ARRAYOFUFIELDSTRUCT():New()

    // Estruturas mantidas por compatibilidade - NÃO USAR
    ::oWSUFIELDSNAME     := ::oWSFIELDSNAME
    ::oWSUTABLERECNOS    := ::oWSTABLERECNOS
Return

WSMETHOD RESET WSCLIENT WSUBTDNTVIEW
    ::cALIAS             := NIL 
    ::nRINIT             := NIL 
    ::nREND              := NIL 
    ::lRDELETED          := NIL 
    ::lRRECNO            := NIL 
    ::oWSGETTABLERESULT  := NIL 
    ::oWSFIELDSNAME      := NIL 
    ::oWSGETTABLEBYFIELDSNAMERESULT := NIL 
    ::oWSGETTALIASRESULT := NIL 
    ::cWHERE             := NIL 
    ::oWSGETTBYWHERERESULT := NIL 
    ::oWSGETTBYWHEREANDFIELDSNAMERESULT := NIL 
    ::oWSGETTDATARESULT  := NIL 
    ::oWSGETTDATABYFIELDSNAMERESULT := NIL 
    ::oWSTABLERECNOS     := NIL 
    ::oWSGETTDATABYRECNOSRESULT := NIL 
    ::oWSGETTDATABYRECNOSANDFIELDSNAMERESULT := NIL 
    ::oWSGETTFIELDSNAMERESULT := NIL 
    ::oWSGETTRECNOSRESULT := NIL 
    ::oWSGETTRECNOSBYWHERERESULT := NIL 
    ::nGETTRMAXRESULT    := NIL 
    ::oWSGETTSTRUCTRESULT := NIL 
    ::oWSGETTSTRUCTBYFIELDSNAMERESULT := NIL 

    // Estruturas mantidas por compatibilidade - NÃO USAR
    ::oWSUFIELDSNAME     := NIL
    ::oWSUTABLERECNOS    := NIL
    ::Init()
Return

WSMETHOD CLONE WSCLIENT WSUBTDNTVIEW
Local oClone := WSUBTDNTVIEW():New()
    oClone:_URL          := ::_URL 
    oClone:cALIAS        := ::cALIAS
    oClone:nRINIT        := ::nRINIT
    oClone:nREND         := ::nREND
    oClone:lRDELETED     := ::lRDELETED
    oClone:lRRECNO       := ::lRRECNO
    oClone:oWSGETTABLERESULT :=  IIF(::oWSGETTABLERESULT = NIL , NIL ,::oWSGETTABLERESULT:Clone() )
    oClone:oWSFIELDSNAME :=  IIF(::oWSFIELDSNAME = NIL , NIL ,::oWSFIELDSNAME:Clone() )
    oClone:oWSGETTABLEBYFIELDSNAMERESULT :=  IIF(::oWSGETTABLEBYFIELDSNAMERESULT = NIL , NIL ,::oWSGETTABLEBYFIELDSNAMERESULT:Clone() )
    oClone:oWSGETTALIASRESULT :=  IIF(::oWSGETTALIASRESULT = NIL , NIL ,::oWSGETTALIASRESULT:Clone() )
    oClone:cWHERE        := ::cWHERE
    oClone:oWSGETTBYWHERERESULT :=  IIF(::oWSGETTBYWHERERESULT = NIL , NIL ,::oWSGETTBYWHERERESULT:Clone() )
    oClone:oWSGETTBYWHEREANDFIELDSNAMERESULT :=  IIF(::oWSGETTBYWHEREANDFIELDSNAMERESULT = NIL , NIL ,::oWSGETTBYWHEREANDFIELDSNAMERESULT:Clone() )
    oClone:oWSGETTDATARESULT :=  IIF(::oWSGETTDATARESULT = NIL , NIL ,::oWSGETTDATARESULT:Clone() )
    oClone:oWSGETTDATABYFIELDSNAMERESULT :=  IIF(::oWSGETTDATABYFIELDSNAMERESULT = NIL , NIL ,::oWSGETTDATABYFIELDSNAMERESULT:Clone() )
    oClone:oWSTABLERECNOS :=  IIF(::oWSTABLERECNOS = NIL , NIL ,::oWSTABLERECNOS:Clone() )
    oClone:oWSGETTDATABYRECNOSRESULT :=  IIF(::oWSGETTDATABYRECNOSRESULT = NIL , NIL ,::oWSGETTDATABYRECNOSRESULT:Clone() )
    oClone:oWSGETTDATABYRECNOSANDFIELDSNAMERESULT :=  IIF(::oWSGETTDATABYRECNOSANDFIELDSNAMERESULT = NIL , NIL ,::oWSGETTDATABYRECNOSANDFIELDSNAMERESULT:Clone() )
    oClone:oWSGETTFIELDSNAMERESULT :=  IIF(::oWSGETTFIELDSNAMERESULT = NIL , NIL ,::oWSGETTFIELDSNAMERESULT:Clone() )
    oClone:oWSGETTRECNOSRESULT :=  IIF(::oWSGETTRECNOSRESULT = NIL , NIL ,::oWSGETTRECNOSRESULT:Clone() )
    oClone:oWSGETTRECNOSBYWHERERESULT :=  IIF(::oWSGETTRECNOSBYWHERERESULT = NIL , NIL ,::oWSGETTRECNOSBYWHERERESULT:Clone() )
    oClone:nGETTRMAXRESULT := ::nGETTRMAXRESULT
    oClone:oWSGETTSTRUCTRESULT :=  IIF(::oWSGETTSTRUCTRESULT = NIL , NIL ,::oWSGETTSTRUCTRESULT:Clone() )
    oClone:oWSGETTSTRUCTBYFIELDSNAMERESULT :=  IIF(::oWSGETTSTRUCTBYFIELDSNAMERESULT = NIL , NIL ,::oWSGETTSTRUCTBYFIELDSNAMERESULT:Clone() )

    // Estruturas mantidas por compatibilidade - NÃO USAR
    oClone:oWSUFIELDSNAME := oClone:oWSFIELDSNAME
    oClone:oWSUTABLERECNOS := oClone:oWSTABLERECNOS
Return oClone

// WSDL Method GETTABLE of Service WSUBTDNTVIEW

WSMETHOD GETTABLE WSSEND cALIAS,nRINIT,nREND,lRDELETED,lRRECNO WSRECEIVE oWSGETTABLERESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTABLE xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RINIT", ::nRINIT, nRINIT , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("REND", ::nREND, nREND , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RDELETED", ::lRDELETED, lRDELETED , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RRECNO", ::lRRECNO, lRRECNO , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTABLE>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTABLE",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTABLERESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTABLERESPONSE:_GETTABLERESULT","UTABLEVIEW",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTABLEBYFIELDSNAME of Service WSUBTDNTVIEW

WSMETHOD GETTABLEBYFIELDSNAME WSSEND cALIAS,nRINIT,nREND,oWSFIELDSNAME,lRDELETED,lRRECNO WSRECEIVE oWSGETTABLEBYFIELDSNAMERESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTABLEBYFIELDSNAME xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RINIT", ::nRINIT, nRINIT , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("REND", ::nREND, nREND , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("FIELDSNAME", ::oWSFIELDSNAME, oWSFIELDSNAME , "UFIELDSNAME", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RDELETED", ::lRDELETED, lRDELETED , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RRECNO", ::lRRECNO, lRRECNO , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTABLEBYFIELDSNAME>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTABLEBYFIELDSNAME",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTABLEBYFIELDSNAMERESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTABLEBYFIELDSNAMERESPONSE:_GETTABLEBYFIELDSNAMERESULT","UTABLEVIEW",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTALIAS of Service WSUBTDNTVIEW

WSMETHOD GETTALIAS WSSEND nRINIT,nREND WSRECEIVE oWSGETTALIASRESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTALIAS xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("RINIT", ::nRINIT, nRINIT , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("REND", ::nREND, nREND , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTALIAS>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTALIAS",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTALIASRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTALIASRESPONSE:_GETTALIASRESULT","UTALIASES",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTBYWHERE of Service WSUBTDNTVIEW

WSMETHOD GETTBYWHERE WSSEND cALIAS,cWHERE,nRINIT,nREND,lRDELETED,lRRECNO WSRECEIVE oWSGETTBYWHERERESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTBYWHERE xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("WHERE", ::cWHERE, cWHERE , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RINIT", ::nRINIT, nRINIT , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("REND", ::nREND, nREND , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RDELETED", ::lRDELETED, lRDELETED , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RRECNO", ::lRRECNO, lRRECNO , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTBYWHERE>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTBYWHERE",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTBYWHERERESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTBYWHERERESPONSE:_GETTBYWHERERESULT","UTABLEVIEW",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTBYWHEREANDFIELDSNAME of Service WSUBTDNTVIEW

WSMETHOD GETTBYWHEREANDFIELDSNAME WSSEND cALIAS,cWHERE,nRINIT,nREND,oWSFIELDSNAME,lRDELETED,lRRECNO WSRECEIVE oWSGETTBYWHEREANDFIELDSNAMERESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTBYWHEREANDFIELDSNAME xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("WHERE", ::cWHERE, cWHERE , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RINIT", ::nRINIT, nRINIT , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("REND", ::nREND, nREND , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("FIELDSNAME", ::oWSFIELDSNAME, oWSFIELDSNAME , "UFIELDSNAME", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RDELETED", ::lRDELETED, lRDELETED , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RRECNO", ::lRRECNO, lRRECNO , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTBYWHEREANDFIELDSNAME>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTBYWHEREANDFIELDSNAME",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTBYWHEREANDFIELDSNAMERESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTBYWHEREANDFIELDSNAMERESPONSE:_GETTBYWHEREANDFIELDSNAMERESULT","UTABLEVIEW",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTDATA of Service WSUBTDNTVIEW

WSMETHOD GETTDATA WSSEND cALIAS,nRINIT,nREND,lRDELETED,lRRECNO WSRECEIVE oWSGETTDATARESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTDATA xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RINIT", ::nRINIT, nRINIT , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("REND", ::nREND, nREND , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RDELETED", ::lRDELETED, lRDELETED , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RRECNO", ::lRRECNO, lRRECNO , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTDATA>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTDATA",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTDATARESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTDATARESPONSE:_GETTDATARESULT","ARRAYOFFIELDVIEW",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTDATABYFIELDSNAME of Service WSUBTDNTVIEW

WSMETHOD GETTDATABYFIELDSNAME WSSEND cALIAS,nRINIT,nREND,oWSFIELDSNAME,lRDELETED,lRRECNO WSRECEIVE oWSGETTDATABYFIELDSNAMERESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTDATABYFIELDSNAME xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RINIT", ::nRINIT, nRINIT , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("REND", ::nREND, nREND , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("FIELDSNAME", ::oWSFIELDSNAME, oWSFIELDSNAME , "UFIELDSNAME", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RDELETED", ::lRDELETED, lRDELETED , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RRECNO", ::lRRECNO, lRRECNO , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTDATABYFIELDSNAME>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTDATABYFIELDSNAME",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTDATABYFIELDSNAMERESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTDATABYFIELDSNAMERESPONSE:_GETTDATABYFIELDSNAMERESULT","ARRAYOFFIELDVIEW",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTDATABYRECNOS of Service WSUBTDNTVIEW

WSMETHOD GETTDATABYRECNOS WSSEND cALIAS,oWSTABLERECNOS,lRDELETED,lRRECNO WSRECEIVE oWSGETTDATABYRECNOSRESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTDATABYRECNOS xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("TABLERECNOS", ::oWSTABLERECNOS, oWSTABLERECNOS , "UTABLERECNOS", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RDELETED", ::lRDELETED, lRDELETED , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RRECNO", ::lRRECNO, lRRECNO , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTDATABYRECNOS>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTDATABYRECNOS",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTDATABYRECNOSRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTDATABYRECNOSRESPONSE:_GETTDATABYRECNOSRESULT","ARRAYOFFIELDVIEW",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTDATABYRECNOSANDFIELDSNAME of Service WSUBTDNTVIEW

WSMETHOD GETTDATABYRECNOSANDFIELDSNAME WSSEND cALIAS,oWSTABLERECNOS,oWSFIELDSNAME,lRDELETED,lRRECNO WSRECEIVE oWSGETTDATABYRECNOSANDFIELDSNAMERESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTDATABYRECNOSANDFIELDSNAME xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("TABLERECNOS", ::oWSTABLERECNOS, oWSTABLERECNOS , "UTABLERECNOS", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("FIELDSNAME", ::oWSFIELDSNAME, oWSFIELDSNAME , "UFIELDSNAME", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RDELETED", ::lRDELETED, lRDELETED , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RRECNO", ::lRRECNO, lRRECNO , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTDATABYRECNOSANDFIELDSNAME>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTDATABYRECNOSANDFIELDSNAME",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTDATABYRECNOSANDFIELDSNAMERESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTDATABYRECNOSANDFIELDSNAMERESPONSE:_GETTDATABYRECNOSANDFIELDSNAMERESULT","ARRAYOFFIELDVIEW",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTFIELDSNAME of Service WSUBTDNTVIEW

WSMETHOD GETTFIELDSNAME WSSEND cALIAS WSRECEIVE oWSGETTFIELDSNAMERESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTFIELDSNAME xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTFIELDSNAME>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTFIELDSNAME",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTFIELDSNAMERESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTFIELDSNAMERESPONSE:_GETTFIELDSNAMERESULT","UFIELDSNAME",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTRECNOS of Service WSUBTDNTVIEW

WSMETHOD GETTRECNOS WSSEND cALIAS,nRINIT,nREND,lRDELETED WSRECEIVE oWSGETTRECNOSRESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTRECNOS xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RINIT", ::nRINIT, nRINIT , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("REND", ::nREND, nREND , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RDELETED", ::lRDELETED, lRDELETED , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTRECNOS>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTRECNOS",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTRECNOSRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTRECNOSRESPONSE:_GETTRECNOSRESULT","UTABLERECNOS",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTRECNOSBYWHERE of Service WSUBTDNTVIEW

WSMETHOD GETTRECNOSBYWHERE WSSEND cALIAS,cWHERE,nRINIT,nREND,lRDELETED WSRECEIVE oWSGETTRECNOSBYWHERERESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTRECNOSBYWHERE xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("WHERE", ::cWHERE, cWHERE , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RINIT", ::nRINIT, nRINIT , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("REND", ::nREND, nREND , "integer", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RDELETED", ::lRDELETED, lRDELETED , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTRECNOSBYWHERE>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTRECNOSBYWHERE",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTRECNOSBYWHERERESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTRECNOSBYWHERERESPONSE:_GETTRECNOSBYWHERERESULT","UTABLERECNOS",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTRMAX of Service WSUBTDNTVIEW

WSMETHOD GETTRMAX WSSEND cALIAS,lRDELETED WSRECEIVE nGETTRMAXRESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTRMAX xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RDELETED", ::lRDELETED, lRDELETED , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTRMAX>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTRMAX",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::nGETTRMAXRESULT    :=  WSAdvValue( oXmlRet,"_GETTRMAXRESPONSE:_GETTRMAXRESULT:TEXT","integer",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTSTRUCT of Service WSUBTDNTVIEW

WSMETHOD GETTSTRUCT WSSEND cALIAS,lRDELETED,lRRECNO WSRECEIVE oWSGETTSTRUCTRESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTSTRUCT xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RDELETED", ::lRDELETED, lRDELETED , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RRECNO", ::lRRECNO, lRRECNO , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTSTRUCT>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTSTRUCT",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTSTRUCTRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTSTRUCTRESPONSE:_GETTSTRUCTRESULT","ARRAYOFUFIELDSTRUCT",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETTSTRUCTBYFIELDSNAME of Service WSUBTDNTVIEW

WSMETHOD GETTSTRUCTBYFIELDSNAME WSSEND cALIAS,oWSFIELDSNAME,lRDELETED,lRRECNO WSRECEIVE oWSGETTSTRUCTBYFIELDSNAMERESULT WSCLIENT WSUBTDNTVIEW
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTSTRUCTBYFIELDSNAME xmlns="http://www.blacktdn.com.br">'
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("FIELDSNAME", ::oWSFIELDSNAME, oWSFIELDSNAME , "UFIELDSNAME", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RDELETED", ::lRDELETED, lRDELETED , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("RRECNO", ::lRRECNO, lRRECNO , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GETTSTRUCTBYFIELDSNAME>"

oXmlRet := SvcSoapCall(    Self,cSoap,; 
    "http://www.blacktdn.com.br/GETTSTRUCTBYFIELDSNAME",; 
    "DOCUMENT","http://www.blacktdn.com.br",,"1.031217",; 
    "http://localhost:8090/UBTDNTVIEW.apw")

::Init()
::oWSGETTSTRUCTBYFIELDSNAMERESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTSTRUCTBYFIELDSNAMERESPONSE:_GETTSTRUCTBYFIELDSNAMERESULT","ARRAYOFUFIELDSTRUCT",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure UTABLEVIEW

WSSTRUCT UBTDNTVIEW_UTABLEVIEW
    WSDATA   oWSTABLEDATA              AS UBTDNTVIEW_ARRAYOFFIELDVIEW
    WSDATA   oWSTABLESTRUCT            AS UBTDNTVIEW_ARRAYOFUFIELDSTRUCT
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UBTDNTVIEW_UTABLEVIEW
    ::Init()
Return Self

WSMETHOD INIT WSCLIENT UBTDNTVIEW_UTABLEVIEW
Return

WSMETHOD CLONE WSCLIENT UBTDNTVIEW_UTABLEVIEW
    Local oClone := UBTDNTVIEW_UTABLEVIEW():NEW()
    oClone:oWSTABLEDATA         := IIF(::oWSTABLEDATA = NIL , NIL , ::oWSTABLEDATA:Clone() )
    oClone:oWSTABLESTRUCT       := IIF(::oWSTABLESTRUCT = NIL , NIL , ::oWSTABLESTRUCT:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT UBTDNTVIEW_UTABLEVIEW
    Local oNode1
    Local oNode2
    ::Init()
    If oResponse = NIL ; Return ; Endif 
    oNode1 :=  WSAdvValue( oResponse,"_TABLEDATA","ARRAYOFFIELDVIEW",NIL,"Property oWSTABLEDATA as s0:ARRAYOFFIELDVIEW on SOAP Response not found.",NIL,"O",NIL,NIL) 
    If oNode1 != NIL
        ::oWSTABLEDATA := UBTDNTVIEW_ARRAYOFFIELDVIEW():New()
        ::oWSTABLEDATA:SoapRecv(oNode1)
    EndIf
    oNode2 :=  WSAdvValue( oResponse,"_TABLESTRUCT","ARRAYOFUFIELDSTRUCT",NIL,"Property oWSTABLESTRUCT as s0:ARRAYOFUFIELDSTRUCT on SOAP Response not found.",NIL,"O",NIL,NIL) 
    If oNode2 != NIL
        ::oWSTABLESTRUCT := UBTDNTVIEW_ARRAYOFUFIELDSTRUCT():New()
        ::oWSTABLESTRUCT:SoapRecv(oNode2)
    EndIf
Return

// WSDL Data Structure UFIELDSNAME

WSSTRUCT UBTDNTVIEW_UFIELDSNAME
    WSDATA   oWSUFLDNAME               AS UBTDNTVIEW_ARRAYOFSTRING
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPSEND
    WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UBTDNTVIEW_UFIELDSNAME
    ::Init()
Return Self

WSMETHOD INIT WSCLIENT UBTDNTVIEW_UFIELDSNAME
Return

WSMETHOD CLONE WSCLIENT UBTDNTVIEW_UFIELDSNAME
    Local oClone := UBTDNTVIEW_UFIELDSNAME():NEW()
    oClone:oWSUFLDNAME          := IIF(::oWSUFLDNAME = NIL , NIL , ::oWSUFLDNAME:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT UBTDNTVIEW_UFIELDSNAME
    Local cSoap := ""
    cSoap += WSSoapValue("UFLDNAME", ::oWSUFLDNAME, ::oWSUFLDNAME , "ARRAYOFSTRING", .T. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT UBTDNTVIEW_UFIELDSNAME
    Local oNode1
    ::Init()
    If oResponse = NIL ; Return ; Endif 
    oNode1 :=  WSAdvValue( oResponse,"_UFLDNAME","ARRAYOFSTRING",NIL,"Property oWSUFLDNAME as s0:ARRAYOFSTRING on SOAP Response not found.",NIL,"O",NIL,NIL) 
    If oNode1 != NIL
        ::oWSUFLDNAME := UBTDNTVIEW_ARRAYOFSTRING():New()
        ::oWSUFLDNAME:SoapRecv(oNode1)
    EndIf
Return

// WSDL Data Structure UTALIASES

WSSTRUCT UBTDNTVIEW_UTALIASES
    WSDATA   oWSTALIASES               AS UBTDNTVIEW_ARRAYOFUANYCODEDESC
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UBTDNTVIEW_UTALIASES
    ::Init()
Return Self

WSMETHOD INIT WSCLIENT UBTDNTVIEW_UTALIASES
Return

WSMETHOD CLONE WSCLIENT UBTDNTVIEW_UTALIASES
    Local oClone := UBTDNTVIEW_UTALIASES():NEW()
    oClone:oWSTALIASES          := IIF(::oWSTALIASES = NIL , NIL , ::oWSTALIASES:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT UBTDNTVIEW_UTALIASES
    Local oNode1
    ::Init()
    If oResponse = NIL ; Return ; Endif 
    oNode1 :=  WSAdvValue( oResponse,"_TALIASES","ARRAYOFUANYCODEDESC",NIL,"Property oWSTALIASES as s0:ARRAYOFUANYCODEDESC on SOAP Response not found.",NIL,"O",NIL,NIL) 
    If oNode1 != NIL
        ::oWSTALIASES := UBTDNTVIEW_ARRAYOFUANYCODEDESC():New()
        ::oWSTALIASES:SoapRecv(oNode1)
    EndIf
Return

// WSDL Data Structure ARRAYOFFIELDVIEW

WSSTRUCT UBTDNTVIEW_ARRAYOFFIELDVIEW
    WSDATA   oWSFIELDVIEW              AS UBTDNTVIEW_FIELDVIEW OPTIONAL
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UBTDNTVIEW_ARRAYOFFIELDVIEW
    ::Init()
Return Self

WSMETHOD INIT WSCLIENT UBTDNTVIEW_ARRAYOFFIELDVIEW
    ::oWSFIELDVIEW         := {} // Array Of  UBTDNTVIEW_FIELDVIEW():New()
Return

WSMETHOD CLONE WSCLIENT UBTDNTVIEW_ARRAYOFFIELDVIEW
    Local oClone := UBTDNTVIEW_ARRAYOFFIELDVIEW():NEW()
    oClone:oWSFIELDVIEW := NIL
    If ::oWSFIELDVIEW <> NIL 
        oClone:oWSFIELDVIEW := {}
        aEval( ::oWSFIELDVIEW , { |x| aadd( oClone:oWSFIELDVIEW , x:Clone() ) } )
    Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT UBTDNTVIEW_ARRAYOFFIELDVIEW
    Local nRElem1, oNodes1, nTElem1
    ::Init()
    If oResponse = NIL ; Return ; Endif 
    oNodes1 :=  WSAdvValue( oResponse,"_FIELDVIEW","FIELDVIEW",{},NIL,.T.,"O",NIL,NIL) 
    nTElem1 := len(oNodes1)
    For nRElem1 := 1 to nTElem1 
        If !WSIsNilNode( oNodes1[nRElem1] )
            aadd(::oWSFIELDVIEW , UBTDNTVIEW_FIELDVIEW():New() )
            ::oWSFIELDVIEW[len(::oWSFIELDVIEW)]:SoapRecv(oNodes1[nRElem1])
        Endif
    Next
Return

// WSDL Data Structure UTABLERECNOS

WSSTRUCT UBTDNTVIEW_UTABLERECNOS
    WSDATA   oWSURECNOS                AS UBTDNTVIEW_ARRAYOFSTRING
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPSEND
    WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UBTDNTVIEW_UTABLERECNOS
    ::Init()
Return Self

WSMETHOD INIT WSCLIENT UBTDNTVIEW_UTABLERECNOS
Return

WSMETHOD CLONE WSCLIENT UBTDNTVIEW_UTABLERECNOS
    Local oClone := UBTDNTVIEW_UTABLERECNOS():NEW()
    oClone:oWSURECNOS           := IIF(::oWSURECNOS = NIL , NIL , ::oWSURECNOS:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT UBTDNTVIEW_UTABLERECNOS
    Local cSoap := ""
    cSoap += WSSoapValue("URECNOS", ::oWSURECNOS, ::oWSURECNOS , "ARRAYOFSTRING", .T. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT UBTDNTVIEW_UTABLERECNOS
    Local oNode1
    ::Init()
    If oResponse = NIL ; Return ; Endif 
    oNode1 :=  WSAdvValue( oResponse,"_URECNOS","ARRAYOFSTRING",NIL,"Property oWSURECNOS as s0:ARRAYOFSTRING on SOAP Response not found.",NIL,"O",NIL,NIL) 
    If oNode1 != NIL
        ::oWSURECNOS := UBTDNTVIEW_ARRAYOFSTRING():New()
        ::oWSURECNOS:SoapRecv(oNode1)
    EndIf
Return

// WSDL Data Structure ARRAYOFUFIELDSTRUCT

WSSTRUCT UBTDNTVIEW_ARRAYOFUFIELDSTRUCT
    WSDATA   oWSUFIELDSTRUCT           AS UBTDNTVIEW_UFIELDSTRUCT OPTIONAL
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UBTDNTVIEW_ARRAYOFUFIELDSTRUCT
    ::Init()
Return Self

WSMETHOD INIT WSCLIENT UBTDNTVIEW_ARRAYOFUFIELDSTRUCT
    ::oWSUFIELDSTRUCT      := {} // Array Of  UBTDNTVIEW_UFIELDSTRUCT():New()
Return

WSMETHOD CLONE WSCLIENT UBTDNTVIEW_ARRAYOFUFIELDSTRUCT
    Local oClone := UBTDNTVIEW_ARRAYOFUFIELDSTRUCT():NEW()
    oClone:oWSUFIELDSTRUCT := NIL
    If ::oWSUFIELDSTRUCT <> NIL 
        oClone:oWSUFIELDSTRUCT := {}
        aEval( ::oWSUFIELDSTRUCT , { |x| aadd( oClone:oWSUFIELDSTRUCT , x:Clone() ) } )
    Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT UBTDNTVIEW_ARRAYOFUFIELDSTRUCT
    Local nRElem1, oNodes1, nTElem1
    ::Init()
    If oResponse = NIL ; Return ; Endif 
    oNodes1 :=  WSAdvValue( oResponse,"_UFIELDSTRUCT","UFIELDSTRUCT",{},NIL,.T.,"O",NIL,NIL) 
    nTElem1 := len(oNodes1)
    For nRElem1 := 1 to nTElem1 
        If !WSIsNilNode( oNodes1[nRElem1] )
            aadd(::oWSUFIELDSTRUCT , UBTDNTVIEW_UFIELDSTRUCT():New() )
            ::oWSUFIELDSTRUCT[len(::oWSUFIELDSTRUCT)]:SoapRecv(oNodes1[nRElem1])
        Endif
    Next
Return

// WSDL Data Structure ARRAYOFSTRING

WSSTRUCT UBTDNTVIEW_ARRAYOFSTRING
    WSDATA   cSTRING                   AS string OPTIONAL
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPSEND
    WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UBTDNTVIEW_ARRAYOFSTRING
    ::Init()
Return Self

WSMETHOD INIT WSCLIENT UBTDNTVIEW_ARRAYOFSTRING
    ::cSTRING              := {} // Array Of  ""
Return

WSMETHOD CLONE WSCLIENT UBTDNTVIEW_ARRAYOFSTRING
    Local oClone := UBTDNTVIEW_ARRAYOFSTRING():NEW()
    oClone:cSTRING              := IIf(::cSTRING <> NIL , aClone(::cSTRING) , NIL )
Return oClone

WSMETHOD SOAPSEND WSCLIENT UBTDNTVIEW_ARRAYOFSTRING
    Local cSoap := ""
    aEval( ::cSTRING , {|x| cSoap := cSoap  +  WSSoapValue("STRING", x , x , "string", .F. , .F., 0 , NIL, .F.)  } ) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT UBTDNTVIEW_ARRAYOFSTRING
    Local oNodes1 :=  WSAdvValue( oResponse,"_STRING","string",{},NIL,.T.,"S",NIL,"a") 
    ::Init()
    If oResponse = NIL ; Return ; Endif 
    aEval(oNodes1 , { |x| aadd(::cSTRING ,  x:TEXT  ) } )
Return

// WSDL Data Structure ARRAYOFUANYCODEDESC

WSSTRUCT UBTDNTVIEW_ARRAYOFUANYCODEDESC
    WSDATA   oWSUANYCODEDESC           AS UBTDNTVIEW_UANYCODEDESC OPTIONAL
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UBTDNTVIEW_ARRAYOFUANYCODEDESC
    ::Init()
Return Self

WSMETHOD INIT WSCLIENT UBTDNTVIEW_ARRAYOFUANYCODEDESC
    ::oWSUANYCODEDESC      := {} // Array Of  UBTDNTVIEW_UANYCODEDESC():New()
Return

WSMETHOD CLONE WSCLIENT UBTDNTVIEW_ARRAYOFUANYCODEDESC
    Local oClone := UBTDNTVIEW_ARRAYOFUANYCODEDESC():NEW()
    oClone:oWSUANYCODEDESC := NIL
    If ::oWSUANYCODEDESC <> NIL 
        oClone:oWSUANYCODEDESC := {}
        aEval( ::oWSUANYCODEDESC , { |x| aadd( oClone:oWSUANYCODEDESC , x:Clone() ) } )
    Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT UBTDNTVIEW_ARRAYOFUANYCODEDESC
    Local nRElem1, oNodes1, nTElem1
    ::Init()
    If oResponse = NIL ; Return ; Endif 
    oNodes1 :=  WSAdvValue( oResponse,"_UANYCODEDESC","UANYCODEDESC",{},NIL,.T.,"O",NIL,NIL) 
    nTElem1 := len(oNodes1)
    For nRElem1 := 1 to nTElem1 
        If !WSIsNilNode( oNodes1[nRElem1] )
            aadd(::oWSUANYCODEDESC , UBTDNTVIEW_UANYCODEDESC():New() )
            ::oWSUANYCODEDESC[len(::oWSUANYCODEDESC)]:SoapRecv(oNodes1[nRElem1])
        Endif
    Next
Return

// WSDL Data Structure FIELDVIEW

WSSTRUCT UBTDNTVIEW_FIELDVIEW
    WSDATA   oWSFLDTAG                 AS UBTDNTVIEW_ARRAYOFSTRING
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UBTDNTVIEW_FIELDVIEW
    ::Init()
Return Self

WSMETHOD INIT WSCLIENT UBTDNTVIEW_FIELDVIEW
Return

WSMETHOD CLONE WSCLIENT UBTDNTVIEW_FIELDVIEW
    Local oClone := UBTDNTVIEW_FIELDVIEW():NEW()
    oClone:oWSFLDTAG            := IIF(::oWSFLDTAG = NIL , NIL , ::oWSFLDTAG:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT UBTDNTVIEW_FIELDVIEW
    Local oNode1
    ::Init()
    If oResponse = NIL ; Return ; Endif 
    oNode1 :=  WSAdvValue( oResponse,"_FLDTAG","ARRAYOFSTRING",NIL,"Property oWSFLDTAG as s0:ARRAYOFSTRING on SOAP Response not found.",NIL,"O",NIL,NIL) 
    If oNode1 != NIL
        ::oWSFLDTAG := UBTDNTVIEW_ARRAYOFSTRING():New()
        ::oWSFLDTAG:SoapRecv(oNode1)
    EndIf
Return

// WSDL Data Structure UFIELDSTRUCT

WSSTRUCT UBTDNTVIEW_UFIELDSTRUCT
    WSDATA   nFLDDEC                   AS integer
    WSDATA   cFLDDESCRIPTION           AS string
    WSDATA   lFLDMANDATORY             AS boolean
    WSDATA   cFLDNAME                  AS string
    WSDATA   nFLDSIZE                  AS integer
    WSDATA   cFLDTITLE                 AS string
    WSDATA   cFLDTYPE                  AS string
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UBTDNTVIEW_UFIELDSTRUCT
    ::Init()
Return Self

WSMETHOD INIT WSCLIENT UBTDNTVIEW_UFIELDSTRUCT
Return

WSMETHOD CLONE WSCLIENT UBTDNTVIEW_UFIELDSTRUCT
    Local oClone := UBTDNTVIEW_UFIELDSTRUCT():NEW()
    oClone:nFLDDEC              := ::nFLDDEC
    oClone:cFLDDESCRIPTION      := ::cFLDDESCRIPTION
    oClone:lFLDMANDATORY        := ::lFLDMANDATORY
    oClone:cFLDNAME             := ::cFLDNAME
    oClone:nFLDSIZE             := ::nFLDSIZE
    oClone:cFLDTITLE            := ::cFLDTITLE
    oClone:cFLDTYPE             := ::cFLDTYPE
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT UBTDNTVIEW_UFIELDSTRUCT
    ::Init()
    If oResponse = NIL ; Return ; Endif 
    ::nFLDDEC            :=  WSAdvValue( oResponse,"_FLDDEC","integer",NIL,"Property nFLDDEC as s:integer on SOAP Response not found.",NIL,"N",NIL,NIL) 
    ::cFLDDESCRIPTION    :=  WSAdvValue( oResponse,"_FLDDESCRIPTION","string",NIL,"Property cFLDDESCRIPTION as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
    ::lFLDMANDATORY      :=  WSAdvValue( oResponse,"_FLDMANDATORY","boolean",NIL,"Property lFLDMANDATORY as s:boolean on SOAP Response not found.",NIL,"L",NIL,NIL) 
    ::cFLDNAME           :=  WSAdvValue( oResponse,"_FLDNAME","string",NIL,"Property cFLDNAME as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
    ::nFLDSIZE           :=  WSAdvValue( oResponse,"_FLDSIZE","integer",NIL,"Property nFLDSIZE as s:integer on SOAP Response not found.",NIL,"N",NIL,NIL) 
    ::cFLDTITLE          :=  WSAdvValue( oResponse,"_FLDTITLE","string",NIL,"Property cFLDTITLE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
    ::cFLDTYPE           :=  WSAdvValue( oResponse,"_FLDTYPE","string",NIL,"Property cFLDTYPE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure UANYCODEDESC

WSSTRUCT UBTDNTVIEW_UANYCODEDESC
    WSDATA   cCODE                     AS string
    WSDATA   cDESCRIPTION              AS string
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UBTDNTVIEW_UANYCODEDESC
    ::Init()
Return Self

WSMETHOD INIT WSCLIENT UBTDNTVIEW_UANYCODEDESC
Return

WSMETHOD CLONE WSCLIENT UBTDNTVIEW_UANYCODEDESC
    Local oClone := UBTDNTVIEW_UANYCODEDESC():NEW()
    oClone:cCODE                := ::cCODE
    oClone:cDESCRIPTION         := ::cDESCRIPTION
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT UBTDNTVIEW_UANYCODEDESC
    ::Init()
    If oResponse = NIL ; Return ; Endif 
    ::cCODE              :=  WSAdvValue( oResponse,"_CODE","string",NIL,"Property cCODE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
    ::cDESCRIPTION       :=  WSAdvValue( oResponse,"_DESCRIPTION","string",NIL,"Property cDESCRIPTION as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return
