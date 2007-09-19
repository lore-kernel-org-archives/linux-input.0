From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch] HID: use hid-plff driver for GreenAsia 0e8f:0003 devices
Date: Wed, 19 Sep 2007 16:36:48 +0300
Message-ID: <46F125F0.4050502@gmail.com>
References: <46F01785.6060501@gmail.com> <Pine.LNX.4.64.0709191155540.24429@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0709191155540.24429@twin.jikos.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Add 0e8f:0003 into the list of devices supported by the hid-plff
force feedback driver. These devices identify themselves as
"GreenAsia Inc.    USB Joystick     " and can be either adapters or
actual game controllers. The testing was done with a K=F6ng Gaming
gamepad.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---

Index: linux-2.6.23-rc6/drivers/hid/usbhid/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-rc6/drivers/hid/usbhid/Kconfig
+++ linux-2.6.23-rc6/drivers/hid/usbhid/Kconfig	2007-09-18 20:54:53.00000=
0000 +0300
@@ -71,12 +71,12 @@
 	  force feedback.
=20
 config PANTHERLORD_FF
-	bool "PantherLord USB/PS2 2in1 Adapter support"
+	bool "PantherLord/GreenAsia based device support"
 	depends on HID_FF
 	select INPUT_FF_MEMLESS if USB_HID
 	help
-	  Say Y here if you have a PantherLord USB/PS2 2in1 Adapter and want
-	  to enable force feedback support for it.
+	  Say Y here if you have a PantherLord/GreenAsia based game controller
+	  or adapter and want to enable force feedback support for it.
=20
 config THRUSTMASTER_FF
 	bool "ThrustMaster FireStorm Dual Power 2 support (EXPERIMENTAL)"
Index: linux-2.6.23-rc6/drivers/hid/usbhid/hid-ff.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-rc6/drivers/hid/usbhid/hid-ff.c
+++ linux-2.6.23-rc6/drivers/hid/usbhid/hid-ff.c	2007-09-18 20:45:51.0000=
00000 +0300
@@ -62,7 +62,8 @@
 	{ 0x46d, 0xca03, hid_lgff_init }, /* Logitech MOMO force wheel */
 #endif
 #ifdef CONFIG_PANTHERLORD_FF
-	{ 0x810, 0x0001, hid_plff_init },
+	{ 0x810, 0x0001, hid_plff_init }, /* "Twin USB Joystick" */
+	{ 0xe8f, 0x0003, hid_plff_init }, /* "GreenAsia Inc.    USB Joystick   =
  " */
 #endif
 #ifdef CONFIG_THRUSTMASTER_FF
 	{ 0x44f, 0xb300, hid_tmff_init },
Index: linux-2.6.23-rc6/drivers/hid/usbhid/hid-plff.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-rc6/drivers/hid/usbhid/hid-plff.c
+++ linux-2.6.23-rc6/drivers/hid/usbhid/hid-plff.c	2007-09-18 21:02:26.00=
0000000 +0300
@@ -1,5 +1,15 @@
 /*
- *  Force feedback support for PantherLord USB/PS2 2in1 Adapter devices
+ *  Force feedback support for PantherLord/GreenAsia based devices
+ *
+ *  The devices are distributed under various names and the same USB dev=
ice ID
+ *  can be used in both adapters and actual game controllers.
+ *
+ *  0810:0001 "Twin USB Joystick"
+ *   - tested with PantherLord USB/PS2 2in1 Adapter
+ *   - contains two reports, one for each port (HID_QUIRK_MULTI_INPUT)
+ *
+ *  0e8f:0003 "GreenAsia Inc.    USB Joystick     "
+ *   - tested with K=F6ng Gaming gamepad
  *
  *  Copyright (c) 2007 Anssi Hannula <anssi.hannula@gmail.com>
  */
@@ -67,11 +77,11 @@
 	struct input_dev *dev;
 	int error;
=20
-	/* The device contains 2 output reports (one for each
-	   HID_QUIRK_MULTI_INPUT device), both containing 1 field, which
-	   contains 4 ff00.0002 usages and 4 16bit absolute values.
+	/* The device contains one output report per physical device, all
+	   containing 1 field, which contains 4 ff00.0002 usages and 4 16bit
+	   absolute values.
=20
-	   The 2 input reports also contain a field which contains
+	   The input reports also contain a field which contains
 	   8 ff00.0001 usages and 8 boolean values. Their meaning is
 	   currently unknown. */
=20
@@ -122,8 +132,8 @@
 		usbhid_submit_report(hid, plff->report, USB_DIR_OUT);
 	}
=20
-	printk(KERN_INFO "hid-plff: Force feedback for PantherLord USB/PS2 "
-	       "2in1 Adapters by Anssi Hannula <anssi.hannula@gmail.com>\n");
+	printk(KERN_INFO "hid-plff: Force feedback for PantherLord/GreenAsia "
+	       "devices by Anssi Hannula <anssi.hannula@gmail.com>\n");
=20
 	return 0;
 }


--=20
Anssi Hannula
