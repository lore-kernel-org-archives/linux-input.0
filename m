From: =?utf-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
Subject: [PATCH] Input: usbtouchscreen - add support for ET&T TC5UH touchscreen controller
Date: Sat, 28 Nov 2009 11:54:37 +0100
Message-ID: <1259405677-9416-1-git-send-email-ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:49928 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbZK1LBY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Nov 2009 06:01:24 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@novell.com>, =?utf-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>

This patch adds support for the ET&T TC5UH 5-wire USB touchscreen contr=
oller.
More info at http://www.etandt.com.tw/board_solution.html

Signed-off-by: Petr =C5=A0tetiar <ynezz@true.cz>
---
 drivers/input/touchscreen/Kconfig          |    5 ++++
 drivers/input/touchscreen/usbtouchscreen.c |   30 ++++++++++++++++++++=
++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
index 8cc453c..a3ba9e1 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -490,6 +490,11 @@ config TOUCHSCREEN_USB_E2I
 	bool "e2i Touchscreen controller (e.g. from Mimo 740)"
 	depends on TOUCHSCREEN_USB_COMPOSITE
=20
+config TOUCHSCREEN_USB_ETT_TC5UH
+	default y
+	bool "ET&T TC5UH touchscreen controler support" if EMBEDDED
+	depends on TOUCHSCREEN_USB_COMPOSITE
+
 config TOUCHSCREEN_TOUCHIT213
 	tristate "Sahara TouchIT-213 touchscreen"
 	select SERIO
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input=
/touchscreen/usbtouchscreen.c
index 68ece58..e3ab3f1 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -121,6 +121,7 @@ enum {
 	DEVTYPE_GOTOP,
 	DEVTYPE_JASTEC,
 	DEVTYPE_E2I,
+	DEVTYPE_TC5UH,
 };
=20
 #define USB_DEVICE_HID_CLASS(vend, prod) \
@@ -201,6 +202,11 @@ static struct usb_device_id usbtouch_devices[] =3D=
 {
 #ifdef CONFIG_TOUCHSCREEN_USB_E2I
 	{USB_DEVICE(0x1ac7, 0x0001), .driver_info =3D DEVTYPE_E2I},
 #endif
+
+#ifdef CONFIG_TOUCHSCREEN_USB_ETT_TC5UH
+	{USB_DEVICE(0x0664, 0x0309), .driver_info =3D DEVTYPE_TC5UH},
+#endif
+
 	{}
 };
=20
@@ -621,6 +627,19 @@ static int jastec_read_data(struct usbtouch_usb *d=
ev, unsigned char *pkt)
 }
 #endif
=20
+/*********************************************************************=
********
+ * ET&T TC5UH part
+ */
+#ifdef CONFIG_TOUCHSCREEN_USB_ETT_TC5UH
+static int tc5uh_read_data(struct usbtouch_usb *dev, unsigned char *pk=
t)
+{
+	dev->x =3D ((pkt[2] & 0x0F) << 8) | pkt[1];
+	dev->y =3D ((pkt[4] & 0x0F) << 8) | pkt[3];
+	dev->touch =3D pkt[0] & 0x01;
+
+	return 1;
+}
+#endif
=20
 /*********************************************************************=
********
  * the different device descriptors
@@ -783,6 +802,17 @@ static struct usbtouch_device_info usbtouch_dev_in=
fo[] =3D {
 		.read_data	=3D e2i_read_data,
 	},
 #endif
+
+#ifdef CONFIG_TOUCHSCREEN_USB_ETT_TC5UH
+	[DEVTYPE_TC5UH] =3D {
+		.min_xc		=3D 0x0,
+		.max_xc		=3D 0x0fff,
+		.min_yc		=3D 0x0,
+		.max_yc		=3D 0x0fff,
+		.rept_size	=3D 5,
+		.read_data	=3D tc5uh_read_data,
+	},
+#endif
 };
=20
=20
--=20
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
