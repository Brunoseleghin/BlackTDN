#INCLUDE "PROTHEUS.CH"
#INCLUDE "DBSTRUCT.CH"
#INCLUDE "uTCREPORT.CH"

Static __cCRLF    := CRLF
Static __cTabC    := CHR(9)

/*
    Programa    : u_btdnGR16.PRW
    Funcao        : u_btdnGR16()
    Autor        : Marinaldo de Jesus [http://www.blacktdn.com.br]
    Data        : 17/06/2013
    Descricao    : Gerar Informacoes em Excel informa��es pagamento Benefici�ria Pens�o Aliment�cia (Rescis�o)
*/                          
User Function btdnGR16()

    Local aInfo
    Local aPerg            := Array(0)
    Local nPerg
    
    Local cFunction        := "btdnGR16"
    Local cTitle        := OemToAnsi( "Pagamento a Pensionistas (Rescis�o)" )
    Local cDescription    := cTitle
    
    Local bProcess        := {|othis,oPanel|btdnGR16Excel(@lIsBlind,@othis,@oPanel,@cTitle)}

    Local lIsBlind        := IsBlind()
    Local lParamBox        := .T. 
    
    Local lExcel        := IF( lIsBlind , .T. , MsgYesNo( "Gerar em Excel?" , "Aten��o" ) )
    
    Private cCadastro     := cTitle
    
    BEGIN SEQUENCE
    
        fInfo(@aInfo,xFilial("SRA"))
        
        cTitle    := ( AllTrim( aInfo[03] ) + " " + cTitle )
            
        IF .NOT.( Type("dDataBase") == "D" )
            dDataBase := MsDate()    
        EndIF
        
        Private MV_PAR01 := AnoMes(dDataBase)

        aAdd( aPerg , Array( 9 ) )
        nPerg := Len( aPerg )
        
        aPerg[nPerg][1]    :=  1                                                    //[1] : 1 - MsGet
        aPerg[nPerg][2]    := "Compat�ncia (Ano/Mes)"                                //[2] : Descricao
        aPerg[nPerg][3]    := MV_PAR01                                                //[3] : String contendo o inicializador do campo
        aPerg[nPerg][4]    := "@R 9999/99"                                            //[4] : String contendo a Picture do campo
        aPerg[nPerg][5]    := "NaoVazio()"                                            //[5] : String contendo a validacao
        aPerg[nPerg][6]    := ""                                                    //[6] : Consulta F3
        aPerg[nPerg][7]    := ".T."                                                //[7] : String contendo a validacao When
        aPerg[nPerg][8]    := 7 + 100                                                //[8] : Tamanho do MsGet
        aPerg[nPerg][9]    := .T.                                                    //[9] : Flag .T./.F. Parametro Obrigatorio ?
        
        Private MV_PAR02 := CtoD("//")

        aAdd( aPerg , Array( 9 ) )
        nPerg := Len( aPerg )
        
        aPerg[nPerg][1]    :=  1                                                    //[1] : 1 - MsGet
        aPerg[nPerg][2]    := "Vencimento"                                            //[2] : Descricao
        aPerg[nPerg][3]    := MV_PAR02                                                //[3] : String contendo o inicializador do campo
        aPerg[nPerg][4]    := "@D"                                                    //[4] : String contendo a Picture do campo
        aPerg[nPerg][5]    := "NaoVazio()"                                            //[5] : String contendo a validacao
        aPerg[nPerg][6]    := ""                                                    //[6] : Consulta F3
        aPerg[nPerg][7]    := ".T."                                                //[7] : String contendo a validacao When
        aPerg[nPerg][8]    := 7 + 100                                                //[8] : Tamanho do MsGet
        aPerg[nPerg][9]    := .T.                                                    //[9] : Flag .T./.F. Parametro Obrigatorio ?

        Private MV_PAR03 := Space(GetSx3Cache("RA_MAT","X3_TAMANHO"))

        aAdd( aPerg , Array( 9 ) )
        nPerg := Len( aPerg )
        
        aPerg[nPerg][1]    :=  1                                                    //[1] : 1 - MsGet
        aPerg[nPerg][2]    := "Matricula"                                            //[2] : Descricao
        aPerg[nPerg][3]    := MV_PAR03                                                //[3] : String contendo o inicializador do campo
        aPerg[nPerg][4]    := "@D"                                                    //[4] : String contendo a Picture do campo
        aPerg[nPerg][5]    := "NaoVazio().and.ExistCpo('SRA',NIL,NIL,NIL,NIL,.F.)"    //[5] : String contendo a validacao
        aPerg[nPerg][6]    := "SRA"                                                //[6] : Consulta F3
        aPerg[nPerg][7]    := ".T."                                                //[7] : String contendo a validacao When
        aPerg[nPerg][8]    := GetSx3Cache("RA_MAT","X3_TAMANHO") + 100                //[8] : Tamanho do MsGet
        aPerg[nPerg][9]    := .T.                                                    //[9] : Flag .T./.F. Parametro Obrigatorio ?
    
        While .NOT.( lParamBox := ParamBox( @aPerg , "Informe a Compet�ncia (YYYY/MM)" , NIL , NIL , NIL , .T. ) )
            MV_PAR01 := AnoMes(dDataBase)
            MV_PAR02 := CtoD("//")
        End While

        Private aNotPrint    := Array(0) //Deverao ser sempre os ultimos campos na Estrutura da View
        
        aAdd( aNotPrint , "FIL" )
        
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
            btdnGR16Prt(@lIsBlind,@MV_PAR01,@cDescription)
        EndIF    
    
    END SEQUENCE
    
Return( .T. )

/*
    Programa    : u_btdnGR16.PRW
    Funcao        : btdnGR16Excel
    Autor        : Marinaldo de Jesus [http://www.blacktdn.com.br]
    Data        : 17/06/2013
    Descricao    : Gerar Informacoes em Excel
*/                          
Static Function btdnGR16Excel(lIsBlind,othis,oPanel,cTitle)

    Local aLastQuery
    Local cLastQuery
    Local cTCSqlError

    Local cAlias
    
    Local cYearMonth    := MV_PAR01
    Local cdVencimento    := DtoC(MV_PAR02)
    
    Local nQryCTotal    := 0
    
    Local bError          := { |e| oError := e , BREAK(e) }
    Local bErrorBlock    := ErrorBlock( bError )
    Local cError
    Local oError

    BEGIN SEQUENCE
    
        MsAguarde( { || cAlias := QueryView(@cYearMonth,@nQryCTotal,cdVencimento) } , "Obtendo dados no SGBD" , "Aguarde..." )
        
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
    Programa    : u_btdnGR16.PRW
    Funcao        : QueryView
    Autor        : Marinaldo de Jesus [http://www.blacktdn.com.br]
    Data        : 17/06/2013
    Descricao    : Obter View para Gerar Informacoes em Excel
*/                          
Static Function QueryView(cYearMonth,nQryCTotal,cdVencimento)

    Local aLastQuery
    Local cLastQuery
    Local cTCSqlError

    Local cAlias        := GetNextAlias()
    
    Local cLine
    Local cDrive

    Local cMat            := MV_PAR03
    
    Local cSQLPDPen        := ""
    Local cSQLReplace    := ""
    Local cSQLBcoAgen    := ""
    Local cSQLRepBcAg    := ""
    
    Local lUseSRD        := MsFile( "RC"+cEmpAnt+SUBSTR(cYearMonth,3) )
    
    Local lfh            := .F.
    Local nfh 
    Local nLine

    Local bError          := { |e| oError := e , BREAK(e) }
    Local bErrorBlock    := ErrorBlock( bError )
    Local cError
    Local oError

    nQryCTotal    := 0

    BEGIN SEQUENCE 
    
        BEGINSQL ALIAS cAlias
        
            %noparser%
    
           SELECT DISTINCT x.V_PENSAO FROM (
                    SELECT SRQ.RQ_VERBADT AS V_PENSAO
                    FROM %table:SRQ% SRQ
                        ,%table:SRV% SRV
                    WHERE SRQ.%notDel% 
                      AND SRV.%notDel%
                      AND SRQ.RQ_FILIAL=%xFilial:SRQ%
                      AND SRV.RV_FILIAL=%xFilial:SRV%
                      AND SRQ.RQ_VERBADT=SRV.RV_COD
                    UNION
                    SELECT SRQ.RQ_VERBFOL AS V_PENSAO
                    FROM %table:SRQ% SRQ
                        ,%table:SRV% SRV
                    WHERE SRQ.%notDel% 
                      AND SRV.%notDel%
                      AND SRQ.RQ_FILIAL=%xFilial:SRQ%
                      AND SRV.RV_FILIAL=%xFilial:SRV%
                      AND SRQ.RQ_VERBFOL=SRV.RV_COD
                    UNION
                    SELECT SRQ.RQ_VERBFER AS V_PENSAO
                    FROM %table:SRQ% SRQ
                        ,%table:SRV% SRV
                    WHERE SRQ.%notDel% 
                      AND SRV.%notDel%
                      AND SRQ.RQ_FILIAL=%xFilial:SRQ%
                      AND SRV.RV_FILIAL=%xFilial:SRV%
                      AND SRQ.RQ_VERBFER=SRV.RV_COD
                    UNION
                    SELECT SRQ.RQ_VERB131 AS V_PENSAO
                    FROM %table:SRQ% SRQ
                        ,%table:SRV% SRV
                    WHERE SRQ.%notDel% 
                      AND SRV.%notDel%
                      AND SRQ.RQ_FILIAL=%xFilial:SRQ% 
                      AND SRV.RV_FILIAL=%xFilial:SRV%
                      AND SRQ.RQ_VERB131=SRV.RV_COD
                    UNION
                    SELECT SRQ.RQ_VERB132 AS V_PENSAO
                    FROM %table:SRQ% SRQ
                        ,%table:SRV% SRV
                    WHERE SRQ.%notDel% 
                      AND SRV.%notDel%
                      AND SRQ.RQ_FILIAL=%xFilial:SRQ%
                      AND SRV.RV_FILIAL=%xFilial:SRV%
                      AND SRQ.RQ_VERBFER=SRV.RV_COD
                    UNION
                    SELECT SRQ.RQ_VERB131 AS V_PENSAO
                    FROM %table:SRQ% SRQ
                        ,%table:SRV% SRV
                    WHERE SRQ.%notDel% 
                      AND SRV.%notDel%
                      AND SRQ.RQ_FILIAL=%xFilial:SRQ%
                      AND SRV.RV_FILIAL=%xFilial:SRV%
                      AND SRQ.RQ_VERB131=SRV.RV_COD
                    UNION
                    SELECT SRQ.RQ_VERBDFE AS V_PENSAO
                    FROM %table:SRQ% SRQ
                        ,%table:SRV% SRV
                    WHERE SRQ.%notDel% 
                      AND SRV.%notDel%
                      AND SRQ.RQ_FILIAL=%xFilial:SRQ%
                      AND SRV.RV_FILIAL=%xFilial:SRV%
                      AND SRQ.RQ_VERBDFE=SRV.RV_COD
                    UNION
                    SELECT SRQ.RQ_VERBRRA AS V_PENSAO
                    FROM %table:SRQ% SRQ
                        ,%table:SRV% SRV
                    WHERE SRQ.%notDel% 
                      AND SRV.%notDel%
                      AND SRQ.RQ_FILIAL=%xFilial:SRQ%
                      AND SRV.RV_FILIAL=%xFilial:SRV%
                      AND SRQ.RQ_VERBRRA=SRV.RV_COD
                    UNION
                    SELECT SRV.RV_COD AS V_PENSAO
                    FROM %table:SRV% SRV
                    WHERE SRV.%notDel%
                      AND SRV.RV_FILIAL=%xFilial:SRV% 
                      AND SRV.RV_CODFOL='056'
              ) AS x

        ENDSQL
        
        aLastQuery    := GetLastQuery()
        cLastQuery    := aLastQuery[2]
    
        While (cAlias)->( .NOT.( Eof() ) )            
            ++nQryCTotal
            (cAlias)->( dbSkip() )
        End While

        (cAlias)->( dbGoTop() )
        
        nLine := 0
        
        While (cAlias)->( .NOT.( Eof() ) )
            cSQLPDPen += "'"+(cAlias)->V_PENSAO+"'"
            IF ( ++nLine < nQryCTotal )
                cSQLPDPen += ","
            EndIF
            (cAlias)->( dbSkip() )
        End While
                
        (cAlias)->( dbCloseArea() )
        
        IF Empty(cSQLPDPen)
            cSQLPDPen := "'@@@'"
        EndIF
        
        cSQLPDPen := "%"+cSQLPDPen+"%"
        
        cSQLReplace := "(REPLACE(SRA.RA_CC,' ','')+'/'+CTT.CTT_DESC01)"
        cSQLReplace := "%"+cSQLReplace+"%"
        
        cSQLBcoAgen    := "'Banco/Agencia/Conta: ' + SubString(y.NUMERO_CONTROLE,1,3)+'/'+SubString(y.NUMERO_CONTROLE,4,5)+'/'+SubString(y.NUMERO_CONTROLE,9,12)+' '+ISNULL(SA6.A6_NREDUZ,'')"
        cSQLBcoAgen := "%"+cSQLBcoAgen+"%"
        
        cSQLRepBcAg    := "SubString(Replace(y.NUMERO_CONTROLE,'/',''),1,8)"
        cSQLRepBcAg    := "%"+cSQLRepBcAg+"%"
        
        IF ( lUseSRD )

            BEGINSQL ALIAS cAlias
            
                COLUMN VALOR AS NUMERIC(15,2)
            
                %noparser%
            
                SELECT
                         y.CODIGO
                        ,y.FUNCIONARIO
                        ,y.ID
                        ,y.FORNECEDOR
                        ,y.COMPET
                        ,y.VENCIMENTO
                        ,%exp:cSQLBcoAgen% AS NUMERO_CONTROLE
                        ,y.VALOR
                           ,y.EMBARCACOES
                           ,y.CODIGO_SAP
                           ,y.FIL
                FROM
                (
                    SELECT
                         SRA.RA_FILIAL                         AS FIL
                        ,SRA.RA_MAT                             AS CODIGO
                        ,SRA.RA_NOME                         AS FUNCIONARIO
                        ,SRQ.RQ_ORDEM                        AS ID
                        ,SRQ.RQ_NOME                         AS FORNECEDOR
                        ,SRD.RD_DATARQ                         AS COMPET
                        ,%exp:cdVencimento%                     AS VENCIMENTO
                        ,(SRQ.RQ_BCDEPBE+SRQ.RQ_CTDEPBE)    AS NUMERO_CONTROLE
                        ,SUM(SRD.RD_VALOR)                     AS VALOR
                           ,%exp:cSQLReplace%                    AS EMBARCACOES
                           ,SRQ.RQ_XCODSAP                        AS CODIGO_SAP
                    FROM
                          %table:SRA% SRA
                         ,%table:SRQ% SRQ
                         ,%table:SRD% SRD
                         ,%table:CTT% CTT
                    WHERE SRA.%notDel%
                      AND SRA.RA_FILIAL=%xFilial:SRA%
                      AND SRA.RA_MAT=%exp:cMat%
                      AND SRA.RA_FILIAL=SRQ.RQ_FILIAL
                      AND SRA.RA_MAT=SRQ.RQ_MAT
                      AND SRQ.%notDel% 
                      AND SRQ.RQ_SEQUENC='01'
                      AND SRA.RA_FILIAL=SRD.RD_FILIAL
                      AND SRA.RA_MAT=SRD.RD_MAT
                      AND SRD.%notDel% 
                      AND SRD.RD_PD IN ( %exp:cSQLPDPen% )
                      AND SRD.RD_DATARQ=%exp:cYearMonth%
                      AND CTT.%notDel%
                      AND CTT.CTT_FILIAL=%xFilial:CTT%
                      AND SRA.RA_CC=CTT.CTT_CUSTO
                      AND (
                               SRD.RD_PD=SRQ.RQ_VERBADT
                               OR
                               SRD.RD_PD=SRQ.RQ_VERBFOL
                               OR
                               SRD.RD_PD=SRQ.RQ_VERBFER
                               OR
                               SRD.RD_PD=SRQ.RQ_VERB131
                               OR
                               SRD.RD_PD=RQ_VERB132
                               OR
                               SRD.RD_PD=RQ_VERBPLR
                               OR
                               SRD.RD_PD=RQ_VERBDFE
                               OR
                               SRD.RD_PD=RQ_VERBRRA
                         )
                    AND EXISTS (
                                       SELECT 
                                           DISTINCT 1
                                       FROM
                                           %table:SRR% SRR
                                       WHERE SRR.%notDel%
                                         AND SRR.RR_FILIAL=SRA.RA_FILIAL
                                         AND SRR.RR_MAT=SRA.RA_MAT
                                         AND SRR.RR_PD IN ( %exp:cSQLPDPen% )
                                         AND SRR.RR_TIPO3='R'
                       )
                    GROUP BY
                         SRA.RA_FILIAL
                        ,SRA.RA_MAT
                        ,SRA.RA_NOME
                        ,SRQ.RQ_ORDEM
                        ,SRQ.RQ_NOME
                        ,SRD.RD_DATARQ
                        ,SRQ.RQ_BCDEPBE
                        ,SRQ.RQ_CTDEPBE
                        ,SRA.RA_CC
                        ,CTT.CTT_DESC01
                        ,SRQ.RQ_XCODSAP
                ) AS y
                LEFT JOIN %table:SA6% SA6
                     ON  SA6.A6_FILIAL BETWEEN ' ' AND 'Z' 
                     AND SA6.A6_COD+A6_AGENCIA=%exp:cSQLRepBcAg%
                     AND SA6.%notDel% 
                WHERE y.VALOR > 0
                ORDER BY 
                    y.FIL
                   ,y.CODIGO
                   ,y.ID
                   ,y.FORNECEDOR
            ENDSQL      
            
        ELSE
        
            BEGINSQL ALIAS cAlias
            
                COLUMN VALOR AS NUMERIC(15,2)
            
                %noparser%
            
                SELECT
                         y.FIL
                        ,y.CODIGO
                        ,y.FUNCIONARIO
                        ,y.ID
                        ,y.FORNECEDOR
                        ,y.COMPET
                        ,y.VENCIMENTO
                        ,%exp:cSQLBcoAgen% AS NUMERO_CONTROLE
                        ,y.VALOR
                           ,y.EMBARCACOES
                           ,y.CODIGO_SAP
                FROM
                (
                    SELECT
                         SRA.RA_FILIAL                         AS FIL
                        ,SRA.RA_MAT                             AS CODIGO
                        ,SRA.RA_NOME                         AS FUNCIONARIO
                        ,SRQ.RQ_ORDEM                        AS ID
                        ,SRQ.RQ_NOME                         AS FORNECEDOR
                        ,%exp:cYearMonth%                     AS COMPET
                        ,%exp:cdVencimento%                     AS VENCIMENTO
                        ,(SRQ.RQ_BCDEPBE+SRQ.RQ_CTDEPBE)    AS NUMERO_CONTROLE
                        ,SUM(SRR.RR_VALOR)                     AS VALOR
                           ,%exp:cSQLReplace%                    AS EMBARCACOES
                           ,SRQ.RQ_XCODSAP                        AS CODIGO_SAP
                    FROM
                          %table:SRA% SRA
                         ,%table:SRQ% SRQ
                         ,%table:SRR% SRR
                         ,%table:CTT% CTT
                    WHERE SRA.%notDel%
                      AND SRA.RA_FILIAL=%xFilial:SRA%
                      AND SRA.RA_MAT=%exp:cMat%
                      AND SRA.RA_FILIAL=SRQ.RQ_FILIAL
                      AND SRA.RA_MAT=SRQ.RQ_MAT
                      AND SRQ.%notDel% 
                      AND SRQ.RQ_SEQUENC='01'
                      AND SRA.RA_FILIAL=SRR.RR_FILIAL
                      AND SRA.RA_MAT=SRR.RR_MAT
                      AND SRR.%notDel% 
                      AND SRR.RR_PD IN ( %exp:cSQLPDPen% ) 
                      AND SRR.RR_TIPO3='R'
                       AND CTT.%notDel%
                      AND CTT.CTT_FILIAL=%xFilial:CTT%
                      AND SRA.RA_CC=CTT.CTT_CUSTO
                      AND (
                               SRR.RR_PD=SRQ.RQ_VERBADT
                               OR
                               SRR.RR_PD=SRQ.RQ_VERBFOL
                               OR
                               SRR.RR_PD=SRQ.RQ_VERBFER
                               OR
                               SRR.RR_PD=SRQ.RQ_VERB131
                               OR
                               SRR.RR_PD=RQ_VERB132
                               OR
                               SRR.RR_PD=RQ_VERBPLR
                               OR
                               SRR.RR_PD=RQ_VERBDFE
                               OR
                               SRR.RR_PD=RQ_VERBRRA
                       )        
                    GROUP BY
                         SRA.RA_FILIAL
                        ,SRA.RA_MAT
                        ,SRA.RA_NOME
                        ,SRQ.RQ_ORDEM
                        ,SRQ.RQ_NOME
                        ,SRQ.RQ_BCDEPBE
                        ,SRQ.RQ_CTDEPBE
                        ,SRA.RA_CC
                        ,CTT.CTT_DESC01
                        ,SRQ.RQ_XCODSAP
                ) AS y
                LEFT JOIN %table:SA6% SA6
                     ON  SA6.A6_FILIAL BETWEEN ' ' AND 'Z' 
                     AND SA6.A6_COD+A6_AGENCIA=%exp:cSQLRepBcAg%
                     AND SA6.%notDel% 
                WHERE y.VALOR > 0
                ORDER BY 
                    y.FIL
                   ,y.CODIGO
                   ,y.ID
                   ,y.FORNECEDOR
            ENDSQL 
        
        ENDIF    
    
        aLastQuery    := GetLastQuery()
        cLastQuery    := aLastQuery[2]
                
        IF ( ( Select( cAlias ) == 0 ) .or. (cAlias)->( Bof() .and. Eof() ) )
            UserException( "NO TABLE/VIEW DATA" )
        EndIF            
       
        SplitPath(GetTempPath(),@cDrive)

        MakeDir(cDrive+"\gerador\")
        nfh     := fCreate(cDrive+"\gerador\"+cEmpAnt+"_Pagamento_a_Pensionistas_Rescisao_"+cYearMonth+".txt")
        lfh        := ( nfh <> -1 )
        
        cLine    := ""
        nLine    := 0

        While (cAlias)->( .NOT.( Eof() ) )
            
            ++nQryCTotal
            
            cLine := StrZero(++nLine,5)
            cLine += __cTabC
            cLine += "00001"
            cLine += __cTabC
            cLine += Day2Str(Last_Day(cYearMonth+"01"))+"."+SubStr(cYearMonth,-2)+"."+SubStr(cYearMonth,1,4)
            cLine += __cTabC
            cLine += Day2Str(CtoD(cdVencimento))+"."+Month2Str(CtoD(cdVencimento))+"."+Year2Str(CtoD(cdVencimento))
            cLine += __cTabC                             
            cLine += "KR"
            cLine += __cTabC
            cLine += SubStr(cYearMonth,-2)
            cLine += __cTabC
            cLine += "BP"+IF((cEmpAnt=="01"),"01",IF((cEmpAnt=="03"),"02","00"))
            cLine += __cTabC
            cLine += "BRL"
            cLine += __cTabC
            cLine += (cAlias)->( AllTrim( EMBARCACOES ) )
            cLine += __cTabC
            cLine += "40"
            cLine += __cTabC
            cLine += "214203"
            cLine += __cTabC
            cLine += (cAlias)->( AllTrim( Transform( VALOR , "@E 999,999,999.99" ) ) )
            cLine += __cTabC
            cLine += __cTabC
            cLine += __cTabC
            cLine += __cTabC
            cLine +=  "PENSAO ALIMENTICIA RESCISAO: " + Transform( cYearMonth , "@E 9999/99")
            cLine +=  "-"
            cLine += (cAlias)->(FORNECEDOR)
            cLine += __cTabC
            cLine += __cCRLF
            
            IF ( lfh )
                fWrite(nfh,cLine)
            EndIF    

            cLine := StrZero(++nLine,5)
            cLine += __cTabC
            cLine += "00001"
            cLine += __cTabC
            cLine += Day2Str(Last_Day(cYearMonth+"01"))+"."+SubStr(cYearMonth,-2)+"."+SubStr(cYearMonth,1,4)
            cLine += __cTabC
            cLine += Day2Str(CtoD(cdVencimento))+"."+Month2Str(CtoD(cdVencimento))+"."+Year2Str(CtoD(cdVencimento))
            cLine += __cTabC
            cLine += "KR"
            cLine += __cTabC
            cLine += SubStr(cYearMonth,-2)
            cLine += __cTabC
            cLine += "BP"+IF((cEmpAnt=="01"),"01",IF((cEmpAnt=="03"),"02","00"))
            cLine += __cTabC
            cLine += "BRL"
            cLine += __cTabC
            cLine += (cAlias)->( AllTrim( EMBARCACOES ) )
            cLine += __cTabC
            cLine += "31"
            cLine += __cTabC
            cLine += "212000"
            cLine += __cTabC
            cLine += (cAlias)->( AllTrim( Transform( VALOR , "@E 999,999,999.99" ) ) )
            cLine += __cTabC
            cLine += __cTabC
            cLine += __cTabC
            cLine += __cTabC
            cLine +=  "PENSAO ALIMENTICIA RESCISAO: " + Transform( cYearMonth , "@E 9999/99")
            cLine +=  "-"
            cLine += (cAlias)->(FORNECEDOR)
            cLine += __cTabC
            cLine += (cAlias)->CODIGO_SAP
            cLine += __cCRLF

            IF ( lfh )
                fWrite(nfh,cLine)
            EndIF    
    
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

    IF ( lfh )
        fClose(nfh)
    EndIF    

Return( cAlias  )

/*
    Programa    : u_btdnGR16.PRW
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
    
    Local nFBreak        := (cAlias)->( FieldPos( "FIL" ) )
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

    DEFAULT cWorkSheet    := "btdnGR16"
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
                    IF ( cColumn == "COMPET" )
                        cColumn := "COMPETENCIA"
                    EndIF
                    IF ( cColumn == "FIL" )
                        cColumn := "FILIAL"
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
    Programa    : u_btdnGR16.PRW
    Fun��o        : btdnGR16Prt
    Autor        : Marinaldo de Jesus [http://www.blacktdn.com.br]
    Data        : 17/06/2013
    Descri��o    : Impressao do Relatorio.
*/
Static Function btdnGR16Prt(lIsBlind,cYearMonth,cDescription)

    Local lSetCentury    := __SetCentury( "ON" ) 

    Local aNiveis        := Array(1)
    Local bGetView        := { || aNiveis[nNivel] := QueryView(@cYearMonth,@nQryCTotal,@cdVencimento) }
    Local bReportPrint    := { || RunReport(@lIsBlind,@aNiveis,@nNiveis) }
    
    Local cCRLF            := CRLF
    Local cdVencimento    := DtoC(MV_PAR02)

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
    Programa    : u_btdnGR16.PRW
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
    Programa    : u_btdnGR16.PRW
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

    Local cQField        := "FIL"
    Local cTField        := "VALOR"

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
                
                IF ( "EMBARCACOES" $ aFields[nField][DBS_NAME] )
                       aFields[nField][DBS_LEN] := 30    
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
    
            aAdd( aCabec1 , { 0 , { || "Filial: " + ( cAlias )->(FieldGet(nQField)) } , 100 } )
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
