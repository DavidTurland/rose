##### http://autoconf-archive.cryp.to/ax_boost_process.html
#
# SYNOPSIS
#
#   AX_BOOST_PROCESS
#
# DESCRIPTION
#
#   Test for the Boost.Process library. The macro requires a preceding
#   call to AX_BOOST_BASE.
#
#   This macro calls:
#
#     AC_SUBST(BOOST_PROCESS_LIB)
#
#   And sets:
#
#     HAVE_BOOST_PROCESS
#
AC_DEFUN([AX_BOOST_PROCESS],
[
  AC_BEFORE([$0], [AX_BOOST_FILESYSTEM])

  AC_ARG_WITH([boost-process],
    AS_HELP_STRING([--with-boost-process@<:@=special-lib@:>@],
      [use the Process library from boost - it is possible to specify a certain library for the linker
           e.g. --with-boost-process=boost_process-gcc-mt]),
    [
      if test "$withval" = "no"; then
        want_boost="no"
      elif test "$withval" = "yes"; then
        want_boost="yes"
        ax_boost_user_process_lib=""
      else
        want_boost="yes"
        ax_boost_user_process_lib="$withval"
      fi
    ],
    [want_boost="yes"]
  )

  if test "x$want_boost" = "xyes"; then
    AC_REQUIRE([AC_PROG_CC])
    AC_REQUIRE([AC_CANONICAL_BUILD])
    CPPFLAGS_SAVED="$CPPFLAGS"
    CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
    export CPPFLAGS

    LDFLAGS_SAVED="$LDFLAGS"
    LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
    export LDFLAGS

    AC_CACHE_CHECK(whether the Boost::Process library is available,
      ax_cv_boost_process,
      [AC_LANG_PUSH([C++])
       CXXFLAGS_SAVE=$CXXFLAGS

       AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[@%:@include <boost/process/v1/child.hpp>]],
         [[boost::process::v1::child child;]])],
         ax_cv_boost_process=yes, ax_cv_boost_process=no)
       CXXFLAGS=$CXXFLAGS_SAVE
       AC_LANG_POP([C++])
      ])

    if test "x$ax_cv_boost_process" = "xyes"; then
      AC_SUBST(BOOST_CPPFLAGS)
      AC_DEFINE(HAVE_BOOST_PROCESS,,[define if the Boost::Process library is available])
      BOOSTLIBDIR=`echo $BOOST_LDFLAGS | sed -e 's/[^\/]*//'`

      LDFLAGS_SAVE=$LDFLAGS
      if test "x$ax_boost_user_process_lib" = "x"; then
        for libextension in `ls $BOOSTLIBDIR/libboost_process*.{so,dylib,a}* 2>/dev/null | sed 's,.*/,,' | sed -e 's;^lib\(boost_process.*\)\.so.*$;\1;' -e 's;^lib\(boost_process.*\)\.a*$;\1;' -e 's;^lib\(boost_process.*\)\.dylib$;\1;'` ; do
          ax_lib=${libextension}
          AC_CHECK_LIB($ax_lib, toupper,
            [BOOST_PROCESS_LIB="-l$ax_lib"; AC_SUBST(BOOST_PROCESS_LIB) link_process="yes"; break],
            [link_process="no"])
        done
        if test "x$link_process" != "xyes"; then
          for libextension in `ls $BOOSTLIBDIR/boost_process*.{dll,a}* 2>/dev/null | sed 's,.*/,,' | sed -e 's;^\(boost_process.*\)\.dll.*$;\1;' -e 's;^\(boost_process.*\)\.a*$;\1;'` ; do
            ax_lib=${libextension}
            AC_CHECK_LIB($ax_lib, toupper,
              [BOOST_PROCESS_LIB="-l$ax_lib"; AC_SUBST(BOOST_PROCESS_LIB) link_process="yes"; break],
              [link_process="no"])
          done
        fi
      else
        for ax_lib in $ax_boost_user_process_lib boost_process-$ax_boost_user_process_lib; do
          AC_CHECK_LIB($ax_lib, toupper,
            [BOOST_PROCESS_LIB="-l$ax_lib"; AC_SUBST(BOOST_PROCESS_LIB) link_process="yes"; break],
            [link_process="no"])
        done
      fi
      if test "x$link_process" = "xno"; then
        AC_MSG_ERROR([could not link against "$ax_lib"])
      fi
    fi
    CPPFLAGS="$CPPFLAGS_SAVED"
    LDFLAGS="$LDFLAGS_SAVED"
  fi
])
