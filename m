From: Helge Deller <deller@gmx.de>
Subject: [PATCH] input/HIL drivers: add MODULE_ALIAS()
Date: Mon, 29 Dec 2008 13:17:25 +0100
Message-ID: <4958BFD5.3080403@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060600040009040903010106"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:49827 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753218AbYL2MRc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Dec 2008 07:17:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Linux/m68k <linux-m68k@vger.kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Frans Pop <elendil@planet.nl>

This is a multi-part message in MIME format.
--------------060600040009040903010106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

resending, as I forgot to CC: Geert and linux-m68k

-------- Original Message --------
Subject: [PATCH] input/HIL drivers: add MODULE_ALIAS()
Date: Fri, 26 Dec 2008 21:09:00 +0100
From: Helge Deller <deller@gmx.de>
To: linux-input@vger.kernel.org,  Dmitry Torokhov
<dmitry.torokhov@gmail.com>
CC: Helge Deller <deller@gmx.de>, Frans Pop <elendil@planet.nl>

Add MODULE_ALIAS() to the HIL keyboard (hil_kbd.c) and HIL mouse
(hil_ptr.c) drivers to make kernel module autoloader functional.
Report HIL port number ID in serio id.id field.

Signed-off-by: Helge Deller <deller@gmx.de>

 keyboard/hil_kbd.c |    1 +
 mouse/hil_ptr.c    |    2 +-
 serio/hil_mlc.c    |    1 +
 3 files changed, 3 insertions(+), 1 deletion(-)


--------------060600040009040903010106
Content-Type: text/x-patch;
 name="hil_drivers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hil_drivers.patch"

diff --git a/drivers/input/keyboard/hil_kbd.c b/drivers/input/keyboard/hil_kbd.c
index 71c1971..7d40c69 100644
--- a/drivers/input/keyboard/hil_kbd.c
+++ b/drivers/input/keyboard/hil_kbd.c
@@ -47,6 +47,7 @@
 MODULE_AUTHOR("Brian S. Julin <bri@calyx.com>");
 MODULE_DESCRIPTION(HIL_GENERIC_NAME " driver");
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS("serio:ty03pr25id00ex*");
 
 #define HIL_KBD_MAX_LENGTH 16
 
diff --git a/drivers/input/mouse/hil_ptr.c b/drivers/input/mouse/hil_ptr.c
index e532c48..0fd42e6 100644
--- a/drivers/input/mouse/hil_ptr.c
+++ b/drivers/input/mouse/hil_ptr.c
@@ -46,7 +46,7 @@
 MODULE_AUTHOR("Brian S. Julin <bri@calyx.com>");
 MODULE_DESCRIPTION(HIL_GENERIC_NAME " driver");
 MODULE_LICENSE("Dual BSD/GPL");
-
+MODULE_ALIAS("serio:ty03pr25id0Fex*");
 
 #define TABLET_SIMULATES_MOUSE	/* allow tablet to be used as mouse */
 #undef  TABLET_AUTOADJUST	/* auto-adjust valid tablet ranges */
diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index 37586a6..7ba9f2b 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -934,6 +934,7 @@ int hil_mlc_register(hil_mlc *mlc)
 		snprintf(mlc_serio->name, sizeof(mlc_serio->name)-1, "HIL_SERIO%d", i);
 		snprintf(mlc_serio->phys, sizeof(mlc_serio->phys)-1, "HIL%d", i);
 		mlc_serio->id			= hil_mlc_serio_id;
+		mlc_serio->id.id		= i; /* HIL port no. */
 		mlc_serio->write		= hil_mlc_serio_write;
 		mlc_serio->open			= hil_mlc_serio_open;
 		mlc_serio->close		= hil_mlc_serio_close;


--------------060600040009040903010106--
