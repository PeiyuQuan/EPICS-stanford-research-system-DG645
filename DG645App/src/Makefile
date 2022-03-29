TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += DG645Support

# Compile and add code to the support library
DG645Support_SRCS += xxxRecord.c
DG645Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
DG645Support_SRCS += dbSubExample.c
DG645Support_SRCS += devDG645Version.c
DG645Support_SRCS += DG645Hello.c
DG645Support_SRCS += initTrace.c

DG645Support_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = DG645Version.h
# Macro name
GENVERSIONMACRO = DG645VERSION

# Build the IOC application
PROD_IOC = DG645

# DG645.dbd will be created and installed
DBD += DG645.dbd

# DG645.dbd will include these files:
DG645_DBD += base.dbd
DG645_DBD += xxxSupport.dbd
DG645_DBD += dbSubExample.dbd
DG645_DBD += devDG645Version.dbd
DG645_DBD += DG645Hello.dbd
DG645_DBD += initTrace.dbd
DG645_DBD += asyn.dbd
DG645_DBD += drvAsynIPPort.dbd
DG645_DBD += drvAsynSerialPort.dbd
DG645_DBD += calc.dbd
DG645_DBD += stream-scalcout.dbd
DG645_DBD += stream.dbd
DG645_DBD += as.dbd
DG645_DBD += asSupport.dbd
# DG645_registerRecordDeviceDriver.cpp derives from DG645.dbd
DG645_SRCS += DG645_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
DG645_SRCS_DEFAULT += DG645Main.cpp
DG645_SRCS_vxWorks += -nil-

# Link in the code from our support library
DG645_LIBS += DG645Support
DG645_LIBS += asyn
DG645_LIBS += calc
DG645_LIBS += autosave
DG645_LIBS += stream
# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into DG645Support
    sncExample_SNCFLAGS += +r
    DG645_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    DG645Support_SRCS += sncExample.stt
    DG645Support_LIBS += seq pv
    DG645_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    DG645_LIBS += qsrv
    DG645_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    DG645_DBD += PVAServerRegister.dbd
    DG645_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
DG645_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devDG645Version$(DEP): $(COMMON_DIR)/$(GENVERSION)
