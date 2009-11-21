From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH] do not overwrite the first part of phys string
Date: Sat, 21 Nov 2009 08:55:12 +0100
Message-ID: <4B079CE0.60604@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail01a.mail.t-online.hu ([84.2.40.6]:61780 "EHLO
	mail01a.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbZKUHzW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Nov 2009 02:55:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>

=46rom: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

Use strlcat() to append a string to the previously created first part.

Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
---
diff -upr linux-2.6.32-rc7.orig/drivers/hid/usbhid/usbkbd.c linux-2.6.3=
2-rc7/drivers/hid/usbhid/usbkbd.c
--- linux-2.6.32-rc7.orig/drivers/hid/usbhid/usbkbd.c	2009-09-10 00:13:=
59.000000000 +0200
+++ linux-2.6.32-rc7/drivers/hid/usbhid/usbkbd.c	2009-11-21 08:48:32.00=
0000000 +0100
@@ -266,7 +266,7 @@ static int usb_kbd_probe(struct usb_inte
 			 le16_to_cpu(dev->descriptor.idProduct));

 	usb_make_path(dev, kbd->phys, sizeof(kbd->phys));
-	strlcpy(kbd->phys, "/input0", sizeof(kbd->phys));
+	strlcat(kbd->phys, "/input0", sizeof(kbd->phys));

 	input_dev->name =3D kbd->name;
 	input_dev->phys =3D kbd->phys;
diff -upr linux-2.6.32-rc7.orig/drivers/input/misc/ati_remote.c linux-2=
=2E6.32-rc7/drivers/input/misc/ati_remote.c
--- linux-2.6.32-rc7.orig/drivers/input/misc/ati_remote.c	2009-09-10 00=
:13:59.000000000 +0200
+++ linux-2.6.32-rc7/drivers/input/misc/ati_remote.c	2009-11-21 08:48:5=
0.000000000 +0100
@@ -766,7 +766,7 @@ static int ati_remote_probe(struct usb_i
 	ati_remote->interface =3D interface;

 	usb_make_path(udev, ati_remote->phys, sizeof(ati_remote->phys));
-	strlcpy(ati_remote->phys, "/input0", sizeof(ati_remote->phys));
+	strlcat(ati_remote->phys, "/input0", sizeof(ati_remote->phys));

 	if (udev->manufacturer)
 		strlcpy(ati_remote->name, udev->manufacturer, sizeof(ati_remote->nam=
e));
diff -upr linux-2.6.32-rc7.orig/drivers/input/misc/powermate.c linux-2.=
6.32-rc7/drivers/input/misc/powermate.c
--- linux-2.6.32-rc7.orig/drivers/input/misc/powermate.c	2009-09-10 00:=
13:59.000000000 +0200
+++ linux-2.6.32-rc7/drivers/input/misc/powermate.c	2009-11-21 08:48:44=
=2E000000000 +0100
@@ -338,7 +338,7 @@ static int powermate_probe(struct usb_in
 	pm->input =3D input_dev;

 	usb_make_path(udev, pm->phys, sizeof(pm->phys));
-	strlcpy(pm->phys, "/input0", sizeof(pm->phys));
+	strlcat(pm->phys, "/input0", sizeof(pm->phys));

 	spin_lock_init(&pm->lock);

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
