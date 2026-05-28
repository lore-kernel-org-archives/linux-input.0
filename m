Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902423783AC;
	Thu, 28 May 2026 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956321; cv=none; b=Ui1PUPnQMwV8bvo8b/y4YkY9JQEAM3htIjB4HnO2QXEuHvUZnvEQq1jOlgCV26Txhtu0rQPChO5f7xiSD3T69SoUNIrQVNu1rESZkpsyGlAO6JruJ7+mR7gzD6oHC8wdoelvF2DNw5REzUBBKNy95Y2AR4QlhScj4UTkdvYvzUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956321; c=relaxed/simple;
	bh=llHQ6LojbtDzB7scSmSvCQ8x2i5DpieuznXZItl/mmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AA0PsRjJb/1/17s/fhrhwoBh4cXWAiPBe6a4RQPCTIAXN4o62zO98O4QtmNZOHc2www7kaAg4qJpbnD8VF44zeYaqBuxLeRkPQyK9o5mmzGS/wtUNNbt/cs0N/4Xkck03G/6jhobro2hqb/EVvwA5Wfa5vsXz1eMSul68zCqxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=lR60RXUK; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="lR60RXUK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779956309; x=1780561109; i=hendrik-noack@gmx.de;
	bh=meYeXazmAyVAHkNStvQFIdxUOOp+N9hS5tWe4KtRJVY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lR60RXUKaI1XBpyP6y+FHXIROuPXrcPZeOv36AnyX48piT6vnycqq3dVy61Ahm3T
	 /BWl59KHd3xHV6j37c3AfHAsB7xwo/18tzJo4Hvh5W0S2rOaVuMUJLsas1KWqiYvr
	 YXL5AeBSz+BN2nhVJttJ69Boss18ImxjZQjcS3F61xiRXF8Ggqs+jRjuPkkDWEQHy
	 KQm+8A5TGbrs20+QQd9YZzib3PQE0UC2V5pr35Dtl1hqZ/lH85SPENGybBzMSpo1p
	 VryO9qckUcAqp5fjBXXVbznK/CJN52F9KbaAfOW3Q+PlBbREvwEdxvUrafy7c2luc
	 XmvGndAu374QtiqzZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsYx-1wX8Fn2WFj-006hW1; Thu, 28
 May 2026 10:18:28 +0200
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
Subject: [PATCH v8 2/2] Input: Add support for Wacom W9000-series penabled touchscreens
Date: Thu, 28 May 2026 09:48:18 +0200
Message-ID: <20260528074818.12151-3-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528074818.12151-1-hendrik-noack@gmx.de>
References: <20260528074818.12151-1-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5T8xOgjchCtm+fG/6UEgHnHga0BvvjAgJL5MSp9CQUp4MGBYAkA
 1oU3cAAuZbxZFl0wbUyQbtdkYvOCjXF+kcm8xqWeQqpl3J7MLNn20MB8VrfIIfN3u6zEcnI
 EMWQLEoJhDfdSU/n8Mji0hdu79CJfR82n+u2lAWDtb5VHlja5oUTMHuu2PGjutUtDHpI2ty
 bHpjEd0dT794lSAP8+Wbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mxFIsTzht8w=;n/MT9Jf/vbtqCP8bd6yenPHUUOZ
 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
 cpjsGiNUhCxXV0JyhKNYcvR434HVwl

Add driver for Wacom W9002 and two Wacom W9007A variants. These are
penabled touchscreens supporting passive Wacom Pens and use I2C.

Co-developed-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
 drivers/input/touchscreen/Kconfig       |  12 +
 drivers/input/touchscreen/Makefile      |   1 +
 drivers/input/touchscreen/wacom_w9000.c | 448 ++++++++++++++++++++++++
 3 files changed, 461 insertions(+)
 create mode 100644 drivers/input/touchscreen/wacom_w9000.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen=
/Kconfig
index 484522d8d675..9b9ae8ac3f7f 100644
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
index 6d397268d2e3..bfd9de83389d 100644
=2D-- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -100,6 +100,7 @@ tsc2007-$(CONFIG_TOUCHSCREEN_TSC2007_IIO)	+=3D tsc2007=
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
index 000000000000..7795508f93b2
=2D-- /dev/null
+++ b/drivers/input/touchscreen/wacom_w9000.c
@@ -0,0 +1,448 @@
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
+#include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
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
+	const u8 cmd_query_num;
+	const u8 msg_coord_num;
+	const char *name;
+};
+
+struct wacom_w9000_data {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	const struct wacom_w9000_variant *variant;
+	u16 fw_version;
+
+	struct touchscreen_properties prop;
+	u16 max_pressure;
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
+static int wacom_w9000_read(struct i2c_client *client, u8 command, u8 len=
, u8 *data)
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
+	if (error || (data[0] !=3D 0x0f))
+		return error ? error : -EIO;
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
+		dev_err_ratelimited(dev, "%s: i2c receive failed (%d)\n", __func__, err=
or);
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
+			dev_warn_ratelimited(dev, "Coordinates out of range x=3D%d, y=3D%d", x=
, y);
+			return;
+		}
+
+		if (pressure > wacom_data->max_pressure) {
+			dev_warn_ratelimited(dev, "Pressure out of range %d", pressure);
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
+	if (!wacom_data->variant) {
+		dev_err(dev, "No i2c match_data available\n");
+		return -EINVAL;
+	}
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
+	error =3D devm_request_threaded_irq(dev, wacom_data->irq, NULL, wacom_w9=
000_interrupt,
+					  IRQF_ONESHOT | IRQF_NO_AUTOEN, client->name, wacom_data);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to register interrupt\n");
+
+	input_dev =3D devm_input_allocate_device(dev);
+	if (!input_dev)
+		return -ENOMEM;
+
+	wacom_data->input_dev =3D input_dev;
+	input_set_drvdata(input_dev, wacom_data);
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
+	if (!error && val)
+		input_abs_set_res(input_dev, wacom_data->prop.swap_x_y ? ABS_Y : ABS_X,
+				  wacom_data->prop.max_x / val);
+	error =3D device_property_read_u32(dev, "touchscreen-y-mm", &val);
+	if (!error && val)
+		input_abs_set_res(input_dev, wacom_data->prop.swap_x_y ? ABS_X : ABS_Y,
+				  wacom_data->prop.max_y / val);
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
+	if (input_device_enabled(wacom_data->input_dev))
+		return wacom_w9000_power_on(wacom_data);
+	else
+		return 0;
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

