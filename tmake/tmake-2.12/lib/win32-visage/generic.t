#!
#! This is a tmake template for building win32-visage applications.
#!
#$ $project{'OBJ_IMPL_OUT'} = '-Fo"$@" $<';
#$ $project{'TMAKE_LINK_CMD'} = '$(LINK) -B"$(LFLAGS)" $(OBJECTS) $(OBJMOC) $(LIBS) -Fe$(TARGET)';
#$ IncludeTemplate("../win32/generic.t");
