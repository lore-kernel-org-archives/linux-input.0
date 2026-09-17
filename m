Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85C3A48E2
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633538; cv=none; b=mVNlbgRX0+QcU4l0rVl26IuuakVnR0R06jFAYyBgwCBFjjjC4EVqZYjrjtLG6K7qxlIJs8y/AfnQH8vybXIwrB5HypVFe0TYfr8/z+xCBKICrVincLFKZz5rzzpnLXUag1Ac4qv3HjSlCV2EuuRm7hZXpMzhPF0Qm/XhqplV0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633538; c=relaxed/simple;
	bh=TdVY/83MraaxJ7fAhtV+rF02u2R1xhzNiw62qZDXq1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fP1sM9nEFOz8LzoI20i/PR7np3wbFfiDU+LlQDsXec4FbnK9FAoq5eC5ziMB85Gc/rQMXlVMpBtBBRNT1e+DnWpGR/Ho2qAO4l//fUrXgMnx7uCmrg+0d3IjWt/RuUuGx+87IHHzihpW4oWnMaTn83WUxaztMeFu8Wvv5o107+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=gprsJ9j2; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="gprsJ9j2"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe7so89665466b.3
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 01:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1789633528; x=1790238328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qDd2rqEWIMnT2Qq4JLPJqf7hZzHmYiYKDQFOGmsjm5U=;
        b=gprsJ9j2EGxzO8xslJKG4+WH6SzlD5OQ+PeCKjabV0ZSIPNTMagR4Tc6Y5RxfGAYbg
         1NzRO3pUAcbxNOTN0PoDpHNz1U5HOrXTtsFicBi1cNSa0q+0VD37jxIA0gLa5J4KSlVK
         +c6idgb2qcHDumV/Fu9iW63T6NuI/yjInTVXNXJbAl8Mn0Fd56v858U/iyMt4Giya5lB
         ngy2IVrOSYr6/l4/0i7soneLCJX9spAcFprbkW7xSWOJaI+WH9JOghJNG8oMEv96YF4K
         jibAbCJwleECy/4rjXDmROJlyIR8fmgA/dLNaYlpiC50nPQRV0iAk7tc/y94hr2Qhhgr
         e/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633528; x=1790238328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qDd2rqEWIMnT2Qq4JLPJqf7hZzHmYiYKDQFOGmsjm5U=;
        b=xCfj0Kx3feNwQhkTBgudSXBuFKOesJWlXSz2qA/zIx5IbOA9BTzoTusn49dDEhDBkB
         9XvBFEbxWroV8R4GCqqI4+tiEbnlu3hyK4T2w4TMilCztugbv+if0wCblaWR1iuc3FC/
         PT7JhDllBocJLGuh3G2JEJQA7vdjOhB6Yjic9qjWO2ro4d7/1Ewl00CbEgUBDR6hHPMz
         lXxBZ4lsEq0UPYRmNuQRTdU4tkQoCwvogRbJsVoawcAO3IeV0DBizdiGml4ZxZNLwEHR
         DI4xCjgjY3M4jTBbn5U/qKKcOL0cV2bbcaNqYyIqV0FjG/d8EY1bpx1n+/fjFWpc8ukt
         20GQ==
X-Forwarded-Encrypted: i=1; AKwUvBySNldY3uUVamgjtJfD8BKiOUY3rbn9Kul2V3rU7o5ZMQEZa9Yrc+L6pI/BD9NxUK4MazMUwc/0cQEU8w==@vger.kernel.org
X-Gm-Message-State: AFuF++npOiFr1cjpLPhtEvyVI0PQASmwqCk6M1pynHZoN0Xc+1v0Bre3
	j7QevwcYX2j3dD1YCK+2ghTkp5NoGsDblZ8um6wAN+FhUNsbdg9WuobNyn+wfQGUP43155QJxec
	7Y+C/
X-Gm-Gg: AYBFou156oT0hV2jDiuJ5HEUzdLzhA5HuvbVfDV+9vutgDyDHOFsbw3x9eLT1B8iu41
	lE8N5tFwn/DmjJGbGeV16R4NxD1ohk+vQmZ1cNSA8yiWDYifJdRsj8gULmkHJQY1OYNoanfqOAr
	1diSYYp4t+78cMwHqagfcL7C0knbP/cZc1ps3YHxbKvIih1fqvxzENbtbS02YYRoOg8bLX2jcVZ
	j1vMZC5mz55dWpF96huPCT8IritodvHCz7bgA3zH8Ejww8h9lYyCS2Lw2k74zlWb7OyKNLslSzK
	f/46V0iQiH/4Wo2BeEXvNrArpbEx4eHxTGd1Und7YzT3Fb6uP4BX2CBTr6OZ0tVmlBOtMh5UlQF
	+JJGkLt7ZbKdhj5VY/aYzNnPiBGFQanCGXLxjcvBf9T95zJPITauKAGIEMPn+y0kTMz+BEnp3sJ
	Q/OGvus0f6jrr8cJVj0O57nbYglPVC2iKQ0eW+GdOAi26QathSMaO6bidsxUelc1YwUy5ynsB/4
	MX3Ri0cnUMTQWUGWmi3UvapZjEvOM6m20RH7/1eczRmRnOAoiJu
X-Received: by 2002:a17:907:d89:b0:c26:3424:f7df with SMTP id a640c23a62f3a-c29e52b4118mr392025966b.30.1789633528080;
        Thu, 17 Sep 2026 01:25:28 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de0851ebsm242943966b.4.2026.09.17.01.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:25:27 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 17 Sep 2026 10:25:24 +0200
Subject: [PATCH v2 2/3] Input: Add driver for ESWIN EPH8621 touchscreen IC
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-eswin-eph8621-v2-2-f534080a6338@fairphone.com>
References: <20260917-eswin-eph8621-v2-0-f534080a6338@fairphone.com>
In-Reply-To: <20260917-eswin-eph8621-v2-0-f534080a6338@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789633524; l=11037;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=TdVY/83MraaxJ7fAhtV+rF02u2R1xhzNiw62qZDXq1w=;
 b=2UOJIZ+laWpe3z69dv4+0glRVKsMCHlTwvmgqiM0k6K1BUnzT59ZDERYvBg3XINscJ8/8PU4d
 NrvifQDByOmDRIYX8IFv+aL9tt8CTkcB+9Rj6IAI6LdT+oEnhglTRSs
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
 drivers/input/touchscreen/eswin_eph8621.c | 333 ++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)

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
index 000000000000..866cdc7e9334
--- /dev/null
+++ b/drivers/input/touchscreen/eswin_eph8621.c
@@ -0,0 +1,333 @@
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
+	if (buf != ts->rx_buf)
+		memcpy(buf, ts->rx_buf, len);
+
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
+	error = eswin_spi_read(ts, payload_len + TLV_HEADER_SIZE, buf);
+	if (error)
+		return error;
+
+	return payload_len;
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
+	if (slot >= ESWIN_MAX_TOUCHES) {
+		dev_warn_ratelimited(ts->dev, "Invalid slot ID: %d\n", slot);
+		return;
+	}
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
+static void eswin_process_report(struct eswin_touch *ts, u8 *buf, unsigned int payload_len)
+{
+	u16 total_len = payload_len + TLV_HEADER_SIZE;
+	u16 offset = TLV_HEADER_SIZE;
+
+	if (buf[TLV_TYPE_FIELD] != TLV_REPORT_DATA)
+		return;
+
+	while (offset < total_len) {
+		u8 ev_len = buf[offset] & EVENT_REPORT_LENGTH_MASK;
+
+		/* Event length must cover the 8-byte payload (ev_len is exclusive of the 1-byte header) */
+		if (ev_len < 7) {
+			dev_warn_ratelimited(ts->dev, "Malformed event length: %d\n", ev_len);
+			break;
+		}
+
+		/* Ensure at least 8 bytes remain for a full contact payload */
+		if (total_len - offset < 8) {
+			dev_warn_ratelimited(ts->dev, "Truncated touch payload\n");
+			break;
+		}
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
+	int payload_len;
+
+	payload_len = eswin_comms_two_stage_read(ts, ts->rx_buf);
+	if (payload_len > 0)
+		eswin_process_report(ts, ts->rx_buf, payload_len);
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

