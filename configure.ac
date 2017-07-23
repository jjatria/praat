AC_INIT([Praat], [6.0.29], [paul.boersma@uva.nl])
AM_INIT_AUTOMAKE([foreign])

AC_CANONICAL_HOST

dnl AC_ARG_VAR([bloob], [description])

dnl AC_CHECK_FUNCS([alarm])
dnl AC_CHECK_FUNCS([bzero])
dnl AC_CHECK_FUNCS([clock_gettime])
dnl AC_CHECK_FUNCS([fesetround])
dnl AC_CHECK_FUNCS([floor])
dnl AC_CHECK_FUNCS([getcwd])
dnl AC_CHECK_FUNCS([gethostbyname])
dnl AC_CHECK_FUNCS([gettimeofday])
dnl AC_CHECK_FUNCS([memchr])
dnl AC_CHECK_FUNCS([memmove])
dnl AC_CHECK_FUNCS([memset])
dnl AC_CHECK_FUNCS([mkdir])
dnl AC_CHECK_FUNCS([modf])
dnl AC_CHECK_FUNCS([pow])
dnl AC_CHECK_FUNCS([regcomp])
dnl AC_CHECK_FUNCS([select])
dnl AC_CHECK_FUNCS([setenv])
dnl AC_CHECK_FUNCS([setlocale])
dnl AC_CHECK_FUNCS([socket])
dnl AC_CHECK_FUNCS([sqrt])
dnl AC_CHECK_FUNCS([strchr])
dnl AC_CHECK_FUNCS([strdup])
dnl AC_CHECK_FUNCS([strerror])
dnl AC_CHECK_FUNCS([strrchr])
dnl AC_CHECK_FUNCS([strstr])
dnl AC_CHECK_FUNCS([strtol])
dnl AC_CHECK_FUNCS([strtoul])
dnl AC_CHECK_FUNCS([utime])
dnl AC_CHECK_HEADERS([arpa/inet.h])
dnl AC_CHECK_HEADERS([fcntl.h])
dnl AC_CHECK_HEADERS([fenv.h])
dnl AC_CHECK_HEADERS([float.h])
dnl AC_CHECK_HEADERS([inttypes.h])
dnl AC_CHECK_HEADERS([limits.h])
dnl AC_CHECK_HEADERS([locale.h])
dnl AC_CHECK_HEADERS([mach/mach.h])
dnl AC_CHECK_HEADERS([malloc.h])
dnl AC_CHECK_HEADERS([memory.h])
dnl AC_CHECK_HEADERS([netdb.h])
dnl AC_CHECK_HEADERS([netinet/in.h])
dnl AC_CHECK_HEADERS([stddef.h])
dnl AC_CHECK_HEADERS([stdint.h])
dnl AC_CHECK_HEADERS([stdlib.h])
dnl AC_CHECK_HEADERS([strings.h])
dnl AC_CHECK_HEADERS([sys/ioctl.h])
dnl AC_CHECK_HEADERS([sys/param.h])
dnl AC_CHECK_HEADERS([sys/socket.h])
dnl AC_CHECK_HEADERS([sys/time.h])
dnl AC_CHECK_HEADERS([unistd.h])
dnl AC_CHECK_HEADERS([utime.h])
dnl AC_CHECK_HEADERS([wchar.h])
dnl AC_CHECK_HEADERS([wctype.h])
dnl AC_CHECK_HEADER_STDBOOL
dnl AC_C_INLINE
dnl AC_C_RESTRICT

dnl Check for functions
dnl AC_FUNC_ALLOCA
dnl AC_FUNC_CHOWN
dnl AC_FUNC_ERROR_AT_LINE
dnl AC_FUNC_FORK
dnl AC_FUNC_FSEEKO
dnl AC_FUNC_MALLOC
dnl AC_FUNC_REALLOC
dnl AC_FUNC_STRTOD

dnl AC_CHECK_LIB([pulse], [pulseAudio_initialize])

AC_PREREQ
AC_PROG_CC
AC_PROG_CXX
AC_PROG_INSTALL
AC_PROG_RANLIB

dnl Check for types
dnl AC_TYPE_INT16_T
dnl AC_TYPE_INT32_T
dnl AC_TYPE_INT64_T
dnl AC_TYPE_INT8_T
dnl AC_TYPE_OFF_T
dnl AC_TYPE_PID_T
dnl AC_TYPE_SIZE_T
dnl AC_TYPE_SSIZE_T
dnl AC_TYPE_UINT16_T
dnl AC_TYPE_UINT32_T
dnl AC_TYPE_UINT64_T
dnl AC_TYPE_UINT8_T

dnl Disable graphics
AC_ARG_ENABLE([graphics],
    AS_HELP_STRING([--disable-graphics], [Disable GUI compilation]))

AS_IF([test "x$enable_graphics" == "xno"],
[
  dnl Do not do the stuff needed for enabling the feature
  echo ">>> DISABLE GRAPHICS <<<"
  AC_DEFINE([NO_GRAPHICS], [1], [Disable compilation of GUI])
])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
