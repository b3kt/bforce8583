#${
   $project{'TMAKE_OUTEXT'} = ".dsp"; 
   if ( Config("staticlib") ) {
      $project{'TMAKE_BLD_CMD'} = $project{'TMAKE_LIB_CMD'}; }
   else {
      $project{'TMAKE_BLD_CMD'} = $project{'TMAKE_LINK_CMD'}; }


	$is_msvc5 = tmake_query_win32_registry("Software\\Microsoft\\DevStudio\\5.0");
   if ( $is_msvc5 ) {
	$project{"MSVCDSP_VER"} = "5.00";
    } else {
	$project{"MSVCDSP_VER"} = "6.00";
    }

if ( Config("dll") )
	{
	$project{"MSVCDSP_BINTYPE"} = "Dynamic-Link Library";
	$project{"MSVCDSP_DSPTYPE"} = "0x0102";
	}
else
	{
	$project{"MSVCDSP_BINTYPE"} = "Application";
	if ( Config("console") )
		{
		$project{'MSVCDSP_CONSOLE'}="Console ";
		$project{"MSVCDSP_DSPTYPE"} = "0x0103";
		}
	else
		{
		$project{"MSVCDSP_DSPTYPE"} = "0x0101";
		}
	}

if ( Config("moc") ) {
	$project{"SOURCES"} .= " " . $project{"SRCMOC"};
    }
    if ( $project{"SOURCES"} || $project{"RC_FILE"} ) {
	$project{"SOURCES"} .= " " . $project{"RC_FILE"};
	@files = split(/\s+/,$project{"SOURCES"}); $text = "";
	foreach ( @files ) {
	    $file = $_;
	    $text .= "# Begin Source File\n\nSOURCE=.\\$file\n";
	    if ( Config("moc") && ($file =~ /\.moc$/) ) {
		$build = "\n\n# Begin Custom Build - Moc'ing $moc_input{$file}...\n" .
			 "InputPath=.\\$file\n\n" .
			 '"' . $file .
			     '" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"' . "\n" .
			 "\t%QTDIR%\\bin\\moc.exe " . $moc_input{$file} . " -o $file\n\n" .
			 "# End Custom Build\n\n";
		$base = $file;
		$base =~ s/\..*//;
		$base =~ tr/a-z/A-Z/;
		$base =~ s/[^A-Z]/_/g;
		$text .= "USERDEP_$base=" . '"' . $moc_input{$file} . '"' .
			 "\n\n" . '!IF  "$(CFG)" == "' .
			 $project{"MSVCDSP_PROJECT"} . ' - Win32 Release"' .
			 $build . '!ELSEIF  "$(CFG)" == "' .
			 $project{"MSVCDSP_PROJECT"} . ' - Win32 Debug"' .
			 $build . "!ENDIF \n\n";
	    }
	    $text .= "# End Source File\n";
	}
	$project{"MSVCDSP_SOURCES"} = $text; $text = "";
    }
    if ( $project{"HEADERS"} ) {
	@files = split(/\s+/,$project{"HEADERS"}); $text = "";
	foreach ( @files ) {
	    $file = $_;
	    $text .= "# Begin Source File\n\nSOURCE=.\\$file\n";
	    if ( Config("moc") && $moc_output{$file} ) {
		$build = "\n\n# Begin Custom Build - Moc'ing $file...\n" .
			 "InputPath=.\\$file\n\n" .
			 '"' . $moc_output{$file} .
			     '" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"' . "\n" .
			 "\t%QTDIR%\\bin\\moc.exe $file -o " . $moc_output{$file} . "\n\n" .
			 "# End Custom Build\n\n";
		$text .= "\n" . '!IF  "$(CFG)" == "' .
			 $project{"MSVCDSP_PROJECT"} . ' - Win32 Release"' .
			 $build . '!ELSEIF  "$(CFG)" == "' .
			 $project{"MSVCDSP_PROJECT"} . ' - Win32 Debug"' .
			 $build . "!ENDIF \n\n";
	    }
	    $text .= "# End Source File\n";
	}
	$project{"MSVCDSP_HEADERS"} = $text; $text = "";
    }
    if ($project{"INTERFACES"} ) {
	$uicpath = Expand("TMAKE_UIC");
	$uicpath =~ s/[.]exe//g;
	$uicpath .= " ";
	@files = split(/\s+/,$project{"INTERFACES"}); $text = ""; $headtext = ""; $sourcetext = "";
	foreach ( @files ) {
	    $file = $_;
	    $filename = $file;
	    $filename =~ s/[.]ui//g;
	    $text .= "# Begin Source File\n\nSOURCE=.\\$file\n";

	    $build = "\n\n# Begin Custom Build - Uic'ing $file...\n" .
			"InputPath=.\\$file\n\n" .
			"BuildCmds= " . $uicpath . $file . 
			" -o " . $filename . ".h\\\n" .
			"\t" . $uicpath . $file .
			" -i " . $filename . ".h -o " . $filename . ".cpp\\\n" .
			"\t%QTDIR%\\bin\\moc " . $filename . ".h -o " . $project{"MOC_DIR"} . "moc_" . $filename . ".cpp \\\n\n" .
			'"' . $filename . '.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"' . "\n" .
			"\t\$(BuildCmds)\n\n" .
			'"' . $filename . '.cpp" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"' . "\n" .
			"\t\$(BuildCmds)\n\n" .
			'"' . $project{"MOC_DIR"} . 'moc_' . $filename . '.cpp" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"' . "\n" .
			"\t\$(BuildCmds)\n\n" .
		"# End Custom Build\n\n";

	    $text .= '!IF  "$(CFG)" == "' . 
		    $project{"MSVCDSP_PROJECT"} . ' - Win32 Release"' . $build . 
			'!ELSEIF  "$(CFG)" == "' .
		    $project{"MSVCDSP_PROJECT"} . ' - Win32 Debug"' . $build .
		"!ENDIF \n\n";

	    $text .= "# End Source File\n";

		$sourcetext .= "# Begin Source File\n\nSOURCE=.\\" . $filename . ".cpp\n# End Source File\n";
		$headtext .= "# Begin Source File\n\nSOURCE=.\\" . $filename . ".h\n# End Source File\n";

	}
	$project{"MSVCDSP_INTERFACES"} = $text; $text = "";
	$project{"MSVCDSP_INTERFACESOURCES"} = $sourcetext; $sourcetext = "";
	$project{"MSVCDSP_INTERFACEHEADERS"} = $headtext; $headtext = "";
}
	$project{'MSVCDSP_ADDCPP'} = $project{'TMAKE_CXXFLAGS'}.' '.$project{'TMAKE_INCPATH'};
#$}
# Microsoft Developer Studio Project File - Name="#$ Expand('__TARGET'); $text .= '" - Package Owner=<4>';
# Microsoft Developer Studio Generated Build File, Format Version #$ Expand('MSVCDSP_VER');
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) #$ Expand('MSVCDSP_CONSOLE'); $text .= $project{'MSVCDSP_BINTYPE'}.'" '.$project{'MSVCDSP_DSPTYPE'};

CFG=#$ Expand('__TARGET'); $text .= ' - Win32 Debug';
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "#$ Expand('__TARGET'); $text .= '.mak".';
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "#$ Expand('__TARGET'); $text .= '.mak" CFG="'.$project{'__TARGET'}.' - Win32 Debug"';
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "#$ Expand('__TARGET'); $text .= ' - Win32 Release" (based on "Win32 (x86) '.$project{'MSVCDSP_BINTYPE'}.'")';
!MESSAGE "#$ Expand('__TARGET'); $text .= ' - Win32 Debug" (based on "Win32 (x86) '.$project{'MSVCDSP_BINTYPE'}.'")';
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=#$ Expand("TMAKE_CXX");
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "#$ Expand('__TARGET'); $text .= ' - Win32 Release"';

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir ""
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir ""
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP #$ Expand('MSVCDSP_ADDCPP');
# ADD CPP #$ Expand('MSVCDSP_ADDCPP');
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=#$ Expand("TMAKE_LINK");
# ADD BASE LINK32 #$ Expand("TMAKE_LIBDIR_FLAGS"); Expand("TMAKE_LIBS"); Expand("TMAKE_LFLAGS");
# ADD LINK32 #$ Expand("TMAKE_LIBDIR_FLAGS"); Expand("TMAKE_LIBS"); Expand("TMAKE_LFLAGS");

!ELSEIF  "$(CFG)" == "#$ Expand('__TARGET'); $text .= ' - Win32 Debug"';

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir ""
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir ""
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP #$ Expand('MSVCDSP_ADDCPP');
# ADD CPP #$ Expand('MSVCDSP_ADDCPP');
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 #$ Expand("TMAKE_LIBDIR_FLAGS"); Expand("TMAKE_LIBS"); Expand("TMAKE_LFLAGS");
# ADD LINK32 #$ Expand("TMAKE_LIBDIR_FLAGS"); Expand("TMAKE_LIBS"); Expand("TMAKE_LFLAGS");

!ENDIF 

# Begin Target

# Name "#$ Expand('__TARGET'); $text .= ' - Win32 Release"';
# Name "#$ Expand('__TARGET'); $text .= ' - Win32 Debug"';
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
#$ Expand('MSVCDSP_SOURCES');
#$ Expand('MSVCDSP_INTERFACESOURCES');
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
#$ Expand('MSVCDSP_HEADERS');
#$ Expand('MSVCDSP_INTERFACEHEADERS');
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# Begin Group "Interfaces"
#$ Expand('MSVCDSP_INTERFACES');
# Prop Default_Filter "ui"
# End Group
# End Target
# End Project
