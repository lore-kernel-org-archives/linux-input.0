Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4131A575;
	Sun, 26 Jul 2026 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785052926; cv=none; b=mnRmSXgd93ML+JaCUWQadxu3gfspxugBudPmEUYI5zBeoEo+QsG73O/e4c409mXde0c3fwlQ2WqpL3j7brfj75wApGylsaMqCOL2qU+c3K/pizuvdYGhg6TxlDq3ADiH13Oqh/O6E/ZIcF/4YNM8fFxLiy4/H7qBs56q59B3/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785052926; c=relaxed/simple;
	bh=JmOLrW5kN9SdoYm7njfZnOrB2QKJ0077RpHyiRffhJo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=R8djVs9robRFEKG3j4dWwj8I3LVKRUZpK563w12r5kvQq4qEkejyDq/DJWu/AzEREbbIVSe1mmzuBBYqkldP/owwChTWVY9d8Z9UbHfbg2DjR6oSSglw2dGRWGv9xBttpcgPwrhIdKwx76g4u3PcKn4/zlYeVArtgxsBUpuEJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=liIywmht; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="liIywmht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785052911;
	bh=hCdRf5n7sT1esNenVJeiJI6tnPYH5mJZzcBOPNHvcHU=;
	h=From:To:Cc:Subject:Date;
	b=liIywmhtTbHJlvN6DCfZT5TfdZbvmcqqZFQiEfFCMWn+HIwkWi+n7Ii65fwnrTFj1
	 6+RYdM9DXPtZ6Dufva42NRMKqNszXr8W2NqgJpAKWcAdwq8lAIKz1Gd2MreXJjU949
	 gsgobI4gsMxrmFQtZy4qfjiioO4sfFHgNJWEphwA=
Received: from localhost ([182.91.149.193])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 72848BC; Sun, 26 Jul 2026 16:01:50 +0800
X-QQ-mid: xmsmtpt1785052910tl4mkgzqw
Message-ID: <tencent_2DEADF4D9ADC33A9420BECBEA70B1A7EFD08@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnR98n0BRp0WdRLMx4xz9j7rr6MQM4v039V0lSgxzAMBsA9p5pN9C
	 2py2qlIbOBOMyqPixH4hTPOhvXAgWeTJmDKkhE5dtY2aIS8YJpqketMWOycCpmN6NOWtwCMu15Uf
	 +Ve2nx2OedkSWkMMBnTQTOUPLUn8t3yOod/kg3f1p7NAX4kbf/Z/2VCjb10LTneA4LUQW3fKguZB
	 tfgDyx2PJzDnJQ3dpBBNBjukGqMreWOPRp4cjKuEvUVLdxeRnwz8Wbr8BkKN6oH8dVePx5OPjVUP
	 Os5yBAtNty0SsdC8xmxiR6H8nDedx6lRW+50ypr/LJsQ6KxVLjCw0iJjJpWChNpvd0NFWgM2AUb+
	 2IH6/os9ZGoXX9Nyxe3IkJZqGjwCo9SW+hTEinG1F9mhwK9kOF+3vofbgoAR8QnbUW55ElIgMH04
	 StPvvubhmRxuqmsYct7OZ6CpKYvhb5HmdQzbtP6cr0Mw5t8JwkULku8uAYsdWwulCPWBUjsBZzZG
	 bkxl9RO8AZlzo8tmvew9DTjFb35NlCjcXyDck9UC0RLfn7L58x+M3dEv6+LT1WS1E29CQYvyGsoX
	 igRGG3is97COljAulrBcTEXbAKDwkjeRPSopAno7BXonbJV1zz1F4hD80xYhkWFTzOsZrO7eQNEG
	 vqAYDauXyJyflanORIKFHwYyWRnLiSLg3nTWMvg69FwayBqkR0gNNW8J17dLtwyq/RxEDyokxQXh
	 W0kpcSFJkgxxsiZO0sX5ynRUhT7qYU5nDdhrcWi35Nw3RtWa6kKXVsgJM140DFLBG06nbGGd4fd2
	 yLvlVBEjgHP28wNnUc64c7huWRRsE0hWpO/Uf11UZk4U+lfusa11T9B2W0DHgQ4r6jWpbiJZ9jDJ
	 y5pDJZKnLHCAEaB9hUI4tnX9yvW0JIGt3QwhcsgWvf5Bh9BjC+dWymoYxwUAAvuhAytFr9gwwGS9
	 jOATjG7R+c/9HPAXq0SFY6H3m1hkKalJQzWilmFMLGbN8ApVoH6S+kgXdCRlDD99hXIYamVZqiff
	 Vttz3wxwSgNo5zJ4GLe0FmXy3nqgedkzsgjYMSwQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: VegetablCat <vegetablecat@foxmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vegetablecat <vegetablecat@foxmail.com>
Subject: [PATCH] Input: xpad - add support for Beitong KP series controllers
Date: Sun, 26 Jul 2026 16:01:48 +0800
X-OQ-MSGID: <20260726080148.56301-1-vegetablecat@foxmail.com>
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

Additionally, add a minimal HID receiver driver for the KP40D
receiver dongle (0x20dd:0x515c) that binds to its HID interface
to prevent hid-generic from interfering.  This requires replacing
module_usb_driver() with manual module_init/module_exit to
register both the USB and HID drivers.

Tested on 20bc:5126 (KP20A) and 20bc:515b (KP40D).

Signed-off-by: vegetablecat <vegetablecat@foxmail.com>
---
 drivers/input/joystick/xpad.c | 111 +++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f36..d33ca18 100644
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
@@ -2312,7 +2357,71 @@ static struct usb_driver xpad_driver = {
 	.id_table	= xpad_table,
 };
 
-module_usb_driver(xpad_driver);
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
+
+static int __init xpad_init(void)
+{
+	int error;
+
+	error = hid_register_driver(&xpad_receiver_driver);
+	if (error)
+		return error;
+
+	error = usb_register(&xpad_driver);
+	if (error) {
+		hid_unregister_driver(&xpad_receiver_driver);
+		return error;
+	}
+
+	return 0;
+}
+
+static void __exit xpad_exit(void)
+{
+	usb_deregister(&xpad_driver);
+	hid_unregister_driver(&xpad_receiver_driver);
+}
+
+module_init(xpad_init);
+module_exit(xpad_exit);
 
 MODULE_AUTHOR("Marko Friedemann <mfr@bmx-chemnitz.de>");
 MODULE_DESCRIPTION("Xbox pad driver");
-- 
2.55.0

