Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919198;
	b=d1+3g9S+CwJXmPM2MinlS6Gm0UtDVRpw2tkSv/Z6L4sBWXKEwGLcRJfWOxNfQvuqMcd6
	 tWwCfbO50CiOwTRwlFr2+kYqb0zpqi1uHb/phqm63H+JzY3xWtv/pzQxS9+9WYLIeeoi4
	 mesghMpCLQCzmUizVAdoWy+yHnsXduoEWwjHulOuotfEXvWgfc74XTpMFt1cYV7OVAQO2
	 djz3MNYJKkmoMaIocsUBS1VKyCnjLS9kaVDObhtZzDeF7DFGoQa++oUGkL/sPqQfc/VtQ
	 MWUo6YKAnJozEobllkrmttxeY43Z9Qf/OBeN01lIAyClvcU3wgv0IVbAZkMh4JkJ3Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aJFaa+PuDhZz0tEI6GPK/mgT16WcMW99XS64dcpzMzA=;
	b=jlWoXB80fihOMKOpyxB6EBhAq6NpDOzvGaaABx4yG5gpRrGZjmSLbSTfZWD66tqBZHA/
	 F1qyUeJE1amrtrGwkOOvjFyP4lbpmQu/bEtfg/dT1LQ/yOK0s/KZpA1PLDlXktBvK9x/5
	 VNTBBYUDDzQVGLH1bkaKxbkr4KeDRZO9cIVZqxrvr5f0iaNdpdAAm1lsQR9gs2lmlcBRU
	 QB74UZwLWngPSWMHHyCL+klWWsxnf6ThaFg/uIJoSufaRXSReqjGm71YqoZulGYzVTGt5
	 FK6RVtXbBmBpgb0my7GJn9S8zkVFr9tQQpuouHUQ3MGYXrApZm0os0GyjJa2GWva1MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kZn95Fo+;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E0C60A3832
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9E0C60A3832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kZn95Fo+
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so21348485e9.0
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 04:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794919196; x=1795523996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJFaa+PuDhZz0tEI6GPK/mgT16WcMW99XS64dcpzMzA=;
        b=kZn95Fo+MDIMSb0LQRD7j3LB23x1WDCOPvwqwM54yVp6uVekRvmA6lWxJhGJ0pG2Mh
         1xi2vNxVr3MfCDuLO3IPiGtDOya9j4kidB+fivprZPx+BN547yJJ1QrUFHgrYn7mtbSR
         AfmbvefVJwvYO9CFM/ZEM/g50+6n7ghP8AvACoOpeIkKdTAmtAfxgprDIGSRilQFhGEh
         W/2/g+P9ApNN2STEx3lLusKM/aposVE0yr94Widvj6V6DXjLhErPziGJ2xEl7day+LPD
         rqZBhX2kzmNKAeUpviz41pNWtle6KzQZo+mtV9oBxvbaHn2uM2KQcFqe9WLTRHL2Po04
         mtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919196; x=1795523996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aJFaa+PuDhZz0tEI6GPK/mgT16WcMW99XS64dcpzMzA=;
        b=ynJyNO4QOZGJf+E1ZSx4+uKKi4L2Dh+6wNnXFx4grYwHO/wOiwXSFMHuL8/nPj6yt5
         +S8kiHUHJ9QKCb/kuh+6PTYzwvBzWLnUwbsULOqM+BY1vdiwqyn7/nKcWCwApKbIY47i
         dcaMNqlj2XokpWUK0mRAyY73/4MJH1cHQjxGN5AB9lZm5hHVeETstMzA0ECEEPfaLwfs
         BF3YtO1MsLSJtr24vVQ5lfDihcJeFgcvQ8Qbhq1eiefEab4+JHgSTIYdXRC81tOEMU+b
         pqz14mcXIivKEvKNJnDoJudZbvLQApCMhDY6CdOANnI8NuraMUdE60H/jzHbyef1MKR6
         tjvg==
X-Forwarded-Encrypted: i=1; AL+hErFiRflKdFcPL9JnlLYdsRUHSuxkVF4HBWr7YZ2+MFfkYdkEUip6JGpc5njpS3W9T4NrSRMCk0zBiDC3RA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/q6Wi2sFNw/P7aHKyL2RJLlQfB2Yl/XVSKf+El9TJoW2zc3ltL
	w2eQXpyJsyLRxz6fXmqoS3PD7bZbOGnkwXvjQ9/RMrVs5+VoaZvFyqFi
X-Gm-Gg: AYBFou0yi5pRtpBxvgQ84eDjX1ajH8RnRdAirhxgLded2DZvUxMFwrrX/9Pqiyqx5Yj
	K6bcfZWv/W1nacfU8ddcE5lnlOVGxsoKkym54nY8U2OKIsRLQ2U1DpVe/J86cK0Nxo95SBPCv02
	sIqgv2IlcFE1r8uqVJpqAgOTLSeBX8CnwI278eCtAMHGVOMXlpUK7r/ssbrG16gDZI0BID1dvQ3
	3LwbFsqqugZTWoAtQVXJSbXLuoJ/HgLdGm0PcIbhxcXRQTYCzq1xcYf4UrAQK4JTgdepYNO2gmG
	yRnwETC0T559PZhtLck9ZO2nOhAq9lAnKmmtOdkQQBFZLOrsH/ZYp6TTjDuZBZl7fjml32ZnuQc
	B7cR2Dk8++5RdDYYRtMqDHP9XxR+ys098ucgka8VB7LIUehgSqwZKNyEFowjn7uD6vLZHFH75WI
	qK3jT9IaWPu0nWTtxyrAxSCQg2OhS4kYkYH3YiJBn/rnk/jaOmeZeaeg2fVT2zvOSZxnpr/CP1X
	h8XlrQpxQgy52HkJuyXp+yp9FOXFZo48MeG6nP6b8GaVOEnTbISGVb5MaoxKa0HiR/qWIDNdYPh
	Fbn/t7tdqHFY6M+pjSu8XbfoGaie8vixBmXielVQSjMQz9+AmcdD0iSnMgfJjAyzVD9IbQ==
X-Received: by 2002:a05:600c:4e43:b0:4a7:c366:d791 with SMTP id 5b1f17b1804b1-4bb559f24ffmr285704105e9.1.1794919196241;
        Tue, 17 Nov 2026 04:39:56 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu. [94.21.223.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:39:55 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 07/11] Input: touchscreen: add Silicon Works SW42902 support
Date: Tue, 17 Nov 2026 13:39:42 +0100
Message-Id: <20261117123946.668557-8-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic multitouch support for the SW42902 controller. Implement the
GPIO power and reset sequence and use the firmware already present in
controller flash; no firmware update is performed.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 MAINTAINERS                         |   1 +
 drivers/input/touchscreen/Kconfig   |  11 +
 drivers/input/touchscreen/Makefile  |   1 +
 drivers/input/touchscreen/sw42902.c | 315 ++++++++++++++++++++++++++++
 4 files changed, 328 insertions(+)
 create mode 100644 drivers/input/touchscreen/sw42902.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f4c54d7d86bd8..83bbedde94533 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25840,6 +25840,7 @@ M:	rofikkerneldev <rofikcoga@gmail.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
+F:	drivers/input/touchscreen/sw42902.c
 
 SILVACO I3C DUAL-ROLE MASTER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9b9ae8ac3f7fd..eadba5125a225 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1402,6 +1402,17 @@ config TOUCHSCREEN_ZINITIX
 	  To compile this driver as a module, choose M here: the
 	  module will be called zinitix.
 
+config TOUCHSCREEN_SW42902
+	tristate "Silicon Works SW42902 touchscreen"
+	depends on I2C
+	depends on GPIOLIB
+	help
+	  Say Y here for the SW42902 I2C touchscreen used in the LG V60.
+	  Basic multitouch uses the controller's existing flash firmware.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called sw42902.
+
 config TOUCHSCREEN_HIMAX_HX83112B
 	tristate "Himax hx83112b touchscreen driver"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index bfd9de83389d8..ee312c2d1529c 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -119,3 +119,4 @@ obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
 obj-$(CONFIG_TOUCHSCREEN_IQS7211)	+= iqs7211.o
 obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
 obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
+obj-$(CONFIG_TOUCHSCREEN_SW42902)		+= sw42902.o
diff --git a/drivers/input/touchscreen/sw42902.c b/drivers/input/touchscreen/sw42902.c
new file mode 100644
index 0000000000000..7b39a97053c63
--- /dev/null
+++ b/drivers/input/touchscreen/sw42902.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Silicon Works SW42902 touchscreen, as used by LG V60 (timelm).
+ * Register protocol and report layout derived from the LGE vendor driver
+ * (Copyright (C) 2015 LGE, author hoyeon.jang@lge.com).
+ * This driver uses the controller's existing flash firmware.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+
+#define SW42902_MAX_CONTACTS	10
+#define SW42902_REPORT_SIZE	(12 + 24 + 12 * SW42902_MAX_CONTACTS)
+#define SW42902_IC_STATUS	0x600
+#define SW42902_VERSION		0x642
+#define SW42902_DEVICE_CTL	0xc00
+#define SW42902_INTERRUPT_CTL	0xc01
+#define SW42902_DRIVING_CTL	0xc03
+#define SW42902_SERIAL_SPI_EN	0xfe4
+#define SW42902_DRIVING_STOP	0x04
+#define SW42902_DRIVING_U3	0x8303
+
+struct sw42902 {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct touchscreen_properties prop;
+	struct gpio_desc *reset;
+	struct gpio_desc *vcl;
+	struct gpio_desc *vdd;
+	u8 report[SW42902_REPORT_SIZE];
+};
+
+static int sw42902_read(struct sw42902 *ts, u16 reg, void *data, u16 len)
+{
+	u8 command[] = { (reg >> 8) | (len > 4 ? 0x20 : 0), reg & 0xff };
+	struct i2c_msg msgs[] = {
+		{ .addr = ts->client->addr, .len = sizeof(command),
+		  .buf = command },
+		{ .addr = ts->client->addr, .flags = I2C_M_RD,
+		  .len = len, .buf = data },
+	};
+	int ret;
+
+	ret = i2c_transfer(ts->client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret < 0)
+		return ret;
+	return ret == ARRAY_SIZE(msgs) ? 0 : -EIO;
+}
+
+static int sw42902_write(struct sw42902 *ts, u16 reg, u32 value)
+{
+	u8 command[6] = { 0x40 | (reg >> 8), reg & 0xff };
+	int ret;
+
+	put_unaligned_le32(value, command + 2);
+	ret = i2c_master_send(ts->client, command, sizeof(command));
+	if (ret < 0)
+		return ret;
+	return ret == sizeof(command) ? 0 : -EIO;
+}
+
+static void sw42902_release_contacts(struct sw42902 *ts)
+{
+	int i;
+
+	for (i = 0; i < SW42902_MAX_CONTACTS; i++) {
+		input_mt_slot(ts->input, i);
+		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, false);
+	}
+	input_mt_sync_frame(ts->input);
+	input_sync(ts->input);
+}
+
+static irqreturn_t sw42902_irq(int irq, void *data)
+{
+	struct sw42902 *ts = data;
+	struct input_dev *input = ts->input;
+	u32 status, header;
+	unsigned int count, i;
+	int ret;
+
+	ret = sw42902_read(ts, SW42902_IC_STATUS, ts->report,
+			   sizeof(ts->report));
+	if (ret) {
+		dev_err_ratelimited(&ts->client->dev, "report read failed: %d\n", ret);
+		sw42902_release_contacts(ts);
+		return IRQ_HANDLED;
+	}
+
+	status = get_unaligned_le32(ts->report + 4);
+	header = get_unaligned_le32(ts->report + 8);
+	/* Only normal absolute-touch reports; ignore pen/gesture/debug IRQs. */
+	if (((status >> 16) & 0xf) != 5 || (header & 0xff))
+		return IRQ_HANDLED;
+
+	count = (header >> 8) & 0x1f;
+	if (count > SW42902_MAX_CONTACTS) {
+		dev_warn_ratelimited(&ts->client->dev, "invalid contact count: %u\n", count);
+		sw42902_release_contacts(ts);
+		return IRQ_HANDLED;
+	}
+
+	/* A palm report cancels all active fingers. */
+	if (header & BIT(31)) {
+		sw42902_release_contacts(ts);
+		return IRQ_HANDLED;
+	}
+
+	for (i = 0; i < count; i++) {
+		const u8 *contact = ts->report + 36 + 12 * i;
+		u32 a = get_unaligned_le32(contact);
+		u32 b = get_unaligned_le32(contact + 4);
+		u32 c = get_unaligned_le32(contact + 8);
+		unsigned int id = a & 0x1f;
+		unsigned int event = (a >> 16) & 3;
+
+		if (id == 15) {
+			sw42902_release_contacts(ts);
+			return IRQ_HANDLED;
+		}
+		if (id >= SW42902_MAX_CONTACTS || (event != 1 && event != 2))
+			continue;
+
+		input_mt_slot(input, id);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
+		touchscreen_report_pos(input, &ts->prop, a >> 18, b & 0x3fff, true);
+		input_report_abs(input, ABS_MT_PRESSURE, (b >> 14) & 0xff);
+		input_report_abs(input, ABS_MT_TOUCH_MAJOR, (c >> 4) & 0x3fff);
+		input_report_abs(input, ABS_MT_TOUCH_MINOR, c >> 18);
+	}
+
+	input_mt_sync_frame(input);
+	input_sync(input);
+	return IRQ_HANDLED;
+}
+
+static void sw42902_power_off(void *data)
+{
+	struct sw42902 *ts = data;
+
+	gpiod_set_value_cansleep(ts->reset, 1);
+	usleep_range(1000, 2000);
+	gpiod_set_value_cansleep(ts->vdd, 0);
+	usleep_range(1000, 2000);
+	gpiod_set_value_cansleep(ts->vcl, 0);
+}
+
+static void sw42902_power_on(struct sw42902 *ts)
+{
+	gpiod_set_value_cansleep(ts->vcl, 1);
+	usleep_range(1000, 2000);
+	gpiod_set_value_cansleep(ts->vdd, 1);
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(ts->reset, 0);
+	/* Docomo downstream DT specifies a 90 ms hardware reset delay. */
+	msleep(90);
+}
+
+static int sw42902_start(struct sw42902 *ts)
+{
+	u8 version[4];
+	int ret;
+
+	ret = sw42902_read(ts, SW42902_VERSION, version, sizeof(version));
+	if (ret)
+		return ret;
+	if (version[2] != 10 || (version[3] & 0xf) != 4) {
+		dev_err(&ts->client->dev, "unexpected chip/protocol: %u/%u\n",
+			version[2], version[3] & 0xf);
+		return -ENODEV;
+	}
+
+	ret = sw42902_write(ts, SW42902_SERIAL_SPI_EN, 0);
+	if (ret)
+		return ret;
+	ret = sw42902_write(ts, SW42902_DEVICE_CTL, 1);
+	if (ret)
+		return ret;
+	ret = sw42902_write(ts, SW42902_INTERRUPT_CTL, 1);
+	if (ret)
+		return ret;
+	ret = sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_STOP);
+	if (ret)
+		return ret;
+	msleep(30);
+	return sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_U3);
+}
+
+static int sw42902_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct sw42902 *ts;
+	struct input_dev *input;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+	if (client->irq <= 0)
+		return dev_err_probe(dev, -EINVAL, "missing interrupt\n");
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+	ts->client = client;
+	i2c_set_clientdata(client, ts);
+
+	ts->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ts->reset))
+		return dev_err_probe(dev, PTR_ERR(ts->reset), "reset GPIO\n");
+	ts->vcl = devm_gpiod_get(dev, "vcl", GPIOD_OUT_LOW);
+	if (IS_ERR(ts->vcl))
+		return dev_err_probe(dev, PTR_ERR(ts->vcl), "3.3 V enable GPIO\n");
+	ts->vdd = devm_gpiod_get(dev, "vdd", GPIOD_OUT_LOW);
+	if (IS_ERR(ts->vdd))
+		return dev_err_probe(dev, PTR_ERR(ts->vdd), "1.8 V enable GPIO\n");
+	ret = devm_add_action_or_reset(dev, sw42902_power_off, ts);
+	if (ret)
+		return ret;
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+	ts->input = input;
+	input->name = "Silicon Works SW42902";
+	input->id.bustype = BUS_I2C;
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, 1079, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 2459, 0, 0);
+	input_set_abs_params(input, ABS_MT_PRESSURE, 0, 255, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 16383, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 16383, 0, 0);
+	touchscreen_parse_properties(input, true, &ts->prop);
+	ret = input_mt_init_slots(input, SW42902_MAX_CONTACTS,
+				  INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	if (ret)
+		return ret;
+	ret = devm_request_threaded_irq(dev, client->irq, NULL, sw42902_irq,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					dev_name(dev), ts);
+	if (ret)
+		return dev_err_probe(dev, ret, "interrupt request failed\n");
+
+	sw42902_power_on(ts);
+	ret = sw42902_start(ts);
+	if (ret)
+		return dev_err_probe(dev, ret, "controller initialization failed\n");
+	ret = input_register_device(input);
+	if (ret)
+		return ret;
+	enable_irq(client->irq);
+	dev_info(dev, "SW42902 initialized using existing flash firmware\n");
+	return 0;
+}
+
+static int sw42902_suspend(struct device *dev)
+{
+	struct sw42902 *ts = i2c_get_clientdata(to_i2c_client(dev));
+
+	disable_irq(ts->client->irq);
+	sw42902_release_contacts(ts);
+	sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_STOP);
+	sw42902_power_off(ts);
+	return 0;
+}
+
+static int sw42902_resume(struct device *dev)
+{
+	struct sw42902 *ts = i2c_get_clientdata(to_i2c_client(dev));
+	int ret;
+
+	sw42902_power_on(ts);
+	ret = sw42902_start(ts);
+	if (ret) {
+		sw42902_power_off(ts);
+		return ret;
+	}
+	enable_irq(ts->client->irq);
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(sw42902_pm_ops, sw42902_suspend, sw42902_resume);
+
+static const struct of_device_id sw42902_of_match[] = {
+	{ .compatible = "lg,sw42902" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sw42902_of_match);
+
+static const struct i2c_device_id sw42902_ids[] = {
+	{ "sw42902" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sw42902_ids);
+
+static struct i2c_driver sw42902_driver = {
+	.driver = {
+		.name = "sw42902",
+		.of_match_table = sw42902_of_match,
+		.pm = pm_sleep_ptr(&sw42902_pm_ops),
+	},
+	.probe = sw42902_probe,
+	.id_table = sw42902_ids,
+};
+module_i2c_driver(sw42902_driver);
+
+MODULE_DESCRIPTION("Silicon Works SW42902 touchscreen driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5

