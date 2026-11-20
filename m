Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190101;
	b=ndRZjuKPItRII8o6GEFS5K43VF/lBY29SVxou24fz3grIaXe0qHCBz4NRNdUF+4gVhEg
	 93XocB9ovAwH1fIGhEtaMenyqIKToOQQxsgpn00hd+SYWaXsnuRbXMOGZlcacKbHDh1sz
	 bYWardtPSOxat5DztLBGNT2SQ8jpolZpbl8sBdZkz1sE3nMzAbCviIn5O81CYliikBIqw
	 qTca3fG+dbHo5K2anATPI0HuDf+HJ9V3EJZxB5ydC+59r5yl/ZVIrKyF2fdA7Hl0ITbYH
	 iaU97efqEV7sy70uvSDnElFuKMIfeG+RtH6w/DuTXd0opC/7NB+X7Wa9eFW2x83DFBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iEwn/neGYJcnJW/f7YdqIPyeyWp1f9cfch/HHbVGQAw=;
	b=H5phlKHfu+Jy5lXxygylyS8PQ+nms/vce4X3WHei9oO4H3TdemfTJMANQIP7e8Mx5pqV
	 7zd0L4D6xVSAHPgfeVzf5NwBTDoxRLgYeKYjjkdOyZlELDDVRw2aYzdtIrp0m20+yuLQo
	 D9D0RDoKvRv9W0Ok4UDzFyH0tZC4eG+jA0dWfvEtVg/WeqaLHmQLJ1bgmkReCekD9ZKQU
	 fwcb5ivZIaGHHN37xKyeuGrfXmCn7MzAz7VkBhedHPoXG2/zVpq7kltKW8SeTLq2JEy8f
	 xcBuyJAI7pdLLR5LgCRFm+ksDI2CvyGICZJNSw0QNOLk6E5KBkkExdm9bqWoXS8lYew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wb6b2T8V;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84160A382A
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 15:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A84160A382A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wb6b2T8V
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so8300915e9.3
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190098; x=1795794898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEwn/neGYJcnJW/f7YdqIPyeyWp1f9cfch/HHbVGQAw=;
        b=Wb6b2T8VaKJdRZgYITEFWwuBsHqJDQ3oc0mo/yiDUBLeRAG3ENZrMoZGo1VQ/Ynaec
         iqL230isIjAVpffbFZAQGQvpTcbeq/fb31MPbqkAI4wX1+c6U8W/jNIz5N67CD4rDvQM
         /MrTCWC2ooYipEXcZfTMX0IyEjnMfHTnSZ56tU7z7MnyTHcck5Ar2t5V8L3qiEZIOiCp
         70KqsBH740Oe2uO1qxmKgrbvRXKo61VtdtIk5J2zCu1TfwBRpUGWqGTIbZvMic99Qwml
         qwHuFn2SIl6YsCQZxIa7XSbpUo8SYWi7yBhhiP2n6UTX7/OapkQSxEqrd+AwuYCRUnTW
         mIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190098; x=1795794898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEwn/neGYJcnJW/f7YdqIPyeyWp1f9cfch/HHbVGQAw=;
        b=ok2/vIpxkiA4lDOthCOHn37/AV5vQ3PowsyAyIUFF95cEA/+iS0mAh4sVHMoF1snsj
         MM7/F8hhp71TDLwa+rr+zdU81LSdPZ/bGi5D3ECqqNJHEIJkKMjxEbQe8+j3+Ecl+1jk
         mr1vjK010Pr7FfP0ykh823NMw2KQBX12C6C/FdVXO9VHCnmrImEfLMSdFvzzgTygnvn8
         FtQLY9gIw6Qo7k/bT518vk5etktjWt/n3fCmCwVUxt2Aokh40DPdsBA5cqlX//tIP0S+
         aGDXEJaWhi59e0ES/9QS5yvpz65zGirqeUkGa6iI+Z53l5irIzj3qJZYgfP9rbnH8AcX
         IOMA==
X-Forwarded-Encrypted: i=1; AL+hErFsAt7AbuipPnop5R2fA6NMpLgA0lu2rCNHj9vrcHrUi6jYRfSBKvIpEPGTY5CFvheFtscJ+tBVEGdPVg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Xn6Z4mXRuBIdWD3TDGKj4XUU4lhTyViH6qST5/N9AezuQZayi
	48P20qBy2mmhvucRGqD98oOhyBksoAyx0r77lbwFGu1cCIzF9WBN/XSU
X-Gm-Gg: AYBFou2dVLwv9z2oeXDe0YGzUTBuuSJTxLoXtPm3qIHgjStyn/4nL6q3npYYkLaxCHh
	FpCSXGPj64vBZby4AOY9aJB35hbSjXWvwJqzzWuitQdAPKMCzQil8ePCSlnuqE/rZ2cR4QbUh2n
	D9Ei4ZP/HnWUfePyGOVATszkxoDMCFQaY1ewp5DGocOpgHwytDGlxFCzXp0uSvFfg2fKVetx+y7
	SUMvoIUwPo0ipOs0J5DfsKwbkv4nwfKUrh8aJgiNHG2xkBB6XILPuE1nF1j58J5Sw3QfGsuT95+
	4nyHJ0/14MEVV8eVNrGoD8Wzlzwt7iC2nLhEVCpUVODR1zo6S09qjO//9oeb501vwndk0AozKmK
	x8A2YAUhdPtbw1GRSTItUG0wPQBsJmkkhRL2/Mp1eJdicwrTHbSkILw+zl+qKhplpNN2dYzyUnE
	1ICHT436vykVqN0owMogMewqFIjF9w5Rnb0sumA9tmRLe4Gr6tw1zIuULwHJTV6HqJNyCvA7yo7
	enz8objvSygLNkvwq+oNAUNzV/MGZ6D6Qllkt6dWDaFEgYZfOE4D3QhjEpEFRS9Cx8smXqgZlaL
	YU6UVG9Kj3SEVXfdmpzBT1CIHmHz5cCj6hj65k8z5lxDn4+3lboNJtGW0DXd3SrX+HPz48UaKF2
	r
X-Received: by 2002:a05:600c:5251:b0:4a1:f8cb:7d70 with SMTP id 5b1f17b1804b1-4bb8881e837mr72253505e9.24.1795190098333;
        Fri, 20 Nov 2026 07:54:58 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:54:57 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
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
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v5 06/10] Input: touchscreen: add Silicon Works SW42902 support
Date: Fri, 20 Nov 2026 16:54:45 +0100
Message-Id: <20261120155450.7719-7-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120155450.7719-1-rofikcoga@gmail.com>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
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
power and reset sequence using regulator supplies and use the firmware
already present in controller flash; no firmware update is performed.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 MAINTAINERS                         |   1 +
 drivers/input/touchscreen/Kconfig   |  13 +
 drivers/input/touchscreen/Makefile  |   1 +
 drivers/input/touchscreen/sw42902.c | 360 ++++++++++++++++++++++++++++
 4 files changed, 375 insertions(+)
 create mode 100644 drivers/input/touchscreen/sw42902.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a29019d984393..7a1904f6d0fad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25840,6 +25840,7 @@ M:	Abdur Rofik <rofikcoga@gmail.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
+F:	drivers/input/touchscreen/sw42902.c
 
 SILVACO I3C DUAL-ROLE MASTER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9b9ae8ac3f7fd..14c6cd999ec92 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1299,6 +1299,19 @@ config TOUCHSCREEN_SURFACE3_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called surface3_spi.
 
+config TOUCHSCREEN_SW42902
+	tristate "Silicon Works SW42902 touchscreen"
+	depends on I2C
+	depends on GPIOLIB
+	help
+	  Say Y here if you have a Silicon Works SW42902 touchscreen
+	  connected to your system (e.g. LG V60).
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sw42902.
+
 config TOUCHSCREEN_SX8654
 	tristate "Semtech SX8654 touchscreen"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index bfd9de83389d8..1ee2590014535 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_TOUCHSCREEN_STMPE)		+= stmpe-ts.o
 obj-$(CONFIG_TOUCHSCREEN_SUN4I)		+= sun4i-ts.o
 obj-$(CONFIG_TOUCHSCREEN_SUR40)		+= sur40.o
 obj-$(CONFIG_TOUCHSCREEN_SURFACE3_SPI)	+= surface3_spi.o
+obj-$(CONFIG_TOUCHSCREEN_SW42902)	+= sw42902.o
 obj-$(CONFIG_TOUCHSCREEN_TI_AM335X_TSC)	+= ti_am335x_tsc.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
diff --git a/drivers/input/touchscreen/sw42902.c b/drivers/input/touchscreen/sw42902.c
new file mode 100644
index 0000000000000..7e4032f6400c9
--- /dev/null
+++ b/drivers/input/touchscreen/sw42902.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 Abdur Rofik <rofikcoga@gmail.com>
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
+#include <linux/regulator/consumer.h>
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
+static const char * const sw42902_supplies[] = {
+	"vcl",
+	"vdd",
+};
+
+struct sw42902 {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct touchscreen_properties prop;
+	struct gpio_desc *reset;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(sw42902_supplies)];
+	bool suspended;
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
+	int error;
+
+	error = i2c_transfer(ts->client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (error < 0)
+		return error;
+	return error == ARRAY_SIZE(msgs) ? 0 : -EIO;
+}
+
+static int sw42902_write(struct sw42902 *ts, u16 reg, u32 value)
+{
+	u8 command[6] = { 0x40 | (reg >> 8), reg & 0xff };
+	int error;
+
+	put_unaligned_le32(value, command + 2);
+	error = i2c_master_send(ts->client, command, sizeof(command));
+	if (error < 0)
+		return error;
+	return error == sizeof(command) ? 0 : -EIO;
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
+	int error;
+
+	error = sw42902_read(ts, SW42902_IC_STATUS, ts->report,
+			     sizeof(ts->report));
+	if (error) {
+		dev_err_ratelimited(&ts->client->dev, "report read failed: %d\n", error);
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
+	/* Pre-scan for palm report to avoid queueing partial touch events */
+	for (i = 0; i < count; i++) {
+		const u8 *contact = ts->report + 36 + 12 * i;
+		u32 a = get_unaligned_le32(contact);
+
+		if ((a & 0x1f) == 15) {
+			sw42902_release_contacts(ts);
+			return IRQ_HANDLED;
+		}
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
+	if (ts->suspended)
+		return;
+
+	gpiod_set_value_cansleep(ts->reset, 1);
+	usleep_range(1000, 2000);
+	regulator_bulk_disable(ARRAY_SIZE(ts->supplies), ts->supplies);
+	ts->suspended = true;
+}
+
+static int sw42902_power_on(struct sw42902 *ts)
+{
+	int error;
+
+	error = regulator_bulk_enable(ARRAY_SIZE(ts->supplies), ts->supplies);
+	if (error)
+		return error;
+
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(ts->reset, 0);
+	/* Docomo downstream DT specifies a 90 ms hardware reset delay. */
+	msleep(90);
+
+	return 0;
+}
+
+static int sw42902_start(struct sw42902 *ts)
+{
+	u8 version[4];
+	int error;
+
+	error = sw42902_read(ts, SW42902_VERSION, version, sizeof(version));
+	if (error)
+		return error;
+	if (version[2] != 10 || (version[3] & 0xf) != 4) {
+		dev_err(&ts->client->dev, "unexpected chip/protocol: %u/%u\n",
+			version[2], version[3] & 0xf);
+		return -ENODEV;
+	}
+
+	error = sw42902_write(ts, SW42902_SERIAL_SPI_EN, 0);
+	if (error)
+		return error;
+	error = sw42902_write(ts, SW42902_DEVICE_CTL, 1);
+	if (error)
+		return error;
+	error = sw42902_write(ts, SW42902_INTERRUPT_CTL, 1);
+	if (error)
+		return error;
+	error = sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_STOP);
+	if (error)
+		return error;
+	msleep(30);
+	error = sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_U3);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static int sw42902_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct sw42902 *ts;
+	struct input_dev *input;
+	int error, i;
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
+
+	for (i = 0; i < ARRAY_SIZE(sw42902_supplies); i++)
+		ts->supplies[i].supply = sw42902_supplies[i];
+
+	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(ts->supplies), ts->supplies);
+	if (error)
+		return dev_err_probe(dev, error, "failed to get regulators\n");
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
+	error = input_mt_init_slots(input, SW42902_MAX_CONTACTS,
+				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	if (error)
+		return error;
+
+	error = sw42902_power_on(ts);
+	if (error)
+		return error;
+
+	error = devm_add_action_or_reset(dev, sw42902_power_off, ts);
+	if (error)
+		return error;
+
+	error = devm_request_threaded_irq(dev, client->irq, NULL, sw42902_irq,
+					  IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					  dev_name(dev), ts);
+	if (error)
+		return error;
+
+	error = sw42902_start(ts);
+	if (error)
+		return dev_err_probe(dev, error, "controller initialization failed\n");
+	error = input_register_device(input);
+	if (error)
+		return error;
+	enable_irq(client->irq);
+	dev_info(dev, "SW42902 initialized using existing flash firmware\n");
+	return 0;
+}
+
+static int sw42902_suspend(struct device *dev)
+{
+	struct sw42902 *ts = i2c_get_clientdata(to_i2c_client(dev));
+
+	if (ts->suspended)
+		return 0;
+
+	disable_irq(ts->client->irq);
+	sw42902_release_contacts(ts);
+	sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_STOP);
+	sw42902_power_off(ts);
+
+	return 0;
+}
+
+static int sw42902_resume(struct device *dev)
+{
+	struct sw42902 *ts = i2c_get_clientdata(to_i2c_client(dev));
+	int error;
+
+	if (!ts->suspended)
+		return 0;
+
+	error = sw42902_power_on(ts);
+	if (error)
+		return error;
+
+	ts->suspended = false;
+
+	error = sw42902_start(ts);
+	if (error) {
+		sw42902_power_off(ts);
+		return error;
+	}
+	enable_irq(ts->client->irq);
+
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
+	{ .name = "sw42902" },
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
+MODULE_AUTHOR("Abdur Rofik <rofikcoga@gmail.com>");
+MODULE_DESCRIPTION("Silicon Works SW42902 touchscreen driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5

