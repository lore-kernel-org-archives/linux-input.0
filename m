Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA8372EE8;
	Thu, 19 Mar 2026 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915840; cv=none; b=MF7a12uDewML2ZQtpOEC9lyykQ5+SDxZS5tF0HqXGwyaNA9FBN7UwRbvSHjJTaC0hsXb2gpArCQtTr+5NhhJt9+na8eXub5QJYMzB4lW7c06VwveXNi/4IKivSM4oriWCrbuwtWn1N4qK3xV+G1x8JIVRQv6SY9j3AX0W/o/kvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915840; c=relaxed/simple;
	bh=Z0hX71QwPTYjUSC9jS3NRP5i/G2LzEMd5U+hpdtH4sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqskY8f1Ql2bPFbLnEtJMcaOna+xe/WBVYIsaXN93A2BjS4eA4e6itzfspQMegf/xTwgV8lVvwf/AhEt6toT5gyzCNwnyDRkeXC/zgp6fez6woxdXIe+N1O1RK3a/wtLUQY2AYwAE5uxaYABxMqdEUv9H1+2G62KjnLi/+BY6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=hN4Ra195; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="hN4Ra195"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773915827; x=1774520627; i=hendrik-noack@gmx.de;
	bh=LDbluETtMgM1rUiHUEF7sGf0Yvzt4jghbcJZMRC55gQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hN4Ra195522KfuZk0tga1EU0fnq2ZTxRcx0wqNhi7l7UCi1/cR6bXIF+j/qYeSrZ
	 s7Tjmt8SCGAxE5Itokpdgk2R3WwHOE8CVbtgiL/Dmy6l2V/aPVAlDCr4SDii63K3K
	 fcu1ucEf8bavnqRvpl82pLqfj4qIx8B4TjVDhN8ZJV9aYW/gTt8frxvs8nlGjSy4E
	 o9gMI+OhBOKFURpm6jaTa8gFg3CrUVlL/9By7OUDGA1Efvpi0Ed4qwmL2LM2rlhgV
	 N3W8EhbIBxbghUehMo5emwdUQ4qTVeD8LPdBYdJz8ZW9GNC6RUF0LUWNj5xxdDRbQ
	 NTEEnt36Z+046UepEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7GM-1vrdwf2L3i-007OFw; Thu, 19
 Mar 2026 11:23:47 +0100
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
Subject: [PATCH v5 2/2] Input: Add support for Wacom W9000-series penabled touchscreens
Date: Thu, 19 Mar 2026 10:53:03 +0100
Message-ID: <20260319095303.19927-3-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319095303.19927-1-hendrik-noack@gmx.de>
References: <20260319095303.19927-1-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9moDxFAalApN6JY8Rf4n91/2b95+fxMb6rNNnipjWgBKLDJMDP0
 YchfaF+t1fyCjkHAny/YJBIfg1tzgl2Q+Hd3YMaqfL2y1fRI1DmKem7yFMMfeKdf3Z+ndWq
 A55Uc2I7radfEakcpV1Dg+YytKYk3sTeI5+sp5a+eASayO0IidK+LJrg/bT8i6O1MhK/lw1
 GD+QKmpadNiGTjo5XHTBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KuUFlgeBHCE=;GmOhNWbsxyGxP3JaIZxcBZqqBRZ
 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
 LPpI0o0cNJGB+ug==

Add driver for Wacom W9002 and two Wacom W9007A variants. These are
penabled touchscreens supporting passive Wacom Pens and use I2C.

Co-developed-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
 drivers/input/touchscreen/Kconfig       |  12 +
 drivers/input/touchscreen/Makefile      |   1 +
 drivers/input/touchscreen/wacom_w9000.c | 433 ++++++++++++++++++++++++
 3 files changed, 446 insertions(+)
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
index 000000000000..f431e03a2b7a
=2D-- /dev/null
+++ b/drivers/input/touchscreen/wacom_w9000.c
@@ -0,0 +1,433 @@
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
+	bool powered;
+
+	struct gpio_desc *flash_mode_gpio;
+	struct gpio_desc *reset_gpio;
+
+	unsigned int irq;
+
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
+/* Must be called with wacom_data->input_dev->mutex held */
+static int wacom_w9000_power_on(struct wacom_w9000_data *wacom_data)
+{
+	int error;
+
+	if (wacom_data->powered)
+		return 0;
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
+	wacom_data->powered =3D true;
+
+	return error;
+}
+
+/* Must be called with wacom_data->input_dev->mutex held */
+static int wacom_w9000_power_off(struct wacom_w9000_data *wacom_data)
+{
+	if (!wacom_data->powered)
+		return 0;
+
+	disable_irq(wacom_data->irq);
+	gpiod_set_value_cansleep(wacom_data->reset_gpio, 1);
+	regulator_disable(wacom_data->regulator);
+
+	wacom_data->powered =3D false;
+
+	return 0;
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
+static int wacom_w9000_open(struct input_dev *dev)
+{
+	struct wacom_w9000_data *wacom_data =3D input_get_drvdata(dev);
+
+	return wacom_w9000_power_on(wacom_data);
+}
+
+static void wacom_w9000_close(struct input_dev *dev)
+{
+	struct wacom_w9000_data *wacom_data =3D input_get_drvdata(dev);
+
+	wacom_w9000_power_off(wacom_data);
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
+	wacom_data->powered =3D false;
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
+	return wacom_w9000_power_off(wacom_data);
+}
+
+static int wacom_w9000_resume(struct device *dev)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct wacom_w9000_data *wacom_data =3D i2c_get_clientdata(client);
+
+	guard(mutex)(&wacom_data->input_dev->mutex);
+
+	return wacom_w9000_power_on(wacom_data);
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

