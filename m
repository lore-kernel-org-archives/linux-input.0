From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: [PATCH BlueZ 3/4] Link to udev only when needed
Date: Fri,  5 Aug 2011 16:09:17 +0200
Message-ID: <1312553358-26280-4-git-send-email-ospite@studenti.unina.it>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312553358-26280-1-git-send-email-ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jim Paris <jim-XrPbb/hENzg@public.gmane.org>, Ranulf Doswell <ralf-fD3LYpizeBGsTnJN9+BGXg@public.gmane.org>, "Pascal A . Brisset" <pascal44973-dXI0m6hRz7k@public.gmane.org>, Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Birchinger <joker-vQrvfurPyUjk1uMJSBkQmQ@public.gmane.org>, Filipe Lopes <falktx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Mikko Virkkila <virkkila-/1wQRMveznE@public.gmane.org>, Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>, Arc Riley <arcriley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Don't link bluetoothd to udev unconditionally, but only when it is
needed. For now bluetoothd needs to be linked to udev only when the
sixaxis plugin is enabled.
---
 Makefile.am |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index dbe0170..219ca0f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -288,7 +288,11 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/event.h src/event.c \
 			src/oob.h src/oob.c src/eir.h src/eir.c
 src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
-							@CAPNG_LIBS@ @UDEV_LIBS@ -ldl -lrt
+							@CAPNG_LIBS@ -ldl -lrt
+if SIXAXISPLUGIN
+src_bluetoothd_LDADD += @UDEV_LIBS@
+endif
+
 src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
-- 
1.7.5.4
