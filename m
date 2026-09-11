Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFCA374A05
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139781; cv=none; b=JRkyULifXOruw4dj3nwmwpmPWNT4XJUf0G559naAqURV+rhEglbL2v6AYdFr8+t16Xj8cBLAfZQ4/DSlyRY/XKRFIB2RD6IzpTKtLKNVRFR6AMz1V92UX/CQ8csQfdUrNEL6H0utbKpLTKHsJjr/TMM3CG4D51D0Vh2JPNT+71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139781; c=relaxed/simple;
	bh=dftZvX/KHdVX0CR6WV563b/JJ4fcKbV2x218LJ0LRfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aB43OhXOpqpDq+pl88p7CrUwmKs5103ru3913gSG4gLXrpne7Q55g3wWu2iF6g+S2HS2UfvMffxU+PL89PhwCCXd+U2Hc8GVFEj5B/Y67N7YmfN+t8MzdyrlZJ5vgP1WCdq5D9YNstCV/BOvW6Kbva73QedEg5Fkj/zSZ2uuKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=WieSbMec; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="WieSbMec"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2949ed8cc3so188682066b.2
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 08:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789139776; x=1789744576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S9ABN5lNyogJGbxMYHZpdC+mEyYAf+m8sMuYe7vU9MQ=;
        b=WieSbMecCsiMZFk+Ok0CPNkUeHilvc5feb5uWkf7b13bB8sfsGCe+8EQnStBGy7kIE
         zQ6H1XnQLSkFPbp4KLLmA3e+85U49ToKbu43klbcgrGOZ1vGHN1RHcuwd0YMbQd+QH9p
         be9A4lY58cVnk9WEte3CwqxjgG2ksxIz4WcJyx39axN0KqvCi4qH0Qdei6IO+U0q2uVv
         LDicuONpMpv+6mlp1jIZmAQebehEdgDvngPxlYc58O4NzPBeueDEVyITvn7WK1qjQT5F
         EZbRLhhzwjF6GuVplGEDQ8OnDLXnIKkIBSOM6wez2Om0FIdAJNajUT/FMdmIvsCDDu6R
         bOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139776; x=1789744576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9ABN5lNyogJGbxMYHZpdC+mEyYAf+m8sMuYe7vU9MQ=;
        b=Vj06hlMH/2OwjTOeEUctiMqAZitnP3xas8/hf6AbAOKMsGMbW0L5nEBD9Q+5HaHFwF
         etu5gAlqYKOAybtn3xP33jlvR/PzUO8/GYelPPQmDV1iJNS1DcLQD/7VFktn5yfU2nPF
         X0irpTRW71ozb8XSB6AtVkLOwNzMj/WzEijaMKgYmz9U/WTWu36l/636RZA2nqyHrKgH
         H1FmtSaUTbFQwVGPnhPDU53I/lpSC6jBymtsdVForR5wMAUYe9BH0u1JSzTjodyA4cbM
         djYzft9eJJWk4RkbRzL7kE2/+K8Y0GfhP6Gs24MNW86LUFt/A3R5FQFYrI3+a9/+5Gea
         fPfA==
X-Forwarded-Encrypted: i=1; AKwUvBx2MrBI8ufwAukj+tKm8WYrdzs5rAGp9PIrNyGIZajwLPXaPKmut+5aNHLjH/nfoEGkmZYyqMUJ+BOV0A==@vger.kernel.org
X-Gm-Message-State: AFuF++nhWQ+GyMv6oc/cK2Z1mp1xAyBJTpMgAqhA5QQGmWitlXTA4Y8V
	PCvt+y4/O8eT2uNRkb+U2ma1vnEnQPWIUGb76hocAc7wG2IpmSpI7MESpu6vJTXVc7U8vOHF0xc
	3JU16
X-Gm-Gg: AYBFou1MuBcDzbLf8GH23wlYC2ZcagT4UPZeC4E4JIn5wLr77Onuih+8crZE4OnaaHp
	AKA5PRdTeX6NcvsmEkmQ6QZypH9RAgVVrE3zRHe8zn9OBRaDHaDt5yF7/LCcbT/qGu1tS0R+uy6
	EZ6bxn/T3ACkkDeJJBueeAd52GWScDY3ZZ1PtSZqNKfAW3lv+KPsxncm1FxgvI1XZxlnOl3vT1X
	+FlGEMCnoOm+8xazPsi3QH0/F4YH8AcEyNaYNdzo9kMOIQn8cBDA2LzfoKirBxIBh6bPWeELsG8
	v96SLvzDASfQfg3csNXa2XS2GWByytf8iUQL90BD+VAuac9xAd/ZWgInnqbZv8Yn54cafxd9ZZO
	c344S91yLkDu2Uvsaz/Lrl/dZH2Nn9QEXJpTNwguTIGuyR37OgHuiJEjE0XlbtXK656+NJrmvdQ
	MRdxOj+b7ygHl2pmxg7VaBRe8LDAFWifMGW2bc3+odu1ykxETn8W1opWaEvZd2OdAoBM1Udr6Ok
	mx489kiUGlfJOrPw/g9hHj6DNW7/151JIus7AP3nQv5uQ9slAe6/A==
X-Received: by 2002:a17:907:3f98:b0:c29:45f6:6a0b with SMTP id a640c23a62f3a-c29667069b1mr225027066b.34.1789139776366;
        Fri, 11 Sep 2026 08:16:16 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660ba623sm94656766b.45.2026.09.11.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:16:15 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 11 Sep 2026 17:16:10 +0200
Subject: [PATCH 2/3] Input: Add driver for ESWIN EPH8621 touchscreen IC
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-eswin-eph8621-v1-2-db447ff9e445@fairphone.com>
References: <20260911-eswin-eph8621-v1-0-db447ff9e445@fairphone.com>
In-Reply-To: <20260911-eswin-eph8621-v1-0-db447ff9e445@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789139772; l=10408;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=dftZvX/KHdVX0CR6WV563b/JJ4fcKbV2x218LJ0LRfc=;
 b=pBwASyFjhf+tD8f0FuO1U32IvharcJENhWsGi6Lu+asdmlIvTSoWOWMFbpgtqV4buscsNP0TT
 M395hvCa9PkCZMpqKXhBXFQC9uKme2A+2NGBWKnpsbItlieGjye69C+
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a driver for the ESWIN EPH8621 touchscreens, connected via SPI.

The driver this is based on - EPH861X - also supports I2C but this is
not added the Fairphone (Gen. 6) has the touchscreen connected via SPI.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/input/touchscreen/Kconfig         |  12 ++
 drivers/input/touchscreen/Makefile        |   1 +
 drivers/input/touchscreen/eswin_eph8621.c | 310 ++++++++++++++++++++++++++++++
 3 files changed, 323 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9b9ae8ac3f7f..007b589cef8e 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -360,6 +360,18 @@ config TOUCHSCREEN_EGALAX_SERIAL
 	  To compile this driver as a module, choose M here: the
 	  module will be called egalax_ts_serial.
 
+config TOUCHSCREEN_ESWIN_EPH8621
+	tristate "ESWIN EPH8621 touchscreen"
+	depends on SPI_MASTER
+	help
+	  Say Y here if you have a ESWIN EPH8621 connected to
+	  your system via SPI.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called eswin_eph8621.
+
 config TOUCHSCREEN_EXC3000
 	tristate "EETI EXC3000 multi-touch panel support"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index bfd9de83389d..4540169d9b54 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_TOUCHSCREEN_ELAN)		+= elants_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
+obj-$(CONFIG_TOUCHSCREEN_ESWIN_EPH8621)	+= eswin_eph8621.o
 obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
diff --git a/drivers/input/touchscreen/eswin_eph8621.c b/drivers/input/touchscreen/eswin_eph8621.c
new file mode 100644
index 000000000000..12b90cc89052
--- /dev/null
+++ b/drivers/input/touchscreen/eswin_eph8621.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ESWIN EPH8621 series touchscreen driver
+ *
+ * Copyright (C) 2026 Luca Weiss <luca.weiss@fairphone.com>
+ *
+ * Based on original EPH861X driver by chris.ollerenshaw@eswin.com
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sizes.h>
+#include <linux/spi/spi.h>
+
+#define ESWIN_MAX_TOUCHES		10
+#define ESWIN_COMMS_BUF_SIZE		3072
+
+/* TLV Protocol Definitions */
+#define TLV_HEADER_SIZE			3 /* 1 byte Type + 2 bytes Length */
+#define TLV_TYPE_FIELD			0
+#define TLV_LENGTH_FIELD		1
+
+#define TLV_REPORT_DATA			0x23
+#define EVENT_REPORT_TYPE_OFFSET	4
+#define EVENT_REPORT_TYPE_MASK		0xF0
+#define EVENT_REPORT_LENGTH_MASK	0x0F
+
+/* Event Types */
+#define CONTACT_TYPE			1
+#define RELEASE_TYPE			2
+
+struct eswin_touch {
+	struct device *dev;
+	struct input_dev *input;
+
+	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data supplies[2];
+
+	struct touchscreen_properties prop;
+
+	u8 *rx_buf;
+	u8 *tx_buf;
+};
+
+static int eswin_spi_read(struct eswin_touch *ts, u16 len, u8 *buf)
+{
+	struct spi_device *spi = to_spi_device(ts->dev);
+	struct spi_transfer xfer = {
+		.tx_buf = ts->tx_buf,
+		.rx_buf = ts->rx_buf,
+		.len = len,
+	};
+	int error;
+
+	if (len > ESWIN_COMMS_BUF_SIZE)
+		return -EINVAL;
+
+	/* ESWIN requires 0xFF dummy bytes clocked out to read data */
+	memset(ts->tx_buf, 0xFF, len);
+	error = spi_sync_transfer(spi, &xfer, 1);
+	if (error)
+		return error;
+
+	memcpy(buf, ts->rx_buf, len);
+	return 0;
+}
+
+/*
+ * Core Touch Handling
+ */
+static int eswin_comms_two_stage_read(struct eswin_touch *ts, u8 *buf)
+{
+	u16 payload_len;
+	int error;
+
+	/* Stage 1: Read 3-byte header */
+	error = eswin_spi_read(ts, TLV_HEADER_SIZE, buf);
+	if (error)
+		return error;
+
+	payload_len = buf[TLV_LENGTH_FIELD] | (buf[TLV_LENGTH_FIELD + 1] << 8);
+	if (payload_len == 0 || payload_len > ESWIN_COMMS_BUF_SIZE - TLV_HEADER_SIZE)
+		return -EINVAL;
+
+	udelay(50);
+
+	/* Stage 2: Read full packet (Header + Payload) */
+	return eswin_spi_read(ts, payload_len + TLV_HEADER_SIZE, buf);
+}
+
+static void eswin_report_contact(struct eswin_touch *ts, u8 *payload)
+{
+	u8 touch_type = (payload[0] & EVENT_REPORT_TYPE_MASK) >> EVENT_REPORT_TYPE_OFFSET;
+	u8 slot = payload[1];
+	u16 x = payload[2] | (payload[3] << 8);
+	u16 y = payload[4] | (payload[5] << 8);
+	u8 width = payload[6];
+	u8 height = payload[7];
+	bool active = false;
+
+	switch (touch_type) {
+	case CONTACT_TYPE:
+		active = true;
+		break;
+	case RELEASE_TYPE:
+		active = false;
+		break;
+	default:
+		dev_warn_ratelimited(ts->dev, "Unhandled touch type: %d\n", touch_type);
+		return;
+	}
+
+	input_mt_slot(ts->input, slot);
+	input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, active);
+
+	if (active) {
+		touchscreen_report_pos(ts->input, &ts->prop, x, y, true);
+		input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR, height);
+		input_report_abs(ts->input, ABS_MT_TOUCH_MINOR, width);
+	}
+}
+
+static void eswin_process_report(struct eswin_touch *ts, u8 *buf)
+{
+	u16 total_len = buf[TLV_LENGTH_FIELD] | (buf[TLV_LENGTH_FIELD + 1] << 8);
+	u16 offset = TLV_HEADER_SIZE;
+
+	if (buf[TLV_TYPE_FIELD] != TLV_REPORT_DATA)
+		return;
+
+	while (offset < total_len + TLV_HEADER_SIZE) {
+		u8 ev_len = buf[offset] & EVENT_REPORT_LENGTH_MASK;
+
+		eswin_report_contact(ts, &buf[offset]);
+		offset += (ev_len + 1);
+	}
+
+	input_mt_sync_frame(ts->input);
+	input_sync(ts->input);
+}
+
+static irqreturn_t eswin_interrupt(int irq, void *dev_id)
+{
+	struct eswin_touch *ts = dev_id;
+	int error;
+
+	error = eswin_comms_two_stage_read(ts, ts->rx_buf);
+	if (!error)
+		eswin_process_report(ts, ts->rx_buf);
+
+	return IRQ_HANDLED;
+}
+
+static int eswin_power_on(struct eswin_touch *ts)
+{
+	int error;
+
+	error = regulator_bulk_enable(ARRAY_SIZE(ts->supplies), ts->supplies);
+	if (error)
+		return error;
+
+	msleep(150);
+	gpiod_set_value_cansleep(ts->reset_gpio, 0);
+	msleep(100);
+
+	return 0;
+}
+
+static void eswin_power_off(struct eswin_touch *ts)
+{
+	gpiod_set_value_cansleep(ts->reset_gpio, 1);
+	regulator_bulk_disable(ARRAY_SIZE(ts->supplies), ts->supplies);
+}
+
+static void eswin_power_off_act(void *data)
+{
+	struct eswin_touch *ts = data;
+
+	eswin_power_off(ts);
+}
+
+static int eswin_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct eswin_touch *ts;
+	int error;
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	ts->dev = dev;
+	spi_set_drvdata(spi, ts);
+
+	spi->mode = SPI_MODE_3;
+	spi->bits_per_word = 8;
+	error = spi_setup(spi);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to setup SPI\n");
+
+	ts->rx_buf = devm_kzalloc(dev, ESWIN_COMMS_BUF_SIZE, GFP_KERNEL);
+	ts->tx_buf = devm_kzalloc(dev, ESWIN_COMMS_BUF_SIZE, GFP_KERNEL);
+	if (!ts->rx_buf || !ts->tx_buf)
+		return -ENOMEM;
+
+	ts->supplies[0].supply = "vddio";
+	ts->supplies[1].supply = "avdd";
+	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(ts->supplies), ts->supplies);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to get regulators\n");
+
+	ts->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ts->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ts->reset_gpio),
+				     "Failed to request reset GPIO\n");
+
+	error = eswin_power_on(ts);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to power on\n");
+
+	error = devm_add_action_or_reset(dev, eswin_power_off_act, ts);
+	if (error)
+		return error;
+
+	ts->input = devm_input_allocate_device(dev);
+	if (!ts->input)
+		return -ENOMEM;
+
+	ts->input->name = "ESWIN Touchscreen";
+	ts->input->id.bustype = BUS_SPI;
+
+	input_set_abs_params(ts->input, ABS_MT_POSITION_X, 0, SZ_64K - 1, 0, 0);
+	input_set_abs_params(ts->input, ABS_MT_POSITION_Y, 0, SZ_64K - 1, 0, 0);
+	input_set_abs_params(ts->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+	input_set_abs_params(ts->input, ABS_MT_TOUCH_MINOR, 0, 255, 0, 0);
+
+	touchscreen_parse_properties(ts->input, true, &ts->prop);
+
+	error = input_mt_init_slots(ts->input, ESWIN_MAX_TOUCHES, INPUT_MT_DIRECT);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to initialize MT slots\n");
+
+	error = devm_request_threaded_irq(dev, spi->irq, NULL, eswin_interrupt,
+					  IRQF_ONESHOT, dev_name(dev), ts);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to request IRQ\n");
+
+	return input_register_device(ts->input);
+}
+
+static int eswin_suspend(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct eswin_touch *ts = spi_get_drvdata(spi);
+
+	disable_irq(spi->irq);
+	eswin_power_off(ts);
+
+	return 0;
+}
+
+static int eswin_resume(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct eswin_touch *ts = spi_get_drvdata(spi);
+	int error;
+
+	error = eswin_power_on(ts);
+	if (error)
+		return error;
+
+	enable_irq(spi->irq);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(eswin_pm_ops, eswin_suspend, eswin_resume);
+
+static const struct of_device_id eswin_of_match[] = {
+	{ .compatible = "eswin,eph8621" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, eswin_of_match);
+
+static const struct spi_device_id eswin_spi_id[] = {
+	{ .name = "eph8621" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, eswin_spi_id);
+
+static struct spi_driver eswin_spi_driver = {
+	.driver = {
+		.name = "eswin_eph8621",
+		.of_match_table = eswin_of_match,
+		.pm = pm_sleep_ptr(&eswin_pm_ops),
+	},
+	.probe = eswin_probe,
+	.id_table = eswin_spi_id,
+};
+module_spi_driver(eswin_spi_driver);
+
+MODULE_AUTHOR("Luca Weiss <luca.weiss@fairphone.com>");
+MODULE_DESCRIPTION("ESWIN EPH8621 SPI touchscreen driver");
+MODULE_LICENSE("GPL");

-- 
2.55.0

