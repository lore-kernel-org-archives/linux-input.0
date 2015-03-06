From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?=
	<sebastien.szymanski@armadeus.com>
Subject: [PATCH 1/2] Input: add support for Semtech SX8654 I2C touchscreen controller
Date: Fri,  6 Mar 2015 19:21:38 +0100
Message-ID: <1425666099-8365-1-git-send-email-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 10.mo1.mail-out.ovh.net ([178.32.96.102]:54319 "EHLO
	10.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbbCFTcG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 14:32:06 -0500
Received: from mail98.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id B1869102428A
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2015 19:16:46 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>
Cc: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>

Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.c=
om>
---
 drivers/input/touchscreen/Kconfig  |  11 ++
 drivers/input/touchscreen/Makefile |   1 +
 drivers/input/touchscreen/sx8654.c | 285 +++++++++++++++++++++++++++++=
++++++++
 3 files changed, 297 insertions(+)
 create mode 100644 drivers/input/touchscreen/sx8654.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
index 5891752..6f713fd0 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -961,6 +961,17 @@ config TOUCHSCREEN_SUR40
 	  To compile this driver as a module, choose M here: the
 	  module will be called sur40.
=20
+config TOUCHSCREEN_SX8654
+	tristate "Semtech SX8654 touchscreen"
+	depends on I2C && OF
+	help
+	  Say Y here if you have a Semtech SX8654 touchscreen controller.
+
+	  If unsure, say N
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sx8654.
+
 config TOUCHSCREEN_TPS6507X
 	tristate "TPS6507x based touchscreens"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchsc=
reen/Makefile
index 0242fea..a06a752 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -79,5 +79,6 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_ATMEL)	+=3D atmel-wm9=
7xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+=3D mainstone-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+=3D zylonite-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_W90X900)	+=3D w90p910_ts.o
+obj-$(CONFIG_TOUCHSCREEN_SX8654)	+=3D sx8654.o
 obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+=3D tps6507x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+=3D zforce_ts.o
diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchsc=
reen/sx8654.c
new file mode 100644
index 0000000..58cc478
--- /dev/null
+++ b/drivers/input/touchscreen/sx8654.c
@@ -0,0 +1,285 @@
+/*
+ * drivers/input/touchscreen/sx8654.c
+ *
+ * Copyright (c) 2015 Armadeus Systems
+ *	S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com>
+ *
+ * Using code from:
+ *  - sx865x.c
+ *	Copyright (c) 2013 U-MoBo Srl
+ *	Pierluigi Passaro <p.passaro@u-mobo.com>
+ *  - sx8650.c
+ *      Copyright (c) 2009 Wayne Roberts
+ *  - tsc2007.c
+ *      Copyright (c) 2008 Kwangwoo Lee
+ *  - ads7846.c
+ *      Copyright (c) 2005 David Brownell
+ *      Copyright (c) 2006 Nokia Corporation
+ *  - corgi_ts.c
+ *      Copyright (C) 2004-2005 Richard Purdie
+ *  - omap_ts.[hc], ads7846.h, ts_osk.c
+ *      Copyright (C) 2002 MontaVista Software
+ *      Copyright (C) 2004 Texas Instruments
+ *      Copyright (C) 2005 Dirk Behme
+ *
+ *  This program is free software; you can redistribute it and/or modi=
fy
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+/* register addresses */
+#define I2C_REG_TOUCH0			0x00
+#define I2C_REG_TOUCH1			0x01
+#define I2C_REG_CHANMASK		0x04
+#define I2C_REG_IRQMASK			0x22
+#define I2C_REG_IRQSRC			0x23
+#define I2C_REG_SOFTRESET		0x3f
+
+/* commands */
+#define CMD_READ_REGISTER		0x40
+#define CMD_MANUAL			0xc0
+#define CMD_PENTRG			0xe0
+
+/* value for I2C_REG_SOFTRESET */
+#define SOFTRESET_VALUE			0xde
+
+/* bits for I2C_REG_IRQSRC */
+#define IRQ_PENTOUCH_TOUCHCONVDONE	0x08
+#define IRQ_PENRELEASE			0x04
+
+/* bits for RegTouch1 */
+#define CONDIRQ				0x20
+#define FILT_7SA			0x03
+
+/* bits for I2C_REG_CHANMASK */
+#define CONV_X				0x80
+#define CONV_Y				0x40
+
+/* coordinates rate: higher nibble of CTRL0 register */
+#define RATE_MANUAL			0x00
+#define RATE_5000CPS			0xf0
+
+/* power delay: lower nibble of CTRL0 register */
+#define POWDLY_1_1MS			0x0b
+
+#define MAX_12BIT			((1 << 12) - 1)
+
+struct sx8654 {
+	struct input_dev *input;
+	struct i2c_client *client;
+};
+
+static irqreturn_t sx8654_irq(int irq, void *handle)
+{
+	struct sx8654 *sx8654 =3D handle;
+	u8 irqsrc;
+	u8 data[4];
+	unsigned int x, y;
+	int retval;
+
+	irqsrc =3D i2c_smbus_read_byte_data(sx8654->client,
+					  (CMD_READ_REGISTER | I2C_REG_IRQSRC));
+	dev_dbg(&sx8654->client->dev, "irqsrc =3D 0x%x", irqsrc);
+
+	if (irqsrc < 0)
+		goto out;
+
+	if (irqsrc & IRQ_PENRELEASE) {
+		dev_dbg(&sx8654->client->dev, "pen release interrupt");
+
+		input_report_key(sx8654->input, BTN_TOUCH, 0);
+		input_sync(sx8654->input);
+	}
+
+	if (irqsrc & IRQ_PENTOUCH_TOUCHCONVDONE) {
+		dev_dbg(&sx8654->client->dev, "pen touch interrupt");
+
+		retval =3D i2c_master_recv(sx8654->client, data, sizeof(data));
+		if (retval !=3D sizeof(data))
+			goto out;
+
+		/* invalid data */
+		if (unlikely(data[0] & 0x80 || data[2] & 0x80))
+			goto out;
+
+		x =3D ((data[0] & 0xf) << 8) | (data[1]);
+		y =3D ((data[2] & 0xf) << 8) | (data[3]);
+
+		input_report_abs(sx8654->input, ABS_X, x);
+		input_report_abs(sx8654->input, ABS_Y, y);
+		input_report_key(sx8654->input, BTN_TOUCH, 1);
+		input_sync(sx8654->input);
+
+		dev_dbg(&sx8654->client->dev, "point(%4d,%4d)\n", x, y);
+	}
+
+out:
+	return IRQ_HANDLED;
+}
+
+static int sx8654_open(struct input_dev *dev)
+{
+	struct sx8654 *sx8654 =3D input_get_drvdata(dev);
+	struct i2c_client *client =3D sx8654->client;
+	int error;
+
+	/* enable pen trigger mode */
+	error =3D i2c_smbus_write_byte_data(client, I2C_REG_TOUCH0,
+					  (RATE_5000CPS | POWDLY_1_1MS));
+	if (error < 0) {
+		dev_err(&client->dev, "writing to I2C_REG_TOUCH0 failed");
+		return -EIO;
+	}
+
+	error =3D i2c_smbus_write_byte(client, CMD_PENTRG);
+	if (error < 0) {
+		dev_err(&client->dev, "writing command CMD_PENTRG failed");
+		return -EIO;
+	}
+
+	enable_irq(client->irq);
+
+	return 0;
+}
+
+static void sx8654_close(struct input_dev *dev)
+{
+	struct sx8654 *sx8654 =3D input_get_drvdata(dev);
+	struct i2c_client *client =3D sx8654->client;
+	int error;
+
+	disable_irq(client->irq);
+
+	/* enable manual mode mode */
+	error =3D i2c_smbus_write_byte(client, CMD_MANUAL);
+	if (error < 0) {
+		dev_err(&client->dev, "writing command CMD_MANUAL failed");
+		return;
+	}
+
+	error =3D i2c_smbus_write_byte_data(client, I2C_REG_TOUCH0, 0);
+	if (error < 0) {
+		dev_err(&client->dev, "writing to I2C_REG_TOUCH0 failed");
+		return;
+	}
+}
+
+static int sx8654_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct sx8654 *sx8654;
+	struct input_dev *input;
+	int error;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+		return -ENXIO;
+
+	sx8654 =3D devm_kzalloc(&client->dev, sizeof(*sx8654), GFP_KERNEL);
+	if (!sx8654)
+		return -ENOMEM;
+
+	input =3D devm_input_allocate_device(&client->dev);
+	if (!sx8654)
+		return -ENOMEM;
+
+	input->name =3D "SX8654 I2C Touchscreen";
+	input->id.bustype =3D BUS_I2C;
+	input->dev.parent =3D &client->dev;
+	input->open =3D sx8654_open;
+	input->close =3D sx8654_close;
+
+	__set_bit(INPUT_PROP_DIRECT, input->propbit);
+	input_set_capability(input, EV_KEY, BTN_TOUCH);
+	input_set_abs_params(input, ABS_X, 0, MAX_12BIT, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, MAX_12BIT, 0, 0);
+
+	sx8654->client =3D client;
+	sx8654->input =3D input;
+
+	input_set_drvdata(sx8654->input, sx8654);
+
+	error =3D i2c_smbus_write_byte_data(client, I2C_REG_SOFTRESET,
+					  SOFTRESET_VALUE);
+	if (error < 0) {
+		dev_err(&client->dev, "writing softreset value failed");
+		return -EIO;
+	}
+
+	error =3D i2c_smbus_write_byte_data(client, I2C_REG_CHANMASK,
+					  (CONV_X | CONV_Y));
+	if (error < 0) {
+		dev_err(&client->dev, "writing to I2C_REG_CHANMASK failed");
+		return -EIO;
+	}
+
+	error =3D i2c_smbus_write_byte_data(client, I2C_REG_IRQMASK,
+					  (IRQ_PENTOUCH_TOUCHCONVDONE |
+					   IRQ_PENRELEASE));
+	if (error < 0) {
+		dev_err(&client->dev, "writing to I2C_REG_IRQMASK failed");
+		return -EIO;
+	}
+
+	error =3D i2c_smbus_write_byte_data(client, I2C_REG_TOUCH1,
+					  (CONDIRQ | FILT_7SA));
+	if (error < 0) {
+		dev_err(&client->dev, "writing to I2C_REG_TOUCH1 failed");
+		return -EIO;
+	}
+
+	error =3D devm_request_threaded_irq(&client->dev, client->irq,
+					  NULL, sx8654_irq,
+					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					  client->name, sx8654);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to enable IRQ %d, error: %d\n",
+			client->irq, error);
+		return error;
+	}
+
+	/* Disable the IRQ, we'll enable it in sx8654_open() */
+	disable_irq(client->irq);
+
+	error =3D input_register_device(sx8654->input);
+	if (error)
+		return error;
+
+	i2c_set_clientdata(client, sx8654);
+	return 0;
+}
+
+static const struct of_device_id sx8654_of_match[] =3D {
+	{ .compatible =3D "semtech,sx8654", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sx8654_of_match);
+
+static const struct i2c_device_id sx8654_id_table[] =3D {
+	{ "semtech_sx8654", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, sx8654_id_table);
+
+static struct i2c_driver sx8654_driver =3D {
+	.driver =3D {
+		.name =3D "sx8654",
+		.of_match_table =3D sx8654_of_match,
+	},
+
+	.id_table =3D sx8654_id_table,
+	.probe =3D sx8654_probe,
+};
+module_i2c_driver(sx8654_driver);
+
+MODULE_AUTHOR("S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.=
com>");
+MODULE_DESCRIPTION("Semtech SX8654 I2C Touchscreen Driver");
+MODULE_LICENSE("GPL");
--=20
2.0.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
