From: =?utf-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
Subject: [PATCH 1/2] Input: usbtouchscreen - add support for ET&T TC4UM touchscreen controller
Date: Fri, 11 Jun 2010 09:40:53 +0200
Message-ID: <1276242054-11127-1-git-send-email-ynezz@true.cz>
References: <20100603075720.GQ26052@ibawizard.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:53039 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab0FKHtL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jun 2010 03:49:11 -0400
In-Reply-To: <20100603075720.GQ26052@ibawizard.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@novell.com>, ynezz@true.cz

This patch adds support for the ET&T TC4UM 4-wire USB touchscreen contr=
oller
and tries to reuse the bits for TC5UH controller in kernel already. Dat=
a
interface is same.

Tested-by: Roger Pueyo Centelles <rogerpueyo@rogerpueyo.com>
Signed-off-by: Petr =C5=A0tetiar <ynezz@true.cz>
---
 drivers/input/touchscreen/Kconfig          |    4 ++--
 drivers/input/touchscreen/usbtouchscreen.c |   21 ++++++++++++--------=
-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
index 3b9d5e2..e835f04 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -540,9 +540,9 @@ config TOUCHSCREEN_USB_ZYTRONIC
 	bool "Zytronic controller" if EMBEDDED
 	depends on TOUCHSCREEN_USB_COMPOSITE
=20
-config TOUCHSCREEN_USB_ETT_TC5UH
+config TOUCHSCREEN_USB_ETT_TC45USB
 	default y
-	bool "ET&T TC5UH touchscreen controler support" if EMBEDDED
+	bool "ET&T USB series TC4UM/TC5UH touchscreen controler support" if E=
MBEDDED
 	depends on TOUCHSCREEN_USB_COMPOSITE
=20
 config TOUCHSCREEN_USB_NEXIO
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input=
/touchscreen/usbtouchscreen.c
index 567d572..3244542 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -135,7 +135,7 @@ enum {
 	DEVTYPE_JASTEC,
 	DEVTYPE_E2I,
 	DEVTYPE_ZYTRONIC,
-	DEVTYPE_TC5UH,
+	DEVTYPE_TC45USB,
 	DEVTYPE_NEXIO,
 };
=20
@@ -222,8 +222,11 @@ static const struct usb_device_id usbtouch_devices=
[] =3D {
 	{USB_DEVICE(0x14c8, 0x0003), .driver_info =3D DEVTYPE_ZYTRONIC},
 #endif
=20
-#ifdef CONFIG_TOUCHSCREEN_USB_ETT_TC5UH
-	{USB_DEVICE(0x0664, 0x0309), .driver_info =3D DEVTYPE_TC5UH},
+#ifdef CONFIG_TOUCHSCREEN_USB_ETT_TC45USB
+	/* TC5UH */
+	{USB_DEVICE(0x0664, 0x0309), .driver_info =3D DEVTYPE_TC45USB},
+	/* TC4UM */
+	{USB_DEVICE(0x0664, 0x0306), .driver_info =3D DEVTYPE_TC45USB},
 #endif
=20
 #ifdef CONFIG_TOUCHSCREEN_USB_NEXIO
@@ -574,10 +577,10 @@ static int irtouch_read_data(struct usbtouch_usb =
*dev, unsigned char *pkt)
 #endif
=20
 /*********************************************************************=
********
- * ET&T TC5UH part
+ * ET&T TC5UH/TC4UM part
  */
-#ifdef CONFIG_TOUCHSCREEN_USB_ETT_TC5UH
-static int tc5uh_read_data(struct usbtouch_usb *dev, unsigned char *pk=
t)
+#ifdef CONFIG_TOUCHSCREEN_USB_ETT_TC45USB
+static int tc45usb_read_data(struct usbtouch_usb *dev, unsigned char *=
pkt)
 {
 	dev->x =3D ((pkt[2] & 0x0F) << 8) | pkt[1];
 	dev->y =3D ((pkt[4] & 0x0F) << 8) | pkt[3];
@@ -1104,14 +1107,14 @@ static struct usbtouch_device_info usbtouch_dev=
_info[] =3D {
 	},
 #endif
=20
-#ifdef CONFIG_TOUCHSCREEN_USB_ETT_TC5UH
-	[DEVTYPE_TC5UH] =3D {
+#ifdef CONFIG_TOUCHSCREEN_USB_ETT_TC45USB
+	[DEVTYPE_TC45USB] =3D {
 		.min_xc		=3D 0x0,
 		.max_xc		=3D 0x0fff,
 		.min_yc		=3D 0x0,
 		.max_yc		=3D 0x0fff,
 		.rept_size	=3D 5,
-		.read_data	=3D tc5uh_read_data,
+		.read_data	=3D tc45usb_read_data,
 	},
 #endif
=20
--=20
1.5.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
