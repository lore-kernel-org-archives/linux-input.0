Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF4A2F5A36;
	Sun, 26 Jul 2026 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054121; cv=none; b=W/e2+af7eXlRTOWp7/o4vk/B/sGyVqWp8qExe7NMmF0S6M/Plpr/Gzj5Ir6r1MYMmzZNRUS5N/6ajTahxRgRGqMAXN5BLTufFw93+0jCp3KmODrBO8V5MmEECzxJGu366YcbMYMFWrks7an04wv1QAtUdymouVO4TJWcVPPmYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054121; c=relaxed/simple;
	bh=NcU8wS93nsidkMQkptraF+nsgOhZAC/uHltM/sn88Xg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=dhIQTjUnOnFqBnaoP2c3OIN6tkC3Io2fIwlbYiao6AlPKhGjOuExD3D4mVySCwFxgrmK0Wn+8HqhRxh9IK6fs1oDsMCltLLTyotAIjLIjOwPbnCpAk2mTwlf7P19ONXCVW+zjyWEabmH8UsfZofpaBOAWFtg50FNcGfOg/oL6fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=JRIcRTb4; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="JRIcRTb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785054107;
	bh=VNA+U2VOyzrrfKPZselM2HN5dKOCfbYeAhwrq3WFrLY=;
	h=From:To:Cc:Subject:Date;
	b=JRIcRTb4Q72/kiyTpWTi7dXiXYurgXwVbq//V9t+S4HIsimX+SWo8HibF8lrx6lRh
	 5+pN0Dh/tmwGAJAiwa7S+ar0cNpgVB1YzB6Nm5RfYyimeHYrB5diyVPDgd8BB1VjDE
	 p3uzraZj9sjZuHqYbv9VY2CPhTKyQrmhW+4ZnGE8=
Received: from localhost ([182.91.149.193])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 56E0C221; Sun, 26 Jul 2026 16:21:46 +0800
X-QQ-mid: xmsmtpt1785054106t2ufx02cv
Message-ID: <tencent_CD9DBF098D1B3BB565A1DD5761C1D34F4805@qq.com>
X-QQ-XMAILINFO: MhK4DKsBP06ipf9ZblDLdulzNxgP3BmOn5rh+H79S7GmcKsLhTAvdmJCmmoEnt
	 L9iB0HF7Y+xksxbv23+MW36+GJaQBGlduGD6RiGXdY4FyParylXCWXBs4q2MVkaIRu8a+EsgzRiu
	 F+Bxgb5FPFd5Z6PXdXPfbp/LjS6nEftMP8ut2tIAIufSno+4HmgRREDTFC9g9QIf8tO6L9tCZl4O
	 S2e18dvGWNqVy7PjeuxMq4kiPkj+5QXYVz4Aj68dW16OE5Ty3JYeBh+/5yyaZ0N2BfKOMDg8av6k
	 y1S2xxk6LtGekycOrH1822ahm9HWFMplU0vhQbMj3XZbvfVdkGVTChZuvpyHP24fa1mJMR/WDSPK
	 EqrU4rPu0quQlobOOy5zWs7/5l1efZcaBboS4b/+T34M5b3D2kT/gz7+ID26VMxWzizCZKRK3Xoy
	 wUvTEwhRimKpIPRX9RLHTeMSA4p6dog1A8oB4eQaqORXzplmJ1TF2H9jDuCUNg4WUy+p+wlL9+Da
	 pU2jVyk8qQOVk9pJj0fFdFQDW9C5NJjIs0Y3YNzNeZFDCoNN/D0fRce7qC7IGKznqvuoVwGApGxi
	 hXFEIXYj8wN3bUeEod2tSIcJHSWIqGdtVHvQuRJjrN1WCaQUoloB124bcqo82jOjl324hFSy2qBJ
	 TB5aRkaOY1phhbQXsoolNskYdXETs4wA1lpY+23D54LGB3iKCw0Lb2RVzxrBISTHIfiuc1EIOcIG
	 AJQp/j4yh7WBXW01GqW95En8JrHEIlv6fr5jpF+O0vY/H9BdvK31sGnjrsRd/hUvwhUvruykVFz4
	 69f7fHeiTMAMmwtQHxwPYrFFqcO+AmqqgNu1cgHljlJZWn7KBi7YSslNXScPjLG5eTq8Ef32bJgZ
	 M3vAm67bsTI01mP+UyZF/j136aji6JzzRsD0V1R+5Uppg7YnHg4W7p/g4zvq1y5BiePonbcSxsbM
	 +c6AgD+F8T/0YpHtzO8NQDkqDP86fXsWm5F9qffLMkheuSCR/1qz2IBY/ib5jQQQ1HbIxRyGPpz5
	 MYZGloTSj764hswINwRjg0iOKjAe8BxbyMe0CmtrS7j3kHhEdw362dZ3JziJmx8NGsb2UT19MNB0
	 ZoaFeKN/P0Emv3erzBQwhtRoW6IhUMyPqVzes08nxYKSFN45w=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: VegetablCat <vegetablecat@foxmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vegetablecat <vegetablecat@foxmail.com>
Subject: [PATCH v2] Input: xpad - add support for Beitong KP series controllers
Date: Sun, 26 Jul 2026 16:21:43 +0800
X-OQ-MSGID: <20260726082143.14721-1-vegetablecat@foxmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: vegetablecat <vegetablecat@foxmail.com>

Beitong KP series controllers (0x20bc:*) enumerate as standard
Xbox 360 devices but require a Microsoft OS Extended Compat ID
descriptor read (XUSB10) to lock into XInput mode.  Without this
request the controller re-enumerates as a Nintendo Switch device
(057e:2069) after approximately 1.9 seconds and stops reporting
valid input.

Add FLAG_READ_XUSB10 and device table entries for KP20A/D,
KP40A/B/D/F, KP50B/C/D/E, and KP70A.  Devices with this flag
trigger a usb_control_msg_recv() during probe to read the XUSB10
descriptor, which is the sole condition required to keep the
controllers in XInput mode.

The flag follows the same pattern as FLAG_DELAY_INIT used for
the ByoWave Proteus Controller.

Additionally, add an optional HID receiver driver for the KP40D
receiver dongle (0x20dd:0x515c) that binds to its HID interface
to prevent hid-generic from interfering.  The receiver dongle is
a separate USB device with its own vendor ID (0x20dd), distinct
from the controller (0x20bc).  The HID code is guarded with
IS_ENABLED(CONFIG_HID) to avoid build failures when HID is
disabled or built as a module.

Tested on 20bc:5126 (KP20A) and 20bc:515b (KP40D).

Signed-off-by: vegetablecat <vegetablecat@foxmail.com>
---
 drivers/input/joystick/xpad.c | 119 +++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f36..13b6168 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -28,6 +28,7 @@
  */
 
 #include <linux/bits.h>
+#include <linux/hid.h>
 #include <linux/kernel.h>
 #include <linux/input.h>
 #include <linux/rcupdate.h>
@@ -72,6 +73,7 @@
 #define PKT_XBE2_FW_5_11    4
 
 #define FLAG_DELAY_INIT BIT(0)
+#define FLAG_READ_XUSB10 BIT(1)
 
 static bool dpad_to_buttons;
 module_param(dpad_to_buttons, bool, S_IRUGO);
@@ -332,6 +334,32 @@ static const struct xpad_device {
 	{ 0x1bad, 0xfd00, "Razer Onza TE", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xfd01, "Razer Onza", 0, XTYPE_XBOX360 },
 	{ 0x1ee9, 0x1590, "ZOTAC Gaming Zone", 0, XTYPE_XBOX360 },
+	{ 0x20bc, 0x5125, "BETOP BTP-KP20A/BTP-KP40A Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5126, "BETOP BTP-KP20A Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5127, "BETOP BTP-KP20A/BTP-KP40A Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5128, "BETOP BTP-KP20A Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x512f, "BETOP BTP-KP70A Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5130, "BETOP BTP-KP70A Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5133, "BETOP BTP-KP50B Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5145, "BETOP BTP-KP40A/BTP-KP40B Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5146, "BETOP BTP-KP40A/BTP-KP40B Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5149, "BETOP BTP-KP50C Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5150, "BETOP BTP-KP50D Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5151, "BETOP BTP-KP50D Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5152, "BETOP BTP-KP50E Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5153, "BETOP BTP-KP50E Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5154, "BETOP BTP-KP40D Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5155, "BETOP BTP-KP40D Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5158, "BETOP BTP-KP20D Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5159, "BETOP BTP-KP20D Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x515b, "BETOP BTP-KP40D Controller (White)", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x515c, "BETOP BTP-KP40D Controller (White)", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x515d, "BETOP BTP-KP40F Controller (White)", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x515e, "BETOP BTP-KP40F Controller (White)", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x515f, "BETOP BTP-KP70A Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5160, "BETOP BTP-KP70A Controller", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x5169, "BETOP BTP-KP40F Controller (Black)", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
+	{ 0x20bc, 0x516a, "BETOP BTP-KP40F Controller (Black)", 0, XTYPE_XBOX360, FLAG_READ_XUSB10 },
 	{ 0x20bc, 0x5134, "BETOP BTP-KP50B Xinput Dongle", 0, XTYPE_XBOX360 },
 	{ 0x20bc, 0x514a, "BETOP BTP-KP50C Xinput Dongle", 0, XTYPE_XBOX360 },
 	{ 0x20d6, 0x2001, "BDA Xbox Series X Wired Controller", 0, XTYPE_XBOXONE },
@@ -778,6 +806,7 @@ struct usb_xpad {
 	time64_t mode_btn_down_ts;
 	bool delay_init;		/* init packets should be delayed */
 	bool delayed_init_done;
+	bool read_xusb10;		/* read XUSB10 descriptor during probe */
 };
 
 static int xpad_init_input(struct usb_xpad *xpad);
@@ -2044,6 +2073,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usb_xpad *xpad;
 	struct usb_endpoint_descriptor *ep_irq_in, *ep_irq_out;
+	u8 ms_feature_descriptor[40];
 	int i, error;
 
 	if (intf->cur_altsetting->desc.bNumEndpoints != 2)
@@ -2082,6 +2112,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	xpad->name = xpad_device[i].name;
 	if (xpad_device[i].flags & FLAG_DELAY_INIT)
 		xpad->delay_init = true;
+	if (xpad_device[i].flags & FLAG_READ_XUSB10)
+		xpad->read_xusb10 = true;
 
 	xpad->packet_type = PKT_XB;
 	INIT_WORK(&xpad->work, xpad_presence_work);
@@ -2148,6 +2180,19 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	xpad->irq_in->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
 	usb_set_intfdata(intf, xpad);
+	if (xpad->read_xusb10) {
+		error = usb_control_msg_recv(udev, 0, 0xee,
+					     USB_TYPE_VENDOR | USB_DIR_IN |
+						USB_RECIP_DEVICE,
+					     0x0000, 0x0004,
+					     ms_feature_descriptor,
+					     sizeof(ms_feature_descriptor), 25,
+					     GFP_KERNEL);
+		if (error)
+			dev_warn(&intf->dev,
+				 "unable to read Microsoft feature descriptor: %d\n",
+				 error);
+	}
 
 	/* Packet type detection */
 	if (le16_to_cpu(udev->descriptor.idVendor) == 0x045e) { /* Microsoft controllers */
@@ -2312,7 +2357,79 @@ static struct usb_driver xpad_driver = {
 	.id_table	= xpad_table,
 };
 
-module_usb_driver(xpad_driver);
+#if IS_ENABLED(CONFIG_HID)
+static int xpad_receiver_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int error;
+
+	error = hid_parse(hdev);
+	if (error)
+		return error;
+
+	error = hid_hw_start(hdev, 0);
+	if (error)
+		return error;
+
+	error = hid_hw_open(hdev);
+	if (error) {
+		hid_hw_stop(hdev);
+		return error;
+	}
+
+	return 0;
+}
+
+static void xpad_receiver_remove(struct hid_device *hdev)
+{
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id xpad_receiver_devices[] = {
+	{ HID_USB_DEVICE(0x20dd, 0x515c) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, xpad_receiver_devices);
+
+static struct hid_driver xpad_receiver_driver = {
+	.name = "xpad-kp40d-receiver",
+	.id_table = xpad_receiver_devices,
+	.probe = xpad_receiver_probe,
+	.remove = xpad_receiver_remove,
+};
+#endif
+
+static int __init xpad_init(void)
+{
+	int error;
+
+#if IS_ENABLED(CONFIG_HID)
+	error = hid_register_driver(&xpad_receiver_driver);
+	if (error)
+		return error;
+#endif
+
+	error = usb_register(&xpad_driver);
+	if (error) {
+#if IS_ENABLED(CONFIG_HID)
+		hid_unregister_driver(&xpad_receiver_driver);
+#endif
+		return error;
+	}
+
+	return 0;
+}
+
+static void __exit xpad_exit(void)
+{
+	usb_deregister(&xpad_driver);
+#if IS_ENABLED(CONFIG_HID)
+	hid_unregister_driver(&xpad_receiver_driver);
+#endif
+}
+
+module_init(xpad_init);
+module_exit(xpad_exit);
 
 MODULE_AUTHOR("Marko Friedemann <mfr@bmx-chemnitz.de>");
 MODULE_DESCRIPTION("Xbox pad driver");
-- 
2.55.0

