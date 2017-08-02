From: zboszor@pr.hu
Subject: [PATCH v2] Input: usbtouchscreen - handle HID class 0x0eef:0x0001 device
Date: Wed,  2 Aug 2017 13:46:39 +0200
Message-ID: <20170802114639.9445-1-zboszor@pr.hu>
References: <20170802091504.29702-1-zboszor@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:35112 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753078AbdHBLqu (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 2 Aug 2017 07:46:50 -0400
In-Reply-To: <20170802091504.29702-1-zboszor@pr.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, =?UTF-8?q?B=C3=B6sz=C3=B6rm=C3=A9nyi=20Zolt=C3=A1n?= <zboszor@pr.hu>

From: Böszörményi Zoltán <zboszor@pr.hu>

The device was previously handled by hid-multitouch only half way,
BTN_TOUCH events were not emitted so Xorg could only detect motion.

The EETI vendor magic sequence is different from what the old
capacitive touchscreen documentation contains which is now used
for this device. Touch events are also implemented for this device
acording to the vendor device driver.

usbhid and hid-multitouch now ignore this device.

v2: Removed copy & paste leftovers

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
---
 drivers/hid/hid-core.c                     |  1 +
 drivers/hid/usbhid/hid-quirks.c            |  1 -
 drivers/input/touchscreen/usbtouchscreen.c | 79 +++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9017dcc14502..3be59cb199dd 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2640,6 +2640,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DEALEXTREAME, USB_DEVICE_ID_DEALEXTREAME_RADIO_SI4701) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER)},
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0401) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index a88e7c7bea0a..3a807485a415 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -34,7 +34,6 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD, HID_QUIRK_BADPAD },
-	{ USB_VENDOR_ID_DWAV, USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER, HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_MOJO, USB_DEVICE_ID_RETRO_ADAPTER, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 2c41107240de..07a8a3a586a8 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -125,6 +125,7 @@ struct usbtouch_usb {
 enum {
 	DEVTYPE_IGNORE = -1,
 	DEVTYPE_EGALAX,
+	DEVTYPE_EGALAX_VENDOR_CODE,
 	DEVTYPE_PANJIT,
 	DEVTYPE_3M,
 	DEVTYPE_ITM,
@@ -155,7 +156,7 @@ enum {
 static const struct usb_device_id usbtouch_devices[] = {
 #ifdef CONFIG_TOUCHSCREEN_USB_EGALAX
 	/* ignore the HID capable devices, handled by usbhid */
-	{USB_DEVICE_HID_CLASS(0x0eef, 0x0001), .driver_info = DEVTYPE_IGNORE},
+	{USB_DEVICE_HID_CLASS(0x0eef, 0x0001), .driver_info = DEVTYPE_EGALAX_VENDOR_CODE},
 	{USB_DEVICE_HID_CLASS(0x0eef, 0x0002), .driver_info = DEVTYPE_IGNORE},
 
 	/* normal device IDs */
@@ -370,6 +371,73 @@ static int egalax_get_pkt_len(unsigned char *buf, int len)
 
 	return 0;
 }
+
+/* eGalax vendor constants */
+#define EGALAX_MOUSE		0x01
+#define EGALAX_DIGITIZER	0x02
+#define EGALAX_VENDORCMD	0x03
+#define EGALAX_MT		0x04
+#define EGALAX_MTOUCH_ALLPOINT	0x06
+
+static int egalax_vendor_init(struct usbtouch_usb *usbtouch)
+{
+	int ret, i;
+	unsigned char *buf;
+	struct usb_device *udev = interface_to_usbdev(usbtouch->interface);
+
+	/*
+	 * An eGalax diagnostic packet kicks the device into using the right
+	 * protocol.  We send a "check active" packet.  The response will be
+	 * read later and ignored.
+	 */
+
+	buf = kmalloc(3, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* EETI vendor magic */
+	buf[0] = 0x05;
+	buf[1] = 0x02;
+	buf[2] = 0x00;
+
+	for (i = 0; i < 3; i++) {
+		ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+				      0,
+				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				      0, 0, buf, 3,
+				      USB_CTRL_SET_TIMEOUT);
+		if (ret >= 0) {
+			ret = 0;
+			break;
+		}
+		if (ret != -EPIPE)
+			break;
+	}
+
+	kfree(buf);
+
+	return ret;
+}
+
+static int egalax_vendor_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
+{
+	switch (pkt[0]) {
+	case EGALAX_MOUSE:
+	case EGALAX_DIGITIZER:
+	case EGALAX_MT:
+		dev->x = ((pkt[3] << 8) + pkt[2]) >> 1;
+		dev->y = ((pkt[5] << 8) + pkt[4]) >> 1;
+		dev->touch = pkt[1] & 0x01;
+		return 1;
+	case EGALAX_MTOUCH_ALLPOINT:
+		/* ignore, TODO */
+		return 0;
+	case EGALAX_VENDORCMD:
+	default:
+		return 0;
+	}
+}
+
 #endif
 
 /*****************************************************************************
@@ -1100,6 +1168,15 @@ static struct usbtouch_device_info usbtouch_dev_info[] = {
 		.read_data	= egalax_read_data,
 		.init		= egalax_init,
 	},
+	[DEVTYPE_EGALAX_VENDOR_CODE] = {
+		.min_xc		= 0x0,
+		.max_xc		= 0x07ff,
+		.min_yc		= 0x0,
+		.max_yc		= 0x07ff,
+		.rept_size	= 16,
+		.read_data	= egalax_vendor_read_data,
+		.init		= egalax_vendor_init,
+	},
 #endif
 
 #ifdef CONFIG_TOUCHSCREEN_USB_PANJIT
-- 
2.13.3

