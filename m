From: Bruno =?iso-8859-1?q?Pr=E9mont?= <bonbons@linux-vserver.org>
Subject: [PATCH] Input: i8042 - move Dritek quirk so it also gets applied on resume
Date: Fri, 16 May 2008 22:08:26 +0200
Message-ID: <200805162208.27593.bonbons@linux-vserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [158.64.110.160] ([158.64.110.160]:49399 "EHLO
	bonbons.gotdns.org" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754226AbYEPUSz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 May 2008 16:18:55 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>

This patch moves the quirk from from i8042_probe() to i8042_enable_kbd_=
port()
which is also called during resume.

I think it is safe to ignore failure to enable dritek. I would also pre=
fer not=20
to fail complete keyboard initialisation if the extension fails.

---
The Dritek quirk is also required on resume from S2RAM, doing it only a=
t probe
time is not sufficient.


Signed-off-by: Bruno Pr=E9mont <bonbons@linux-vserver.org>
CC: Dmitry Torokhov <dtor@mail.ru>

diff -NurpP linux-2.6.25.4-orig/drivers/input/serio/i8042.c=20
linux-2.6.25.4/drivers/input/serio/i8042.c
--- linux-2.6.25.4-orig/drivers/input/serio/i8042.c	2008-04-17=20
04:49:44.000000000 +0200
+++ linux-2.6.25.4/drivers/input/serio/i8042.c	2008-05-16 21:37:12.0000=
00000=20
+0200
@@ -404,6 +404,15 @@ static int i8042_enable_kbd_port(void)
 		printk(KERN_ERR "i8042.c: Failed to enable KBD port.\n");
 		return -EIO;
 	}
+#ifdef CONFIG_X86
+	if (i8042_dritek) {
+		char param =3D 0x90;
+		int error =3D i8042_command(&param, 0x1059);
+		if (error)
+			printk(KERN_WARNING "Failed to enable DRITEK "
+			       "extension: %d\n", error);
+	}
+#endif
=20
 	return 0;
 }
@@ -1171,14 +1179,6 @@ static int __devinit i8042_probe(struct=20
 		if (error)
 			goto out_fail;
 	}
-#ifdef CONFIG_X86
-	if (i8042_dritek) {
-		char param =3D 0x90;
-		error =3D i8042_command(&param, 0x1059);
-		if (error)
-			goto out_fail;
-	}
-#endif
 /*
  * Ok, everything is ready, let's register all serio ports
  */

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
