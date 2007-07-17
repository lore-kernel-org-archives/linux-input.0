From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: [PATCH 1/3] leds-clevo-mail: export i8042_command()
Date: Tue, 17 Jul 2007 12:18:19 +0200
Message-ID: <469C976B.3030206@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757774AbXGQKSp@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Rodrigo Pereira <rodripe@gmail.com>
List-Id: linux-input@vger.kernel.org

=46rom: M=E1rton N=E9meth <nm127@freemail.hu>

Export the i8042_command() function which manages the mutual exclusion
with the help of the i8042_lock spinlock. This lets possible to use the
i8042 hardware safely from other part of the kernel, too.

Signed-off-by: M=E1rton N=E9meth <nm127@freemail.hu>
---
diff -uprN linux-2.6.22.orig/drivers/input/serio/i8042.c linux-2.6.22/d=
rivers/input/serio/i8042.c
--- linux-2.6.22.orig/drivers/input/serio/i8042.c	2007-07-09 01:32:17.0=
00000000 +0200
+++ linux-2.6.22/drivers/input/serio/i8042.c	2007-07-16 20:53:38.000000=
000 +0200
@@ -208,7 +208,7 @@ static int __i8042_command(unsigned char
  	return 0;
  }

-static int i8042_command(unsigned char *param, int command)
+int i8042_command(unsigned char *param, int command)
  {
  	unsigned long flags;
  	int retval;
@@ -219,6 +219,7 @@ static int i8042_command(unsigned char *

  	return retval;
  }
+EXPORT_SYMBOL(i8042_command);

  /*
   * i8042_kbd_write() sends a byte out through the keyboard interface.
diff -uprN linux-2.6.22.orig/include/linux/i8042.h linux-2.6.22/include=
/linux/i8042.h
--- linux-2.6.22.orig/include/linux/i8042.h	1970-01-01 01:00:00.0000000=
00 +0100
+++ linux-2.6.22/include/linux/i8042.h	2007-07-16 21:00:54.000000000 +0=
200
@@ -0,0 +1,10 @@
+
+/* There is already a header file linux/drivers/input/serio/i8042.h, s=
o
+ * using the _LINUX prefix here as this is the <linux/i8042.h> file.
+ */
+#ifndef _LINUX_I8042_H
+#define _LINUX_I8402_H
+
+int i8042_command(unsigned char *param, int command);
+
+#endif
