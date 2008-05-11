From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 8/9] HID: move apple quirks
Date: Sun, 11 May 2008 22:00:42 +0200
Message-ID: <1210536043-19812-8-git-send-email-jirislaby@gmail.com>
References: <1210536043-19812-1-git-send-email-jirislaby@gmail.com>
 <1210536043-19812-2-git-send-email-jirislaby@gmail.com>
 <1210536043-19812-3-git-send-email-jirislaby@gmail.com>
 <1210536043-19812-4-git-send-email-jirislaby@gmail.com>
 <1210536043-19812-5-git-send-email-jirislaby@gmail.com>
 <1210536043-19812-6-git-send-email-jirislaby@gmail.com>
 <1210536043-19812-7-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.wellnetcz.com ([212.24.148.102]:36601 "EHLO WNmonitoring"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759787AbYEKUG2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 11 May 2008 16:06:28 -0400
In-Reply-To: <1210536043-19812-7-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com, akpm@linux-foundation.org, Jiri Slaby <jirislaby@gmail.com>, Jiri Slaby <jslaby@suse.cz>

Move them from core code to separate driver.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/hid/Kconfig             |   14 ++
 drivers/hid/Makefile            |    1 +
 drivers/hid/hid-apple.c         |  471 +++++++++++++++++++++++++++++++=
++++++++
 drivers/hid/hid-core.c          |   33 +++-
 drivers/hid/hid-input-quirks.c  |    8 -
 drivers/hid/hid-input.c         |  219 +------------------
 drivers/hid/usbhid/Kconfig      |   11 -
 drivers/hid/usbhid/hid-quirks.c |   43 ----
 include/linux/hid.h             |   12 -
 net/bluetooth/hidp/core.c       |   22 --
 10 files changed, 519 insertions(+), 315 deletions(-)
 create mode 100644 drivers/hid/hid-apple.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 066e8c0..9a9fd7d 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -78,6 +78,20 @@ config HID_LOGITECH
 	Support for some Logitech devices which breaks less or more
 	HID specification.
=20
+config HID_APPLE
+	tristate "Apple"
+	default m
+	depends on (USB_HID || BT_HIDP)
+	---help---
+	Support for some Apple devices which less or more break
+	HID specification.
+
+	Say Y here if you want support for the special keys (Fn, Numlock) on
+	Apple iBooks, PowerBooks, MacBooks, MacBook Pros and aluminum USB
+	keyboards.
+
+	If unsure, say N.
+
 endmenu
=20
 endif # HID_SUPPORT
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index cae036b..8a5cbbe 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -9,6 +9,7 @@ hid-$(CONFIG_HID_DEBUG)		+=3D hid-debug.o
 hid-$(CONFIG_HIDRAW)		+=3D hidraw.o
=20
 obj-$(CONFIG_HID_LOGITECH)	+=3D hid-logitech.o
+obj-$(CONFIG_HID_APPLE)		+=3D hid-apple.o
=20
 obj-$(CONFIG_USB_HID)		+=3D usbhid/
 obj-$(CONFIG_USB_MOUSE)		+=3D usbhid/
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
new file mode 100644
index 0000000..ce1c21f
--- /dev/null
+++ b/drivers/hid/hid-apple.c
@@ -0,0 +1,471 @@
+/*
+ *  USB HID quirks support for Linux
+ *
+ *  Copyright (c) 1999 Andreas Gal
+ *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Conc=
ept2, Inc
+ *  Copyright (c) 2006-2007 Jiri Kosina
+ *  Copyright (c) 2007 Paul Walmsley
+ *  Copyright (c) 2008 Jiri Slaby <jslaby@suse.cz>
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
+#include <linux/autoconf.h>
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#include "hid-ids.h"
+
+#define APPLE_RDESC_JIS		0x0001
+#define APPLE_IGNORE_MOUSE	0x0002
+#define APPLE_HAS_FN		0x0004
+#define APPLE_FN_ON		0x0008	/* is fn pressed? */
+#define APPLE_HIDDEV		0x0010
+#define APPLE_ISO_KEYBOARD	0x0020
+#define APPLE_MIGHTYMOUSE	0x0040
+#define APPLE_INVERT_HWHEEL	0x0080
+#define APPLE_IGNORE_HIDINPUT	0x0100
+#define APPLE_NUMLOCK_EMULATION	0x0200
+
+#define APPLE_FLAG_FKEY		0x01
+
+static unsigned int fnmode =3D 1;
+module_param(fnmode, uint, 0644);
+MODULE_PARM_DESC(fnmode, "Mode of fn key on Apple keyboards (0 =3D dis=
abled, "
+		"[1] =3D fkeyslast, 2 =3D fkeysfirst)");
+
+struct apple_sc {
+	unsigned long quirks;
+	DECLARE_BITMAP(pressed_fn, KEY_CNT);
+	DECLARE_BITMAP(pressed_numlock, KEY_CNT);
+};
+
+struct apple_key_translation {
+	u16 from;
+	u16 to;
+	u8 flags;
+};
+
+static struct apple_key_translation apple_fn_keys[] =3D {
+	{ KEY_BACKSPACE, KEY_DELETE },
+	{ KEY_F1,	KEY_BRIGHTNESSDOWN, APPLE_FLAG_FKEY },
+	{ KEY_F2,	KEY_BRIGHTNESSUP,   APPLE_FLAG_FKEY },
+	{ KEY_F3,	KEY_FN_F5,          APPLE_FLAG_FKEY }, /* Expos=C3=A9 */
+	{ KEY_F4,	KEY_FN_F4,          APPLE_FLAG_FKEY }, /* Dashboard */
+	{ KEY_F7,	KEY_PREVIOUSSONG,   APPLE_FLAG_FKEY },
+	{ KEY_F8,	KEY_PLAYPAUSE,      APPLE_FLAG_FKEY },
+	{ KEY_F9,	KEY_NEXTSONG,       APPLE_FLAG_FKEY },
+	{ KEY_F10,	KEY_MUTE,           APPLE_FLAG_FKEY },
+	{ KEY_F11,	KEY_VOLUMEDOWN,     APPLE_FLAG_FKEY },
+	{ KEY_F12,	KEY_VOLUMEUP,       APPLE_FLAG_FKEY },
+	{ KEY_UP,	KEY_PAGEUP },
+	{ KEY_DOWN,	KEY_PAGEDOWN },
+	{ KEY_LEFT,	KEY_HOME },
+	{ KEY_RIGHT,	KEY_END },
+	{ }
+};
+
+static struct apple_key_translation powerbook_fn_keys[] =3D {
+	{ KEY_BACKSPACE, KEY_DELETE },
+	{ KEY_F1,	KEY_BRIGHTNESSDOWN,     APPLE_FLAG_FKEY },
+	{ KEY_F2,	KEY_BRIGHTNESSUP,       APPLE_FLAG_FKEY },
+	{ KEY_F3,	KEY_MUTE,               APPLE_FLAG_FKEY },
+	{ KEY_F4,	KEY_VOLUMEDOWN,         APPLE_FLAG_FKEY },
+	{ KEY_F5,	KEY_VOLUMEUP,           APPLE_FLAG_FKEY },
+	{ KEY_F6,	KEY_NUMLOCK,            APPLE_FLAG_FKEY },
+	{ KEY_F7,	KEY_SWITCHVIDEOMODE,    APPLE_FLAG_FKEY },
+	{ KEY_F8,	KEY_KBDILLUMTOGGLE,     APPLE_FLAG_FKEY },
+	{ KEY_F9,	KEY_KBDILLUMDOWN,       APPLE_FLAG_FKEY },
+	{ KEY_F10,	KEY_KBDILLUMUP,         APPLE_FLAG_FKEY },
+	{ KEY_UP,	KEY_PAGEUP },
+	{ KEY_DOWN,	KEY_PAGEDOWN },
+	{ KEY_LEFT,	KEY_HOME },
+	{ KEY_RIGHT,	KEY_END },
+	{ }
+};
+
+static struct apple_key_translation powerbook_numlock_keys[] =3D {
+	{ KEY_J,	KEY_KP1 },
+	{ KEY_K,	KEY_KP2 },
+	{ KEY_L,	KEY_KP3 },
+	{ KEY_U,	KEY_KP4 },
+	{ KEY_I,	KEY_KP5 },
+	{ KEY_O,	KEY_KP6 },
+	{ KEY_7,	KEY_KP7 },
+	{ KEY_8,	KEY_KP8 },
+	{ KEY_9,	KEY_KP9 },
+	{ KEY_M,	KEY_KP0 },
+	{ KEY_DOT,	KEY_KPDOT },
+	{ KEY_SLASH,	KEY_KPPLUS },
+	{ KEY_SEMICOLON, KEY_KPMINUS },
+	{ KEY_P,	KEY_KPASTERISK },
+	{ KEY_MINUS,	KEY_KPEQUAL },
+	{ KEY_0,	KEY_KPSLASH },
+	{ KEY_F6,	KEY_NUMLOCK },
+	{ KEY_KPENTER,	KEY_KPENTER },
+	{ KEY_BACKSPACE, KEY_BACKSPACE },
+	{ }
+};
+
+static struct apple_key_translation apple_iso_keyboard[] =3D {
+	{ KEY_GRAVE,	KEY_102ND },
+	{ KEY_102ND,	KEY_GRAVE },
+	{ }
+};
+
+static struct apple_key_translation *apple_find_translation(
+		struct apple_key_translation *table, u16 from)
+{
+	struct apple_key_translation *trans;
+
+	/* Look for the translation */
+	for (trans =3D table; trans->from; trans++)
+		if (trans->from =3D=3D from)
+			return trans;
+
+	return NULL;
+}
+
+static int hidinput_apple_event(struct hid_device *hid, struct input_d=
ev *input,
+		struct hid_usage *usage, __s32 value)
+{
+	struct apple_sc *asc =3D hid_get_drvdata(hid);
+	struct apple_key_translation *trans;
+
+	if (usage->code =3D=3D KEY_FN) {
+		if (value)
+			asc->quirks |=3D APPLE_FN_ON;
+		else
+			asc->quirks &=3D ~APPLE_FN_ON;
+
+		input_event(input, usage->type, usage->code, value);
+
+		return 1;
+	}
+
+	if (fnmode) {
+		int do_translate;
+
+		trans =3D apple_find_translation((hid->product < 0x220 ||
+					hid->product >=3D 0x300) ?
+					powerbook_fn_keys : apple_fn_keys,
+					usage->code);
+		if (trans) {
+			if (test_bit(usage->code, asc->pressed_fn))
+				do_translate =3D 1;
+			else if (trans->flags & APPLE_FLAG_FKEY)
+				do_translate =3D
+					(fnmode =3D=3D 2 && (asc->quirks & APPLE_FN_ON)) ||
+					(fnmode =3D=3D 1 && !(asc->quirks & APPLE_FN_ON));
+			else
+				do_translate =3D (asc->quirks & APPLE_FN_ON);
+
+			if (do_translate) {
+				if (value)
+					set_bit(usage->code, asc->pressed_fn);
+				else
+					clear_bit(usage->code, asc->pressed_fn);
+
+				input_event(input, usage->type, trans->to,
+						value);
+
+				return 1;
+			}
+		}
+
+		if (asc->quirks & APPLE_NUMLOCK_EMULATION &&
+				(test_bit(usage->code, asc->pressed_numlock) ||
+				test_bit(LED_NUML, input->led))) {
+			trans =3D apple_find_translation(powerbook_numlock_keys,
+					usage->code);
+
+			if (trans) {
+				if (value)
+					set_bit(usage->code,
+							asc->pressed_numlock);
+				else
+					clear_bit(usage->code,
+							asc->pressed_numlock);
+
+				input_event(input, usage->type, trans->to,
+						value);
+			}
+
+			return 1;
+		}
+	}
+
+	if (asc->quirks & APPLE_ISO_KEYBOARD) {
+		trans =3D apple_find_translation(apple_iso_keyboard, usage->code);
+		if (trans) {
+			input_event(input, usage->type, trans->to, value);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static int apple_event(struct hid_device *hdev, struct hid_field *fiel=
d,
+		struct hid_usage *usage, __s32 value)
+{
+	struct apple_sc *asc =3D hid_get_drvdata(hdev);
+
+	if (!field->hidinput)
+		return -ENODEV;
+
+	if ((asc->quirks & APPLE_INVERT_HWHEEL) &&
+			usage->code =3D=3D REL_HWHEEL) {
+		input_event(field->hidinput->input, usage->type, usage->code,
+				-value);
+		return 0;
+	}
+
+	if ((asc->quirks & APPLE_HAS_FN) &&
+			hidinput_apple_event(hdev, field->hidinput->input,
+				usage, value))
+		return 0;
+
+
+	return -ENODEV;
+}
+
+/*
+ * MacBook JIS keyboard has wrong logical maximum
+ */
+static void apple_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int rsize)
+{
+	struct apple_sc *asc =3D hid_get_drvdata(hdev);
+
+	if ((asc->quirks & APPLE_RDESC_JIS) && rsize >=3D 60 &&
+			rdesc[53] =3D=3D 0x65 && rdesc[59] =3D=3D 0x65) {
+		dev_info(&hdev->dev, "fixing up MacBook JIS keyboard report "
+				"descriptor\n");
+		rdesc[53] =3D rdesc[59] =3D 0xe7;
+	}
+}
+
+static void apple_setup_input(struct input_dev *input)
+{
+	struct apple_key_translation *trans;
+
+	set_bit(KEY_NUMLOCK, input->keybit);
+
+	/* Enable all needed keys */
+	for (trans =3D apple_fn_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+
+	for (trans =3D powerbook_fn_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+
+	for (trans =3D powerbook_numlock_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+
+	for (trans =3D apple_iso_keyboard; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+}
+
+static int apple_input_mapping(struct hid_device *hdev, struct hid_inp=
ut *hi,
+		struct hid_usage *usage, unsigned long **bit, int *max)
+{
+	if (usage->hid =3D=3D (HID_UP_CUSTOM | 0x0003)) {
+		/* The fn key on Apple USB keyboards */
+		set_bit(EV_REP, hi->input->evbit);
+		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_FN);
+		apple_setup_input(hi->input);
+		return 1;
+	}
+
+	/* we want the hid layer to go through standard path (set and ignore)=
 */
+	return 0;
+}
+
+static void apple_input_mapped(struct hid_device *hdev, struct hid_inp=
ut *hi,
+		struct hid_usage *usage, unsigned long **bit, int *max)
+{
+	struct apple_sc *asc =3D hid_get_drvdata(hdev);
+
+	if (asc->quirks & APPLE_MIGHTYMOUSE) {
+		if (usage->hid =3D=3D HID_GD_Z)
+			hid_map_usage(hi, usage, bit, max, EV_REL, REL_HWHEEL);
+		else if (usage->code =3D=3D BTN_1)
+			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_2);
+		else if (usage->code =3D=3D BTN_2)
+			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_1);
+	}
+}
+
+static int apple_probe(struct hid_device *hdev,
+		const struct hid_device_id *id)
+{
+	unsigned long quirks =3D id->driver_data;
+	struct apple_sc *asc;
+	int ret;
+
+#if defined(CONFIG_USB_HID) || defined(CONFIG_USB_HID_MODULE)
+	/* return something else or move to hid layer? device will reside
+	   allocated */
+	if (id->bus =3D=3D BUS_USB && (id->driver_data & APPLE_IGNORE_MOUSE) =
&&
+			to_usb_interface(hdev->dev.parent)->cur_altsetting->
+			desc.bInterfaceProtocol =3D=3D USB_INTERFACE_PROTOCOL_MOUSE)
+		return -ENODEV;
+#endif
+
+	asc =3D kzalloc(sizeof(*asc), GFP_KERNEL);
+	if (asc =3D=3D NULL) {
+		dev_err(&hdev->dev, "can't alloc apple descriptor\n");
+		return -ENOMEM;
+	}
+
+	hid_set_drvdata(hdev, asc);
+
+	if (quirks & APPLE_HIDDEV)
+		hdev->quirks |=3D HID_QUIRK_HIDDEV;
+	if (quirks & APPLE_IGNORE_HIDINPUT)
+		hdev->quirks |=3D HID_QUIRK_IGNORE_HIDINPUT;
+
+	ret =3D hid_parse(hdev);
+	if (ret) {
+		dev_err(&hdev->dev, "parse failed\n");
+		goto err_free;
+	}
+
+	ret =3D hid_hw_start(hdev);
+	if (ret) {
+		dev_err(&hdev->dev, "hw start failed\n");
+		goto err_free;
+	}
+
+	return 0;
+err_free:
+	kfree(asc);
+	return ret;
+}
+
+static void apple_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	kfree(hid_get_drvdata(hdev));
+}
+
+static const struct hid_device_id apple_devices[] =3D {
+#if defined(CONFIG_USB_HID) || defined(CONFIG_USB_HID_MODULE)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4)=
,
+		.driver_data =3D APPLE_HIDDEV | APPLE_IGNORE_HIDINPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE=
),
+		.driver_data =3D APPLE_MIGHTYMOUSE | APPLE_INVERT_HWHEEL },
+
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_AN=
SI),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_IS=
O),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI=
),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO)=
,
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE | APPLE_ISO_KEYBOARD},
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS)=
,
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANS=
I),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO=
),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE | APPLE_ISO_KEYBOARD},
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS=
),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANS=
I),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO=
),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE | APPLE_ISO_KEYBOARD},
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS=
),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ANSI),
+		.driver_data =3D APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ISO),
+		.driver_data =3D APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_JIS),
+		.driver_data =3D APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_=
ANSI),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_=
ISO),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_=
JIS),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELES=
S_ANSI),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELES=
S_ISO),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_ISO_KEYBOARD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELES=
S_JIS),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP=
_ONLY),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_=
ONLY),
+		.driver_data =3D APPLE_HAS_FN | APPLE_NUMLOCK_EMULATION |
+			APPLE_IGNORE_MOUSE },
+
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS=
),
+		.driver_data =3D APPLE_RDESC_JIS },
+#endif
+
+#if defined(CONFIG_BT_HIDP) || defined(CONFIG_BT_HIDP_MODULE)
+	/* Apple wireless Mighty Mouse */
+	{ HID_BT_DEVICE(USB_VENDOR_ID_APPLE, 0x030c),
+		.driver_data =3D APPLE_MIGHTYMOUSE | APPLE_INVERT_HWHEEL },
+#endif
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, apple_devices);
+
+static struct hid_driver apple_driver =3D {
+	.name =3D "apple",
+	.id_table =3D apple_devices,
+	.report_fixup =3D apple_report_fixup,
+	.probe =3D apple_probe,
+	.remove =3D apple_remove,
+	.event =3D apple_event,
+	.input_mapping =3D apple_input_mapping,
+	.input_mapped =3D apple_input_mapped,
+};
+
+static int apple_init(void)
+{
+	int ret;
+
+	ret =3D hid_register_driver(&apple_driver);
+	if (ret)
+		printk(KERN_ERR "can't register apple driver\n");
+
+	return ret;
+}
+
+static void apple_exit(void)
+{
+	hid_unregister_driver(&apple_driver);
+}
+
+module_init(apple_init);
+module_exit(apple_exit);
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3406c1e..07676f2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1129,12 +1129,43 @@ static const struct hid_device_id hid_usb_black=
list[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVE=
R) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER)=
 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER_=
2) },
+	/* APPLE */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4)=
 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE=
) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_AN=
SI) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_IS=
O) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI=
) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO)=
 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS)=
 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANS=
I) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO=
) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS=
) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANS=
I) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO=
) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS=
) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ANSI) }=
,
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ISO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_JIS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_=
ANSI) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_=
ISO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_=
JIS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELES=
S_ANSI) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELES=
S_ISO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELES=
S_JIS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP=
_ONLY) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_=
ONLY) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS=
) },
+	{ }
+};
+
+static const struct hid_device_id hid_bt_blacklist[] =3D {
+	{ HID_BT_DEVICE(USB_VENDOR_ID_APPLE, 0x030c) },
 	{ }
 };
=20
 static const struct hid_device_id *hid_blacklist[] =3D {
 	[BUS_USB] =3D hid_usb_blacklist,
-	[BUS_BLUETOOTH] =3D NULL,
+	[BUS_BLUETOOTH] =3D hid_bt_blacklist,
 };
=20
 static int hid_bus_match(struct device *dev, struct device_driver *drv=
)
diff --git a/drivers/hid/hid-input-quirks.c b/drivers/hid/hid-input-qui=
rks.c
index 51ae184..ff9bbdd 100644
--- a/drivers/hid/hid-input-quirks.c
+++ b/drivers/hid/hid-input-quirks.c
@@ -399,19 +399,11 @@ int hidinput_event_quirks(struct hid_device *hid,=
 struct hid_field *field, struc
 		return 1;
 	}
=20
-	if ((hid->quirks & HID_QUIRK_INVERT_HWHEEL) && (usage->code =3D=3D RE=
L_HWHEEL)) {
-		input_event(input, usage->type, usage->code, -value);
-		return 1;
-	}
-
 	if ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_ON) && (usage->code =3D=
=3D REL_WHEEL)) {
 		input_event(input, usage->type, REL_HWHEEL, value);
 		return 1;
 	}
=20
-	if ((hid->quirks & HID_QUIRK_APPLE_HAS_FN) && hidinput_apple_event(hi=
d, input, usage, value))
-		return 1;
-
 	/* Handling MS keyboards special buttons */
 	if (hid->quirks & HID_QUIRK_MICROSOFT_KEYS &&=20
 			usage->hid =3D=3D (HID_UP_MSVENDOR | 0xff05)) {
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 5dc017e..0b13dca 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -34,11 +34,6 @@
 #include <linux/hid.h>
 #include <linux/hid-debug.h>
=20
-static int hid_apple_fnmode =3D 1;
-module_param_named(pb_fnmode, hid_apple_fnmode, int, 0644);
-MODULE_PARM_DESC(pb_fnmode,
-		"Mode of fn key on Apple keyboards (0 =3D disabled, 1 =3D fkeyslast,=
 2 =3D fkeysfirst)");
-
 #define unk	KEY_UNKNOWN
=20
 static const unsigned char hid_keyboard[256] =3D {
@@ -88,200 +83,6 @@ static const struct {
 #define map_key_clear(c)	hid_map_usage_clear(hidinput, usage, &bit, \
 		&max, EV_KEY, (c))
=20
-#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
-
-struct hidinput_key_translation {
-	u16 from;
-	u16 to;
-	u8 flags;
-};
-
-#define APPLE_FLAG_FKEY 0x01
-
-static struct hidinput_key_translation apple_fn_keys[] =3D {
-	{ KEY_BACKSPACE, KEY_DELETE },
-	{ KEY_F1,       KEY_BRIGHTNESSDOWN, APPLE_FLAG_FKEY },
-	{ KEY_F2,       KEY_BRIGHTNESSUP,   APPLE_FLAG_FKEY },
-	{ KEY_F3,       KEY_FN_F5,          APPLE_FLAG_FKEY }, /* Expos=E9 */
-	{ KEY_F4,       KEY_FN_F4,          APPLE_FLAG_FKEY }, /* Dashboard *=
/
-	{ KEY_F7,       KEY_PREVIOUSSONG,   APPLE_FLAG_FKEY },
-	{ KEY_F8,       KEY_PLAYPAUSE,      APPLE_FLAG_FKEY },
-	{ KEY_F9,       KEY_NEXTSONG,       APPLE_FLAG_FKEY },
-	{ KEY_F10,      KEY_MUTE,           APPLE_FLAG_FKEY },
-	{ KEY_F11,      KEY_VOLUMEDOWN,     APPLE_FLAG_FKEY },
-	{ KEY_F12,      KEY_VOLUMEUP,       APPLE_FLAG_FKEY },
-	{ KEY_UP,       KEY_PAGEUP },
-	{ KEY_DOWN,     KEY_PAGEDOWN },
-	{ KEY_LEFT,     KEY_HOME },
-	{ KEY_RIGHT,    KEY_END },
-	{ }
-};
-
-static struct hidinput_key_translation powerbook_fn_keys[] =3D {
-	{ KEY_BACKSPACE, KEY_DELETE },
-	{ KEY_F1,       KEY_BRIGHTNESSDOWN,     APPLE_FLAG_FKEY },
-	{ KEY_F2,       KEY_BRIGHTNESSUP,       APPLE_FLAG_FKEY },
-	{ KEY_F3,       KEY_MUTE,               APPLE_FLAG_FKEY },
-	{ KEY_F4,       KEY_VOLUMEDOWN,         APPLE_FLAG_FKEY },
-	{ KEY_F5,       KEY_VOLUMEUP,           APPLE_FLAG_FKEY },
-	{ KEY_F6,       KEY_NUMLOCK,            APPLE_FLAG_FKEY },
-	{ KEY_F7,       KEY_SWITCHVIDEOMODE,    APPLE_FLAG_FKEY },
-	{ KEY_F8,       KEY_KBDILLUMTOGGLE,     APPLE_FLAG_FKEY },
-	{ KEY_F9,       KEY_KBDILLUMDOWN,       APPLE_FLAG_FKEY },
-	{ KEY_F10,      KEY_KBDILLUMUP,         APPLE_FLAG_FKEY },
-	{ KEY_UP,       KEY_PAGEUP },
-	{ KEY_DOWN,     KEY_PAGEDOWN },
-	{ KEY_LEFT,     KEY_HOME },
-	{ KEY_RIGHT,    KEY_END },
-	{ }
-};
-
-static struct hidinput_key_translation powerbook_numlock_keys[] =3D {
-	{ KEY_J,        KEY_KP1 },
-	{ KEY_K,        KEY_KP2 },
-	{ KEY_L,        KEY_KP3 },
-	{ KEY_U,        KEY_KP4 },
-	{ KEY_I,        KEY_KP5 },
-	{ KEY_O,        KEY_KP6 },
-	{ KEY_7,        KEY_KP7 },
-	{ KEY_8,        KEY_KP8 },
-	{ KEY_9,        KEY_KP9 },
-	{ KEY_M,        KEY_KP0 },
-	{ KEY_DOT,      KEY_KPDOT },
-	{ KEY_SLASH,    KEY_KPPLUS },
-	{ KEY_SEMICOLON, KEY_KPMINUS },
-	{ KEY_P,        KEY_KPASTERISK },
-	{ KEY_MINUS,    KEY_KPEQUAL },
-	{ KEY_0,        KEY_KPSLASH },
-	{ KEY_F6,       KEY_NUMLOCK },
-	{ KEY_KPENTER,  KEY_KPENTER },
-	{ KEY_BACKSPACE, KEY_BACKSPACE },
-	{ }
-};
-
-static struct hidinput_key_translation apple_iso_keyboard[] =3D {
-	{ KEY_GRAVE,    KEY_102ND },
-	{ KEY_102ND,    KEY_GRAVE },
-	{ }
-};
-
-static struct hidinput_key_translation *find_translation(struct hidinp=
ut_key_translation *table, u16 from)
-{
-	struct hidinput_key_translation *trans;
-
-	/* Look for the translation */
-	for (trans =3D table; trans->from; trans++)
-		if (trans->from =3D=3D from)
-			return trans;
-
-	return NULL;
-}
-
-int hidinput_apple_event(struct hid_device *hid, struct input_dev *inp=
ut,
-		struct hid_usage *usage, __s32 value)
-{
-	struct hidinput_key_translation *trans;
-
-	if (usage->code =3D=3D KEY_FN) {
-		if (value) hid->quirks |=3D  HID_QUIRK_APPLE_FN_ON;
-		else       hid->quirks &=3D ~HID_QUIRK_APPLE_FN_ON;
-
-		input_event(input, usage->type, usage->code, value);
-
-		return 1;
-	}
-
-	if (hid_apple_fnmode) {
-		int do_translate;
-
-		trans =3D find_translation((hid->product < 0x220 ||
-					  hid->product >=3D 0x300) ?
-					 powerbook_fn_keys : apple_fn_keys,
-					 usage->code);
-		if (trans) {
-			if (test_bit(usage->code, hid->apple_pressed_fn))
-				do_translate =3D 1;
-			else if (trans->flags & APPLE_FLAG_FKEY)
-				do_translate =3D
-					(hid_apple_fnmode =3D=3D 2 &&  (hid->quirks & HID_QUIRK_APPLE_FN_=
ON)) ||
-					(hid_apple_fnmode =3D=3D 1 && !(hid->quirks & HID_QUIRK_APPLE_FN_=
ON));
-			else
-				do_translate =3D (hid->quirks & HID_QUIRK_APPLE_FN_ON);
-
-			if (do_translate) {
-				if (value)
-					set_bit(usage->code, hid->apple_pressed_fn);
-				else
-					clear_bit(usage->code, hid->apple_pressed_fn);
-
-				input_event(input, usage->type, trans->to, value);
-
-				return 1;
-			}
-		}
-
-		if (hid->quirks & HID_QUIRK_APPLE_NUMLOCK_EMULATION && (
-				test_bit(usage->code, hid->pb_pressed_numlock) ||
-				test_bit(LED_NUML, input->led))) {
-			trans =3D find_translation(powerbook_numlock_keys, usage->code);
-
-			if (trans) {
-				if (value)
-					set_bit(usage->code, hid->pb_pressed_numlock);
-				else
-					clear_bit(usage->code, hid->pb_pressed_numlock);
-
-				input_event(input, usage->type, trans->to, value);
-			}
-
-			return 1;
-		}
-	}
-
-	if (hid->quirks & HID_QUIRK_APPLE_ISO_KEYBOARD) {
-		trans =3D find_translation(apple_iso_keyboard, usage->code);
-		if (trans) {
-			input_event(input, usage->type, trans->to, value);
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-static void hidinput_apple_setup(struct input_dev *input)
-{
-	struct hidinput_key_translation *trans;
-
-	set_bit(KEY_NUMLOCK, input->keybit);
-
-	/* Enable all needed keys */
-	for (trans =3D apple_fn_keys; trans->from; trans++)
-		set_bit(trans->to, input->keybit);
-
-	for (trans =3D powerbook_fn_keys; trans->from; trans++)
-		set_bit(trans->to, input->keybit);
-
-	for (trans =3D powerbook_numlock_keys; trans->from; trans++)
-		set_bit(trans->to, input->keybit);
-
-	for (trans =3D apple_iso_keyboard; trans->from; trans++)
-		set_bit(trans->to, input->keybit);
-
-}
-#else
-inline int hidinput_apple_event(struct hid_device *hid,
-				       struct input_dev *input,
-				       struct hid_usage *usage, __s32 value)
-{
-	return 0;
-}
-
-static inline void hidinput_apple_setup(struct input_dev *input)
-{
-}
-#endif
-
 static inline int match_scancode(int code, int scancode)
 {
 	if (scancode =3D=3D 0)
@@ -719,16 +520,7 @@ static void hidinput_configure_usage(struct hid_in=
put *hidinput, struct hid_fiel
 		case HID_UP_CUSTOM: /* Reported on Logitech and Apple USB keyboards =
*/
=20
 			set_bit(EV_REP, input->evbit);
-			switch(usage->hid & HID_USAGE) {
-				case 0x003:
-					/* The fn key on Apple USB keyboards */
-					map_key_clear(KEY_FN);
-					hidinput_apple_setup(input);
-					break;
-
-				default:    goto ignore;
-			}
-			break;
+			goto ignore;
=20
 		case HID_UP_LOGIVENDOR:
=20
@@ -765,15 +557,6 @@ mapped:
 		device->driver->input_mapped(device, hidinput, usage,
 				&bit, &max);
=20
-	if (device->quirks & HID_QUIRK_MIGHTYMOUSE) {
-		if (usage->hid =3D=3D HID_GD_Z)
-			map_rel(REL_HWHEEL);
-		else if (usage->code =3D=3D BTN_1)
-			map_key(BTN_2);
-		else if (usage->code =3D=3D BTN_2)
-			map_key(BTN_1);
-	}
-
 	if ((device->quirks & (HID_QUIRK_2WHEEL_MOUSE_HACK_7 | HID_QUIRK_2WHE=
EL_MOUSE_HACK_5 |
 			HID_QUIRK_2WHEEL_MOUSE_HACK_B8)) && (usage->type =3D=3D EV_REL) &&
 			(usage->code =3D=3D REL_WHEEL))
diff --git a/drivers/hid/usbhid/Kconfig b/drivers/hid/usbhid/Kconfig
index 18f0910..177bfa1 100644
--- a/drivers/hid/usbhid/Kconfig
+++ b/drivers/hid/usbhid/Kconfig
@@ -24,17 +24,6 @@ config USB_HID
 comment "Input core support is needed for USB HID input layer or HIDBP=
 support"
 	depends on USB_HID && INPUT=3Dn
=20
-config USB_HIDINPUT_POWERBOOK
-	bool "Enable support for Apple laptop/aluminum USB special keys"
-	default n
-	depends on USB_HID
-	help
-	  Say Y here if you want support for the special keys (Fn, Numlock) o=
n
-	  Apple iBooks, PowerBooks, MacBooks, MacBook Pros and aluminum USB
-	  keyboards.
-
-	  If unsure, say N.
-
 config HID_FF
 	bool "Force feedback support (EXPERIMENTAL)"
 	depends on USB_HID && EXPERIMENTAL
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-q=
uirks.c
index df71db7..c6ccbfa 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -54,7 +54,6 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_AFATECH, USB_DEVICE_ID_AFATECH_AF9016, HID_QUIRK_FULL=
SPEED_INTERVAL },
=20
 	{ USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM, HID_QUIRK_HIDDEV },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4, HID_QUIRK_HIDD=
EV | HID_QUIRK_IGNORE_HIDINPUT },
 	{ USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE, HID_QUIRK_H=
IDDEV | HID_QUIRK_IGNORE_HIDINPUT },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV, HID_QUIRK_HID=
INPUT },
=20
@@ -67,8 +66,6 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K, HID_QUIRK_MICROSOFT=
_KEYS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_LK6K, HID_QUIRK_MICROSOFT=
_KEYS },
=20
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE, HID_QUIRK_MIG=
HTYMOUSE | HID_QUIRK_INVERT_HWHEEL },
-
 	{ USB_VENDOR_ID_PANTHERLORD, USB_DEVICE_ID_PANTHERLORD_TWIN_USB_JOYST=
ICK, HID_QUIRK_MULTI_INPUT | HID_QUIRK_SKIP_OUTPUT_REPORTS },
 	{ USB_VENDOR_ID_PLAYDOTCOM, USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII, HID_Q=
UIRK_MULTI_INPUT },
=20
@@ -92,29 +89,6 @@ static const struct hid_blacklist {
=20
 	{ USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_=
QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
=20
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI, HID_QUIRK_A=
PPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUS=
E },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ISO, HID_QUIRK_AP=
PLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE=
 },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI, HID_QUIRK_APP=
LE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE =
},
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO, HID_QUIRK_APPL=
E_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE |=
 HID_QUIRK_APPLE_ISO_KEYBOARD},
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS, HID_QUIRK_APPL=
E_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE }=
,
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI, HID_QUIRK_AP=
PLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE=
 },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO, HID_QUIRK_APP=
LE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE =
| HID_QUIRK_APPLE_ISO_KEYBOARD},
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS, HID_QUIRK_APP=
LE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE =
},
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANSI, HID_QUIRK_AP=
PLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE=
 },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO, HID_QUIRK_APP=
LE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE =
| HID_QUIRK_APPLE_ISO_KEYBOARD},
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS, HID_QUIRK_APP=
LE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE =
},
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ANSI, HID_QUIRK_APPLE_=
HAS_FN },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ISO, HID_QUIRK_APPLE_H=
AS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_JIS, HID_QUIRK_APPLE_H=
AS_FN },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ANSI, HID_QUIRK=
_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MO=
USE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ISO, HID_QUIRK_=
APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOU=
SE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_JIS, HID_QUIRK_=
APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOU=
SE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI, HID_QUI=
RK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ISO, HID_QUIR=
K_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_IS=
O_KEYBOARD },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS, HID_QUIR=
K_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY, HID_QUIR=
K_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_M=
OUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY, HID_QUIRK=
_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MO=
USE },
-
 	{ USB_VENDOR_ID_DELL, USB_DEVICE_ID_DELL_W7658, HID_QUIRK_RESET_LEDS =
},
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_KBD, HID_QUIRK_RESET=
_LEDS },
=20
@@ -134,8 +108,6 @@ static const struct hid_rdesc_blacklist {
=20
 	{ USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E, HID_QUIRK_RDESC=
_BUTTON_CONSUMER },
=20
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS, HID_QUIRK_RDE=
SC_MACBOOK_JIS },
-
 	{ USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE, HID_Q=
UIRK_RDESC_PETALYNX },
=20
 	{ USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE, HID_QUIRK_R=
DESC_SAMSUNG_REMOTE },
@@ -476,18 +448,6 @@ static void usbhid_fixup_cypress_descriptor(unsign=
ed char *rdesc, int rsize)
 		printk(KERN_INFO "Fixing up Cypress report descriptor\n");
 }
=20
-/*
- * MacBook JIS keyboard has wrong logical maximum
- */
-static void usbhid_fixup_macbook_descriptor(unsigned char *rdesc, int =
rsize)
-{
-	if (rsize >=3D 60 && rdesc[53] =3D=3D 0x65
-			&& rdesc[59] =3D=3D 0x65) {
-		printk(KERN_INFO "Fixing up MacBook JIS keyboard report descriptor\n=
");
-		rdesc[53] =3D rdesc[59] =3D 0xe7;
-	}
-}
-
 static void usbhid_fixup_button_consumer_descriptor(unsigned char *rde=
sc, int rsize)
 {
 	if (rsize >=3D 30 && rdesc[29] =3D=3D 0x05
@@ -530,9 +490,6 @@ static void __usbhid_fixup_report_descriptor(__u32 =
quirks, char *rdesc, unsigned
 	if (quirks & HID_QUIRK_RDESC_PETALYNX)
 		usbhid_fixup_petalynx_descriptor(rdesc, rsize);
=20
-	if (quirks & HID_QUIRK_RDESC_MACBOOK_JIS)
-		usbhid_fixup_macbook_descriptor(rdesc, rsize);
-
 	if (quirks & HID_QUIRK_RDESC_BUTTON_CONSUMER)
 		usbhid_fixup_button_consumer_descriptor(rdesc, rsize);
=20
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 1af9305..b3669da 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -267,11 +267,6 @@ struct hid_item {
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_7		0x00000080
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x00000100
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x00000200
-#define HID_QUIRK_MIGHTYMOUSE			0x00000400
-#define HID_QUIRK_APPLE_HAS_FN			0x00000800
-#define HID_QUIRK_APPLE_FN_ON			0x00001000
-#define HID_QUIRK_INVERT_HWHEEL			0x00002000
-#define HID_QUIRK_APPLE_ISO_KEYBOARD		0x00004000
 #define HID_QUIRK_BAD_RELATIVE_KEYS		0x00008000
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_IGNORE_MOUSE			0x00020000
@@ -286,7 +281,6 @@ struct hid_item {
 #define HID_QUIRK_HWHEEL_WHEEL_INVERT		0x04000000
 #define HID_QUIRK_MICROSOFT_KEYS		0x08000000
 #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
-#define HID_QUIRK_APPLE_NUMLOCK_EMULATION	0x20000000
=20
 /*
  * Separate quirks for runtime report descriptor fixup
@@ -295,7 +289,6 @@ struct hid_item {
 #define HID_QUIRK_RDESC_CYMOTION		0x00000001
 #define HID_QUIRK_RDESC_SWAPPED_MIN_MAX		0x00000004
 #define HID_QUIRK_RDESC_PETALYNX		0x00000008
-#define HID_QUIRK_RDESC_MACBOOK_JIS		0x00000010
 #define HID_QUIRK_RDESC_BUTTON_CONSUMER		0x00000020
 #define HID_QUIRK_RDESC_SAMSUNG_REMOTE		0x00000040
 #define HID_QUIRK_RDESC_MICROSOFT_RECV_1028	0x00000080
@@ -482,10 +475,6 @@ struct hid_device {							/* device report descrip=
tor */
=20
 	/* handler for raw output data, used by hidraw */
 	int (*hid_output_raw_report) (struct hid_device *, __u8 *, size_t);
-#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
-	unsigned long apple_pressed_fn[BITS_TO_LONGS(KEY_CNT)];
-	unsigned long pb_pressed_numlock[BITS_TO_LONGS(KEY_CNT)];
-#endif
 };
=20
 static inline void *hid_get_drvdata(struct hid_device *hdev)
@@ -645,7 +634,6 @@ int hidinput_find_field(struct hid_device *hid, uns=
igned int type, unsigned int
 int hidinput_mapping_quirks(struct hid_usage *, struct hid_input *,
 		unsigned long **, int *);
 int hidinput_event_quirks(struct hid_device *, struct hid_field *, str=
uct hid_usage *, __s32);
-int hidinput_apple_event(struct hid_device *, struct input_dev *, stru=
ct hid_usage *, __s32);
 void hid_output_report(struct hid_report *report, __u8 *data);
 struct hid_device *hid_allocate_device(void);
 int hid_parse_report(struct hid_device *hid, __u8 *start, unsigned siz=
e);
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index e85ff38..1e9b0d1 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -677,27 +677,6 @@ static void hidp_close(struct hid_device *hid)
 {
 }
=20
-static const struct {
-	__u16 idVendor;
-	__u16 idProduct;
-	unsigned quirks;
-} hidp_blacklist[] =3D {
-	/* Apple wireless Mighty Mouse */
-	{ 0x05ac, 0x030c, HID_QUIRK_MIGHTYMOUSE | HID_QUIRK_INVERT_HWHEEL },
-
-	{ }	/* Terminating entry */
-};
-
-static void hidp_setup_quirks(struct hid_device *hid)
-{
-	unsigned int n;
-
-	for (n =3D 0; hidp_blacklist[n].idVendor; n++)
-		if (hidp_blacklist[n].idVendor =3D=3D le16_to_cpu(hid->vendor) &&
-				hidp_blacklist[n].idProduct =3D=3D le16_to_cpu(hid->product))
-			hid->quirks =3D hidp_blacklist[n].quirks;
-}
-
 static int hidp_parse(struct hid_device *hid)
 {
 	struct hidp_session *session =3D hid->driver_data;
@@ -723,7 +702,6 @@ static int hidp_parse(struct hid_device *hid)
=20
 	session->req =3D NULL;
=20
-	hidp_setup_quirks(hid);
 	return 0;
 }
=20
--=20
1.5.4.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
