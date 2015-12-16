From: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
	<zboszor@pr.hu>
Subject: [PATCH] Add eGalaxTouch serial touchscreen driver v3
Date: Wed, 16 Dec 2015 13:43:18 +0100
Message-ID: <1450269798-13928-1-git-send-email-zboszor@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail9.pr.hu ([87.242.0.9]:54236 "EHLO mail9.pr.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933010AbbLPMnc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 07:43:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, =?UTF-8?q?B=C3=B6sz=C3=B6rm=C3=A9nyi=20Zolt=C3=A1n?= <zboszormenyi@sicom.com>, =?UTF-8?q?B=F6sz=F6rm=E9nyi=20Zolt=E1n?= <zboszor@pr.hu>

=46rom: B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n <zboszormenyi@sicom.com>

There are two EETI touchscreen drivers in the kernel (eeti_ts and egala=
x_ts)
but both are for I2C-connected panels. This is for a different, serial
and not multi-touch touchscreen panel. The protocol documentation is at
http://www.eeti.com.tw/pdf/Software%20Programming%20Guide_v2.0.pdf

Signed-off-by: B=F6sz=F6rm=E9nyi Zolt=E1n <zboszor@pr.hu>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---
 drivers/input/touchscreen/egalax_ts_serial.c | 194 +++++++++++++++++++=
++++++++
 1 file changed, 194 insertions(+)
 create mode 100644 drivers/input/touchscreen/egalax_ts_serial.c

diff --git a/drivers/input/touchscreen/egalax_ts_serial.c b/drivers/inp=
ut/touchscreen/egalax_ts_serial.c
new file mode 100644
index 0000000..59f2bfc
--- /dev/null
+++ b/drivers/input/touchscreen/egalax_ts_serial.c
@@ -0,0 +1,194 @@
+/*
+ * EETI Egalax serial touchscreen driver
+ *
+ * Copyright (c) 2015 Zolt=E1n B=F6sz=F6rm=E9nyi <zboszor@pr.hu>
+ *
+ * based on the
+ *
+ * Hampshire serial touchscreen driver (Copyright (c) 2010 Adam Bennet=
t)
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished by
+ * the Free Software Foundation.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+
+#define DRIVER_DESC	"EETI Egalax serial touchscreen driver"
+
+/*
+ * Definitions & global arrays.
+ */
+
+#define EGALAX_FORMAT_MAX_LENGTH	6
+#define EGALAX_FORMAT_START_BIT		BIT(7)
+#define EGALAX_FORMAT_PRESSURE_BIT	BIT(6)
+#define EGALAX_FORMAT_TOUCH_BIT		BIT(0)
+#define EGALAX_FORMAT_RESOLUTION_MASK	0x06
+
+#define EGALAX_MIN_XC			0
+#define EGALAX_MAX_XC			0x4000
+#define EGALAX_MIN_YC			0
+#define EGALAX_MAX_YC			0x4000
+
+/*
+ * Per-touchscreen data.
+ */
+struct egalax {
+	struct input_dev *input;
+	struct serio *serio;
+	int idx;
+	u8 data[EGALAX_FORMAT_MAX_LENGTH];
+	char phys[32];
+};
+
+static void egalax_process_data(struct egalax *egalax)
+{
+	struct input_dev *dev =3D egalax->input;
+	u8 *data =3D egalax->data;
+	u16 x, y;
+	u8 shift;
+	u8 mask;
+
+	shift =3D 3 - ((data[0] & EGALAX_FORMAT_RESOLUTION_MASK) >> 1);
+	mask =3D 0xff >> (shift + 1);
+
+	x =3D (((u16)(data[1] & mask) << 7) | (data[2] & 0x7f)) << shift;
+	y =3D (((u16)(data[3] & mask) << 7) | (data[4] & 0x7f)) << shift;
+
+	input_report_key(dev, BTN_TOUCH, data[0] & EGALAX_FORMAT_TOUCH_BIT);
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, y);
+	input_sync(dev);
+}
+
+static irqreturn_t egalax_interrupt(struct serio *serio,
+				    unsigned char data, unsigned int flags)
+{
+	struct egalax *egalax =3D serio_get_drvdata(serio);
+	int pkt_len;
+
+	egalax->data[egalax->idx++] =3D data;
+
+	if (likely(egalax->data[0] & EGALAX_FORMAT_START_BIT)) {
+		pkt_len =3D egalax->data[0] & EGALAX_FORMAT_PRESSURE_BIT ? 6 : 5;
+		if (pkt_len =3D=3D egalax->idx) {
+			egalax_process_data(egalax);
+			egalax->idx =3D 0;
+		}
+	} else {
+		dev_dbg(&serio->dev, "unknown/unsynchronized data: %x\n",
+			egalax->data[0]);
+		egalax->idx =3D 0;
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * egalax_connect() is the routine that is called when someone adds a
+ * new serio device that supports egalax protocol and registers it as
+ * an input device. This is usually accomplished using inputattach.
+ */
+static int egalax_connect(struct serio *serio, struct serio_driver *dr=
v)
+{
+	struct egalax *egalax;
+	struct input_dev *input_dev;
+	int error;
+
+	egalax =3D kzalloc(sizeof(struct egalax), GFP_KERNEL);
+	input_dev =3D input_allocate_device();
+	if (!egalax) {
+		error =3D -ENOMEM;
+		goto err_free_mem;
+	}
+
+	egalax->serio =3D serio;
+	egalax->input =3D input_dev;
+	snprintf(egalax->phys, sizeof(egalax->phys),
+		 "%s/input0", serio->phys);
+
+	input_dev->name =3D "EETI eGalaxTouch Serial TouchScreen";
+	input_dev->phys =3D egalax->phys;
+	input_dev->id.bustype =3D BUS_RS232;
+	input_dev->id.vendor =3D SERIO_EGALAX;
+	input_dev->id.product =3D 0;
+	input_dev->id.version =3D 0x0001;
+	input_dev->dev.parent =3D &serio->dev;
+
+	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
+	input_set_abs_params(input_dev, ABS_X,
+			     EGALAX_MIN_XC, EGALAX_MAX_XC, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y,
+			     EGALAX_MIN_YC, EGALAX_MAX_YC, 0, 0);
+
+	serio_set_drvdata(serio, egalax);
+
+	error =3D serio_open(serio, drv);
+	if (error)
+		goto err_reset_drvdata;
+
+	error =3D input_register_device(input_dev);
+	if (error)
+		goto err_close_serio;
+
+	return 0;
+
+err_close_serio:
+	serio_close(serio);
+err_reset_drvdata:
+	serio_set_drvdata(serio, NULL);
+err_free_mem:
+	input_free_device(input_dev);
+	kfree(egalax);
+	return error;
+}
+
+static void egalax_disconnect(struct serio *serio)
+{
+	struct egalax *egalax =3D serio_get_drvdata(serio);
+
+	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
+	input_unregister_device(egalax->input);
+	kfree(egalax);
+}
+
+/*
+ * The serio driver structure.
+ */
+
+static const struct serio_device_id egalax_serio_ids[] =3D {
+	{
+		.type	=3D SERIO_RS232,
+		.proto	=3D SERIO_EGALAX,
+		.id	=3D SERIO_ANY,
+		.extra	=3D SERIO_ANY,
+	},
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(serio, egalax_serio_ids);
+
+static struct serio_driver egalax_drv =3D {
+	.driver		=3D {
+		.name	=3D "egalax",
+	},
+	.description	=3D DRIVER_DESC,
+	.id_table	=3D egalax_serio_ids,
+	.interrupt	=3D egalax_interrupt,
+	.connect	=3D egalax_connect,
+	.disconnect	=3D egalax_disconnect,
+};
+module_serio_driver(egalax_drv);
+
+MODULE_AUTHOR("Zolt=E1n B=F6sz=F6rm=E9nyi <zboszor@pr.hu>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL v2");
--=20
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
