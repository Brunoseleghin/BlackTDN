#include "ndj.ch"
//------------------------------------------------------------------------------------------------
    /*/
        CLASS:tNDJTimeCalc
        Autor:Marinaldo de Jesus [BlackTDN:(http://www.blacktdn.com.br/)]
        Data:23/12/2013
        Descricao:Calculo de Horas
        Sintaxe:tNDJTimeCalc():New()->Objeto do Tipo TimeCalc
    /*/
//------------------------------------------------------------------------------------------------
Class tNDJTimeCalc From LongClassName
    DATA cClassName
    Method New() CONSTRUCTOR
    Method ClassName()    
    Method HMSToTime(nHours,nMinuts,nSeconds)
    Method SecsToHMS(nSecsToHMS,nHours,nMinuts,nSeconds,cRet)
    Method SecsToTime(nSecs)
    Method TimeToSecs(cTime)
    Method SecsToHrs(nSeconds)
    Method HrsToSecs(nHours)
    Method SecsToMin(nSeconds)
    Method MinToSecs(nMinuts)
    Method IncTime(cTime,nIncHours,nIncMinuts,nIncSeconds)
    Method DecTime(cTime,nDecHours,nDecMinuts,nDecSeconds)
    Method Time2NextDay(cTime,dDate)
    Method ExtractTime(cTime,nHours,nMinutes,nSeconds,cRet)
    Method AverageTime(cTime,nDividendo,lMiliSecs)
EndClass

Method New() Class tNDJTimeCalc
    self:ClassName()
Return(self)

Method ClassName() Class tNDJTimeCalc
    self:cClassName:="TNDJTIMECALC"
Return(self:cClassName)

Method HMSToTime(nHours,nMinuts,nSeconds) Class tNDJTimeCalc

    Local cTime
    
    DEFAULT nHours:=0
    DEFAULT nMinuts:=0
    DEFAULT nSeconds:=0
    
    cTime:=AllTrim(Str(nHours))
    cTime:=StrZero(Val(cTime),Max(Len(cTime),2))
    cTime+=":"
    cTime+=StrZero(Val(AllTrim(Str(nMinuts))),2)
    cTime+=":"
    cTime+=StrZero(Val(AllTrim(Str(nSeconds))),2)

Return(cTime)

Method SecsToHMS(nSecsToHMS,nHours,nMinuts,nSeconds,cRet) Class tNDJTimeCalc

    Local nRet:=0
    
    DEFAULT nSecsToHMS:=0
    DEFAULT cRet:="H"
    
    nHours:=self:SecsToHrs(nSecsToHMS)
    nMinuts:=self:SecsToMin(nSecsToHMS)
    nSeconds:=(self:HrsToSecs(nHours)+self:MinToSecs(nMinuts))
    nSeconds:=(nSecsToHMS-nSeconds)
    nSeconds:=Int(nSeconds)
    nSeconds:=Mod(nSeconds,60)
    
    IF (cRet$"Hh")
        nRet:=nHours
    ElseIF (cRet$"Mm")
        nRet:=nMinuts
    ElseIF (cRet$"Ss")
        nRet:=nSeconds
    EndIF

Return(nRet)

Method SecsToTime(nSecs) Class tNDJTimeCalc
    Local nHours
    Local nMinuts
    Local nSeconds
    self:SecsToHMS(nSecs,@nHours,@nMinuts,@nSeconds)
Return(self:HMSToTime(nHours,nMinuts,nSeconds))

Method TimeToSecs(cTime) Class tNDJTimeCalc

    Local nHours
    Local nMinuts
    Local nSeconds
    
    DEFAULT cTime:="00:00:00"
    
    self:ExtractTime(cTime,@nHours,@nMinuts,@nSeconds)
    
    nMinuts+=__Hrs2Min(nHours)
    nSeconds+=(nMinuts*60)

Return(nSeconds)

Method SecsToHrs(nSeconds) Class tNDJTimeCalc
    Local nHours
    nHours:=(nSeconds/3600)
    nHours:=Int(nHours)
Return(nHours)

Method HrsToSecs(nHours) Class tNDJTimeCalc
Return((nHours*3600))

Method SecsToMin(nSeconds) Class tNDJTimeCalc
    Local nMinuts
    nMinuts:=(nSeconds/60)
    nMinuts:=Int(nMinuts)
    nMinuts:=Mod(nMinuts,60)
Return(nMinuts)

Method MinToSecs(nMinuts) Class tNDJTimeCalc
Return((nMinuts*60))

Method IncTime(cTime,nIncHours,nIncMinuts,nIncSeconds) Class tNDJTimeCalc

    Local nSeconds
    Local nMinuts
    Local nHours
    
    DEFAULT nIncHours:=0
    DEFAULT nIncMinuts:=0
    DEFAULT nIncSeconds:=0
    
    self:ExtractTime(cTime,@nHours,@nMinuts,@nSeconds)
    
    nHours+=nIncHours
    nMinuts+=nIncMinuts
    nSeconds+=nIncSeconds
    nSeconds:=(self:HrsToSecs(nHours)+self:MinToSecs(nMinuts)+nSeconds)
    
Return(self:SecsToTime(nSeconds))

Method DecTime(cTime,nDecHours,nDecMinuts,nDecSeconds) Class tNDJTimeCalc

    Local nSeconds
    Local nMinuts
    Local nHours
    
    DEFAULT nDecHours:=0
    DEFAULT nDecMinuts:=0
    DEFAULT nDecSeconds:=0
    
    self:ExtractTime(cTime,@nHours,@nMinuts,@nSeconds)
    
    nHours-=nDecHours
    nMinuts-=nDecMinuts
    nSeconds-=nDecSeconds
    nSeconds:=(self:HrsToSecs(nHours)+self:MinToSecs(nMinuts)+nSeconds)
    
Return(self:SecsToTime(nSeconds))

Method Time2NextDay(cTime,dDate) Class tNDJTimeCalc
    While (Val(cTime)>=24)
        cTime:=self:DecTime(cTime,24)
        ++dDate
    End While
Return({cTime,dDate})

Method ExtractTime(cTime,nHours,nMinutes,nSeconds,cRet) Class tNDJTimeCalc

    Local nRet:=0
    
    Local nAT
    
    DEFAULT cTime:="00:00:00"
    DEFAULT cRet:="H"
    
    nAT:=AT(":",cTime)
    
    IF (nAT==0)
        nHours:=Val(cTime)
        nMinutes:=0
        nSeconds:=0
    Else
        nHours:=Val(SubStr(cTime,1,nAT-1))
        cTime:=SubStr(cTime,nAT+1)
        nAT:=(At(":",cTime))
        IF (nAT==0)
            nMinutes:=Val(cTime)
            nSeconds:=0
        Else
            nMinutes:=Val(SubStr(cTime,1,nAT-1))
            nSeconds:=Val(SubStr(cTime,nAT+1))
        EndIF
    EndIF
    
    IF (cRet$"Hh")
        nRet:=nHours
    ElseIF (cRet$"Mm")
        nRet:=nMinutes
    ElseIF (cRet$"Ss")
        nRet:=nSeconds
    EndIF

Return(nRet)

Method AverageTime(cTime,nDividendo,lMiliSecs) Class tNDJTimeCalc

    Local cAverageTime:="00:00:00:000"
    
    Local nSeconds
    Local nAverageTime
    Local nMiliSecs
    
    DEFAULT nDividendo:=0
    
    IF (nDividendo>0)
    
        nSeconds:=self:TimeToSecs(cTime)
        nSeconds:=(nSeconds/nDividendo)
        nAverageTime:=Int(nSeconds)
    
        nMiliSecs:=(nSeconds-nAverageTime)
        nMiliSecs*=1000
        nMiliSecs:=Int(nMiliSecs)
    
        cAverageTime:=self:SecsToTime(nAverageTime)

    EndIF
    
    DEFAULT lMiliSecs:=.T.
    IF (lMiliSecs)
        DEFAULT nMiliSecs:=0
         cAverageTime+=(":"+StrZero(nMiliSecs,IF(nMiliSecs>999,4,3)))
    EndIF

Return(cAverageTime)

//------------------------------------------------------------------------------------------------
    /*/
        CLASS:tNDJRemaining
        Autor:Marinaldo de Jesus [BlackTDN:(http://www.blacktdn.com.br/)]
        Data:23/12/2013
        Descricao:Calculo de Tempo Remanescente
        Sintaxe:tNDJRemaining():New()->Objeto do Tipo Remaining
    /*/
//------------------------------------------------------------------------------------------------
Class tNDJRemaining From tNDJTimeCalc
    
    DATA cAverageTime   AS CHARACTER INIT "00:00:00:000" HIDDEN
    DATA cEndTime       AS CHARACTER INIT "00:00:00"     HIDDEN
    DATA cStartTime     AS CHARACTER INIT "00:00:00"     HIDDEN
    DATA cTimeDiff      AS CHARACTER INIT "00:00:00"     HIDDEN
    DATA cTRemaining    AS CHARACTER INIT "00:00:00"     HIDDEN
    DATA dEndTime       AS DATE      INIT Ctod("//")     HIDDEN
    DATA dStartTime     AS DATE      INIT Ctod("//")     HIDDEN
    DATA nProgress      AS NUMERIC   INIT 0              HIDDEN    
    DATA nSRemaining    AS NUMERIC   INIT 0              HIDDEN
    DATA nTotal         AS NUMERIC   INIT 0              HIDDEN

    //-------------------------------------------------------------------
        // EXPORTED:Instancia um novo objeto
    //-------------------------------------------------------------------    
    Method New(nTotal) CONSTRUCTOR
    
    //-------------------------------------------------------------------
        // EXPORTED:Retorna o Nome da Classe
    //-------------------------------------------------------------------
    Method ClassName()

    //-------------------------------------------------------------------
        // EXPORTED:Seta novo Total para Calcule()
    //-------------------------------------------------------------------
    Method SetRemaining(nTotal)

    //-------------------------------------------------------------------
        // EXPORTED:Para Obter os Tempos utilize o Metodo Calcule
    //-------------------------------------------------------------------
    Method Calcule(lProgress)

    //-------------------------------------------------------------------
        // EXPORTED:Retorna os Valores das Propriedades
    //-------------------------------------------------------------------
    Method GetcAverageTime()
    Method GetcEndTime()
    Method GetcStartTime()
    Method GetcTimeDiff()
    Method GetcTRemaining()
    Method GetdEndTime()
    Method GetdStartTime()
    Method GetnProgress()
    Method GetnSRemaining()
    Method GetnTotal()
    
ENDClass

Method New(nTotal) Class tNDJRemaining
    _Super:New()
    self:SetRemaining(@nTotal)
Return(self)

Method ClassName() Class tNDJRemaining
Return("TNDJREMAINING")

Method SetRemaining(nTotal) Class tNDJRemaining
    DEFAULT nTotal:=1
    self:cAverageTime:="00:00:00:000"
    self:cEndTime:="00:00:00"
    self:cStartTime:=Time()
    self:cTimeDiff:="00:00:00"
    self:cTRemaining:="00:00:00"
    self:dEndTime:=CToD("//")
    self:dStartTime:=Date()
    self:nProgress:=0
    self:nSRemaining:=0
    self:nTotal:=nTotal
Return(self)

Method Calcule(lProgress) Class tNDJRemaining

    Local aEndTime

    Local cTime:=Time()
    Local dDate:=Date()

    Local nIncTime:=0
    
    Local nTime
    Local nTimeEnd
    Local nTimeDiff
    Local nStartTime

    IF .NOT.(dDate==Self:dStartTime)
        nIncTime:=abs(dDate-self:dStartTime)
        nIncTime*=24
    EndIF    

    nTime:=(self:TimeToSecs(cTime)+IF(nIncTime>0,self:HrsToSecs(nIncTime),0))
    nStartTime:=self:TimeToSecs(self:cStartTime)    

    nTimeDiff:=abs(nTime-nStartTime)
    self:cTimeDiff:=self:SecsToTime(nTimeDiff)
    self:cTRemaining:=self:SecsToTime(abs(nTimeDiff-nStartTime))
    self:nSRemaining:=nTimeDiff

    DEFAULT lProgress:=.T.
    IF (lProgress)
        ++self:nProgress
    EndIF

    self:cAverageTime:=self:AverageTime(self:cTimeDiff,self:nProgress,.T.)

    IF self:nTotal<self:nProgress
        nTimeEnd:=self:nTotal
        self:nTotal:=self:nProgress
        self:nProgress:=nTimeEnd
    EndIF
    nTimeEnd:=(((self:nTotal-self:nProgress)*self:nSRemaining)/self:nProgress)
    self:cEndTime:=self:SecsToTime(nTimeEnd)
    self:cEndTime:=self:IncTime(cTime,NIL,NIL,self:TimeToSecs(self:cEndTime))
    aEndTime:=self:Time2NextDay(self:cEndTime,dDate)
    self:cEndTime:=aEndTime[1]
    self:dEndTime:=aEndTime[2]

Return(self)

Method GetcAverageTime() Class tNDJRemaining
Return(self:cAverageTime)

Method GetcEndTime() Class tNDJRemaining
Return(self:cEndTime)

Method GetcStartTime() Class tNDJRemaining
Return(self:cStartTime)

Method GetcTimeDiff() Class tNDJRemaining
Return(self:cTimeDiff)

Method GetcTRemaining() Class tNDJRemaining
Return(self:cTRemaining)

Method GetdEndTime() Class tNDJRemaining
Return(self:dEndTime)

Method GetdStartTime() Class tNDJRemaining
Return(self:dStartTime)

Method GetnProgress() Class tNDJRemaining
Return(self:nProgress)

Method GetnSRemaining() Class tNDJRemaining
Return(self:nSRemaining)

Method GetnTotal() Class tNDJRemaining
Return(self:nTotal)
