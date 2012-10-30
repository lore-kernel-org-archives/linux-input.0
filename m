From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] HID: Add driver for ION iCade
Date: Tue, 30 Oct 2012 20:55:41 +0100
Message-ID: <1351626941.11123.2.camel@sirocco.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51351 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab2J3Tzq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Oct 2012 15:55:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, benjamin.tissoires@gmail.com


Add a driver for the ION iCade mini arcade cabinet [1]. The device
generates a key press and release for each joystick movement or
button press or release. For example, moving the stick to the
left will generate the "A" key being pressed and the released.

A list of all the combinations is available in the iCade
developer guide [2].

This driver hides all this and makes the device work as a generic
joystick.

[1]: http://www.ionaudio.com/products/details/icade
[2]: http://www.ionaudio.com/downloads/iCade_Dev_Resource_v1.3.pdf
---
 drivers/hid/Kconfig     |   6 ++
 drivers/hid/Makefile    |   1 +
 drivers/hid/hid-core.c  |   1 +
 drivers/hid/hid-icade.c | 194 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 drivers/hid/hid-ids.h   |   3 +
 5 files changed, 205 insertions(+)
 create mode 100644 drivers/hid/hid-icade.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 1630150..750d435 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -265,6 +265,12 @@ config HID_GYRATION
 	---help---
 	Support for Gyration remote control.
=20
+config HID_ICADE
+	tristate "ION iCade arcade controller"
+	depends on (BT_HIDP)
+	---help---
+	Support for the ION iCade arcade controller to work as a joystick.
+
 config HID_TWINHAN
 	tristate "Twinhan IR remote control"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index cef68ca..9860d97 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_HID_LCPOWER)       +=3D hid-lcpower.o
 obj-$(CONFIG_HID_LENOVO_TPKBD)	+=3D hid-lenovo-tpkbd.o
 obj-$(CONFIG_HID_LOGITECH)	+=3D hid-logitech.o
 obj-$(CONFIG_HID_LOGITECH_DJ)	+=3D hid-logitech-dj.o
+obj-$(CONFIG_HID_ICADE)		+=3D hid-icade.o
 obj-$(CONFIG_HID_MAGICMOUSE)    +=3D hid-magicmouse.o
 obj-$(CONFIG_HID_MICROSOFT)	+=3D hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+=3D hid-monterey.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bd3971b..0a6b36f 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1572,6 +1572,7 @@ static const struct hid_device_id hid_have_specia=
l_driver[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8086, USB_DEVICE_ID_SENSOR_HUB_0=
9FA) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087, USB_DEVICE_ID_SENSOR_HUB_1=
020) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087, USB_DEVICE_ID_SENSOR_HUB_0=
9FA) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ION, USB_DEVICE_ID_ICADE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE=
) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KEYTOUCH, USB_DEVICE_ID_KEYTOUCH_IEC) =
},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
diff --git a/drivers/hid/hid-icade.c b/drivers/hid/hid-icade.c
new file mode 100644
index 0000000..54e1cb9
--- /dev/null
+++ b/drivers/hid/hid-icade.c
@@ -0,0 +1,194 @@
+/*
+ *  USB HID quirks support for Linux
+ *
+ *  Copyright (c) 1999 Andreas Gal
+ *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Conc=
ept2, Inc
+ *  Copyright (c) 2006-2007 Jiri Kosina
+ *  Copyright (c) 2007 Paul Walmsley
+ *  Copyright (c) 2008 Jiri Slaby <jirislaby@gmail.com>
+ *  Copyright (c) 2012 Bastien Nocera <hadess@hadess.net>
+ *  Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.co=
m>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License as published by t=
he Free
+ * Software Foundation; either version 2 of the License, or (at your o=
ption)
+ * any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+
+#include "hid-ids.h"
+
+struct icade_key_translation {
+	u16 from_key;
+	u16 from_usage; /* hid_keyboard[from_usage] =3D=3D from_key */
+	u16 to;
+	u8  press : 1;
+};
+
+/*
+ *   =E2=86=91      A C Y L
+ *  =E2=86=90 =E2=86=92
+ *   =E2=86=93      B X Z R
+ *
+ *
+ *  UP ON,OFF  =3D w,e
+ *  RT ON,OFF  =3D d,c
+ *  DN ON,OFF  =3D x,z
+ *  LT ON,OFF  =3D a,q
+ *  A  ON,OFF  =3D y,t
+ *  B  ON,OFF  =3D h,r
+ *  C  ON,OFF  =3D u,f
+ *  X  ON,OFF  =3D j,n
+ *  Y  ON,OFF  =3D i,m
+ *  Z  ON,OFF  =3D k,p
+ *  L  ON,OFF  =3D o,g
+ *  R  ON,OFF  =3D l,v
+ */
+static const struct icade_key_translation icade_keys[] =3D {
+	{ KEY_W,	26,	KEY_UP,		1 },
+	{ KEY_E,	8,	KEY_UP,		0 },
+	{ KEY_D,	7,	KEY_RIGHT,	1 },
+	{ KEY_C,	6,	KEY_RIGHT,	0 },
+	{ KEY_X,	27,	KEY_DOWN,	1 },
+	{ KEY_Z,	29,	KEY_DOWN,	0 },
+	{ KEY_A,	4,	KEY_LEFT,	1 },
+	{ KEY_Q,	20,	KEY_LEFT,	0 },
+	{ KEY_Y,	28,	BTN_A,		1 },
+	{ KEY_T,	23,	BTN_A,		0 },
+	{ KEY_H,	11,	BTN_B,		1 },
+	{ KEY_R,	21,	BTN_B,		0 },
+	{ KEY_U,	24,	BTN_C,		1 },
+	{ KEY_F,	9,	BTN_C,		0 },
+	{ KEY_J,	13,	BTN_X,		1 },
+	{ KEY_N,	17,	BTN_X,		0 },
+	{ KEY_I,	12,	BTN_Y,		1 },
+	{ KEY_M,	16,	BTN_Y,		0 },
+	{ KEY_K,	14,	BTN_Z,		1 },
+	{ KEY_P,	19,	BTN_Z,		0 },
+	{ KEY_O,	18,	BTN_THUMBL,	1 },
+	{ KEY_G,	10,	BTN_THUMBL,	0 },
+	{ KEY_L,	15,	BTN_THUMBR,	1 },
+	{ KEY_V,	25,	BTN_THUMBR,	0 },
+
+	{ }
+};
+
+static const struct icade_key_translation *icade_find_translation(
+		u16 from)
+{
+	const struct icade_key_translation *trans;
+
+	/* Look for the translation */
+	for (trans =3D icade_keys; trans->from_key; trans++)
+		if (trans->from_usage =3D=3D from)
+			return trans;
+
+	return NULL;
+}
+
+static int icade_event(struct hid_device *hdev, struct hid_field *fiel=
d,
+		struct hid_usage *usage, __s32 value)
+{
+	const struct icade_key_translation *trans;
+	unsigned code;
+
+	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput ||
+			!usage->type)
+		return 0;
+
+	code =3D usage->hid & HID_USAGE;
+
+	/* We ignore the fake key up, and act only on key down */
+	if (!value)
+		return 1;
+
+	trans =3D icade_find_translation (code);
+
+	if (!trans)
+		return 1;
+
+	input_event(field->hidinput->input, usage->type, trans->to, trans->pr=
ess);
+
+	return 1;
+}
+
+static int icade_input_mapping(struct hid_device *hdev, struct hid_inp=
ut *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	const struct icade_key_translation *trans;
+	unsigned code;
+
+	if ((usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_KEYBOARD) {
+		/* find out which KEY_ code is (usage->hid & HID_USAGE)
+		 * and store it into code */
+		code =3D usage->hid & HID_USAGE;
+
+		trans =3D icade_find_translation (code);
+
+		if (!trans)
+			return -1;
+
+		hid_map_usage(hi, usage, bit, max, EV_KEY, trans->to);
+		set_bit(trans->to, hi->input->keybit);
+
+		return 1;
+	}
+
+	/* ignore others */
+	return -1;
+
+}
+
+static int icade_input_mapped(struct hid_device *hdev, struct hid_inpu=
t *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	if (usage->type =3D=3D EV_KEY)
+		set_bit(usage->type, hi->input->evbit);
+
+	return -1;
+}
+
+static const struct hid_device_id icade_devices[] =3D {
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ION, USB_DEVICE_ID_ICADE) },
+
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, icade_devices);
+
+static struct hid_driver icade_driver =3D {
+	.name =3D "icade",
+	.id_table =3D icade_devices,
+	.event =3D icade_event,
+	.input_mapped =3D icade_input_mapped,
+	.input_mapping =3D icade_input_mapping,
+};
+
+static int __init icade_init(void)
+{
+	int ret;
+
+	ret =3D hid_register_driver(&icade_driver);
+	if (ret)
+		pr_err("can't register icade driver\n");
+
+	return ret;
+}
+
+static void __exit icade_exit(void)
+{
+	hid_unregister_driver(&icade_driver);
+}
+
+module_init(icade_init);
+module_exit(icade_exit);
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 269b509..9bc8d57 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -420,6 +420,9 @@
 #define USB_VENDOR_ID_ILITEK		0x222a
 #define USB_DEVICE_ID_ILITEK_MULTITOUCH	0x0001
=20
+#define USB_VENDOR_ID_ION		0x15e4
+#define USB_DEVICE_ID_ICADE		0x0132
+
 #define USB_VENDOR_ID_HOLTEK		0x1241
 #define USB_DEVICE_ID_HOLTEK_ON_LINE_GRIP	0x5015
=20
--=20
1.7.12.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
