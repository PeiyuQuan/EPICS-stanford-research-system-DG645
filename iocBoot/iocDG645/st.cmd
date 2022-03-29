#!../../bin/linux-x86_64/DG645

#- You may have to change DG645 to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/DG645.dbd"
DG645_registerRecordDeviceDriver pdbbase

## Load record instances
epicsEnvSet ("STREAM_PROTOCOL_PATH", "${TOP}/DG645App/Db")
epicsEnvSet("PREFIX", "SLAC:DG645:")
epicsEnvSet("PORT", "serial1")

drvAsynIPPortConfigure("serial1", "192.168.0.10:4002<192.168.0.10:4002/> COM", 0, 0, 0)
asynOctetSetInputEos("serial1",0,"\r\n")
asynOctetSetOutputEos("serial1",0,"\r\n")
asynSetOption("serial1",0,"baud","19200")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
#asynSetOption("serial1",0,"clocal","N")
asynSetOption("serial1",0,"crtscts","Y")
asynSetTraceIOMask("serial1",0,ESCAPE)
asynSetTraceMask("serial1",0,DRIVER|ERROR|FLOW)


dbLoadRecords("${TOP}/DG645App/Db/DG645.db","P=$(PREFIX),PORT=serial1")
dbLoadRecords ("$(ASYN)/db/asynRecord.db", "P=$(PREFIX), R=asyn1, PORT=serial1, ADDR=0, IMAX=80, OMAX=80")
dbLoadRecords ("$(AUTOSAVE)/db/save_restoreStatus.db", "P=SLAC:DG645:")
iocInit

## Start any sequence programs
#seq sncExample, "user=quan"
