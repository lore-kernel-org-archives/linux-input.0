From: Piotr Sawuk <piotr5@users.sf.net>
Subject: [PATCH 1/1] R.A.T.5 also works with hid-saitek
Date: Wed, 30 Dec 2015 18:34:17 +0100
Message-ID: <56841599.5050800@users.sf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070907080407050505020300"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from grace.univie.ac.at ([131.130.3.115]:32965 "EHLO
	grace.univie.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbbL3Rjb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Dec 2015 12:39:31 -0500
Received: from justin.univie.ac.at ([131.130.3.111] helo=justin.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.86)
	(envelope-from <piotr5@users.sf.net>)
	id 1aEKdf-0003pd-0p
	for linux-input@vger.kernel.org; Wed, 30 Dec 2015 18:34:19 +0100
Received: from chello084114156179.12.15.vie.surfer.at ([84.114.156.179] helo=[192.168.0.12])
	by justin.univie.ac.at with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.86)
	(envelope-from <piotr5@users.sf.net>)
	id 1aEKde-0000M3-Nr
	for linux-input@vger.kernel.org; Wed, 30 Dec 2015 18:34:18 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------070907080407050505020300
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

sorry for the old kernel. tell me if it failed to apply.

and I have a question, since I know nothing of linux-programming:
in include/linux/hidraw.h there is a struct hidraw defined.
obviously one of these is assigned to each device.
also hid-saitek.c uses that and stores its data inside.
more exactly in ->hid->dev->mode is a value I'd like to read.
what is the proper way to do that? is it possible from userspace?
hid-saitek module removes information on what colour the mode-LED has.
that information is stored in the mode variable of struct saitec_sc.
since that struct is only defined in the c-sources, I have a problem?
would it be sufficient to move that definition into include/?
any suggestions on where to?

P

--------------070907080407050505020300
Content-Type: text/x-patch;
 name="RAT5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="RAT5.patch"

Signed-off-by: Piotr Sawuk <piotr5@users.sf.net>
---
add support for mad catz r.a.t.5

diff -rup linux-4.2.6-gentoo/drivers/hid/hid-core.c linux-4.2.6-gentoo-rat5/drivers/hid/hid-core.c
--- linux-4.2.6-gentoo/drivers/hid/hid-core.c	2015-08-30 20:34:09.000000000 +0200
+++ linux-4.2.6-gentoo-rat5/drivers/hid/hid-core.c	2015-12-30 12:09:14.340841552 +0100
@@ -1959,6 +1959,7 @@ static const struct hid_device_id hid_ha
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT5) },
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
diff -rup linux-4.2.6-gentoo/drivers/hid/hid-ids.h linux-4.2.6-gentoo-rat5/drivers/hid/hid-ids.h
--- linux-4.2.6-gentoo/drivers/hid/hid-ids.h	2015-08-30 20:34:09.000000000 +0200
+++ linux-4.2.6-gentoo-rat5/drivers/hid/hid-ids.h	2015-12-29 18:47:36.756225217 +0100
@@ -634,6 +634,7 @@
 
 #define USB_VENDOR_ID_MADCATZ		0x0738
 #define USB_DEVICE_ID_MADCATZ_BEATPAD	0x4540
+#define USB_DEVICE_ID_MADCATZ_RAT5	0x1705
 #define USB_DEVICE_ID_MADCATZ_RAT9	0x1709
 
 #define USB_VENDOR_ID_MCC		0x09db
diff -rup linux-4.2.6-gentoo/drivers/hid/hid-saitek.c linux-4.2.6-gentoo-rat5/drivers/hid/hid-saitek.c
--- linux-4.2.6-gentoo/drivers/hid/hid-saitek.c	2015-08-30 20:34:09.000000000 +0200
+++ linux-4.2.6-gentoo-rat5/drivers/hid/hid-saitek.c	2015-12-30 12:11:59.264802539 +0100
@@ -181,6 +181,8 @@ static const struct hid_device_id saitek
 		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7),
 		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT5),
+		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9),
 		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7),
diff -rup linux-4.2.6-gentoo/drivers/hid/Kconfig linux-4.2.6-gentoo-rat5/drivers/hid/Kconfig
--- linux-4.2.6-gentoo/drivers/hid/Kconfig	2015-08-30 20:34:09.000000000 +0200
+++ linux-4.2.6-gentoo-rat5/drivers/hid/Kconfig	2015-12-30 12:14:49.228404039 +0100
@@ -665,6 +665,7 @@ config HID_SAITEK
 
 	Supported devices:
 	- PS1000 Dual Analog Pad
+	- R.A.T.5 Gaming Mouse
 	- R.A.T.9 Gaming Mouse
 	- R.A.T.7 Gaming Mouse
 	- M.M.O.7 Gaming Mouse
-- 

--------------070907080407050505020300--
