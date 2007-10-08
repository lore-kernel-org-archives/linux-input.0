From: if <zeylie@gmail.com>
Subject: GeneralTouch USB Touchscreen Support
Date: Mon, 8 Oct 2007 14:05:13 +0400
Message-ID: <f37dba8b0710080305t37b57e3dpe2fd7be231893ba5@mail.gmail.com>
Reply-To: zeylienospam@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
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

Sending patch as told to.
Formal notes:
Patch made against 2.6.22.9 sources.
Marketing is lying, quick google for model ( TL6B17S) shows they say
it has 4096x4096 sensitivity, while device itself do not report more
than 0x0470 (i set 0x0500 as max), so with monitors greater than 1024
pixels special calibration is needed.
I wrote mail to manufacturer asking for linux drivers but got no
response, so i had no way but to sniff the usb bus and figure out how
to make the device work, and reversing is not illegal in my country.
I agree with GPL of course, the following patch can be used according to it ;-)

hope that's all

regards,
Ilya Frolov


======== lsusb -v for this device ===========
Bus 003 Device 002: ID 0dfc:0001 GeneralTouch Technology Co., Ltd Touchscreen
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0dfc GeneralTouch Technology Co., Ltd
  idProduct          0x0001 Touchscreen
  bcdDevice            0.01
  iManufacturer           1 General Touch Co. Ltd.
  iProduct                2 GeneralTouch USB Touchscreen
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          4 HID Touchscreen
    bmAttributes         0x60
      (Missing must-be-set bit!)
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      85
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0007  1x 7 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)


========= REST IS PATCH =============

diff -uprN -X linux-2.6.22.9-vanilla/Documentation/dontdiff
linux-2.6.22.9-vanilla/drivers/hid/usbhid/hid-quirks.c
linux-2.6.22.9.my/drivers/hid/usbhid/hid-quirks.c
--- linux-2.6.22.9-vanilla/drivers/hid/usbhid/hid-quirks.c	2007-09-26
22:03:01.000000000 +0400
+++ linux-2.6.22.9.my/drivers/hid/usbhid/hid-quirks.c	2007-10-04
13:36:52.000000000 +0400
@@ -217,6 +217,8 @@

 #define USB_VENDOR_ID_PANJIT		0x134c

+#define USB_VENDOR_ID_GENERAL_TOUCH	0x0dfc
+
 #define USB_VENDOR_ID_PANTHERLORD	0x0810
 #define USB_DEVICE_ID_PANTHERLORD_TWIN_USB_JOYSTICK	0x0001

@@ -284,7 +286,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_NEC, USB_DEVICE_ID_NEC_USB_GAME_PAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
-
+
 	{ USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION, HID_QUIRK_CYMOTION },

 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_DINOVO_EDGE,
HID_QUIRK_DUPLICATE_USAGES },
@@ -397,6 +399,10 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_PANJIT, 0x0002, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_PANJIT, 0x0003, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_PANJIT, 0x0004, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GENERAL_TOUCH, 0x0001, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GENERAL_TOUCH, 0x0002, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GENERAL_TOUCH, 0x0003, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GENERAL_TOUCH, 0x0004, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_LABPRO, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_GOTEMP, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_SKIP, HID_QUIRK_IGNORE },
@@ -581,7 +587,7 @@ static void usbhid_remove_all_dquirks(vo

 }

-/**
+/**
  * usbhid_quirks_init: apply USB HID quirks specified at module load time
  */
 int usbhid_quirks_init(char **quirks_param)
@@ -644,7 +650,7 @@ static const struct hid_blacklist *usbhi

 	if (bl_entry != NULL)
 		dbg("Found squirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\n",
-				bl_entry->quirks, bl_entry->idVendor,
+				bl_entry->quirks, bl_entry->idVendor,
 				bl_entry->idProduct);
 	return bl_entry;
 }
diff -uprN -X linux-2.6.22.9-vanilla/Documentation/dontdiff
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
diff -uprN -X linux-2.6.22.9-vanilla/Documentation/dontdiff
linux-2.6.22.9-vanilla/drivers/input/touchscreen/usbtouchscreen.c
linux-2.6.22.9.my/drivers/input/touchscreen/usbtouchscreen.c
--- linux-2.6.22.9-vanilla/drivers/input/touchscreen/usbtouchscreen.c	2007-09-26
22:03:01.000000000 +0400
+++ linux-2.6.22.9.my/drivers/input/touchscreen/usbtouchscreen.c	2007-10-05
11:40:36.000000000 +0400
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
