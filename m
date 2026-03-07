Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800013959D;
	Sat,  7 Mar 2026 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772909239; cv=none; b=ejrusuljzSreZEzjSrbXiI9RlH+fmoBDkiOS6KunoNNPOBorQzB/ns0XE4dimEd2of83Ib3jZkd2276iZd73a0qZ6a7yrTUXot3o+OUslJW3CvokjhCbgw5BvZpfUD7bo637BK1nEfg0tFkfwnMXvOhzkMdaQgPkQIlwxWS7li0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772909239; c=relaxed/simple;
	bh=I7Rg707QrdIG6Jd7iOeFzxv8eRIQOuAdI5t3RCqpIgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlTjBs3DDnYJLtQQXzn+rrNRKlNQD9xdNTlyz2ke9x0r5+qDRqeie55ZL1WiSW8f2b4WMN6nXVovlMCSHcd7q4m1rJ33DLYia9VX/x/qvRFXrPPyOl/amNC8Qo5Sd4CmzXqUHuykbOdeKUURJdjqrTlH2xmoipY5SNrAEcmgW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=WZXHckAZ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="WZXHckAZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772909233; x=1773514033; i=hendrik-noack@gmx.de;
	bh=ZrUyj+4U/jQ1zIUrfM7Zs2uSRJEY0QMFvv+3CHMrSp0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WZXHckAZrzhwq98NndAmUvH6fotlv0r7oFun/lj9VyXCI/EkXKebJg0fM7I0p8Y1
	 7vgYTH5cbj2GnIWQSOpgHlj+JyOB+KKyQK8tRMyz5GDRKThkNYfy+qeb+xI9SQKAe
	 m3/OkjVKFsrzxjr91rA13nxQGfcK4aWSljTz/9A+y53atMh+27wL1qkLWmw6hytXH
	 mZoNaLP/lbEFKZj0Q7bS673lWhDeMuJFB5ruWK78ViA3Y3mIAfvPw0GXbe28G/ZOf
	 4FG1AGloFMpZZqaM4q1VeX/QOZnj03l31VJ5OC60XO9k3Mql74yp67AkNPI/ohViv
	 zQjRwyKUuDDOHgY3sA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJmF-1vMG033lnn-00bZ0y; Sat, 07
 Mar 2026 19:47:13 +0100
From: Hendrik Noack <hendrik-noack@gmx.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Hendrik Noack <hendrik-noack@gmx.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] Input: Add support for Wacom W9000-series penabled touchscreens
Date: Sat,  7 Mar 2026 19:15:33 +0100
Message-ID: <20260307181557.66927-3-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260307181557.66927-1-hendrik-noack@gmx.de>
References: <20260307181557.66927-1-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N/Elkc81gBDLuURWg3rjeV+8CCQmQ+mxiYyLNSMLYGDGrPHN4SI
 ZFII5TfrAdnM80uB4vFj+hzV/mQZ0a/1torjJU5f9W+yVuiQmHxju+b+OEuvJDmYLdlbxYR
 4oC3GuajU32DdFf3nx5rj0QBZwsGwPNHoeFeXprvR+0gOfCKoKEMyc3M+q7ufof7yHXkg0H
 NE05QFpeoPRzhiW+qqNYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R4E7+hSqdoE=;KVMLSFSt1nvizuMj/iYRmaMKxIA
 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
 G1

Add driver for Wacom W9002 and two Wacom W9007A variants. These are
penabled touchscreens supporting passive Wacom Pens and use I2C.

Co-developed-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
 drivers/input/touchscreen/Kconfig       |  12 +
 drivers/input/touchscreen/Makefile      |   1 +
 drivers/input/touchscreen/wacom_w9000.c | 510 ++++++++++++++++++++++++
 3 files changed, 523 insertions(+)
 create mode 100644 drivers/input/touchscreen/wacom_w9000.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen=
/Kconfig
index 7d5b72ee07fa..a28328fb7648 100644
=2D-- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -610,6 +610,18 @@ config TOUCHSCREEN_WACOM_I2C
 	  To compile this driver as a module, choose M here: the module
 	  will be called wacom_i2c.
=20
+config TOUCHSCREEN_WACOM_W9000
+	tristate "Wacom W9000-series penabled touchscreen (I2C)"
+	depends on I2C
+	help
+	  Say Y here if you have a Wacom W9000-series penabled I2C touchscreen.
+	  This driver supports models W9002 and W9007A.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called wacom_w9000.
+
 config TOUCHSCREEN_LPC32XX
 	tristate "LPC32XX touchscreen controller"
 	depends on ARCH_LPC32XX
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscree=
n/Makefile
index ab9abd151078..aa3915df83b2 100644
=2D-- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -102,6 +102,7 @@ tsc2007-$(CONFIG_TOUCHSCREEN_TSC2007_IIO)	+=3D tsc2007=
_iio.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+=3D tsc2007.o
 obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001)	+=3D wacom_w8001.o
 obj-$(CONFIG_TOUCHSCREEN_WACOM_I2C)	+=3D wacom_i2c.o
+obj-$(CONFIG_TOUCHSCREEN_WACOM_W9000)	+=3D wacom_w9000.o
 obj-$(CONFIG_TOUCHSCREEN_WDT87XX_I2C)	+=3D wdt87xx_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_WM831X)	+=3D wm831x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX)	+=3D wm97xx-ts.o
diff --git a/drivers/input/touchscreen/wacom_w9000.c b/drivers/input/touch=
screen/wacom_w9000.c
new file mode 100644
index 000000000000..3c7959a28ccb
=2D-- /dev/null
+++ b/drivers/input/touchscreen/wacom_w9000.c
@@ -0,0 +1,510 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Wacom W9000-series penabled I2C touchscreen driver
+ *
+ * Copyright (c) 2026 Hendrik Noack <hendrik-noack@gmx.de>
+ *
+ * Partially based on vendor driver:
+ *	Copyright (C) 2012, Samsung Electronics Co. Ltd.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/touchscreen.h>
+#include <linux/unaligned.h>
+
+/* Some chips have flaky firmware that requires many retries before respo=
nding. */
+#define CMD_QUERY_RETRIES	8
+
+/* Message length */
+#define CMD_QUERY_NUM_MAX	9
+#define MSG_COORD_NUM_MAX	12
+
+/* Commands */
+#define CMD_QUERY		0x2a
+
+struct wacom_w9000_variant {
+	const unsigned int cmd_query_num;
+	const unsigned int msg_coord_num;
+	const char *name;
+};
+
+struct wacom_w9000_data {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	const struct wacom_w9000_variant *variant;
+	unsigned int fw_version;
+
+	struct touchscreen_properties prop;
+	unsigned int max_pressure;
+
+	struct regulator *regulator;
+
+	struct gpio_desc *flash_mode_gpio;
+	struct gpio_desc *pen_inserted_gpio;
+	struct gpio_desc *reset_gpio;
+
+	unsigned int irq;
+	unsigned int pen_insert_irq;
+
+	bool pen_inserted;
+	bool pen_proximity;
+};
+
+static int wacom_w9000_read(struct i2c_client *client, u8 command, int le=
n, char *data)
+{
+	int error, res;
+	struct i2c_msg msg[] =3D {
+		{
+			.addr =3D client->addr,
+			.flags =3D 0,
+			.buf =3D &command,
+			.len =3D sizeof(command),
+		}, {
+			.addr =3D client->addr,
+			.flags =3D I2C_M_RD,
+			.buf =3D data,
+			.len =3D len,
+		}
+	};
+
+	res =3D i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	if (res !=3D ARRAY_SIZE(msg)) {
+		error =3D res < 0 ? res : -EIO;
+		dev_err(&client->dev, "%s: i2c transfer failed: %d (%d)\n", __func__, e=
rror, res);
+		return error;
+	}
+
+	return 0;
+}
+
+static int wacom_w9000_query(struct wacom_w9000_data *wacom_data)
+{
+	struct i2c_client *client =3D wacom_data->client;
+	struct device *dev =3D &wacom_data->client->dev;
+	int error;
+	int retry =3D 0;
+	u8 data[CMD_QUERY_NUM_MAX];
+
+	for (; retry < CMD_QUERY_RETRIES; retry++) {
+		error =3D wacom_w9000_read(client, CMD_QUERY, wacom_data->variant->cmd_=
query_num,
+					 data);
+
+		if (!error && (data[0] =3D=3D 0x0f))
+			break;
+	}
+
+	if (error)
+		return error;
+
+	dev_dbg(dev, "query: %*ph, %d\n", wacom_data->variant->cmd_query_num, da=
ta, retry);
+
+	wacom_data->prop.max_x =3D get_unaligned_be16(&data[1]);
+	wacom_data->prop.max_y =3D get_unaligned_be16(&data[3]);
+	wacom_data->max_pressure =3D get_unaligned_be16(&data[5]);
+	wacom_data->fw_version =3D get_unaligned_be16(&data[7]);
+
+	dev_dbg(dev, "max_x:%d, max_y:%d, max_pressure:%d, fw:%#x", wacom_data->=
prop.max_x,
+		wacom_data->prop.max_y, wacom_data->max_pressure,
+		wacom_data->fw_version);
+
+	return 0;
+}
+
+static int wacom_w9000_power_on(struct wacom_w9000_data *wacom_data)
+{
+	int error;
+
+	error =3D regulator_enable(wacom_data->regulator);
+	if (error) {
+		dev_err(&wacom_data->client->dev, "Failed to enable regulators: %d\n", =
error);
+		return error;
+	}
+
+	msleep(200);
+
+	gpiod_set_value_cansleep(wacom_data->reset_gpio, 0);
+	enable_irq(wacom_data->irq);
+
+	return error;
+}
+
+static void wacom_w9000_power_off(struct wacom_w9000_data *wacom_data)
+{
+	disable_irq(wacom_data->irq);
+	gpiod_set_value_cansleep(wacom_data->reset_gpio, 1);
+	regulator_disable(wacom_data->regulator);
+}
+
+static void wacom_w9000_coord(struct wacom_w9000_data *wacom_data)
+{
+	struct i2c_client *client =3D wacom_data->client;
+	struct device *dev =3D &wacom_data->client->dev;
+	int error;
+	u8 data[MSG_COORD_NUM_MAX];
+	bool touch, rubber, side_button;
+	u16 x, y, pressure;
+	u8 distance =3D 0;
+
+	error =3D i2c_master_recv(client, data, wacom_data->variant->msg_coord_n=
um);
+	if (error !=3D wacom_data->variant->msg_coord_num) {
+		if (error >=3D 0)
+			error =3D -EIO;
+		dev_err(dev, "%s: i2c receive failed (%d)\n", __func__, error);
+		return;
+	}
+
+	dev_dbg(dev, "data: %*ph", wacom_data->variant->msg_coord_num, data);
+
+	if (data[0] & BIT(7)) {
+		wacom_data->pen_proximity =3D true;
+
+		touch =3D !!(data[0] & BIT(4));
+		side_button =3D !!(data[0] & BIT(5));
+		rubber =3D !!(data[0] & BIT(6));
+
+		x =3D get_unaligned_be16(&data[1]);
+		y =3D get_unaligned_be16(&data[3]);
+		pressure =3D get_unaligned_be16(&data[5]);
+
+		if (wacom_data->variant->msg_coord_num > 7)
+			distance =3D data[7];
+
+		if (x > wacom_data->prop.max_x || y > wacom_data->prop.max_y) {
+			dev_warn(dev, "Coordinates out of range x=3D%d, y=3D%d", x, y);
+			return;
+		}
+
+		touchscreen_report_pos(wacom_data->input_dev, &wacom_data->prop, x, y, =
false);
+		input_report_abs(wacom_data->input_dev, ABS_PRESSURE, pressure);
+
+		if (wacom_data->variant->msg_coord_num > 7)
+			input_report_abs(wacom_data->input_dev, ABS_DISTANCE, distance);
+
+		input_report_key(wacom_data->input_dev, BTN_STYLUS, side_button);
+		input_report_key(wacom_data->input_dev, BTN_TOUCH, touch);
+		input_report_key(wacom_data->input_dev, BTN_TOOL_PEN, !rubber);
+		input_report_key(wacom_data->input_dev, BTN_TOOL_RUBBER, rubber);
+		input_sync(wacom_data->input_dev);
+	} else if (wacom_data->pen_proximity) {
+		input_report_abs(wacom_data->input_dev, ABS_PRESSURE, 0);
+
+		if (wacom_data->variant->msg_coord_num > 7)
+			input_report_abs(wacom_data->input_dev, ABS_DISTANCE, 255);
+
+		input_report_key(wacom_data->input_dev, BTN_STYLUS, 0);
+		input_report_key(wacom_data->input_dev, BTN_TOUCH, 0);
+		input_report_key(wacom_data->input_dev, BTN_TOOL_PEN, 0);
+		input_report_key(wacom_data->input_dev, BTN_TOOL_RUBBER, 0);
+		input_sync(wacom_data->input_dev);
+
+		wacom_data->pen_proximity =3D false;
+	}
+}
+
+static irqreturn_t wacom_w9000_interrupt(int irq, void *dev_id)
+{
+	struct wacom_w9000_data *wacom_data =3D dev_id;
+
+	wacom_w9000_coord(wacom_data);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t wacom_w9000_interrupt_pen_insert(int irq, void *dev_id=
)
+{
+	struct wacom_w9000_data *wacom_data =3D dev_id;
+	struct device *dev =3D &wacom_data->client->dev;
+	int error;
+	bool pen_inserted;
+
+	pen_inserted =3D gpiod_get_value_cansleep(wacom_data->pen_inserted_gpio)=
;
+
+	input_report_switch(wacom_data->input_dev, SW_PEN_INSERTED, pen_inserted=
);
+	input_sync(wacom_data->input_dev);
+
+	if (!pen_inserted && wacom_data->pen_inserted) {
+		error =3D wacom_w9000_power_on(wacom_data);
+		if (error)
+			return IRQ_HANDLED;
+	} else if (pen_inserted && !wacom_data->pen_inserted) {
+		wacom_w9000_power_off(wacom_data);
+	}
+
+	dev_dbg(dev, "Pen inserted changed from %d to %d", wacom_data->pen_inser=
ted, pen_inserted);
+
+	wacom_data->pen_inserted =3D pen_inserted;
+
+	return IRQ_HANDLED;
+}
+
+static int wacom_w9000_open(struct input_dev *dev)
+{
+	struct wacom_w9000_data *wacom_data =3D input_get_drvdata(dev);
+	int error;
+
+	if (wacom_data->pen_inserted_gpio) {
+		wacom_data->pen_inserted =3D gpiod_get_value_cansleep(wacom_data->pen_i=
nserted_gpio);
+
+		input_report_switch(wacom_data->input_dev, SW_PEN_INSERTED,
+				    wacom_data->pen_inserted);
+		input_sync(wacom_data->input_dev);
+	}
+
+	if (!wacom_data->pen_inserted) {
+		error =3D wacom_w9000_power_on(wacom_data);
+		if (error)
+			return error;
+	}
+
+	if (wacom_data->pen_inserted_gpio)
+		enable_irq(wacom_data->pen_insert_irq);
+
+	return 0;
+}
+
+static void wacom_w9000_close(struct input_dev *dev)
+{
+	struct wacom_w9000_data *wacom_data =3D input_get_drvdata(dev);
+
+	if (wacom_data->pen_inserted_gpio)
+		disable_irq(wacom_data->pen_insert_irq);
+
+	if (!wacom_data->pen_inserted)
+		wacom_w9000_power_off(wacom_data);
+}
+
+static int wacom_w9000_probe(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	struct wacom_w9000_data *wacom_data;
+	struct input_dev *input_dev;
+	int error;
+	u32 val;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(dev, "i2c_check_functionality error\n");
+		return -EIO;
+	}
+
+	wacom_data =3D devm_kzalloc(dev, sizeof(*wacom_data), GFP_KERNEL);
+	if (!wacom_data)
+		return -ENOMEM;
+
+	wacom_data->variant =3D i2c_get_match_data(client);
+
+	if (wacom_data->variant->cmd_query_num > CMD_QUERY_NUM_MAX ||
+	    wacom_data->variant->msg_coord_num > MSG_COORD_NUM_MAX) {
+		dev_err(dev, "Length of message for %s exceeds the maximum\n",
+			wacom_data->variant->name);
+		return -EINVAL;
+	}
+
+	if (wacom_data->variant->msg_coord_num < 7) {
+		dev_err(dev, "Length of coordinates message for %s too short\n",
+			wacom_data->variant->name);
+		return -EINVAL;
+	}
+
+	wacom_data->client =3D client;
+
+	input_dev =3D devm_input_allocate_device(dev);
+	if (!input_dev)
+		return -ENOMEM;
+
+	wacom_data->input_dev =3D input_dev;
+	input_set_drvdata(input_dev, wacom_data);
+
+	wacom_data->irq =3D client->irq;
+	i2c_set_clientdata(client, wacom_data);
+
+	wacom_data->regulator =3D devm_regulator_get(dev, "vdd");
+	if (IS_ERR(wacom_data->regulator))
+		return dev_err_probe(dev, PTR_ERR(wacom_data->regulator),
+				     "Failed to get regulators\n");
+
+	wacom_data->flash_mode_gpio =3D devm_gpiod_get_optional(dev, "flash-mode=
", GPIOD_OUT_LOW);
+	if (IS_ERR(wacom_data->flash_mode_gpio))
+		return dev_err_probe(dev, PTR_ERR(wacom_data->flash_mode_gpio),
+				     "Failed to get flash-mode gpio\n");
+
+	wacom_data->pen_inserted_gpio =3D devm_gpiod_get_optional(dev, "pen-inse=
rted", GPIOD_IN);
+	if (IS_ERR(wacom_data->pen_inserted_gpio))
+		return dev_err_probe(dev, PTR_ERR(wacom_data->pen_inserted_gpio),
+				     "Failed to get pen-insert gpio\n");
+
+	wacom_data->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_O=
UT_HIGH);
+	if (IS_ERR(wacom_data->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(wacom_data->reset_gpio),
+				     "Failed to get reset gpio\n");
+
+	error =3D regulator_enable(wacom_data->regulator);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to enable regulators\n");
+
+	msleep(200);
+
+	gpiod_set_value_cansleep(wacom_data->reset_gpio, 0);
+
+	error =3D wacom_w9000_query(wacom_data);
+
+	gpiod_set_value_cansleep(wacom_data->reset_gpio, 1);
+	regulator_disable(wacom_data->regulator);
+
+	if (error)
+		return dev_err_probe(dev, error, "Failed to query\n");
+
+	input_dev->name =3D wacom_data->variant->name;
+	input_dev->id.bustype =3D BUS_I2C;
+	input_dev->dev.parent =3D dev;
+	input_dev->id.vendor =3D 0x56a;
+	input_dev->id.version =3D wacom_data->fw_version;
+	input_dev->open =3D wacom_w9000_open;
+	input_dev->close =3D wacom_w9000_close;
+
+	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
+	input_set_capability(input_dev, EV_KEY, BTN_TOOL_PEN);
+	input_set_capability(input_dev, EV_KEY, BTN_TOOL_RUBBER);
+	input_set_capability(input_dev, EV_KEY, BTN_STYLUS);
+
+	input_set_abs_params(input_dev, ABS_X, 0, wacom_data->prop.max_x, 4, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, wacom_data->prop.max_y, 4, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE, 0, wacom_data->max_pressur=
e, 0, 0);
+
+	if (wacom_data->variant->msg_coord_num > 7)
+		input_set_abs_params(input_dev, ABS_DISTANCE, 0, 255, 0, 0);
+
+	touchscreen_parse_properties(input_dev, false, &wacom_data->prop);
+
+	dev_info(dev, "%s size X%uY%u\n", wacom_data->variant->name,
+		 wacom_data->prop.max_x, wacom_data->prop.max_y);
+
+	error =3D device_property_read_u32(dev, "touchscreen-x-mm", &val);
+	if (!error)
+		input_abs_set_res(input_dev, ABS_X, wacom_data->prop.max_x / val);
+	error =3D device_property_read_u32(dev, "touchscreen-y-mm", &val);
+	if (!error)
+		input_abs_set_res(input_dev, ABS_Y, wacom_data->prop.max_y / val);
+
+	error =3D devm_request_threaded_irq(dev, wacom_data->irq, NULL, wacom_w9=
000_interrupt,
+					  IRQF_ONESHOT | IRQF_NO_AUTOEN, client->name, wacom_data);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to register interrupt\n");
+
+	if (wacom_data->pen_inserted_gpio) {
+		wacom_data->pen_insert_irq =3D gpiod_to_irq(wacom_data->pen_inserted_gp=
io);
+		error =3D devm_request_threaded_irq(dev, wacom_data->pen_insert_irq, NU=
LL,
+						  wacom_w9000_interrupt_pen_insert, IRQF_ONESHOT |
+						  IRQF_NO_AUTOEN | IRQF_TRIGGER_RISING |
+						  IRQF_TRIGGER_FALLING, "wacom_pen_insert",
+						  wacom_data);
+		if (error)
+			return dev_err_probe(dev, error,
+					     "Failed to register pen-insert interrupt\n");
+
+		input_set_capability(input_dev, EV_SW, SW_PEN_INSERTED);
+	} else {
+		wacom_data->pen_inserted =3D false;
+	}
+
+	error =3D input_register_device(wacom_data->input_dev);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to register input device\n");
+
+	return 0;
+}
+
+static int wacom_w9000_suspend(struct device *dev)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct wacom_w9000_data *wacom_data =3D i2c_get_clientdata(client);
+
+	guard(mutex)(&wacom_data->input_dev->mutex);
+
+	if (wacom_data->pen_inserted_gpio)
+		disable_irq(wacom_data->pen_insert_irq);
+
+	if (!wacom_data->pen_inserted)
+		wacom_w9000_power_off(wacom_data);
+
+	return 0;
+}
+
+static int wacom_w9000_resume(struct device *dev)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct wacom_w9000_data *wacom_data =3D i2c_get_clientdata(client);
+	int error =3D 0;
+
+	guard(mutex)(&wacom_data->input_dev->mutex);
+
+	if (wacom_data->pen_inserted_gpio) {
+		wacom_data->pen_inserted =3D gpiod_get_value_cansleep(wacom_data->pen_i=
nserted_gpio);
+
+		input_report_switch(wacom_data->input_dev, SW_PEN_INSERTED,
+				    wacom_data->pen_inserted);
+		input_sync(wacom_data->input_dev);
+	}
+
+	if (!wacom_data->pen_inserted)
+		error =3D wacom_w9000_power_on(wacom_data);
+
+	if (wacom_data->pen_inserted_gpio)
+		enable_irq(wacom_data->pen_insert_irq);
+
+	return error;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(wacom_w9000_pm, wacom_w9000_suspend, waco=
m_w9000_resume);
+
+static const struct wacom_w9000_variant w9002 =3D {
+	.cmd_query_num  =3D 9,
+	.msg_coord_num  =3D 7,
+	.name =3D "Wacom W9002 Digitizer",
+};
+
+static const struct wacom_w9000_variant w9007a_lt03 =3D {
+	.cmd_query_num	=3D 9,
+	.msg_coord_num	=3D 8,
+	.name =3D "Wacom W9007A LT03 Digitizer",
+};
+
+static const struct wacom_w9000_variant w9007a_v1 =3D {
+	.cmd_query_num	=3D 9,
+	.msg_coord_num	=3D 12,
+	.name =3D "Wacom W9007A V1 Digitizer",
+};
+
+static const struct of_device_id wacom_w9000_of_match[] =3D {
+	{ .compatible =3D "wacom,w9002", .data =3D &w9002 },
+	{ .compatible =3D "wacom,w9007a-lt03", .data =3D &w9007a_lt03, },
+	{ .compatible =3D "wacom,w9007a-v1", .data =3D &w9007a_v1, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wacom_w9000_of_match);
+
+static const struct i2c_device_id wacom_w9000_id[] =3D {
+	{ .name =3D "w9002", .driver_data =3D (kernel_ulong_t)&w9002 },
+	{ .name =3D "w9007a-lt03", .driver_data =3D (kernel_ulong_t)&w9007a_lt03=
 },
+	{ .name =3D "w9007a-v1", .driver_data =3D (kernel_ulong_t)&w9007a_v1 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wacom_w9000_id);
+
+static struct i2c_driver wacom_w9000_driver =3D {
+	.driver =3D {
+		.name	=3D "wacom_w9000",
+		.of_match_table =3D wacom_w9000_of_match,
+		.pm	=3D pm_sleep_ptr(&wacom_w9000_pm),
+	},
+	.probe		=3D wacom_w9000_probe,
+	.id_table	=3D wacom_w9000_id,
+};
+module_i2c_driver(wacom_w9000_driver);
+
+/* Module information */
+MODULE_AUTHOR("Hendrik Noack <hendrik-noack@gmx.de>");
+MODULE_DESCRIPTION("Wacom W9000-series penabled touchscreen driver");
+MODULE_LICENSE("GPL");
=2D-=20
2.43.0

