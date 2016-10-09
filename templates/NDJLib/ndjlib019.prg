#include "ndj.ch"

Static oNDJLIB019

CLASS NDJLIB019

    DATA cClassName

    METHOD NEW() CONSTRUCTOR
    METHOD ClassName()

    METHOD IniGetPValue(cFile,cSession,cPropertyName,cDefaultValue,cIgnoreToken)

ENDCLASS

User Function DJLIB019()
    DEFAULT oNDJLIB019:=NDJLIB019():New()
Return(oNDJLIB019)

METHOD NEW() CLASS NDJLIB019
    self:ClassName()
RETURN(self)

METHOD ClassName() CLASS NDJLIB019
    self:cClassName:="NDJLIB019"
RETURN(self:cClassName)

//------------------------------------------------------------------------------------------------
    /*/
        Funcao:IniGetPValue
        Autor:Marinaldo de Jesus
        Data:11/01/2011
        Uso:Retornar o Valor Atribuido a uma Propriedade de Acordo com a Sessao em um arquivo .INI
        Sintaxe:StaticCall(NDJLIB019,IniGetPValue,cFile,cSession,cPropertyName,cDefault)
    /*/
//------------------------------------------------------------------------------------------------
METHOD IniGetPValue(cFile,cSession,cPropertyName,cDefaultValue,cIgnoreToken) CLASS NDJLIB019
Return(IniGetPValue(@cFile,@cSession,@cPropertyName,@cDefaultValue,@cIgnoreToken))
Static Function IniGetPValue(cFile,cSession,cPropertyName,cDefaultValue,cIgnoreToken)
    Local oTFINI:=TFINI():New(@cFile,@cIgnoreToken)
    Local cPropertyValue:=oTFINI:GetPropertyValue(@cSession,@cPropertyName,@cDefaultValue)
    oTFINI:=NIL
Return(cPropertyValue)
