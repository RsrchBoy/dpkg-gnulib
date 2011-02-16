# locale-ar.m4 serial 2
dnl Copyright (C) 2003, 2005-2011 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl From Ben Pfaff, based on locale-fr.m4 by Bruno Haible.

dnl Determine the name of an Arabic locale with traditional encoding.
AC_DEFUN([gt_LOCALE_AR],
[
  AC_REQUIRE([AC_CANONICAL_HOST])
  AC_REQUIRE([AM_LANGINFO_CODESET])
  AC_CACHE_CHECK([for a traditional Arabic locale], [gt_cv_locale_ar], [
    AC_LANG_CONFTEST([AC_LANG_SOURCE([
changequote(,)dnl
#include <locale.h>
#include <time.h>
#if HAVE_LANGINFO_CODESET
# include <langinfo.h>
#endif
#include <stdlib.h>
#include <string.h>
struct tm t;
char buf[16];
int main () {
  /* Check whether the given locale name is recognized by the system.  */
  if (setlocale (LC_ALL, "") == NULL) return 1;
  /* Check that nl_langinfo(CODESET) is nonempty and not "ASCII" or "646"
     and ends in "6". */
#if HAVE_LANGINFO_CODESET
  {
    const char *cs = nl_langinfo (CODESET);
    if (cs[0] == '\0' || strcmp (cs, "ASCII") == 0 || strcmp (cs, "646") == 0
        || cs[strlen (cs) - 1] != '6')
      return 1;
  }
#endif
#ifdef __CYGWIN__
  /* On Cygwin, avoid locale names without encoding suffix, because the
     locale_charset() function relies on the encoding suffix.  Note that
     LC_ALL is set on the command line.  */
  if (strchr (getenv ("LC_ALL"), '.') == NULL) return 1;
#endif
  return 0;
}
changequote([,])dnl
      ])])
    if AC_TRY_EVAL([ac_link]) && test -s conftest$ac_exeext; then
      # Setting LC_ALL is not enough. Need to set LC_TIME to empty, because
      # otherwise on MacOS X 10.3.5 the LC_TIME=C from the beginning of the
      # configure script would override the LC_ALL setting. Likewise for
      # LC_CTYPE, which is also set at the beginning of the configure script.
      # Values tested:
      #   - The usual locale name:                         ar_SA
      #   - The locale name with explicit encoding suffix: ar_SA.ISO-8859-6
      #   - The HP-UX locale name:                         ar_SA.iso88596
      #   - The Solaris 7 locale name:                     ar
      # Also try ar_EG instead of ar_SA because Egypt is a large country too.
      for gt_cv_locale_ar in ar_SA ar_SA.ISO-8859-6 ar_SA.iso88596 ar_EG ar_EG.ISO-8859-6 ar_EG.iso88596 ar none; do
        if test $gt_cv_locale_ar = none; then
          break
        fi
        if (LC_ALL=$gt_cv_locale_ar LC_TIME= LC_CTYPE= ./conftest; exit) 2>/dev/null; then
	  break
	fi
      done
    fi
    rm -fr conftest*
  ])
  LOCALE_AR=$gt_cv_locale_ar
  AC_SUBST([LOCALE_AR])
])
