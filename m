Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1BF18871F;
	Sun, 26 Apr 2026 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777213872; cv=none; b=py1MCiWM6uqEXsEFr/jlYTfo5URq4y2CqqPc8nw+NWlv1ZvfeisO+vbf65InMhVV/31FR/sdXBLUsdkzP11YPnzfvN+QDqpzQKpXqVTUtJbKZZCqUdiHcP6Ac9AZBeiOgVYaxHAGF3w1WHjYesOa4xKlE97RTTy9meW83EX3yeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777213872; c=relaxed/simple;
	bh=1UdhukUtwsXwWKGcTzcs4ZBRkls9PPk6X+OcWqorjSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qC5ujf/FwZxia0seHFV3JN/8I8ivW2kRRTxw1A539BkxqBXCE4vNRM1z/BmpvZmL+nf6HPd/x1LL785nGGeVy+7cVOYc8FLtcoWP9cD4CnHWU3OkSCLiYy8oM6tgDeDx3ZLpEgux34rtJKPJCiNmIkWBP1nCF5XAxZQ1BHQ0LvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=gNvZPJ7A; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="gNvZPJ7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777213867; x=1777818667; i=hendrik-noack@gmx.de;
	bh=dc4KxtVUnKK91G+RwN0o2AusaZ9YjLYJWDuHjF7I9bY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gNvZPJ7AX15FsKihY46YVA4pR0gQCdLNLHk9KIq3gBeqX3GpkUUqXfHTKHSBgq9w
	 zBJDiQ2Mz2UEQTC3kUby4CQVpfRU00q+mHDc//xkw6Xim6C0VzbYvf8JfUNR824c9
	 ciYX18Op4jqI5sBlSrkxj/9YgF/pLoETVa0qKnSdIbnLV7/7mNT01z9B+0Voak3eO
	 zbwpezuNo4YKRH3a9DhMAE3rCJPcVYvKVOffdbTC1t/rAR65X2fat0+/u3LNUP26G
	 xGQRf6WzK62vTJ0FWmW8Anv+BOuhYuq+6ZgS/E2CjMDc2Ca4uCOjuyEndEEvi6zMk
	 oFg1hmve/fNwrBlWjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KPq-1vH2Dp2aME-00vgU2; Sun, 26
 Apr 2026 16:31:07 +0200
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
Subject: [PATCH v6 2/2] Input: Add support for Wacom W9000-series penabled touchscreens
Date: Sun, 26 Apr 2026 15:52:32 +0200
Message-ID: <20260426135232.371272-3-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426135232.371272-1-hendrik-noack@gmx.de>
References: <20260426135232.371272-1-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4sys3xu7+z0xy3IBKPmyciUO6oxgbfCBI2iVLjaWL2E24VvLLZI
 mk/lG2YMCzcpnwjgrrVF62wKGab/cybzeilGT+XI4zxNU3mh5R9zlnE7cvK1ULP7GHaDmxZ
 10Hk0WwM2ozcaZ1rIDpvN8fb+nvVCqCfLOKxOL+oxUJQfBHuRX8rBEPk4PgpGEI0vOSCYrJ
 qpfvISrQgaFwQKUQq5tVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bfCts1nBhsY=;JaFNh8pEm3BuCmOHBO2zeHryjEA
 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

Add driver for Wacom W9002 and two Wacom W9007A variants. These are
penabled touchscreens supporting passive Wacom Pens and use I2C.

Co-developed-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
 drivers/input/touchscreen/Kconfig       |  12 +
 drivers/input/touchscreen/Makefile      |   1 +
 drivers/input/touchscreen/wacom_w9000.c | 438 ++++++++++++++++++++++++
 3 files changed, 451 insertions(+)
 create mode 100644 drivers/input/touchscreen/wacom_w9000.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen=
/Kconfig
index aeaf9a9cbb41..6714c1e451a6 100644
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
index f2b002abebe8..6db05b4a2ee5 100644
=2D-- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -101,6 +101,7 @@ tsc2007-$(CONFIG_TOUCHSCREEN_TSC2007_IIO)	+=3D tsc2007=
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
index 000000000000..3ef32dba35ab
=2D-- /dev/null
+++ b/drivers/input/touchscreen/wacom_w9000.c
@@ -0,0 +1,438 @@
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
+		if (pressure > wacom_data->max_pressure) {
+			dev_warn(dev, "Pressure out of range %d", pressure);
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

