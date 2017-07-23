noinst_LIBRARIES = libkar.a

libkar_a_DEPENDENCIES = ipaSerifRegularPS.o longchar.o

ipaSerifRegularPS_o_SOURCES = kar/ipaSerifRegularPS.cpp kar/UnicodeData.h kar/longchar.h

longchar_o_SOURCES = kar/longchar.cpp kar/UnicodeData.h kar/longchar.h

libkar.a: ipaSerifRegularPS.o longchar.o
	echo "LIBKAR"
	touch kar/libkar.a
	rm kar/libkar.a
	$(AR) cq kar/libkar.a kar/ipaSerifRegularPS.o kar/longchar.o
	$(RANLIB) kar/libkar.a
