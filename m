From: Peter <peter@slim-one.de>
Subject: [PATCH] G27_support
Date: Mon, 02 May 2011 21:17:57 +0200
Message-ID: <1304363877.5713.17.camel@slim-one-desktop>
References: <1299842104.2550.24.camel@slim-one-desktop>
	 <1300769820-16198-1-git-send-email-simon@mungewell.org>
Reply-To: peter@slim-one.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TVjO+mHoMtxQHGZKXfnb"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:58288 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab1EBTX2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 May 2011 15:23:28 -0400
In-Reply-To: <1300769820-16198-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Olivier Michel <Olivier.Michel@cyberbotics.com>, Simon Wood <simon@mungewell.org>


--=-TVjO+mHoMtxQHGZKXfnb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

here's a small patch to add support for the Logitech G27 wheel, since
the prior patch only added FF support for the Driving Force Pro and G25.
The patch contains the changes from the G25 and DFP, too, since they
were not in linux/kernel/git/jikos/hid.git.
I tested the changes with wine/LFS and got full support for all axes and
buttons.

Regards, Peter

--=-TVjO+mHoMtxQHGZKXfnb
Content-Disposition: attachment; filename="G27.patch"
Content-Type: text/x-patch; name="G27.patch"; charset="us-ascii"
Content-Transfer-Encoding: 7bit

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c3d6626..4e33886 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1405,6 +1405,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFP_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_WHEEL) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G27_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WII_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACETRAVELLER) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d485894..7db251c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -394,6 +394,7 @@
 #define USB_DEVICE_ID_LOGITECH_MOMO_WHEEL	0xc295
 #define USB_DEVICE_ID_LOGITECH_DFP_WHEEL	0xc298
 #define USB_DEVICE_ID_LOGITECH_G25_WHEEL	0xc299
+#define USB_DEVICE_ID_LOGITECH_G27_WHEEL	0xc29b
 #define USB_DEVICE_ID_LOGITECH_WII_WHEEL	0xc29c
 #define USB_DEVICE_ID_LOGITECH_ELITE_KBD	0xc30a
 #define USB_DEVICE_ID_S510_RECEIVER	0xc50c
diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 3da9040..21f205f 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -377,6 +377,8 @@ static const struct hid_device_id lg_devices[] = {
 		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_WHEEL),
 		.driver_data = LG_FF },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G27_WHEEL),
+		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFP_WHEEL),
 		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WII_WHEEL),
diff --git a/drivers/hid/hid-lgff.c b/drivers/hid/hid-lgff.c
index 90d0ef2..f901349 100644
--- a/drivers/hid/hid-lgff.c
+++ b/drivers/hid/hid-lgff.c
@@ -72,6 +72,9 @@ static const struct dev_type devices[] = {
 	{ 0x046d, 0xc287, ff_joystick_ac },
 	{ 0x046d, 0xc293, ff_joystick },
 	{ 0x046d, 0xc294, ff_wheel },
+	{ 0x046d, 0xc298, ff_wheel },
+	{ 0x046d, 0xc299, ff_wheel },
+	{ 0x046d, 0xc29b, ff_wheel },
 	{ 0x046d, 0xc295, ff_joystick },
 	{ 0x046d, 0xca03, ff_wheel },
 };

--=-TVjO+mHoMtxQHGZKXfnb--

