Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A921DE3B7;
	Sun, 26 Jul 2026 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054668; cv=none; b=o20MZR0RIuIVUuHxFlE45mBS/cCpqbSfaClO8N7Nn2p7a0taBoWeJnbFyuOM/Z3Heqmm+LvBjraKp4DCSPfvU0YQap97aEKp6otanHqflBTqJVyXPY5ELFzDKXBaYffyFe9dVMAP43hVkRhkOOLcm+TMqEWuv9wDJvDrVu+81dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054668; c=relaxed/simple;
	bh=AjPg063Jv3eK++Fw4bWz8c5uOqEEDvpEI/dIOEVIA1A=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=GSLYe7VUysxlmo5RjivRWxorPYeGlHn1UdQ7df7qbnuAOTPkIOcrpO94mQzQs9w9qsBErHbN5h3UYFB1vEJwjQVo5StTESTVtyEOmI3Mo1KDrDumUDpZdUMvar+uRzdDEIUzXZCTUhujrYDPjlPuELNVMePXom7eXS3HE3TIjes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=hZg6AZ2u; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="hZg6AZ2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785054661;
	bh=DmD8nmw81JtBh+DoqCuBj4SOmV6svb7yAZd61Io82cM=;
	h=From:To:Cc:Subject:Date;
	b=hZg6AZ2umdfP8diXbY/+HaQQSa/rVXwgU3QBXOgKZGnOdKFAU176xvWoJg1nIJuW8
	 nWr55SSwrJ5/gD3BYPCLUx7GbP2euVsOzVphPPOKb6hN3iSi2yd6eblUzCot89YFHj
	 2XMhoSAhvYKzYqJC/p0S59yKdMfPH4tQwsDOkqq0=
Received: from localhost ([182.91.149.193])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 7BB8E2BB; Sun, 26 Jul 2026 16:30:59 +0800
X-QQ-mid: xmsmtpt1785054659t4uf4prm3
Message-ID: <tencent_252E78F8262DB8F915A8CF35CD7087A50A0A@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7VR60mi+D30T+n5DUeTbCBCbg0i4rdPPElHoLKTq5GGoeGv3ffQ
	 8qbT3wubrbN6tnwNUnYou9chgA/CbSWqS/4gUIl876FcsRUk4WmFqx+f281kEOe52R8AmQLy9mJi
	 86EYM/epMq8rEYg2FYLdWztVkKppyNwFODgLV4qagdgFSDCCmYHWYjx0TQI+ST1D1f4YiDWN3U68
	 UX3ATkuG8XAjsz9IGH9VPOHSc4WzanMH9HGiNp/YQYtdJLPZr5DervY2E6w5n/e03keSO35iv8Fp
	 Jmq0Y4sQ7phdQQXdTxLpt4LPKYhPcO+pY65slLRx0rQEwX4Iwwklb+sSPkkuq+ixeE91XQ1SOQNB
	 R4xIe1ci/XEZGeGMKmvoaZ0gqQzdJXZqwn5WrLeRGQDgJy6IzAGQ4Zq+uZIoPXE1RhlX7caKsZUz
	 4bHLf9vspQEadoLJDtjEIGm32H5pKHK6JeI9Rb4DqZ+uxLOib7nmcFgM2l+NJeB2MypNt0/zr7/z
	 LAjwXHjD5+OSbGtkpse/sCaC8WBWWUt7QQBJZqgVjCL71h+i8NxPkBJXKhe46logC2XSeXd8eY/N
	 MwBi/BvsfGylFAt4GufQtz2LJQqrPVbT3DRGPylXa+VexNWygPWX3x3S6RkLzHpqka9WDwOGjaDR
	 7MW2jwnbRxX8+/idMqFTEPB6ZN88IxuTZdmThRpWDEN1HZKAaujo2/xMSKfBNuMozla2hBNDo6fo
	 PXatWE7qZSlpsIsNoHV4H9HeMbFC+7P7d0OCVwqd6HBvNGMh0HegviXVKyRy3Z5K46FaqrUp5XpO
	 HgBFYq0o9y662ZKd37JOETh8umn/+W+FLfiDuKP2/CB9LWzMVJHrCnsiJS9JS1Q+WmFPYreo/6TD
	 a2LSHToGcMI3+QA1WJTHurbbAiTG2MbaluVd6M0RUVeyKeNCMSZdGY3tqoIp+bcd3iEFscVb2vGm
	 vPWk+XwS4Gazsp9plXEnBmsYbnV089JmuC1YGi8G1raLokohH0AfhjSLWUqQn5Wm9k4yOg6+7jhh
	 HqzHCg0LkLwJRVFb2L+rEGFhI8YnGfSff4Yja8PYlS+7K8e0JVmN6l28+JtC4sfYvdzhJ35QIiO0
	 hX69TtKxCeoDUOZjnmjPcarmzykVjuLmppyVNg
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: VegetablCat <vegetablecat@foxmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vegetablecat <vegetablecat@foxmail.com>
Subject: [PATCH v3] Input: xpad - add support for Beitong KP series controllers
Date: Sun, 26 Jul 2026 16:30:56 +0800
X-OQ-MSGID: <20260726083056.18825-1-vegetablecat@foxmail.com>
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
the ByoWave Proteus Controller.  The 25ms timeout for the
usb_control_msg_recv() call is consistent with the existing
usage in xpad_start_input() for the legacy Xbox 360 vendor
capability request.

Additionally, add an optional HID receiver driver for the KP40D
receiver dongle (0x20dd:0x515c) that binds to its HID interface
to prevent hid-generic from interfering.  The receiver dongle is
a separate USB device with its own vendor ID (0x20dd), distinct
from the controller (0x20bc).  The HID code is guarded with
IS_REACHABLE(CONFIG_HID) to handle the case where xpad is
built-in (y) and HID is a loadable module (m).

Tested on 20bc:5126 (KP20A) and 20bc:515b (KP40D).

Signed-off-by: vegetablecat <vegetablecat@foxmail.com>
---
 drivers/input/joystick/xpad.c | 119 +++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f36..8cd4001 100644
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
+#if IS_REACHABLE(CONFIG_HID)
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
+#if IS_REACHABLE(CONFIG_HID)
+	error = hid_register_driver(&xpad_receiver_driver);
+	if (error)
+		return error;
+#endif
+
+	error = usb_register(&xpad_driver);
+	if (error) {
+#if IS_REACHABLE(CONFIG_HID)
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
+#if IS_REACHABLE(CONFIG_HID)
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

