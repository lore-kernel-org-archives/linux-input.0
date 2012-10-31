From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] HID: Add driver for ION iCade
Date: Wed, 31 Oct 2012 12:10:10 +0100
Message-ID: <1351681810.14430.1.camel@sirocco.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55471 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935344Ab2JaLKO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 07:10:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, Jiri Kosina <jkosina@suse.cz>


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

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/Kconfig     |   9 ++
 drivers/hid/Makefile    |   1 +
 drivers/hid/hid-core.c  |   1 +
 drivers/hid/hid-icade.c | 259 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 drivers/hid/hid-ids.h   |   3 +
 5 files changed, 273 insertions(+)
 create mode 100644 drivers/hid/hid-icade.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 1630150..813f0fe 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -265,6 +265,15 @@ config HID_GYRATION
 	---help---
 	Support for Gyration remote control.
=20
+config HID_ICADE
+	tristate "ION iCade arcade controller"
+	depends on (BT_HIDP)
+	---help---
+	Support for the ION iCade arcade controller to work as a joystick.
+
+	To compile this driver as a module, choose M here: the
+	module will be called hid-icade.
+
 config HID_TWINHAN
 	tristate "Twinhan IR remote control"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index cef68ca..85c910c 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_HID_GYRATION)	+=3D hid-gyration.o
 obj-$(CONFIG_HID_HOLTEK)	+=3D hid-holtek-kbd.o
 obj-$(CONFIG_HID_HOLTEK)	+=3D hid-holtekff.o
 obj-$(CONFIG_HID_HYPERV_MOUSE)	+=3D hid-hyperv.o
+obj-$(CONFIG_HID_ICADE)		+=3D hid-icade.o
 obj-$(CONFIG_HID_KENSINGTON)	+=3D hid-kensington.o
 obj-$(CONFIG_HID_KEYTOUCH)	+=3D hid-keytouch.o
 obj-$(CONFIG_HID_KYE)		+=3D hid-kye.o
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
index 0000000..1d6565e
--- /dev/null
+++ b/drivers/hid/hid-icade.c
@@ -0,0 +1,259 @@
+/*
+ *  ION iCade input driver
+ *
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
+
+#include "hid-ids.h"
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
+
+/* The translation code uses HID usage instead of input layer
+ * keys. This code generates a lookup table that makes
+ * translation quick.
+ *
+ * #include <linux/input.h>
+ * #include <stdio.h>
+ * #include <assert.h>
+ *
+ * #define unk     KEY_UNKNOWN
+ *
+ * < copy of hid_keyboard[] from hid-input.c >
+ *
+ * struct icade_key_translation {
+ *     int         from;
+ *     const char *to;
+ *     int         press;
+ * };
+ *
+ * static const struct icade_key_translation icade_keys[] =3D {
+ *    { KEY_W,        "KEY_UP",         1 },
+ *    { KEY_E,        "KEY_UP",         0 },
+ *    { KEY_D,        "KEY_RIGHT",      1 },
+ *    { KEY_C,        "KEY_RIGHT",      0 },
+ *    { KEY_X,        "KEY_DOWN",       1 },
+ *    { KEY_Z,        "KEY_DOWN",       0 },
+ *    { KEY_A,        "KEY_LEFT",       1 },
+ *    { KEY_Q,        "KEY_LEFT",       0 },
+ *    { KEY_Y,        "BTN_A",          1 },
+ *    { KEY_T,        "BTN_A",          0 },
+ *    { KEY_H,        "BTN_B",          1 },
+ *    { KEY_R,        "BTN_B",          0 },
+ *    { KEY_U,        "BTN_C",          1 },
+ *    { KEY_F,        "BTN_C",          0 },
+ *    { KEY_J,        "BTN_X",          1 },
+ *    { KEY_N,        "BTN_X",          0 },
+ *    { KEY_I,        "BTN_Y",          1 },
+ *    { KEY_M,        "BTN_Y",          0 },
+ *    { KEY_K,        "BTN_Z",          1 },
+ *    { KEY_P,        "BTN_Z",          0 },
+ *    { KEY_O,        "BTN_THUMBL",     1 },
+ *    { KEY_G,        "BTN_THUMBL",     0 },
+ *    { KEY_L,        "BTN_THUMBR",     1 },
+ *    { KEY_V,        "BTN_THUMBR",     0 },
+ *
+ *    { }
+ * };
+ *
+ * static int
+ * usage_for_key (int key)
+ * {
+ *     int i;
+ *     for (i =3D 0; i < 256; i++) {
+ *     if (hid_keyboard[i] =3D=3D key)
+ *         return i;
+ *     }
+ *     assert(0);
+ * }
+ *
+ * int main (int argc, char **argv)
+ * {
+ *     const struct icade_key_translation *trans;
+ *     int max_usage =3D 0;
+ *
+ *     for (trans =3D icade_keys; trans->from; trans++) {
+ *         int usage =3D usage_for_key (trans->from);
+ *         max_usage =3D usage > max_usage ? usage : max_usage;
+ *     }
+ *
+ *     printf ("#define ICADE_MAX_USAGE %d\n\n", max_usage);
+ *     printf ("struct icade_key {\n");
+ *     printf ("\tu16 to;\n");
+ *     printf ("\tu8 press:1;\n");
+ *     printf ("};\n\n");
+ *     printf ("static const struct icade_key "
+ *             "icade_usage_table[%d] =3D {\n", max_usage + 1);
+ *     for (trans =3D icade_keys; trans->from; trans++) {
+ *         printf ("\t[%d] =3D { %s, %d },\n",
+ *                 usage_for_key (trans->from), trans->to, trans->pres=
s);
+ *     }
+ *     printf ("};\n");
+ *
+ *     return 0;
+ * }
+ */
+
+#define ICADE_MAX_USAGE 29
+
+struct icade_key {
+	u16 to;
+	u8 press:1;
+};
+
+static const struct icade_key icade_usage_table[30] =3D {
+	[26] =3D { KEY_UP, 1 },
+	[8] =3D { KEY_UP, 0 },
+	[7] =3D { KEY_RIGHT, 1 },
+	[6] =3D { KEY_RIGHT, 0 },
+	[27] =3D { KEY_DOWN, 1 },
+	[29] =3D { KEY_DOWN, 0 },
+	[4] =3D { KEY_LEFT, 1 },
+	[20] =3D { KEY_LEFT, 0 },
+	[28] =3D { BTN_A, 1 },
+	[23] =3D { BTN_A, 0 },
+	[11] =3D { BTN_B, 1 },
+	[21] =3D { BTN_B, 0 },
+	[24] =3D { BTN_C, 1 },
+	[9] =3D { BTN_C, 0 },
+	[13] =3D { BTN_X, 1 },
+	[17] =3D { BTN_X, 0 },
+	[12] =3D { BTN_Y, 1 },
+	[16] =3D { BTN_Y, 0 },
+	[14] =3D { BTN_Z, 1 },
+	[19] =3D { BTN_Z, 0 },
+	[18] =3D { BTN_THUMBL, 1 },
+	[10] =3D { BTN_THUMBL, 0 },
+	[15] =3D { BTN_THUMBR, 1 },
+	[25] =3D { BTN_THUMBR, 0 },
+};
+
+static const struct icade_key *icade_find_translation(u16 from)
+{
+	if (from < 0 || from > ICADE_MAX_USAGE)
+		return NULL;
+	return &icade_usage_table[from];
+}
+
+static int icade_event(struct hid_device *hdev, struct hid_field *fiel=
d,
+		struct hid_usage *usage, __s32 value)
+{
+	const struct icade_key *trans;
+
+	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput ||
+			!usage->type)
+		return 0;
+
+	/* We ignore the fake key up, and act only on key down */
+	if (!value)
+		return 1;
+
+	trans =3D icade_find_translation(usage->hid & HID_USAGE);
+
+	if (!trans)
+		return 1;
+
+	input_event(field->hidinput->input, usage->type,
+			trans->to, trans->press);
+
+	return 1;
+}
+
+static int icade_input_mapping(struct hid_device *hdev, struct hid_inp=
ut *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	const struct icade_key *trans;
+
+	if ((usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_KEYBOARD) {
+		trans =3D icade_find_translation(usage->hid & HID_USAGE);
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
+MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");
+MODULE_DESCRIPTION("ION iCade input driver");
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
