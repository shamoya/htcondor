# Microsoft Developer Studio Generated NMAKE File, Based on condor_status.dsp
!IF "$(CFG)" == ""
CFG=condor_status - Win32 Debug
!MESSAGE No configuration specified. Defaulting to condor_status - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "condor_status - Win32 Release" && "$(CFG)" !=\
 "condor_status - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "condor_status.mak" CFG="condor_status - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "condor_status - Win32 Release" (based on\
 "Win32 (x86) Console Application")
!MESSAGE "condor_status - Win32 Debug" (based on\
 "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "condor_status - Win32 Release"

OUTDIR=.\..\src\condor_status.V6
INTDIR=.\..\src\condor_status.V6
# Begin Custom Macros
OutDir=.\..\src\condor_status.V6
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\condor_status.exe"

!ELSE 

ALL : "condor_io - Win32 Release" "condor_classad - Win32 Release"\
 "condor_cpp_util - Win32 Release" "condor_util_lib - Win32 Release"\
 "$(OUTDIR)\condor_status.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"condor_util_lib - Win32 ReleaseCLEAN"\
 "condor_cpp_util - Win32 ReleaseCLEAN" "condor_classad - Win32 ReleaseCLEAN"\
 "condor_io - Win32 ReleaseCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\prettyPrint.obj"
	-@erase "$(INTDIR)\setflags.obj"
	-@erase "$(INTDIR)\status.obj"
	-@erase "$(INTDIR)\totals.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\condor_status.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /MT /W3 /GX /O2 /I "..\src\h" /I "..\src\condor_includes" /I\
 "..\src\condor_c++_util" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS"\
 /Fp"..\src\condor_c++_util/condor_common.pch" /Yu"condor_common.h"\
 /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /TP /c 
CPP_OBJS=..\src\condor_status.V6/
CPP_SBRS=.

.c{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

RSC=rc.exe
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\condor_status.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=ws2_32.lib kernel32.lib user32.lib gdi32.lib winspool.lib\
 comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib\
 odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)\condor_status.pdb" /machine:I386\
 /out:"$(OUTDIR)\condor_status.exe" 
LINK32_OBJS= \
	"$(INTDIR)\prettyPrint.obj" \
	"$(INTDIR)\setflags.obj" \
	"$(INTDIR)\status.obj" \
	"$(INTDIR)\totals.obj" \
	"..\src\condor_c++_util\condor_cpp_util.lib" \
	"..\src\condor_classad\condor_classad.lib" \
	"..\src\condor_io\condor_io.lib" \
	"..\src\condor_util_lib\condor_util.lib"

"$(OUTDIR)\condor_status.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "condor_status - Win32 Debug"

OUTDIR=.\..\src\condor_status.V6
INTDIR=.\..\src\condor_status.V6
# Begin Custom Macros
OutDir=.\..\src\condor_status.V6
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\condor_status.exe" "$(OUTDIR)\condor_status.bsc"

!ELSE 

ALL : "condor_io - Win32 Debug" "condor_classad - Win32 Debug"\
 "condor_cpp_util - Win32 Debug" "condor_util_lib - Win32 Debug"\
 "$(OUTDIR)\condor_status.exe" "$(OUTDIR)\condor_status.bsc"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"condor_util_lib - Win32 DebugCLEAN"\
 "condor_cpp_util - Win32 DebugCLEAN" "condor_classad - Win32 DebugCLEAN"\
 "condor_io - Win32 DebugCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\prettyPrint.obj"
	-@erase "$(INTDIR)\prettyPrint.sbr"
	-@erase "$(INTDIR)\setflags.obj"
	-@erase "$(INTDIR)\setflags.sbr"
	-@erase "$(INTDIR)\status.obj"
	-@erase "$(INTDIR)\status.sbr"
	-@erase "$(INTDIR)\totals.obj"
	-@erase "$(INTDIR)\totals.sbr"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(OUTDIR)\condor_status.bsc"
	-@erase "$(OUTDIR)\condor_status.exe"
	-@erase "$(OUTDIR)\condor_status.ilk"
	-@erase "$(OUTDIR)\condor_status.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /MTd /W3 /GX /Z7 /Od /I "..\src\h" /I "..\src\condor_includes"\
 /I "..\src\condor_c++_util" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS"\
 /FR"$(INTDIR)\\" /Fp"..\src\condor_c++_util/condor_common.pch"\
 /Yu"condor_common.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /TP /c 
CPP_OBJS=..\src\condor_status.V6/
CPP_SBRS=..\src\condor_status.V6/

.c{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

RSC=rc.exe
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\condor_status.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\prettyPrint.sbr" \
	"$(INTDIR)\setflags.sbr" \
	"$(INTDIR)\status.sbr" \
	"$(INTDIR)\totals.sbr"

"$(OUTDIR)\condor_status.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib ws2_32.lib ../src/condor_c++_util/condor_common.obj\
 ..\src\condor_util_lib/condor_common.obj /nologo /subsystem:console\
 /incremental:yes /pdb:"$(OUTDIR)\condor_status.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)\condor_status.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\prettyPrint.obj" \
	"$(INTDIR)\setflags.obj" \
	"$(INTDIR)\status.obj" \
	"$(INTDIR)\totals.obj" \
	"..\src\condor_c++_util\condor_cpp_util.lib" \
	"..\src\condor_classad\condor_classad.lib" \
	"..\src\condor_io\condor_io.lib" \
	"..\src\condor_util_lib\condor_util.lib"

"$(OUTDIR)\condor_status.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(CFG)" == "condor_status - Win32 Release" || "$(CFG)" ==\
 "condor_status - Win32 Debug"

!IF  "$(CFG)" == "condor_status - Win32 Release"

"condor_util_lib - Win32 Release" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F .\condor_util_lib.mak\
 CFG="condor_util_lib - Win32 Release" 
   cd "."

"condor_util_lib - Win32 ReleaseCLEAN" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\condor_util_lib.mak\
 CFG="condor_util_lib - Win32 Release" RECURSE=1 
   cd "."

!ELSEIF  "$(CFG)" == "condor_status - Win32 Debug"

"condor_util_lib - Win32 Debug" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F .\condor_util_lib.mak\
 CFG="condor_util_lib - Win32 Debug" 
   cd "."

"condor_util_lib - Win32 DebugCLEAN" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\condor_util_lib.mak\
 CFG="condor_util_lib - Win32 Debug" RECURSE=1 
   cd "."

!ENDIF 

!IF  "$(CFG)" == "condor_status - Win32 Release"

"condor_cpp_util - Win32 Release" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F .\condor_cpp_util.mak\
 CFG="condor_cpp_util - Win32 Release" 
   cd "."

"condor_cpp_util - Win32 ReleaseCLEAN" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\condor_cpp_util.mak\
 CFG="condor_cpp_util - Win32 Release" RECURSE=1 
   cd "."

!ELSEIF  "$(CFG)" == "condor_status - Win32 Debug"

"condor_cpp_util - Win32 Debug" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F .\condor_cpp_util.mak\
 CFG="condor_cpp_util - Win32 Debug" 
   cd "."

"condor_cpp_util - Win32 DebugCLEAN" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\condor_cpp_util.mak\
 CFG="condor_cpp_util - Win32 Debug" RECURSE=1 
   cd "."

!ENDIF 

!IF  "$(CFG)" == "condor_status - Win32 Release"

"condor_classad - Win32 Release" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F .\condor_classad.mak\
 CFG="condor_classad - Win32 Release" 
   cd "."

"condor_classad - Win32 ReleaseCLEAN" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\condor_classad.mak\
 CFG="condor_classad - Win32 Release" RECURSE=1 
   cd "."

!ELSEIF  "$(CFG)" == "condor_status - Win32 Debug"

"condor_classad - Win32 Debug" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F .\condor_classad.mak\
 CFG="condor_classad - Win32 Debug" 
   cd "."

"condor_classad - Win32 DebugCLEAN" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\condor_classad.mak\
 CFG="condor_classad - Win32 Debug" RECURSE=1 
   cd "."

!ENDIF 

!IF  "$(CFG)" == "condor_status - Win32 Release"

"condor_io - Win32 Release" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F .\condor_io.mak CFG="condor_io - Win32 Release" 
   cd "."

"condor_io - Win32 ReleaseCLEAN" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\condor_io.mak\
 CFG="condor_io - Win32 Release" RECURSE=1 
   cd "."

!ELSEIF  "$(CFG)" == "condor_status - Win32 Debug"

"condor_io - Win32 Debug" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F .\condor_io.mak CFG="condor_io - Win32 Debug" 
   cd "."

"condor_io - Win32 DebugCLEAN" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) CLEAN /F .\condor_io.mak CFG="condor_io - Win32 Debug"\
 RECURSE=1 
   cd "."

!ENDIF 

SOURCE=..\src\condor_status.V6\prettyPrint.C
DEP_CPP_PRETT=\
	"..\src\condor_c++_util\condor_api.h"\
	"..\src\condor_c++_util\format_time.h"\
	"..\src\condor_includes\condor_attributes.h"\
	"..\src\condor_includes\condor_collector.h"\
	"..\src\condor_includes\condor_network.h"\
	"..\src\condor_status.V6\status_types.h"\
	"..\src\condor_status.V6\totals.h"\
	"..\src\h\file_lock.h"\
	"..\src\h\sched.h"\
	"..\src\h\startup.h"\
	{$(INCLUDE)}"ad_printmask.h"\
	{$(INCLUDE)}"condor_ast.h"\
	{$(INCLUDE)}"condor_astbase.h"\
	{$(INCLUDE)}"condor_attrlist.h"\
	{$(INCLUDE)}"condor_classad.h"\
	{$(INCLUDE)}"condor_commands.h"\
	{$(INCLUDE)}"condor_common.h"\
	{$(INCLUDE)}"condor_constants.h"\
	{$(INCLUDE)}"condor_event.h"\
	{$(INCLUDE)}"condor_exprtype.h"\
	{$(INCLUDE)}"condor_file_lock.h"\
	{$(INCLUDE)}"condor_fix_assert.h"\
	{$(INCLUDE)}"condor_fix_string.h"\
	{$(INCLUDE)}"condor_header_features.h"\
	{$(INCLUDE)}"condor_hpux_64bit_types.h"\
	{$(INCLUDE)}"condor_macros.h"\
	{$(INCLUDE)}"condor_q.h"\
	{$(INCLUDE)}"condor_query.h"\
	{$(INCLUDE)}"condor_sys_dux.h"\
	{$(INCLUDE)}"condor_sys_hpux.h"\
	{$(INCLUDE)}"condor_sys_irix.h"\
	{$(INCLUDE)}"condor_sys_linux.h"\
	{$(INCLUDE)}"condor_sys_nt.h"\
	{$(INCLUDE)}"condor_sys_solaris.h"\
	{$(INCLUDE)}"condor_system.h"\
	{$(INCLUDE)}"fake_flock.h"\
	{$(INCLUDE)}"generic_query.h"\
	{$(INCLUDE)}"HashTable.h"\
	{$(INCLUDE)}"list.h"\
	{$(INCLUDE)}"MyString.h"\
	{$(INCLUDE)}"proc.h"\
	{$(INCLUDE)}"query_result_type.h"\
	{$(INCLUDE)}"simplelist.h"\
	{$(INCLUDE)}"stream.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"user_log.c++.h"\
	

!IF  "$(CFG)" == "condor_status - Win32 Release"


"$(INTDIR)\prettyPrint.obj" : $(SOURCE) $(DEP_CPP_PRETT) "$(INTDIR)"\
 "..\src\condor_c++_util\condor_common.pch"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "condor_status - Win32 Debug"


"$(INTDIR)\prettyPrint.obj"	"$(INTDIR)\prettyPrint.sbr" : $(SOURCE)\
 $(DEP_CPP_PRETT) "$(INTDIR)" "..\src\condor_c++_util\condor_common.pch"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\condor_status.V6\setflags.C
DEP_CPP_SETFL=\
	"..\src\condor_c++_util\condor_api.h"\
	"..\src\condor_includes\condor_attributes.h"\
	"..\src\condor_includes\condor_collector.h"\
	"..\src\condor_includes\condor_network.h"\
	"..\src\condor_status.V6\status_types.h"\
	"..\src\condor_status.V6\totals.h"\
	"..\src\h\file_lock.h"\
	"..\src\h\sched.h"\
	"..\src\h\startup.h"\
	{$(INCLUDE)}"ad_printmask.h"\
	{$(INCLUDE)}"condor_ast.h"\
	{$(INCLUDE)}"condor_astbase.h"\
	{$(INCLUDE)}"condor_attrlist.h"\
	{$(INCLUDE)}"condor_classad.h"\
	{$(INCLUDE)}"condor_commands.h"\
	{$(INCLUDE)}"condor_common.h"\
	{$(INCLUDE)}"condor_constants.h"\
	{$(INCLUDE)}"condor_event.h"\
	{$(INCLUDE)}"condor_exprtype.h"\
	{$(INCLUDE)}"condor_file_lock.h"\
	{$(INCLUDE)}"condor_fix_assert.h"\
	{$(INCLUDE)}"condor_fix_string.h"\
	{$(INCLUDE)}"condor_header_features.h"\
	{$(INCLUDE)}"condor_hpux_64bit_types.h"\
	{$(INCLUDE)}"condor_macros.h"\
	{$(INCLUDE)}"condor_q.h"\
	{$(INCLUDE)}"condor_query.h"\
	{$(INCLUDE)}"condor_sys_dux.h"\
	{$(INCLUDE)}"condor_sys_hpux.h"\
	{$(INCLUDE)}"condor_sys_irix.h"\
	{$(INCLUDE)}"condor_sys_linux.h"\
	{$(INCLUDE)}"condor_sys_nt.h"\
	{$(INCLUDE)}"condor_sys_solaris.h"\
	{$(INCLUDE)}"condor_system.h"\
	{$(INCLUDE)}"fake_flock.h"\
	{$(INCLUDE)}"generic_query.h"\
	{$(INCLUDE)}"HashTable.h"\
	{$(INCLUDE)}"list.h"\
	{$(INCLUDE)}"MyString.h"\
	{$(INCLUDE)}"proc.h"\
	{$(INCLUDE)}"query_result_type.h"\
	{$(INCLUDE)}"simplelist.h"\
	{$(INCLUDE)}"stream.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"user_log.c++.h"\
	

!IF  "$(CFG)" == "condor_status - Win32 Release"


"$(INTDIR)\setflags.obj" : $(SOURCE) $(DEP_CPP_SETFL) "$(INTDIR)"\
 "..\src\condor_c++_util\condor_common.pch"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "condor_status - Win32 Debug"


"$(INTDIR)\setflags.obj"	"$(INTDIR)\setflags.sbr" : $(SOURCE) $(DEP_CPP_SETFL)\
 "$(INTDIR)" "..\src\condor_c++_util\condor_common.pch"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\condor_status.V6\status.C
DEP_CPP_STATU=\
	"..\src\condor_c++_util\condor_api.h"\
	"..\src\condor_c++_util\extArray.h"\
	"..\src\condor_c++_util\get_daemon_addr.h"\
	"..\src\condor_includes\condor_attributes.h"\
	"..\src\condor_includes\condor_collector.h"\
	"..\src\condor_includes\condor_config.h"\
	"..\src\condor_includes\condor_debug.h"\
	"..\src\condor_includes\condor_network.h"\
	"..\src\condor_includes\condor_state.h"\
	"..\src\condor_status.V6\status_types.h"\
	"..\src\condor_status.V6\totals.h"\
	"..\src\h\file_lock.h"\
	"..\src\h\sched.h"\
	"..\src\h\sig_install.h"\
	"..\src\h\startup.h"\
	{$(INCLUDE)}"ad_printmask.h"\
	{$(INCLUDE)}"condor_ast.h"\
	{$(INCLUDE)}"condor_astbase.h"\
	{$(INCLUDE)}"condor_attrlist.h"\
	{$(INCLUDE)}"condor_classad.h"\
	{$(INCLUDE)}"condor_commands.h"\
	{$(INCLUDE)}"condor_common.h"\
	{$(INCLUDE)}"condor_constants.h"\
	{$(INCLUDE)}"condor_event.h"\
	{$(INCLUDE)}"condor_expressions.h"\
	{$(INCLUDE)}"condor_exprtype.h"\
	{$(INCLUDE)}"condor_file_lock.h"\
	{$(INCLUDE)}"condor_fix_assert.h"\
	{$(INCLUDE)}"condor_fix_string.h"\
	{$(INCLUDE)}"condor_header_features.h"\
	{$(INCLUDE)}"condor_hpux_64bit_types.h"\
	{$(INCLUDE)}"condor_macros.h"\
	{$(INCLUDE)}"condor_q.h"\
	{$(INCLUDE)}"condor_query.h"\
	{$(INCLUDE)}"condor_sys_dux.h"\
	{$(INCLUDE)}"condor_sys_hpux.h"\
	{$(INCLUDE)}"condor_sys_irix.h"\
	{$(INCLUDE)}"condor_sys_linux.h"\
	{$(INCLUDE)}"condor_sys_nt.h"\
	{$(INCLUDE)}"condor_sys_solaris.h"\
	{$(INCLUDE)}"condor_system.h"\
	{$(INCLUDE)}"daemon_types.h"\
	{$(INCLUDE)}"fake_flock.h"\
	{$(INCLUDE)}"generic_query.h"\
	{$(INCLUDE)}"HashTable.h"\
	{$(INCLUDE)}"list.h"\
	{$(INCLUDE)}"MyString.h"\
	{$(INCLUDE)}"proc.h"\
	{$(INCLUDE)}"query_result_type.h"\
	{$(INCLUDE)}"simplelist.h"\
	{$(INCLUDE)}"stream.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	{$(INCLUDE)}"user_log.c++.h"\
	

!IF  "$(CFG)" == "condor_status - Win32 Release"


"$(INTDIR)\status.obj" : $(SOURCE) $(DEP_CPP_STATU) "$(INTDIR)"\
 "..\src\condor_c++_util\condor_common.pch"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "condor_status - Win32 Debug"


"$(INTDIR)\status.obj"	"$(INTDIR)\status.sbr" : $(SOURCE) $(DEP_CPP_STATU)\
 "$(INTDIR)" "..\src\condor_c++_util\condor_common.pch"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\condor_status.V6\totals.C
DEP_CPP_TOTAL=\
	"..\src\condor_includes\condor_attributes.h"\
	"..\src\condor_includes\condor_network.h"\
	"..\src\condor_includes\condor_state.h"\
	"..\src\condor_status.V6\status_types.h"\
	"..\src\condor_status.V6\totals.h"\
	"..\src\h\file_lock.h"\
	"..\src\h\sched.h"\
	"..\src\h\startup.h"\
	{$(INCLUDE)}"condor_ast.h"\
	{$(INCLUDE)}"condor_astbase.h"\
	{$(INCLUDE)}"condor_attrlist.h"\
	{$(INCLUDE)}"condor_classad.h"\
	{$(INCLUDE)}"condor_commands.h"\
	{$(INCLUDE)}"condor_common.h"\
	{$(INCLUDE)}"condor_constants.h"\
	{$(INCLUDE)}"condor_exprtype.h"\
	{$(INCLUDE)}"condor_file_lock.h"\
	{$(INCLUDE)}"condor_fix_assert.h"\
	{$(INCLUDE)}"condor_fix_string.h"\
	{$(INCLUDE)}"condor_header_features.h"\
	{$(INCLUDE)}"condor_hpux_64bit_types.h"\
	{$(INCLUDE)}"condor_macros.h"\
	{$(INCLUDE)}"condor_sys_dux.h"\
	{$(INCLUDE)}"condor_sys_hpux.h"\
	{$(INCLUDE)}"condor_sys_irix.h"\
	{$(INCLUDE)}"condor_sys_linux.h"\
	{$(INCLUDE)}"condor_sys_nt.h"\
	{$(INCLUDE)}"condor_sys_solaris.h"\
	{$(INCLUDE)}"condor_system.h"\
	{$(INCLUDE)}"fake_flock.h"\
	{$(INCLUDE)}"HashTable.h"\
	{$(INCLUDE)}"MyString.h"\
	{$(INCLUDE)}"proc.h"\
	{$(INCLUDE)}"stream.h"\
	{$(INCLUDE)}"sys\stat.h"\
	{$(INCLUDE)}"sys\types.h"\
	

!IF  "$(CFG)" == "condor_status - Win32 Release"


"$(INTDIR)\totals.obj" : $(SOURCE) $(DEP_CPP_TOTAL) "$(INTDIR)"\
 "..\src\condor_c++_util\condor_common.pch"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "condor_status - Win32 Debug"


"$(INTDIR)\totals.obj"	"$(INTDIR)\totals.sbr" : $(SOURCE) $(DEP_CPP_TOTAL)\
 "$(INTDIR)" "..\src\condor_c++_util\condor_common.pch"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 


!ENDIF 

