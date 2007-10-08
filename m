From: if <zeylienospam@gmail.com>
Subject: Re: GeneralTouch USB Touchscreen Support
Date: Mon, 8 Oct 2007 22:04:28 +0400
Message-ID: <f37dba8b0710081104l52c0c0b4j25dc60c4e6b05c99@mail.gmail.com>
References: <f37dba8b0710080305t37b57e3dpe2fd7be231893ba5@mail.gmail.com>
	 <d120d5000710080623o4a0be879w45d59be6ee025d40@mail.gmail.com>
	 <Pine.LNX.4.64.0710081633330.25413@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0710081633330.25413@twin.jikos.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry.torokhov@gmail.com
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hello!

Thanks for correcting me (my vim automatically strips leading whitespace)
Below is the correct patch, without whitespace difference and with
hid-quirks entry sorted.

        Signed-off-by: Ilya Frolov <zeylie@gmail.com>

regards,
Ilya

========== REST IS PATCH ===================

diff -uprNb -X linux-2.6.22.9-vanilla/Documentation/dontdiff
linux-2.6.22.9-vanilla/drivers/hid/usbhid/hid-quirks.c
linux-2.6.22.9.my/drivers/hid/usbhid/hid-quirks.c
--- linux-2.6.22.9-vanilla/drivers/hid/usbhid/hid-quirks.c	2007-09-26
22:03:01.000000000 +0400
+++ linux-2.6.22.9.my/drivers/hid/usbhid/hid-quirks.c	2007-10-08
21:55:50.000000000 +0400
@@ -105,6 +105,8 @@
 #define USB_VENDOR_ID_ESSENTIAL_REALITY	0x0d7f
 #define USB_DEVICE_ID_ESSENTIAL_REALITY_P5 0x0100

+#define USB_VENDOR_ID_GENERAL_TOUCH	0x0dfc
+
 #define USB_VENDOR_ID_GLAB		0x06c2
 #define USB_DEVICE_ID_4_PHIDGETSERVO_30	0x0038
 #define USB_DEVICE_ID_1_PHIDGETSERVO_30	0x0039
@@ -308,6 +310,10 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ESSENTIAL_REALITY,
USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GENERAL_TOUCH, 0x0001, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GENERAL_TOUCH, 0x0002, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GENERAL_TOUCH, 0x0003, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GENERAL_TOUCH, 0x0004, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GLAB, USB_DEVICE_ID_4_PHIDGETSERVO_30, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GLAB, USB_DEVICE_ID_1_PHIDGETSERVO_30, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_0_4_IF_KIT, HID_QUIRK_IGNORE },
diff -uprNb -X linux-2.6.22.9-vanilla/Documentation/dontdiff
linux-2.6.22.9-vanilla/drivers/input/touchscreen/Kconfig
linux-2.6.22.9.my/drivers/input/touchscreen/Kconfig
--- linux-2.6.22.9-vanilla/drivers/input/touchscreen/Kconfig	2007-09-26
22:03:01.000000000 +0400
+++ linux-2.6.22.9.my/drivers/input/touchscreen/Kconfig	2007-10-04
12:58:16.000000000 +0400
@@ -219,4 +219,9 @@ config TOUCHSCREEN_USB_DMC_TSC10
 	bool "DMC TSC-10/25 device support" if EMBEDDED
 	depends on TOUCHSCREEN_USB_COMPOSITE

+config TOUCHSCREEN_USB_GENERAL_TOUCH
+	default y
+	bool "GeneralTouch Touchscreen device support" if EMBEDDED
+	depends on TOUCHSCREEN_USB_COMPOSITE
+
 endif
diff -uprNb -X linux-2.6.22.9-vanilla/Documentation/dontdiff
linux-2.6.22.9-vanilla/drivers/input/touchscreen/usbtouchscreen.c
linux-2.6.22.9.my/drivers/input/touchscreen/usbtouchscreen.c
--- linux-2.6.22.9-vanilla/drivers/input/touchscreen/usbtouchscreen.c	2007-09-26
22:03:01.000000000 +0400
+++ linux-2.6.22.9.my/drivers/input/touchscreen/usbtouchscreen.c	2007-10-08
21:42:35.000000000 +0400
@@ -110,6 +110,7 @@ enum {
 	DEVTYPE_ETURBO,
 	DEVTYPE_GUNZE,
 	DEVTYPE_DMC_TSC10,
+	DEVTYPE_GENERAL_TOUCH,
 };

 static struct usb_device_id usbtouch_devices[] = {
@@ -150,6 +151,10 @@ static struct usb_device_id usbtouch_dev
 	{USB_DEVICE(0x0afa, 0x03e8), .driver_info = DEVTYPE_DMC_TSC10},
 #endif

+#ifdef CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH
+	{USB_DEVICE(0x0dfc, 0x0001), .driver_info = DEVTYPE_GENERAL_TOUCH},
+#endif
+
 	{}
 };

@@ -414,6 +419,20 @@ static int dmc_tsc10_read_data(struct us
 }
 #endif

+/*****************************************************************************
+ * General Touch Part
+ */
+#ifdef CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH
+static int general_touch_read_data(struct usbtouch_usb *dev, unsigned
char *pkt)
+{
+	dev->x = ((pkt[2] & 0x0F) << 8) | pkt[1] ;
+	dev->y = ((pkt[4] & 0x0F) << 8) | pkt[3] ;
+	dev->press = pkt[5] & 0xff;
+	dev->touch = pkt[0] & 0x01;
+
+	return 1;
+}
+#endif

 /*****************************************************************************
  * the different device descriptors
@@ -504,6 +523,18 @@ static struct usbtouch_device_info usbto
 		.read_data	= dmc_tsc10_read_data,
 	},
 #endif
+
+#ifdef CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH
+	[DEVTYPE_GENERAL_TOUCH] = {
+		.min_xc		= 0x0,
+		.max_xc		= 0x0500,
+		.min_yc		= 0x0,
+		.max_yc		= 0x0500,
+		.rept_size	= 7,
+		.read_data	= general_touch_read_data,
+	}
+#endif
+
 };
