Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338041;
	b=VrMdKT0sQmfEloA3RgQwt8jTnabteULd0ulLQ9Fo9QOagr7A7MuY/AObvN6TsxLcW9V/
	 +t7QNSdLe8jaCMDS7N5cWWIQtevVKkFgYB9bDnw9Ngqaul9ijTqLiU2bU/dhHWam/apk0
	 iRMkXqSXMGBj1IsH0H03GOxJymUA/P0kJasxX6XLdgPZASN8SjkG1yheqy8A//NAMo3ep
	 hmNB7EFrzmIv2OyZfZcEikrdBZqefoV6OwaVVu9YqSS/0yfJ0rTLGBSHhgW3cTnsYeygH
	 5y+dmaTDyXvVJtrWvaZG+316O8E+Q8C+YvtDCdx4IIw4quoFG+7/uT+1BqGV7q0XasQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338041;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=cP/B96ro6vKE5n0aOXJqNdWdjeIAD/dRlyN6TlyJkdw=;
	b=s+4SZOL8Y3wUwsaSKb72LWXLH8Fp8KdXehQ5qcYf5QTQdtkctkpdVFp0ZOlvno7QucFX
	 1o65oYGng0cdg4ReQDt7qSP7K3oKxhW6rfo4mJbtbpToJlmqn5n4L3dzaNwikUvtqpDkf
	 WIAZd1flbmQyfHLfiX790uibmtZZBHJutBGuEGpxjNpTErZ10quJ9WVyL+2Z0a5/4QqBn
	 FTF3F5rLaNlnX0avAODn2vryskvqWwbZjE8L09FtlQRqgMxQUXzv8cX/GiAkZpJqIHfBz
	 bWhL58c/nFn14GFGo4H6uRAqE/4OqxuNaVWMfHOsWZnw6pR23f2LS+pkK4MGekXPwNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=H8C57Nb0;
	arc=none smtp.remote-ip=185.70.43.100
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1A60A260E;
	Fri, 30 Oct 2026 05:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30C1A60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=H8C57Nb0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793338037; x=1793597237;
	bh=cP/B96ro6vKE5n0aOXJqNdWdjeIAD/dRlyN6TlyJkdw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H8C57Nb0a/fGILyZVXNQvRCq0Z9nSU2MMpvofVy3eWWOwpcTI4bU4ASXwPMRLOpv6
	 dBDw5KI2F4rDtTt4VcYi6RmRw6dU9RuV/7qJyJq4h3yHmPWwLkgsolctNupO9fZnqn
	 hmJeD09xpHhOd6RCxGi6EMx9rDIHC0dCR7MAcUZvsDIjlhlSKiOg45N4Di/Aw7XOEL
	 Q3/vaVFCLRIzI7e924GRvFofN4y9BT63L39pY/LzM/6FtmP59SnSblDDl27DyFjaxq
	 xYbZpAKfSFuiGwVEuDLVwoHpExe+pnOCScUiKY5mfOtmgbv0ao8wPCKPeVuFp8lHII
	 um9TPmd7S4V4g==
Date: Fri, 30 Oct 2026 05:27:15 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH 2/2] Input: add FocalTech FT3683G touchscreen driver
Message-ID: <20261030-focaltech-ft3683g-v1-2-38b2f941b039@pm.me>
In-Reply-To: <20261030-focaltech-ft3683g-v1-0-38b2f941b039@pm.me>
References: <20261030-focaltech-ft3683g-v1-0-38b2f941b039@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: e2120225ef3bf4e731446e577af46253b953e77b
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add a driver for the FocalTech FT3683G, a flexible OLED capacitive
touch controller supporting 10-point multitouch over SPI. This touch
controller is found in the Nothing Phone (3a).

The driver implements the SPI transport layer, touch event parsing for
the FocalTech protocol v2 format, and basic power management.

The existing edt-ft5x06 driver is not reused, as the FT3683G uses
FocalTech's newer v2 reporting protocol (protocol version header) over
SPI with a custom framing (length header, dummy bytes, status byte and
a CRC-16/MCRF4XX trailer) instead of plain register access.

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 MAINTAINERS                                   |   1 +
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/focaltech_ft3683g.c | 365 ++++++++++++++++++++++=
++++
 4 files changed, 379 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68efbf580964..79f3d6211cb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10503,6 +10503,7 @@ M:=09Alexander Koskovich <akoskovich@pm.me>
 L:=09linux-input@vger.kernel.org
 S:=09Maintained
 F:=09Documentation/devicetree/bindings/input/touchscreen/focaltech,ft3683g=
.yaml
+F:=09drivers/input/touchscreen/focaltech_ft3683g.c
=20
 FOCUSRITE CONTROL PROTOCOL/SCARLETT2 MIXER DRIVERS (Scarlett Gen 2+, Clare=
tt, and Vocaster)
 M:=09Geoffrey D. Bennett <g@b4.vu>
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/=
Kconfig
index 9b9ae8ac3f7f..f7ade03f4a0e 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1414,4 +1414,16 @@ config TOUCHSCREEN_HIMAX_HX83112B
 =09  To compile this driver as a module, choose M here: the
 =09  module will be called himax_hx83112b.
=20
+config TOUCHSCREEN_FOCALTECH_FT3683G
+=09tristate "Focaltech FT3683G touchscreen driver"
+=09depends on SPI
+=09select CRC_CCITT
+=09help
+=09  Say Y here to enable support for FocalTech FT3683G touchscreens.
+
+=09  If unsure, say N.
+
+=09  To compile this driver as a module, choose M here: the
+=09  module will be called focaltech_ft3683g.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen=
/Makefile
index bfd9de83389d..45cdd7bb7d6f 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -119,3 +119,4 @@ obj-$(CONFIG_TOUCHSCREEN_IQS5XX)=09+=3D iqs5xx.o
 obj-$(CONFIG_TOUCHSCREEN_IQS7211)=09+=3D iqs7211.o
 obj-$(CONFIG_TOUCHSCREEN_ZINITIX)=09+=3D zinitix.o
 obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)=09+=3D himax_hx83112b.o
+obj-$(CONFIG_TOUCHSCREEN_FOCALTECH_FT3683G)=09+=3D focaltech_ft3683g.o
diff --git a/drivers/input/touchscreen/focaltech_ft3683g.c b/drivers/input/=
touchscreen/focaltech_ft3683g.c
new file mode 100644
index 000000000000..5c8133ffb265
--- /dev/null
+++ b/drivers/input/touchscreen/focaltech_ft3683g.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FocalTech FT3683G Touchscreen Driver
+ *
+ * Copyright (c) 2012-2020 FocalTech Systems, Ltd.
+ * Copyright (c) Alexander Koskovich <akoskovich@pm.me>
+ */
+
+#include <linux/cache.h>
+#include <linux/crc-ccitt.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+
+#define FT3683G_MAX_POINTS=0910
+
+#define FT3683G_SPI_CMD_READ=090xa0
+#define FT3683G_SPI_DUMMY=093
+#define FT3683G_SPI_RETRIES=093
+#define FT3683G_SPI_CS_DELAY_US=09150
+
+#define FT3683G_REG_CHIP_ID=090xa3
+#define FT3683G_REG_CHIP_ID2=090x9f
+
+#define FT3683G_CHIP_IDH=090x56
+#define FT3683G_CHIP_IDL=090x72
+
+#define FT3683G_REG_TOUCH_DATA=090x01
+
+#define FT3683G_TOUCH_LEN=098
+#define FT3683G_TOUCH_HEADER=094
+#define FT3683G_TOUCH_BUF_SIZE=09(FT3683G_MAX_POINTS * FT3683G_TOUCH_LEN +=
 \
+=09=09=09=09 FT3683G_TOUCH_HEADER)
+
+#define FT3683G_TOUCH_OFF_XH=090
+#define FT3683G_TOUCH_OFF_XL=091
+#define FT3683G_TOUCH_OFF_YH=092
+#define FT3683G_TOUCH_OFF_YL=093
+
+#define FT3683G_EVENT_DOWN=090
+#define FT3683G_EVENT_UP=091
+#define FT3683G_EVENT_CONTACT=092
+
+#define FT3683G_PROTOCOL_V2=090x02
+
+#define FT3683G_FW_INIT=09=090xff
+
+struct ft3683g_data {
+=09struct spi_device *spi;
+=09struct input_dev *input;
+=09struct touchscreen_properties props;
+=09struct regulator_bulk_data supplies[2];
+=09struct gpio_desc *reset_gpio;
+=09struct device *dev;
+=09struct mutex spi_lock; /* protects tx_buf/rx_buf */
+=09u8 tx_buf[256] ____cacheline_aligned;
+=09u8 rx_buf[256] ____cacheline_aligned;
+};
+
+static int ft3683g_spi_read(struct ft3683g_data *ts, u8 addr,
+=09=09=09    u8 *data, u32 len)
+{
+=09struct spi_transfer xfer =3D { };
+=09u32 dp =3D 4 + FT3683G_SPI_DUMMY;
+=09u32 txlen =3D dp + len + 2;
+=09u16 crc_calc, crc_read;
+=09int error, i;
+
+=09guard(mutex)(&ts->spi_lock);
+
+=09memset(ts->tx_buf, 0, txlen);
+=09ts->tx_buf[0] =3D addr;
+=09ts->tx_buf[1] =3D FT3683G_SPI_CMD_READ;
+=09ts->tx_buf[2] =3D (len >> 8) & 0xff;
+=09ts->tx_buf[3] =3D len & 0xff;
+
+=09xfer.tx_buf =3D ts->tx_buf;
+=09xfer.rx_buf =3D ts->rx_buf;
+=09xfer.len =3D txlen;
+
+=09for (i =3D 0; i < FT3683G_SPI_RETRIES; i++) {
+=09=09error =3D spi_sync_transfer(ts->spi, &xfer, 1);
+=09=09if (error)
+=09=09=09continue;
+
+=09=09if (ts->rx_buf[3] & 0xa0) {
+=09=09=09fsleep(FT3683G_SPI_CS_DELAY_US);
+=09=09=09continue;
+=09=09}
+
+=09=09crc_calc =3D crc_ccitt(0xffff, &ts->rx_buf[dp], len);
+=09=09crc_read =3D ts->rx_buf[dp + len] |
+=09=09=09   (ts->rx_buf[dp + len + 1] << 8);
+=09=09if (crc_calc !=3D crc_read) {
+=09=09=09fsleep(FT3683G_SPI_CS_DELAY_US);
+=09=09=09continue;
+=09=09}
+
+=09=09memcpy(data, &ts->rx_buf[dp], len);
+=09=09return 0;
+=09}
+
+=09return error ? error : -EIO;
+}
+
+static int ft3683g_read_reg(struct ft3683g_data *ts, u8 addr, u8 *val)
+{
+=09return ft3683g_spi_read(ts, addr, val, 1);
+}
+
+static int ft3683g_check_chip_id(struct ft3683g_data *ts)
+{
+=09u8 idh, idl;
+=09int error;
+
+=09error =3D ft3683g_read_reg(ts, FT3683G_REG_CHIP_ID, &idh);
+=09if (error)
+=09=09return error;
+
+=09error =3D ft3683g_read_reg(ts, FT3683G_REG_CHIP_ID2, &idl);
+=09if (error)
+=09=09return error;
+
+=09if (idh !=3D FT3683G_CHIP_IDH || idl !=3D FT3683G_CHIP_IDL) {
+=09=09dev_err(ts->dev,
+=09=09=09"chip ID mismatch: expected %02x%02x, got %02x%02x\n",
+=09=09=09FT3683G_CHIP_IDH, FT3683G_CHIP_IDL, idh, idl);
+=09=09return -ENODEV;
+=09}
+
+=09dev_dbg(ts->dev, "chip ID: %02x%02x\n", idh, idl);
+=09return 0;
+}
+
+static irqreturn_t ft3683g_irq(int irq, void *dev_id)
+{
+=09struct ft3683g_data *ts =3D dev_id;
+=09u8 buf[FT3683G_TOUCH_BUF_SIZE];
+=09unsigned int x, y, id, event;
+=09int event_num, i, base;
+=09u8 protocol;
+=09int error;
+
+=09error =3D ft3683g_spi_read(ts, FT3683G_REG_TOUCH_DATA,
+=09=09=09=09 buf, sizeof(buf));
+=09if (error) {
+=09=09dev_err_ratelimited(ts->dev, "failed to read touch data: %d\n",
+=09=09=09=09    error);
+=09=09return IRQ_HANDLED;
+=09}
+
+=09if (!memchr_inv(&buf[1], FT3683G_FW_INIT, 4)) {
+=09=09input_mt_sync_frame(ts->input);
+=09=09input_sync(ts->input);
+=09=09return IRQ_HANDLED;
+=09}
+
+=09protocol =3D (buf[1] >> 4) & 0x0f;
+=09if (protocol !=3D FT3683G_PROTOCOL_V2)
+=09=09return IRQ_HANDLED;
+
+=09event_num =3D buf[1] & 0x0f;
+=09if (!event_num || event_num > FT3683G_MAX_POINTS)
+=09=09return IRQ_HANDLED;
+
+=09for (i =3D 0; i < event_num; i++) {
+=09=09base =3D FT3683G_TOUCH_LEN * i + FT3683G_TOUCH_HEADER;
+
+=09=09event =3D buf[base + FT3683G_TOUCH_OFF_XH] >> 6;
+=09=09id =3D buf[base + FT3683G_TOUCH_OFF_YH] >> 4;
+=09=09if (id >=3D FT3683G_MAX_POINTS)
+=09=09=09continue;
+
+=09=09input_mt_slot(ts->input, id);
+
+=09=09if (event =3D=3D FT3683G_EVENT_DOWN ||
+=09=09    event =3D=3D FT3683G_EVENT_CONTACT) {
+=09=09=09x =3D ((buf[base + FT3683G_TOUCH_OFF_XH] & 0x0f) << 8) |
+=09=09=09    buf[base + FT3683G_TOUCH_OFF_XL];
+=09=09=09y =3D ((buf[base + FT3683G_TOUCH_OFF_YH] & 0x0f) << 8) |
+=09=09=09    buf[base + FT3683G_TOUCH_OFF_YL];
+
+=09=09=09input_mt_report_slot_state(ts->input,
+=09=09=09=09=09=09   MT_TOOL_FINGER, true);
+=09=09=09touchscreen_report_pos(ts->input, &ts->props,
+=09=09=09=09=09       x, y, true);
+=09=09} else {
+=09=09=09input_mt_report_slot_state(ts->input,
+=09=09=09=09=09=09   MT_TOOL_FINGER, false);
+=09=09}
+=09}
+
+=09input_mt_sync_frame(ts->input);
+=09input_sync(ts->input);
+=09return IRQ_HANDLED;
+}
+
+static int ft3683g_power_on(struct ft3683g_data *ts)
+{
+=09int error;
+
+=09gpiod_set_value_cansleep(ts->reset_gpio, 1);
+=09usleep_range(2000, 3000);
+
+=09error =3D regulator_bulk_enable(ARRAY_SIZE(ts->supplies), ts->supplies)=
;
+=09if (error) {
+=09=09dev_err(ts->dev, "failed to enable regulators: %d\n", error);
+=09=09return error;
+=09}
+
+=09usleep_range(2000, 3000);
+=09gpiod_set_value_cansleep(ts->reset_gpio, 0);
+=09msleep(50);
+
+=09return 0;
+}
+
+static void ft3683g_power_off(struct ft3683g_data *ts)
+{
+=09gpiod_set_value_cansleep(ts->reset_gpio, 1);
+=09regulator_bulk_disable(ARRAY_SIZE(ts->supplies), ts->supplies);
+}
+
+static void ft3683g_power_off_act(void *data)
+{
+=09struct ft3683g_data *ts =3D data;
+
+=09ft3683g_power_off(ts);
+}
+
+static int ft3683g_probe(struct spi_device *spi)
+{
+=09struct device *dev =3D &spi->dev;
+=09struct ft3683g_data *ts;
+=09int error;
+
+=09ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+=09if (!ts)
+=09=09return -ENOMEM;
+
+=09ts->dev =3D dev;
+=09ts->spi =3D spi;
+=09spi_set_drvdata(spi, ts);
+=09mutex_init(&ts->spi_lock);
+
+=09ts->supplies[0].supply =3D "vddio";
+=09ts->supplies[1].supply =3D "vci";
+=09error =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(ts->supplies),
+=09=09=09=09=09ts->supplies);
+=09if (error)
+=09=09return dev_err_probe(dev, error, "failed to get regulators\n");
+
+=09ts->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+=09if (IS_ERR(ts->reset_gpio))
+=09=09return dev_err_probe(dev, PTR_ERR(ts->reset_gpio),
+=09=09=09=09     "failed to request reset gpio\n");
+
+=09error =3D ft3683g_power_on(ts);
+=09if (error)
+=09=09return error;
+
+=09error =3D devm_add_action_or_reset(dev, ft3683g_power_off_act, ts);
+=09if (error)
+=09=09return error;
+
+=09error =3D ft3683g_check_chip_id(ts);
+=09if (error)
+=09=09return error;
+
+=09ts->input =3D devm_input_allocate_device(dev);
+=09if (!ts->input)
+=09=09return -ENOMEM;
+
+=09ts->input->name =3D "FocalTech FT3683G Touchscreen";
+=09ts->input->id.bustype =3D BUS_SPI;
+=09input_set_drvdata(ts->input, ts);
+
+=09input_set_capability(ts->input, EV_ABS, ABS_MT_POSITION_X);
+=09input_set_capability(ts->input, EV_ABS, ABS_MT_POSITION_Y);
+=09touchscreen_parse_properties(ts->input, true, &ts->props);
+
+=09error =3D input_mt_init_slots(ts->input, FT3683G_MAX_POINTS,
+=09=09=09=09    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+=09if (error)
+=09=09return dev_err_probe(dev, error, "failed to init MT slots\n");
+
+=09error =3D devm_request_threaded_irq(dev, spi->irq, NULL, ft3683g_irq,
+=09=09=09=09=09  IRQF_ONESHOT, "ft3683g", ts);
+=09if (error)
+=09=09return dev_err_probe(dev, error, "failed to request IRQ\n");
+
+=09error =3D input_register_device(ts->input);
+=09if (error)
+=09=09return dev_err_probe(dev, error,
+=09=09=09=09     "failed to register input device\n");
+
+=09return 0;
+}
+
+static int ft3683g_suspend(struct device *dev)
+{
+=09struct ft3683g_data *ts =3D dev_get_drvdata(dev);
+
+=09disable_irq(ts->spi->irq);
+
+=09input_mt_sync_frame(ts->input);
+=09input_sync(ts->input);
+
+=09ft3683g_power_off(ts);
+
+=09return 0;
+}
+
+static int ft3683g_resume(struct device *dev)
+{
+=09struct ft3683g_data *ts =3D dev_get_drvdata(dev);
+=09int error;
+
+=09error =3D ft3683g_power_on(ts);
+=09if (error)
+=09=09return error;
+
+=09enable_irq(ts->spi->irq);
+
+=09return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ft3683g_pm_ops, ft3683g_suspend, ft3683g_r=
esume);
+
+static const struct spi_device_id ft3683g_id[] =3D {
+=09{ "ft3683g" },
+=09{ }
+};
+MODULE_DEVICE_TABLE(spi, ft3683g_id);
+
+static const struct of_device_id ft3683g_of_match[] =3D {
+=09{ .compatible =3D "focaltech,ft3683g", },
+=09{ }
+};
+MODULE_DEVICE_TABLE(of, ft3683g_of_match);
+
+static struct spi_driver ft3683g_driver =3D {
+=09.driver =3D {
+=09=09.name =3D "focaltech-ft3683g",
+=09=09.of_match_table =3D ft3683g_of_match,
+=09=09.pm =3D pm_sleep_ptr(&ft3683g_pm_ops),
+=09},
+=09.probe =3D ft3683g_probe,
+=09.id_table =3D ft3683g_id,
+};
+module_spi_driver(ft3683g_driver);
+
+MODULE_AUTHOR("Alexander Koskovich <akoskovich@pm.me>");
+MODULE_DESCRIPTION("FocalTech FT3683G touchscreen driver");
+MODULE_LICENSE("GPL");

--=20
2.55.0


