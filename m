From: =?UTF-8?q?B=C3=B6sz=C3=B6rm=C3=A9nyi=20Zolt=C3=A1n?=
	<zboszormenyi@sicom.com>
Subject: [PATCH] input/touchscreen: New EETI eGalaxTouch serial touchscreen driver
Date: Tue, 15 Dec 2015 12:22:07 +0100
Message-ID: <1450178527-26745-1-git-send-email-zboszormenyi@sicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail9.pr.hu ([87.242.0.9]:60413 "EHLO mail9.pr.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964922AbbLOLoV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2015 06:44:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, =?UTF-8?q?B=C3=B6sz=C3=B6rm=C3=A9nyi=20Zolt=C3=A1n?= <zboszor@pr.hu>

=46rom: B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n <zboszor@pr.hu>

There are two EETI touchscreen drivers in the kernel (eeti_ts and egala=
x_ts)
but both are for I2C-connected panels. This is for a different, serial
and not multi-touch touchscreen panel. The protocol documentation is at
http://www.eeti.com.tw/pdf/Software%20Programming%20Guide_v2.0.pdf

Signed-off-by: B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n <zboszor@pr.hu>

---
 drivers/input/touchscreen/Kconfig  |  10 ++
 drivers/input/touchscreen/Makefile |   1 +
 drivers/input/touchscreen/egalax.c | 210 +++++++++++++++++++++++++++++=
++++++++
 include/uapi/linux/serio.h         |   1 +
 4 files changed, 222 insertions(+)
 create mode 100644 drivers/input/touchscreen/egalax.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
index ae33da7..816a9dc 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -301,20 +301,30 @@ config TOUCHSCREEN_FT6236
 	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y here to enable support for the I2C connected FT6x06 and
 	  FT6x36 family of capacitive touchscreen drivers.
=20
 	  If unsure, say N.
=20
 	  To compile this driver as a module, choose M here: the
 	  module will be called ft6236.
=20
+config TOUCHSCREEN_EGALAX_SERIO
+	tristate "EETI eGalax serial touchscreen"
+	select SERIO
+	help
+	  Say Y here to enable support for serial connected EETI
+	  eGalax touch panels.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called egalax.
+
 config TOUCHSCREEN_FUJITSU
 	tristate "Fujitsu serial touchscreen"
 	select SERIO
 	help
 	  Say Y here if you have the Fujitsu touchscreen (such as one
 	  installed in Lifebook P series laptop) connected to your
 	  system.
=20
 	  If unsure, say N.
=20
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchsc=
reen/Makefile
index cbaa6ab..6f63b51 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -28,20 +28,21 @@ obj-$(CONFIG_TOUCHSCREEN_CYTTSP4_SPI)	+=3D cyttsp4_=
spi.o
 obj-$(CONFIG_TOUCHSCREEN_DA9034)	+=3D da9034-ts.o
 obj-$(CONFIG_TOUCHSCREEN_DA9052)	+=3D da9052_tsi.o
 obj-$(CONFIG_TOUCHSCREEN_DYNAPRO)	+=3D dynapro.o
 obj-$(CONFIG_TOUCHSCREEN_EDT_FT5X06)	+=3D edt-ft5x06.o
 obj-$(CONFIG_TOUCHSCREEN_HAMPSHIRE)	+=3D hampshire.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+=3D gunze.o
 obj-$(CONFIG_TOUCHSCREEN_EETI)		+=3D eeti_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ELAN)		+=3D elants_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+=3D elo.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+=3D egalax_ts.o
+obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIO)	+=3D egalax.o
 obj-$(CONFIG_TOUCHSCREEN_FT6236)	+=3D ft6236.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+=3D fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+=3D goodix.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+=3D ili210x.o
 obj-$(CONFIG_TOUCHSCREEN_IMX6UL_TSC)	+=3D imx6ul_tsc.o
 obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+=3D inexio.o
 obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+=3D intel-mid-touch.o
 obj-$(CONFIG_TOUCHSCREEN_IPROC)		+=3D bcm_iproc_tsc.o
 obj-$(CONFIG_TOUCHSCREEN_LPC32XX)	+=3D lpc32xx_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MAX11801)	+=3D max11801_ts.o
diff --git a/drivers/input/touchscreen/egalax.c b/drivers/input/touchsc=
reen/egalax.c
new file mode 100644
index 0000000..94ac9bd
--- /dev/null
+++ b/drivers/input/touchscreen/egalax.c
@@ -0,0 +1,210 @@
+/*
+ * EETI Egalax serial touchscreen driver
+ *
+ * Copyright (c) 2015 Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@=
pr.hu>
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
+MODULE_AUTHOR("Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@pr.hu>"=
);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+/*
+ * Definitions & global arrays.
+ */
+
+#define EGALAX_FORMAT_MAX_LENGTH 6
+#define EGALAX_RESPONSE_BEGIN_BYTE 0x80
+#define EGALAX_FORMAT_PRESSURE_BIT 0x40
+#define EGALAX_FORMAT_TOUCH_BIT 0x01
+#define EGALAX_FORMAT_RESOLUTION 0x06
+
+#define EGALAX_MIN_XC 0
+#define EGALAX_MAX_XC 0x4000
+#define EGALAX_MIN_YC 0
+#define EGALAX_MAX_YC 0x4000
+
+#define EGALAX_GET_XC(data, resbits, shift) ((((data[1] & (resbits)) <=
< 7) | (data[2] & 0x7f)) << shift)
+#define EGALAX_GET_YC(data, resbits, shift) ((((data[3] & (resbits)) <=
< 7) | (data[4] & 0x7f)) << shift)
+#define EGALAX_GET_TOUCHED(data) (EGALAX_FORMAT_TOUCH_BIT & data[0])
+
+/*
+ * Per-touchscreen data.
+ */
+
+struct egalax {
+	struct input_dev *dev;
+	struct serio *serio;
+	int idx;
+	int bytes;
+	int resbits;
+	int shift;
+	unsigned char data[EGALAX_FORMAT_MAX_LENGTH];
+	char phys[32];
+};
+
+static void egalax_process_data(struct egalax *pegalax)
+{
+	struct input_dev *dev =3D pegalax->dev;
+
+	if (++pegalax->idx =3D=3D pegalax->bytes) {
+		input_report_abs(dev, ABS_X, EGALAX_GET_XC(pegalax->data, pegalax->r=
esbits, pegalax->shift));
+		input_report_abs(dev, ABS_Y, EGALAX_GET_YC(pegalax->data, pegalax->r=
esbits, pegalax->shift));
+		input_report_key(dev, BTN_TOUCH, EGALAX_GET_TOUCHED(pegalax->data));
+		input_sync(dev);
+
+		pegalax->idx =3D 0;
+	}
+}
+
+static irqreturn_t egalax_interrupt(struct serio *serio,
+		unsigned char data, unsigned int flags)
+{
+	struct egalax *pegalax =3D serio_get_drvdata(serio);
+
+	pegalax->data[pegalax->idx] =3D data;
+
+	if (EGALAX_RESPONSE_BEGIN_BYTE & pegalax->data[0]) {
+		pegalax->bytes =3D (EGALAX_FORMAT_PRESSURE_BIT & pegalax->data[0] ? =
6 : 5);
+		switch ((EGALAX_FORMAT_RESOLUTION & pegalax->data[0]) >> 1) {
+		case 0:
+			pegalax->resbits =3D 0x0f;
+			pegalax->shift =3D 3;
+			break;
+		case 1:
+			pegalax->resbits =3D 0x1f;
+			pegalax->shift =3D 2;
+			break;
+		case 2:
+			pegalax->resbits =3D 0x3f;
+			pegalax->shift =3D 1;
+			break;
+		default:
+			pegalax->resbits =3D 0x7f;
+			pegalax->shift =3D 0;
+			break;
+		}
+		egalax_process_data(pegalax);
+	}
+	else
+		dev_dbg(&serio->dev, "unknown/unsynchronized data: %x\n",
+			pegalax->data[0]);
+
+	return IRQ_HANDLED;
+}
+
+static void egalax_disconnect(struct serio *serio)
+{
+	struct egalax *pegalax =3D serio_get_drvdata(serio);
+
+	input_get_device(pegalax->dev);
+	input_unregister_device(pegalax->dev);
+	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
+	input_put_device(pegalax->dev);
+	kfree(pegalax);
+}
+
+/*
+ * egalax_connect() is the routine that is called when someone adds a
+ * new serio device that supports egalax protocol and registers it as
+ * an input device. This is usually accomplished using inputattach.
+ */
+
+static int egalax_connect(struct serio *serio, struct serio_driver *dr=
v)
+{
+	struct egalax *pegalax;
+	struct input_dev *input_dev;
+	int err;
+
+	pegalax =3D kzalloc(sizeof(struct egalax), GFP_KERNEL);
+	input_dev =3D input_allocate_device();
+	if (!pegalax || !input_dev) {
+		err =3D -ENOMEM;
+		goto fail1;
+	}
+
+	pegalax->serio =3D serio;
+	pegalax->dev =3D input_dev;
+	snprintf(pegalax->phys, sizeof(pegalax->phys),
+		 "%s/input0", serio->phys);
+
+	input_dev->name =3D "EETI eGalaxTouch Serial TouchScreen";
+	input_dev->phys =3D pegalax->phys;
+	input_dev->id.bustype =3D BUS_RS232;
+	input_dev->id.vendor =3D SERIO_EGALAX;
+	input_dev->id.product =3D 0;
+	input_dev->id.version =3D 0x0001;
+	input_dev->dev.parent =3D &serio->dev;
+	input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
+	input_set_abs_params(pegalax->dev, ABS_X,
+			     EGALAX_MIN_XC, EGALAX_MAX_XC, 0, 0);
+	input_set_abs_params(pegalax->dev, ABS_Y,
+			     EGALAX_MIN_YC, EGALAX_MAX_YC, 0, 0);
+
+	serio_set_drvdata(serio, pegalax);
+
+	err =3D serio_open(serio, drv);
+	if (err)
+		goto fail2;
+
+	err =3D input_register_device(pegalax->dev);
+	if (err)
+		goto fail3;
+
+	return 0;
+
+ fail3:	serio_close(serio);
+ fail2:	serio_set_drvdata(serio, NULL);
+ fail1:	input_free_device(input_dev);
+	kfree(pegalax);
+	return err;
+}
+
+/*
+ * The serio driver structure.
+ */
+
+static struct serio_device_id egalax_serio_ids[] =3D {
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
+
+module_serio_driver(egalax_drv);
diff --git a/include/uapi/linux/serio.h b/include/uapi/linux/serio.h
index becdd78..c2ea169 100644
--- a/include/uapi/linux/serio.h
+++ b/include/uapi/linux/serio.h
@@ -70,12 +70,13 @@
 #define SERIO_FUJITSU	0x35
 #define SERIO_ZHENHUA	0x36
 #define SERIO_INEXIO	0x37
 #define SERIO_TOUCHIT213	0x38
 #define SERIO_W8001	0x39
 #define SERIO_DYNAPRO	0x3a
 #define SERIO_HAMPSHIRE	0x3b
 #define SERIO_PS2MULT	0x3c
 #define SERIO_TSC40	0x3d
 #define SERIO_WACOM_IV	0x3e
+#define SERIO_EGALAX	0x3f
=20
 #endif /* _UAPI_SERIO_H */
--=20
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
