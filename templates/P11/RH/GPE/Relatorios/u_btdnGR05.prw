#INCLUDE "PROTHEUS.CH"
#INCLUDE "DBSTRUCT.CH"
#INCLUDE "uTCREPORT.CH"

Static __cCRLF    := CRLF

/*
    Programa    : u_btdnGR05.PRW
    Funcao        : u_btdnGR05()
    Autor        : Marinaldo de Jesus [http://www.blacktdn.com.br]
    Data        : 17/06/2013
    Descricao    : Gerar Informacoes em Excel
*/                          
User Function btdnGR05()

    Local aPerg            := Array(0)
    Local nPerg
    
    Local cFunction        := "btdnGR05"
    Local cTitle        := OemToAnsi( "Relat�rio de L�quido do m�s" )
    Local cDescription    := cTitle
    
    Local bProcess        := {|othis,oPanel|btdnGR05Excel(@lIsBlind,@othis,@oPanel,@cTitle)}

    Local lIsBlind        := IsBlind()
    Local lParamBox        := .T. 
    
    Local lExcel        := IF( lIsBlind , .T. , MsgYesNo( "Gerar em Excel?" , "Aten��o" ) )
    
    Private cCadastro     := cTitle

    BEGIN SEQUENCE
        
        aAdd( aPerg , Array( 9 ) )
        nPerg := Len( aPerg )
            
        IF .NOT.( Type("dDataBase") == "D" )
            dDataBase := MsDate()    
        EndIF
        
        Private MV_PAR01    := AnoMes(dDataBase)
        
        aPerg[nPerg][1]    :=  1                                                    //[1] : 1 - MsGet
        aPerg[nPerg][2]    := "Compat�ncia (Ano/Mes)"                                //[2] : Descricao
        aPerg[nPerg][3]    := MV_PAR01                                                //[3] : String contendo o inicializador do campo
        aPerg[nPerg][4]    := "@R 9999/99"                                            //[4] : String contendo a Picture do campo
        aPerg[nPerg][5]    := "NaoVazio()"                                            //[5] : String contendo a validacao
        aPerg[nPerg][6]    := ""                                                    //[6] : Consulta F3
        aPerg[nPerg][7]    := ".T."                                                //[7] : String contendo a validacao When
        aPerg[nPerg][8]    := 7 + 100                                                //[8] : Tamanho do MsGet
        aPerg[nPerg][9]    := .T.                                                    //[9] : Flag .T./.F. Parametro Obrigatorio ?
    
        While .NOT.( lParamBox := ParamBox( @aPerg , "Informe a Compet�ncia (YYYY/MM)" , NIL , NIL , NIL , .T. ) )
            MV_PAR01 := AnoMes(dDataBase)
        End While

        Private aNotPrint    := Array(0) //Deverao ser sempre os ultimos campos na Estrutura da View
        
    
        IF ( lExcel )
            IF ( lIsBlind )
                BatchProcess(cCadastro,cTitle,cFunction,bProcess,{||.F.})
                Return .T.
            Else
                tNewProcess():New(@cFunction,@cTitle,@bProcess,@cDescription,"",NIL,.T.,5,"Aguarde...Gerando",.T.)
            EndIF
        Else
            uTCREPORT ACTIVATE
            uTCREPORT SET FONT "MS Mincho" SIZE 0,9
            uTCREPORT SET LINE HEIGHT 45
            btdnGR05Prt(lIsBlind,MV_PAR01,cDescription)
        EndIF    
    
    END SEQUENCE
    
Return( .T. )

/*
    Programa    : u_btdnGR05.PRW
    Funcao        : btdnGR05Excel
    Autor        : Marinaldo de Jesus [http://www.blacktdn.com.br]
    Data        : 17/06/2013
    Descricao    : Gerar Informacoes em Excel
*/                          
Static Function btdnGR05Excel(lIsBlind,othis,oPanel,cTitle)

    Local aLastQuery
    Local cLastQuery
    Local cTCSqlError

    Local cAlias
    
    Local cYearMonth    := MV_PAR01
    
    Local nQryCTotal    := 0
    
    Local bError          := { |e| oError := e , BREAK(e) }
    Local bErrorBlock    := ErrorBlock( bError )
    Local cError
    Local oError

    BEGIN SEQUENCE
    
        MsAguarde( { || cAlias := QueryView(@cYearMonth,@nQryCTotal) } , "Obtendo dados no SGBD" , "Aguarde..." )
        
        IF ( Empty( cAlias ) .or. ( Select( cAlias ) == 0 ) )
            ApMsgAlert( "N�o Existem Dados a serem Gerados" , "Aten��o" )
            BREAK
        EndIF

        IF .NOT.( lIsBlind )
            othis:SetRegua1(nQryCTotal)
            othis:SetRegua2(nQryCTotal)
        EndIF

        DBToExcel(@othis,@cAlias,@nQryCTotal,@lIsBlind,@cYearMonth,@cTitle)

        (cAlias)->( dbCloseArea() )

    RECOVER

        IF ( ValType( oError ) == "O" )
            cError    := oError:Description
        EndIF
        
        aLastQuery    := GetLastQuery()
        cLastQuery    := aLastQuery[2]
            
        cTCSqlError    := TCSqlError()

        IF ( Select( cAlias ) > 0 )
            (cAlias)->( dbCloseArea() )
        EndIF

    END SEQUENCE
    ErrorBlock( bErrorBlock )

Return( NIL )

/*
    Programa    : u_btdnGR05.PRW
    Funcao        : QueryView
    Autor        : Marinaldo de Jesus [http://www.blacktdn.com.br]
    Data        : 17/06/2013
    Descricao    : Obter View para Gerar Informacoes em Excel
*/                          
Static Function QueryView(cYearMonth,nQryCTotal)

    Local aLastQuery
    Local cLastQuery
    Local cTCSqlError

    Local cAlias        := GetNextAlias()

    Local bError          := { |e| oError := e , BREAK(e) }
    Local bErrorBlock    := ErrorBlock( bError )
    Local cError
    Local oError

    nQryCTotal    := 0

    BEGIN SEQUENCE
        
        BEGINSQL ALIAS cAlias
            COLUMN RD_VALOR    AS NUMERIC(15,2)
            %noparser%
            SELECT SRA.RA_FILIAL
                  ,CTT.CTT_DESC01
                  ,SRA.RA_MAT
                  ,SRA.RA_NOME
                  ,SRA.RA_BCDEPSA
                    ,SRA.RA_CTDEPSA
                  ,SRD.RD_VALOR
            FROM
                %table:SRA% SRA
               ,%table:CTT% CTT
               ,%table:SRD% SRD
            WHERE SRA.%NotDel%
              AND SRA.RA_FILIAL BETWEEN ' ' AND 'Z'
              AND CTT.%NotDel%
              AND CTT.CTT_FILIAL BETWEEN ' ' AND 'Z'
              AND SRA.RA_CC=CTT.CTT_CUSTO
              AND SRD.%NotDel%
              AND SRD.RD_FILIAL=SRA.RA_FILIAL
              AND SRD.RD_MAT=SRA.RA_MAT
              AND SRD.RD_DATARQ=%exp:cYearMonth%
              AND SRD.RD_PD='799'
              AND EXISTS(
                  SELECT
                      1
                  FROM %table:SRD% SRD_X
                  WHERE SRD_X.%NotDel%
                      AND SRD_X.RD_FILIAL=SRA.RA_FILIAL
                      AND SRD_X.RD_MAT=SRA.RA_MAT
                      AND SRD_X.RD_DATARQ=%exp:cYearMonth%
                      AND SRD_X.RD_PD='799'
              )    
            ORDER BY
                 SRA.RA_FILIAL
                ,SRA.RA_NOME
        ENDSQL
                
        IF ( ( Select( cAlias ) == 0 ) .or. (cAlias)->( Bof() .and. Eof() ) )
            UserException( "NO TABLE/VIEW DATA" )
        EndIF            

        While (cAlias)->( .NOT.( Eof() ) )
            ++nQryCTotal
            (cAlias)->( dbSkip() )
        End While

        (cAlias)->( dbGoTop() )

    RECOVER

        IF ( ValType( oError ) == "O" )
            cError    := oError:Description
        EndIF
        
        aLastQuery    := GetLastQuery()
        cLastQuery    := aLastQuery[2]
            
        cTCSqlError    := TCSqlError()

        IF ( Select( cAlias ) > 0 )
            (cAlias)->( dbCloseArea() )
        EndIF
        
        cAlias := ""

    END SEQUENCE
    ErrorBlock( bErrorBlock )

Return( cAlias  )

/*
    Programa    : u_btdnGR05.PRW
    Funcao        : QueryView
    Autor        : Marinaldo de Jesus [http://www.blacktdn.com.br]
    Data        : 17/06/2013
    Descricao    : Mostrar os Dados no Excel
*/                          
Static Function DBToExcel(othis,cAlias,nQryCTotal,lIsBlind,cYearMonth,cTable,lTotalize,lPicture)
    
    Local aHeader        := (cAlias)->( dbStruct() )
    
    Local oFWMSExcel    := FWMSExcel():New()
    
    Local oMsExcel
    
    Local aCells        := Array(0)
    
    Local cType
    Local cColumn
    
    Local cFile
    Local cFileTMP
    
    Local cPicture
    
    Local cWorkSheet
    Local cCompetencia    := ( SubStr(cYearMonth,-2)+"/"+SubStr(cYearMonth,1,4))
    
    Local lTotal
    
    Local nField
    Local nFields
    
    Local nAlign
    Local nFormat
    
    Local nFBreak        := (cAlias)->( FieldPos( "RA_FILIAL" ) )
    Local lBreak
    Local cLBreak        := "@@__cLBreak__@@"
    Local cWBreak
    Local cTBreak

    Local uCell
    
    Local lNotPrint        := ( ( Type("aNotPrint") == "A" ) .and. ( Len( aNotPrint ) > 0 ) )
    
    Local bError          := { |e| oError := e , BREAK(e) }
    Local bErrorBlock    := ErrorBlock( bError )
    Local cError
    Local oError

    DEFAULT cWorkSheet    := "btdnGR05"
    DEFAULT cTable         := cWorkSheet
    DEFAULT lTotalize     := .T.
    DEFAULT lPicture     := .F.
    
    BEGIN SEQUENCE
        
        nFields := Len( aHeader )
        
        While (cAlias)->( .NOT.( Eof() ) )

            IF .NOT.( lIsBlind )
                othis:IncRegua2("Processando...")
                IF ( othis:lEnd )
                    othis:lEnd := MsgNoYes("Deseja abortar o processo?","Aten��o")
                    IF ( othis:lEnd )
                        othis:SaveLog("Processo Abortado Pelo Usu�rio: " + Dtoc(MsDate()) +  " - " + Time() )
                        EXIT
                    EndIF
                EndIF
            EndIF
    
            lBreak    := .NOT.( (cAlias)->( AllTrim( FieldGet( nFBreak ) ) == cLBreak ) )
            
            IF ( lBreak )
            
                cLBreak    := (cAlias)->( AllTrim( FieldGet( nFBreak ) ) )
    
                cWBreak    := ( cLBreak )
                cTBreak    := ( cTable + " - " + cLBreak + " (Competencia: " + cCompetencia + ")" )
                
                oFWMSExcel:AddworkSheet(cWBreak)
                oFWMSExcel:AddTable(cWBreak,cTBreak)
                
                For nField := 1 To nFields
                    IF ( lNotPrint .and. ( aScan( aNotPrint , {|cField| ( cField $ aHeader[nField][DBS_NAME] ) } ) > 0 ) )
                        Loop
                    EndIF
                    cType   := aHeader[nField][DBS_TYPE]
                    nAlign  := IF(cType=="C",1,IF(cType=="N",3,2))
                    nFormat := IF(cType=="D",4,IF(cType=="N",2,1)) 
                    cColumn := GetSx3Cache(aHeader[nField][DBS_NAME],"X3_TITULO") 
                    IF ( cColumn == NIL )
                        cColumn := aHeader[nField][DBS_NAME]
                    EndIF
                    IF ( ( "Desc Moeda 1" $ cColumn ) .or. ( "CTT_DESC01" $ aHeader[nField][DBS_NAME] ) )
                        cColumn    := "Centro de Custo"
                    ElseIF ( "RA_MAT" $ aHeader[nField][DBS_NAME] )
                        cColumn    := "C�digo"
                    EndIF            
                    cColumn    := OemToAnsi( cColumn )
                    lTotal     := ( lTotalize .and. cType == "N" )
                    oFWMSExcel:AddColumn(@cWBreak,@cTBreak,@cColumn,@nAlign,@nFormat,@lTotal)
                Next nField
            
            EndIF    
            
            aSize(aCells,0)    
            
            For nField := 1 To nFields
                IF ( lNotPrint .and. ( aScan( aNotPrint , {|cField| ( cField $ aHeader[nField][DBS_NAME] ) } ) > 0 ) )
                    Loop
                EndIF
                uCell := (cAlias)->( FieldGet( nField ) )
                IF ( lPicture )
                    cPicture := GetSx3Cache(aHeader[nField][DBS_NAME],"X3_PICTURE")
                    IF .NOT.( Empty(cPicture) )
                        uCell := Transform(uCell,cPicture)
                    EndIF
                EndIF
                aAdd(aCells,uCell)
            Next nField

            oFWMSExcel:AddRow(@cWBreak,@cTBreak,aClone(aCells))
            
            (cAlias)->( dbSkip() )
    
            IF .NOT.( lIsBlind )
                othis:IncRegua1("Processando...")
                IF ( othis:lEnd )
                    othis:lEnd := MsgNoYes("Deseja abortar o processo?","Aten��o")
                    IF ( othis:lEnd )
                        othis:SaveLog("Processo Abortado Pelo Usu�rio: " + Dtoc(MsDate()) +  " - " + Time() )
                        EXIT
                    EndIF
                EndIF
            EndIF
        
        End While

        oFWMSExcel:Activate()
        
        cFile := ( CriaTrab( NIL, .F. ) + ".xml" )
        
        While File( cFile )
            cFile := ( CriaTrab( NIL, .F. ) + ".xml" )
        End While
        
        oFWMSExcel:GetXMLFile( cFile )
        oFWMSExcel:DeActivate()
        
        IF .NOT.( File( cFile ) )
            cFile := ""
            BREAK
        EndIF
        
        cFileTMP := ( GetTempPath() + cFile )
        IF .NOT.( __CopyFile( cFile , cFileTMP ) )
            fErase( cFile )
            cFile := ""
            BREAK
        EndIF
        
        fErase( cFile )
        
        cFile := cFileTMP
        
        IF .NOT.( File( cFile ) )
            cFile := ""
            BREAK
        EndIF
        
        IF .NOT.( ApOleClient("MsExcel") )
            BREAK
        EndIF
        
        oMsExcel := MsExcel():New()
        oMsExcel:WorkBooks:Open( cFile )
        oMsExcel:SetVisible( .T. )
        oMsExcel := oMsExcel:Destroy()
        
    RECOVER

        IF ( ValType( oError ) == "O" )
            cError    := oError:Description
        EndIF

    END SEQUENCE
    ErrorBlock( bErrorBlock )
    
    oFWMSExcel := FreeObj( oFWMSExcel )

Return( cFile )

/*
    Programa    : u_btdnGR05.PRW
    Fun��o        : btdnGR05Prt
    Autor        : Marinaldo de Jesus [http://www.blacktdn.com.br]
    Data        : 17/06/2013
    Descri��o    : Impressao do Relatorio.
*/
Static Function btdnGR05Prt(lIsBlind,cYearMonth,cDescription)

    Local lSetCentury    := __SetCentury( "ON" ) 

    Local aNiveis        := Array(1)
    Local bGetView        := { || aNiveis[nNivel] := QueryView(@cYearMonth,@nQryCTotal) }
    Local bReportPrint    := { || RunReport(@lIsBlind,@aNiveis,@nNiveis) }
    
    Local cCRLF            := CRLF

    Local nNivel
    Local nNiveis        := Len(aNiveis)
    Local nQryCTotal    := 0

    Local uRet

    Private cDesc1        := "Este programa tem como objetivo imprimir relatorio "
    Private cDesc2        := "de acordo com os parametros informados pelo usuario."
    Private cDesc3      := ProcName() + " " + cDescription

    Private TITULO       := cDescription + " (Competencia:" + ( SubStr(cYearMonth,-2)+"/"+SubStr(cYearMonth,1,4))+")"

    Private aCabec1     := Array(0)
    Private aCabec2     := Array(0)
    Private aCabec3     := Array(0)

    Private wCabec0        := 3
    Private wCabec1     := ""
    Private wCabec2     := ""
    Private wCabec3     := ""

    Private NOMEPROG     := ProcName()
    Private TAMANHO      := "G"
    Private LIMITE       := IF((TAMANHO=="P"),80,IF(TAMANHO=="M",132,220))
    Private cLine        := Replicate( "-" , LIMITE )
    Private lAbortPrint    := .F.

    Private cString     := "SE1"

    For nNivel := 1 To nNiveis
        MsAguarde( bGetView , "Selecionando Dados no SGBD" , "Aguarde..." )
    Next nNivel    

    RPrint(bReportPrint)
    
Return( uRet )

/*
    Programa    : u_btdnGR05.PRW
    Fun��o        : RPrint
    Autor        : Marinaldo de Jesus [http://www.blacktdn.com.br]
    Data        : 17/06/2013
    Descri��o    : Tratamento para impressao no modelo R3
*/
Static Function RPrint(bReportPrint)

    Local aOrd            := {}

    Private nTipo       := 18
    Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
    Private nLastKey    := 0
    Private CONTFL      := 01
    Private m_pag       := 01
    Private wnrel       := NOMEPROG // Coloque aqui o nome do arquivo usado para impressao em disco
    Private nLin          := 999

    wnrel := SetPrint(cString,NOMEPROG,"",@TITULO,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,TAMANHO,,.T.)

    IF ( nLastKey == 27 )
       Return( .F. )
    EndIF

    SetDefault(aReturn,cString)

    IF ( nLastKey == 27 )
       Return( .F. )
    EndIF

    nTipo := If(aReturn[4]==1,15,18)

    RptStatus( bReportPrint , TITULO )

    SET DEVICE TO SCREEN

    IF (aReturn[5]==1)
       dbCommitAll()
       SET PRINTER TO
       OurSpool(wnrel)
    EndIF

    MS_FLUSH()

Return( .T. )

/*
    Programa    : u_btdnGR05.PRW
    Fun��o        : RunReport
    Autor        : Marinaldo de Jesus [http://www.blacktdn.com.br]
    Data        : 17/06/2013
    Descri��o    : Impressao dos Dados
*/
Static Function RunReport(lIsBlind,aNiveis,nNiveis)

    Local aField
    Local aPicture

    Local cType
    Local cAlias
    Local cQuebra
    Local cLinePrn
    Local cX3Titulo
    
    Local nCol                                                
    Local nNivel
    Local nFSize
    Local nField
    Local nFields
    
    Local nQTotal   := 0
    Local nRTotal    := 0
    
    Local nQField
    Local lFQuebra

    Local nTField
    Local lFTotal
    
    Local lNotPrint        := ( ( Type("aNotPrint") == "A" ) .and. ( Len( aNotPrint ) > 0 ) )

    Local cQField        := "RA_FILIAL"
    Local cTField        := "RD_VALOR"

    BEGIN SEQUENCE

        For nNivel := 1 To nNiveis
            
            cAlias     := aNiveis[nNivel]
            
            IF ( Empty( cAlias ) .or. ( Select( cAlias ) == 0 ) )
                Loop
            EndIF

            aFields     := ( cAlias )->( dbStruct() )
            nFields     := Len(aFields)
            
            aPicture := Array(nFields)
            
            nCol     := 0
            
            wCabec2     := ""
            
            uTCREPORT DEL HEADER aCabec1
            aSize( aCabec1 , 0 )
            
            uTCREPORT DEL HEADER aCabec2
            aSize( aCabec2 , 0 )

            uTCREPORT DEL HEADER aCabec3
            aSize( aCabec3 , 0 )
            
            nQField        := (cAlias)->( FieldPos(cQField) )
            lFQuebra    := ( nQField > 0 )
            
            nTField        := (cAlias)->( FieldPos(cTField) )
            lFTotal        := ( nTField > 0 )
            
            For nField := 1 To nFields
                
                IF ( lNotPrint .and. ( aScan( aNotPrint , {|cField| ( cField $ aFields[nField][DBS_NAME] ) } ) > 0 ) )
                    Loop
                EndIF
                
                cX3Titulo    := GetSX3Cache(aFields[nField][DBS_NAME],"X3_TITULO")
                IF ( cX3Titulo == NIL )
                    cX3Titulo := aFields[nField][DBS_NAME]
                EndIF
                   
                   cX3Titulo    := AllTrim(cX3Titulo)
                   uFieldGet    := ( cAlias )->( FieldGet(nField) )
                
                IF ( ( "Desc Moeda 1" $ cX3Titulo ) .or. ( "CTT_DESC01" $ aFields[nField][DBS_NAME] ) )
                    cX3Titulo    := ""
                ElseIF ( "RA_MAT" $ aFields[nField][DBS_NAME] )
                    cX3Titulo    := "C�digo"
                ElseIF ( "CTT_DESC01" $ aFields[nField][DBS_NAME] )
                    cX3Titulo    := ""
                EndIF            

                nFSize        := aFields[nField][DBS_LEN]
                nFSize        += aFields[nField][DBS_DEC]
                nFSize        := Max(nFSize,Len(cX3Titulo))
                cPicture    := GetSx3Cache(aFields[nField][DBS_NAME],"X3_PICTURE")
                cType         := aFields[nField][DBS_TYPE]
                
                IF (;
                        ( cPicture == NIL );
                        .or.;
                        Empty(cPicture);
                    )    
                    DO CASE
                    CASE ( cType $ "[C]/[L]/[M]" )
                        cPicture := "@!"
                    CASE ( cType == "D" )
                        cPicture := "@D"
                    CASE ( cType == "N" )
                        IF ( aFields[nField][DBS_DEC] > 0 )
                            cPicture := "@R "
                            cPicture += Replicate("9",(aFields[nField][DBS_LEN]-aFields[nField][DBS_DEC])-1)
                            cPicture += "."
                            cPicture += Replicate("9",aFields[nField][DBS_DEC])
                        Else
                            cPicture := "@R "
                            cPicture += Replicate("9",aFields[nField][DBS_LEN])
                        EndIF               
                    OTHERWISE
                        cPicture := "@!"
                    ENDCASE
                EndIF    
                cPicture            := AllTrim(cPicture)
                aPicture[nField]    := cPicture
                IF ( cType == "C" )
                    uFieldGet        := SubStr(uFieldGet,1,aFields[nField][DBS_LEN])
                EndIF
                uFieldGet             := Transform(uFieldGet,cPicture)
                nFSize                 := Max(nFSize,Len(uFieldGet))
                nFSize                += 1
                aAdd( aCabec3 , { nCol , PADC( OemToAnsi( cX3Titulo ) , nFSize ) , nFSize } )
                nCol                 += ( nFSize + 1 )
            Next nField
    
            aAdd( aCabec1 , { 0 , "Filial: " + ( cAlias )->(FieldGet(nQField)) , 100 } )
            aAdd( aCabec2 , { 0 , "" , 100 } )        
    
            uTCREPORT ADD HEADER aCabec1 
                                         
            uTCREPORT ADD HEADER aCabec2 
            
            uTCREPORT ADD HEADER aCabec3

            uTCREPORT CHK PAGE BREAK
            
            While ( cAlias )->( .NOT.( Eof() ) )
                nCol     := 0
                cLinePrn := ""
                For nField := 1 To nFields
                    IF ( lNotPrint .and. ( aScan( aNotPrint , {|cField| ( cField $ aFields[nField][DBS_NAME] ) } ) > 0 ) )
                        Loop
                    EndIF
                    uFieldGet    := ( cAlias )->( FieldGet(nField) )
                    cType         := aFields[nField][DBS_TYPE]
                    IF ( cType == "C" )
                        uFieldGet := SubStr(uFieldGet,1,aFields[nField][DBS_LEN])
                    EndIF
                    nFSize        := aCabec3[nField][3]
                    cPicture    := aPicture[nField]
                    cLinePrn    += PadR(Transform(uFieldGet,cPicture),nFSize)
                Next nField
                nCol := aCabec3[1][1]
                @ nLin,nCol PSAY OemToAnsi(cLinePrn)
                nLin := nLin+1
                IF ( lFQuebra )
                    cQuebra := ( cAlias )->( FieldGet( nQField ) )
                    IF ( lFTotal )
                        nQTotal += ( cAlias )->( FieldGet( nTField ) )
                    EndIF    
                EndIF
                IF ( lFTotal )
                    nRTotal    += ( cAlias )->( FieldGet( nTField ) )
                EndIF    
                ( cAlias )->( dbSkip() )
                IF ( lFQuebra )
                    IF .NOT.( cQuebra == ( cAlias )->( FieldGet( nQField ) ) )
                        IF ( lFTotal )
                            nLin := nLin+2
                            cLinePrn := ""
                            For nField := 1 To nFields
                                IF ( lNotPrint .and. ( aScan( aNotPrint , {|cField| ( cField $ aFields[nField][DBS_NAME] ) } ) > 0 ) )
                                    Loop
                                EndIF
                                uFieldGet    := ( cAlias )->( FieldGet(nField) )
                                cType         := aFields[nField][DBS_TYPE]
                                IF ( cType == "C" )
                                    uFieldGet := SubStr(uFieldGet,1,aFields[nField][DBS_LEN])
                                EndIF
                                nFSize        := aCabec3[nField][3]
                                cPicture    := aPicture[nField]
                                IF ( nField == nTField )
                                    cLinePrn    += PadR(Transform(nQTotal,cPicture),nFSize)
                                Else
                                    cLinePrn    += Space(nFSize)
                                EndIF    
                            Next nField
                            @nLin,nCol PSAY OemToAnsi( cLinePrn )
                            nLin := nLin+1
                            nQTotal    := 0
                        EndIF
                        nLin := nLin+1
                        @nLin,nCol PSAY OemToAnsi( cLine )
                        nLin := nLin+1
                        IF (cAlias)->( .NOT.( Eof() ) )
                            uTCREPORT SET PAGE BREAK
                            uTCREPORT CHK PAGE BREAK
                        EndIF    
                    EndIF
                EndIF
                        
            End While

            IF ( lFTotal )
                nLin := nLin+2
                cLinePrn := ""
                For nField := 1 To nFields
                    IF ( lNotPrint .and. ( aScan( aNotPrint , {|cField| ( cField $ aFields[nField][DBS_NAME] ) } ) > 0 ) )
                        Loop
                    EndIF
                    uFieldGet    := ( cAlias )->( FieldGet(nField) )
                    cType         := aFields[nField][DBS_TYPE]
                    IF ( cType == "C" )
                        uFieldGet := SubStr(uFieldGet,1,aFields[nField][DBS_LEN])
                    EndIF
                    nFSize        := aCabec3[nField][3]
                    cPicture    := aPicture[nField]
                    IF ( nField == nTField )
                        cLinePrn    += PadR(Transform(nRTotal,cPicture),nFSize)
                    Else
                        cLinePrn    += Space(nFSize)
                    EndIF    
                Next nField
                @nLin,nCol PSAY OemToAnsi( cLinePrn )
                nLin := nLin+1
                nRTotal    := 0
            EndIF

            uTCREPORT SET PAGE BREAK

        Next nNivel

    END SEQUENCE

Return( .T. )
