Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B326299;
	Fri,  1 May 2026 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641109; cv=none; b=VpgY2FcXV68BFoLGRPchsq7X2fRS2UShcW2muFx/prYMrSVmvtubFGb7BkRy1sRCkSeRJe3kyGI5l1bMWlNfideG6oaE3DsVYzb5h2RtXzoN6elx8jSY9T/V//gqmnCZTBMCV6MlyaGwwg1HdkTL0KTkPMVDmNh1iW+ApRFcb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641109; c=relaxed/simple;
	bh=MmUpXeoF38ilPhMI85ZX/RMsI6pj8ictI8m0CiqPMvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gf6CrxzwkR09IOdrNeIwJjmiz+8T0PTY1SmeJfCtm4ladirpIQLg9vLkYdHtKJc+wO0wazyHtutvVZZMldXfKmup1H8fx9VdhqQEIuY8MPd/JzB3AUhtRpjipst8ffg1w9yKRpJtq7UrUfZ3OyZ66vwCFtvns0JywPhuPS4T8UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=L8su4p8A; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="L8su4p8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777641085; x=1778245885; i=hendrik-noack@gmx.de;
	bh=8Nvz2NGRfnA9N/xEwSSVyf9FR4CC95QiDRLaufVS+po=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L8su4p8ADOnwPDqClumv6oOctvKnpUT9WgPRhpaz5MKsuNjgl4Jh01DcpcJXOo1d
	 tRxfWeM8PNVoCkUtg1DMWv3COSJ6E7SIPDIwhmf5DSfQ7W5MREYrGPv91z+5naccQ
	 TqIbqX7peNWEOCimp4BPsP0NFnN+8cfTVRNDygf1xTfdav8fBbSZERbKrot/Dx+Ne
	 76UBQoigfvTG8tJ3gwTXsZ2Qm+85znF/0OPqrOnOF11lYyuwNPqfgZyjcHfcBE1TC
	 CD7TOXxl3shozW33/dL5o1TG1ttGk4FY+iSY8IEot+s3iR6qVVvnpfNc1J1vq7gJU
	 Zb6I9iahWftyYusGtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1w9PRr0WNK-005mGK; Fri, 01
 May 2026 15:11:25 +0200
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
Subject: [PATCH v7 2/2] Input: Add support for Wacom W9000-series penabled touchscreens
Date: Fri,  1 May 2026 14:40:03 +0200
Message-ID: <20260501124002.132540-4-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501124002.132540-1-hendrik-noack@gmx.de>
References: <20260501124002.132540-1-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T6pSr61Kq7j2KWsENBrMqQQd7Q1nDZKmdxN4AljA3lO5+u0ZLnB
 WXhn0TXm6v2k9mHOScHb1htu1JiEA9F3DAI55D2tR3smw0n3sw9eAq9+oiHztmUCynfjhL1
 WA/1r7JARAD7I4Jci5lZ6jtDhUPxeYMfu1s+rF1IagXwJ21kiBGB+mUCJMwztd3/0dAJTl1
 GKcmgdNKp1grdOdQT7ARA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lleu6sxgmUk=;V/a1VRfTCdP9C42XDn0LizsD3IQ
 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

Add driver for Wacom W9002 and two Wacom W9007A variants. These are
penabled touchscreens supporting passive Wacom Pens and use I2C.

Co-developed-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
 drivers/input/touchscreen/Kconfig       |  12 +
 drivers/input/touchscreen/Makefile      |   1 +
 drivers/input/touchscreen/wacom_w9000.c | 446 ++++++++++++++++++++++++
 3 files changed, 459 insertions(+)
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
index 000000000000..4a671ee1164e
=2D-- /dev/null
+++ b/drivers/input/touchscreen/wacom_w9000.c
@@ -0,0 +1,446 @@
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

