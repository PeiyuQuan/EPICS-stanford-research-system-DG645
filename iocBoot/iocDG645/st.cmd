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

drvAsynSerialPortConfigure("serial1", "/dev/ttyUSB0", 0, 0, 0)
asynOctetSetInputEos("serial1",0,"\r\n")
asynOctetSetOutputEos("serial1",0,"\r\n")
asynSetOption("serial1",0,"baud","19200")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
asynSetOption("serial1",0,"clocal","Y")
asynSetOption("serial1",0,"crtscts","Y")

dbLoadRecords("${TOP}/DG645App/Db/DG6451.db","P=$(PREFIX),PORT=serial1")
dbLoadRecords("${TOP}/DG645App/Db/DG6452.db","P=$(PREFIX),PORT=serial1,M=m1,N=1")
dbLoadRecords("${TOP}/DG645App/Db/DG6452.db","P=$(PREFIX),PORT=serial1,M=m2,N=2")
dbLoadRecords("${TOP}/DG645App/Db/DG6452.db","P=$(PREFIX),PORT=serial1,M=m3,N=3")
dbLoadRecords("${TOP}/DG645App/Db/DG6452.db","P=$(PREFIX),PORT=serial1,M=m4,N=4")
dbLoadRecords("${TOP}/DG645App/Db/DG6453.db","P=$(PREFIX),PORT=serial1,L=l0,N=0")
dbLoadRecords("${TOP}/DG645App/Db/DG6453.db","P=$(PREFIX),PORT=serial1,L=l1,N=1")
dbLoadRecords("${TOP}/DG645App/Db/DG6453.db","P=$(PREFIX),PORT=serial1,L=l2,N=2")
dbLoadRecords("${TOP}/DG645App/Db/DG6453.db","P=$(PREFIX),PORT=serial1,L=l3,N=3")
dbLoadRecords("${TOP}/DG645App/Db/DG6453.db","P=$(PREFIX),PORT=serial1,L=l4,N=4")
dbLoadRecords("${TOP}/DG645App/Db/DG6454.db","P=$(PREFIX),PORT=serial1,K=k2,N=2")
dbLoadRecords("${TOP}/DG645App/Db/DG6454.db","P=$(PREFIX),PORT=serial1,K=k3,N=3")
dbLoadRecords("${TOP}/DG645App/Db/DG6454.db","P=$(PREFIX),PORT=serial1,K=k4,N=4")
dbLoadRecords("${TOP}/DG645App/Db/DG6454.db","P=$(PREFIX),PORT=serial1,K=k5,N=5")
dbLoadRecords("${TOP}/DG645App/Db/DG6454.db","P=$(PREFIX),PORT=serial1,K=k6,N=6")
dbLoadRecords("${TOP}/DG645App/Db/DG6454.db","P=$(PREFIX),PORT=serial1,K=k7,N=7")
dbLoadRecords("${TOP}/DG645App/Db/DG6454.db","P=$(PREFIX),PORT=serial1,K=k8,N=8")
dbLoadRecords("${TOP}/DG645App/Db/DG6454.db","P=$(PREFIX),PORT=serial1,K=k9,N=9")
dbLoadRecords ("$(ASYN)/db/asynRecord.db", "P=$(PREFIX), R=asyn1, PORT=serial1, ADDR=0, IMAX=80, OMAX=80")
dbLoadRecords ("$(AUTOSAVE)/db/save_restoreStatus.db", "P=SLAC:DG645:")
iocInit

## Start any sequence programs
#seq sncExample, "user=quan"
