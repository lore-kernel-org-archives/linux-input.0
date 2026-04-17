Received: from sonic308-8.consmr.mail.gq1.yahoo.com (sonic308-8.consmr.mail.gq1.yahoo.com [98.137.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ACF26B2CE
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776404806; cv=none; b=jUPNAric7qYueUUDef7cNFopCtB7eP2PJ6OwZZL+NWvwrI4ezGpk+qRAtgosbYuQSIgldDyklE5KfHFzVfqvXiEnf9MYykx+Ej1LGjHZ0P9w2hZC1dcPAmjw93TSF6MfYpBWqi4y0NwV5IEMv/3YIjAVulyTBwuQ7H0Z4qx07EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776404806; c=relaxed/simple;
	bh=k2frjHOxLYnqUc+JwEo9/mX2lBoayK0/kTT+3HzJMyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ewu03rNF/KZgG+OGARzdG/Q/TxcbnRZK6N6MkEtPyz0QropnABnwhNHoL/+kqFWnsbcpL5Lr3kItaPJKZ34ywizejeR2/awmEGI/SBLptjaJ/gWeFVg0kq6aoSDDAwW7PmdZ+T5gdp1MWig4j+fM9h3y+v3v5jMLbf0SAHNEH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tjNkmcve; arc=none smtp.client-ip=98.137.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tjNkmcve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776404798; bh=wExSW9EgWKsvnWWgtDmagUrH5VnNEv3N8LLMKs0+BqI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tjNkmcvegxeBS2E1P8H0iS0iCzIbaxPCpjXsmZtT04DwZJO33BNe9sfGsBbkU2cQIUxaxajvefYZoaT3TPNiHFRHjwsVYB9TcU4yar7Iy+7PG9sfMEXd36IUoCZ2AEPJAVgPa33rRlSzZUwHlNcy2Z5uAUILVJVN7TRDoAUrkdBMQXcI3Xxv4TyluaTrfGxglS3YtNZbPOWcW0inD3WrbmWYyhj2Ygc3b6t1r4iukMqiEOduu7qiePekHi3K5L80sT74IEe8tT8ZNUP8y29VDcp8sa/4dzFZERPB25VWsaynhxj+5zIcoTREj+S389h5cVgEMkaouasyOxXsoHollg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776404798; bh=R8hiBIILVuk3J6kY9bO3cO8BTgyAsLtJqfs6KbUIzHt=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qpxcp6AaTbpbsGmtyNxljEF9ffohuI2egrk3ZlQMkh1T6+YZfce7Is+zJEyU8QQxTwKjVgj9taHe/pH0pIdlYqx65jihzymTqx2vQ7x/4O9GPN71zXUIVrmo7RtlL8HrRpMLXZi8XQhsVxcqfMsxe4sL9a3/YKPq9ve8QLisWR+AHAfp/VS7L3vcMnTMF64PpLYdYA5npiqxaiAsgFHFRo+K3F1GrcmK+9mWPLPSYmIdVwetFiFb0RX4sv2vajdVIulhQn3Ue/RYtqReHrBMODROBx8tSZDSDqj1RLVcDIzbTBEWjTfTwcHNks80wTAkSin82cCzAB9597GzI3XWDg==
X-YMail-OSG: KAAe8X0VM1mE0NXQCvlHQYXo.HLwl9H_oeyOuyfPGW1nO6whKLFIjcdZPulB686
 VZLPRT0vWsMorhtfUt5AKrh4XZQsmddHfFkJrltnb0ng2WvBSFc3DfwmNU7qK7U581EGjLDKqLC1
 Wip8Zx5pQHUxP4WTPCRzc6qNp3i2gL8WPIlIHvr1Tic0Fi7KX37q1co6z7pHZ2LJEKhKSQpF6PfF
 7TQYOWyl0wDv9hEalJRJuNLjCaK8F8KsFMKDtymLbgaNhauKC_YXGlQLDcBw975.TCykrGzxVbXw
 a_GFonhFDVr.gpO.usTQh67YWpjMQnX4unwLfFG0yoH7CUBHgkjt7pbnB5JOfYV5w1LuQWmDPMAL
 oySr3TPPjPjn.gKRqoQmDCR6Ph0Q0kKI7j.dkb9NP1HsNn2XXYnQD7wFXHoukeMkLsHSsxl8EDeJ
 yCuHB5__79BrWbe9DsxdCnIeSjxzdP52DaXuviBQBz_AigN2yucoHvUm_yUWNY.PhifxppRr3m8H
 t_droHn4I5td9eYJEL3lA5JOQHh7XMrZ0Ds9b2RQuB2WGH.gaUX16OH3r50tn6kSd3sHXDMnddwy
 A4aOxVNdvImP4zTAe2NqZ7YCwIXosd99Nsn74iextImttJ8bAIAl.Zrq_wKXfVt6YaN9JF6oDAih
 ZGa.6kAEPY.9GP5nn9wsgRlPzCMNb17aNWTLQST3L._V_FtPEgulCQkYkpEy9LfndYxM8c25e0w3
 W5SE6AX8jcoQH5io_kHeECdA24gs90Q0yAdSsFB4x84vTFwqAbdN4KlYxQLGfHxXgCKYoObdCDwj
 71eRXG6uESvnew6bVeIE38eA1qYydq0Q0MrYnsuJUZ_rRp2hj8vLmdwjY_OEwVI5yeLGyvBKl5h0
 NeI_rKou8RKVRoKAnOrWfIlO9X0PIsWAUJzx4gxhNOXRIhfJXZmpPBLlhxCb8VgiNlf5Iv3pXym2
 CmdfHqEFDuDtCpawlMEf7jNQBocFsuhpftufnBzRQZ7tQpBPr5tPV2B3ghdz.NLZ7Ndbfk1uYfdC
 btgj.xxpdUepng0xChob0WTkA2MSutd71paMXMQBOk3_.FnQPI3nuJ13RDiRu7n2aPOw4TRokq6L
 CEhxc4.ItYZ7lpo3vouF1bXQSYhYP9LTqBbKQNzedoChqTZcXagdfBr4YpXVJk_QcXqPfW.les.v
 irgeeSPRVkZ89j_gRrRHcGZF5rRoxNTOmEPdzLZxPPULJy7ML__Rdb5bi1JFCWiVrIlySH241PFd
 iJm7k5whYW43qlFcLjASndEwqrMwgw0mZEHLsb96tn3b34hKX3wwqx0w1HQSKaVLBa.NEY67GBmV
 P8OlGArG6WWdFA.Lqkod1B0GjfMTSr_KAEKOkWkwGDNf6mLmLvjyKcbVI5dZ.VRH3wVkK6ugOJaM
 UbLb6USz4kSXM9L_..gj5Bk6HEmeTbq4KIRmpBE0q8Y7nsWGNdDcNnN79KIA_5VzF6ep4ngJtnYS
 Uq50ZKN3HXuRZ1FixhTPYS_ZWmBlwIXRwS4x3ez2eD8I0k1cZnyCrUXSlkIDCxhB0WlUdEb2qFQ4
 RUaBEzHHD09YLxc_NrlcUw.2TFoDvJf59xxbELGjTfVTampEELQVJRvRzvqZPnbGbfA5we7x7bp0
 EUoXd5V0jHq0BfLqgzE7bvePZne0PUhnyliUtseTrqsSi7eRjhapz5TlUtOW3kwcpyIkKtQy92ys
 OqXAfYwG8vd7cFDhAy0bgMPvzJr1FZUOBksrSErBJET1XhzGy5t10YRO1EA2rCKxDlnv.lYUe4Hh
 3SMuAFoPec3JnO1FSATjrYJp1u8tJEcFM5MR5ojzdFd7POsyrFpyMPXaomqlDBj2n1HaE6GeqQZs
 PbOpmbgfcajc1cS16oC3OPZOOcxfEaxiFGCt9TY7bgEUNYva4bi4k_9DsgstOMtoBmWZ6ZB378ch
 u22Fka4FExzdUtosUDU8vDuEixGtMx0956v.9X_fv_oihbzW6DO4DVqa23aXJXZDq1e.I_.HnvLS
 LFLB4HyxWIGBlg8wUH8t.YVHj6qVX72M3qxF4KePNhpa5nYViaO1T5G6vtd6LkG0sXTqxyH8KQ0_
 QAC0eVUwMDr2lO1riexvw26o_u2i7O7_TzPAt.ctOqHyH5LxSinUU3pxwzUpoxylhWeDjWmL32Uq
 CDUoS9ljU3ixuuUKCjd6.HV_6qoSTWlIs8LXiuC3UKH7Hfb9SBTGRw3AsqEbKhYpF5.ilDCbsSbu
 C5eklx3n2mdGJvwMAqqPx9rd_d3.CTWZtwYTdIXPYT9054W76OJnSESGyGVsPPEUqijUeFz2fM5t
 zsbxXqJY-
X-Sonic-MF: <sainiharpreet29@yahoo.com>
X-Sonic-ID: 352db566-56dd-4450-a521-8e62e487c8a2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Fri, 17 Apr 2026 05:46:38 +0000
Received: by hermes--production-bf1-697f88457-t7j8c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3c2bb0bd53f21136eb796b7edd82f0f5;
          Fri, 17 Apr 2026 05:25:56 +0000 (UTC)
From: Harpreet Saini <sainiharpreet29@yahoo.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <david@lechnology.com>,
	Harpreet Saini <sainiharpreet29@yahoo.com>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] input: misc: Add PixArt PAJ7620 gesture sensor driver
Date: Fri, 17 Apr 2026 01:25:27 -0400
Message-ID: <20260417052527.62535-3-sainiharpreet29@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417052527.62535-1-sainiharpreet29@yahoo.com>
References: <20260417052527.62535-1-sainiharpreet29@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver adds support for the PixArt PAJ7620 gesture sensor.
It implements hand gesture recognition (up, down, left, right,
etc.) and reports them as standard input key events. The driver
includes power management support via Runtime PM.

Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>
---
 drivers/input/misc/Kconfig   |  12 ++
 drivers/input/misc/Makefile  |   1 +
 drivers/input/misc/paj7620.c | 350 +++++++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/input/misc/paj7620.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 94a753fcb64f..de4206c297f2 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -453,6 +453,18 @@ config INPUT_KXTJ9
 	  To compile this driver as a module, choose M here: the module will
 	  be called kxtj9.
 
+config INPUT_PAJ7620
+	tristate "PixArt PAJ7620 Gesture Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here if you want to support the PixArt PAJ7620 gesture
+	  sensor. This sensor supports 9 hand gestures and communicates
+	  over the I2C bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called paj7620.
+
 config INPUT_POWERMATE
 	tristate "Griffin PowerMate and Contour Jog support"
 	depends on USB_ARCH_HAS_HCD
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 415fc4e2918b..dec8b8d0cdf4 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_INPUT_PF1550_ONKEY)	+= pf1550-onkey.o
 obj-$(CONFIG_INPUT_PM8941_PWRKEY)	+= pm8941-pwrkey.o
 obj-$(CONFIG_INPUT_PM8XXX_VIBRATOR)	+= pm8xxx-vibrator.o
 obj-$(CONFIG_INPUT_PMIC8XXX_PWRKEY)	+= pmic8xxx-pwrkey.o
+obj-$(CONFIG_INPUT_PAJ7620) 		+= paj7620.o
 obj-$(CONFIG_INPUT_POWERMATE)		+= powermate.o
 obj-$(CONFIG_INPUT_PWM_BEEPER)		+= pwm-beeper.o
 obj-$(CONFIG_INPUT_PWM_VIBRA)		+= pwm-vibra.o
diff --git a/drivers/input/misc/paj7620.c b/drivers/input/misc/paj7620.c
new file mode 100644
index 000000000000..632a77ce4085
--- /dev/null
+++ b/drivers/input/misc/paj7620.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PixArt PAJ7620 Gesture Sensor - Input driver
+ *
+ * Copyright (C) 2026 Harpreet Saini <sainiharpreet29@yahoo.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+/* Registers */
+#define PAJ7620_REG_BANK_SEL        0xEF
+#define PAJ7620_REG_GES_RESULT1     0x43
+#define PAJ7620_REG_GES_RESULT2     0x44
+#define PAJ7620_REG_SLEEP_BANK0     0x65
+#define PAJ7620_REG_SLEEP_BANK1     0x05
+#define PAJ7620_REG_AUTO_STANDBY    0x073
+
+/* Gesture bits */
+#define PAJ_UP           BIT(0)
+#define PAJ_DOWN         BIT(1)
+#define PAJ_LEFT         BIT(2)
+#define PAJ_RIGHT        BIT(3)
+#define PAJ_FORWARD      BIT(4)
+#define PAJ_BACKWARD     BIT(5)
+#define PAJ_CLOCKWISE    BIT(6)
+#define PAJ_ANTICLOCK    BIT(7)
+#define PAJ_WAVE         BIT(8)
+
+struct paj7620_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct input_dev *idev;
+	struct regulator_bulk_data supplies[3];
+};
+
+/*
+ * The following arrays contain undocumented register sequences required to
+ * initialize the sensor's internal DSP and gesture engine.
+ * These were derived from vendor reference code and verified via testing.
+ */
+static const struct reg_sequence Init_Register[] = {
+	{ 0xEF, 0x00 }, { 0x37, 0x07 }, { 0x38, 0x17 }, { 0x39, 0x06 },
+	{ 0x41, 0x00 }, { 0x42, 0x00 }, { 0x46, 0x2D }, { 0x47, 0x0F },
+	{ 0x48, 0x3C }, { 0x49, 0x00 }, { 0x4A, 0x1E }, { 0x4C, 0x20 },
+	{ 0x51, 0x10 }, { 0x5E, 0x10 }, { 0x60, 0x27 }, { 0x80, 0x42 },
+	{ 0x81, 0x44 }, { 0x82, 0x04 }, { 0x8B, 0x01 }, { 0x90, 0x06 },
+	{ 0x95, 0x0A }, { 0x96, 0x0C }, { 0x97, 0x05 }, { 0x9A, 0x14 },
+	{ 0x9C, 0x3F }, { 0xA5, 0x19 }, { 0xCC, 0x19 }, { 0xCD, 0x0B },
+	{ 0xCE, 0x13 }, { 0xCF, 0x64 }, { 0xD0, 0x21 }, { 0xEF, 0x01 },
+	{ 0x02, 0x0F }, { 0x03, 0x10 }, { 0x04, 0x02 }, { 0x25, 0x01 },
+	{ 0x27, 0x39 }, { 0x28, 0x7F }, { 0x29, 0x08 }, { 0x3E, 0xFF },
+	{ 0x5E, 0x3D }, { 0x65, 0x96 }, { 0x67, 0x97 }, { 0x69, 0xCD },
+	{ 0x6A, 0x01 }, { 0x6D, 0x2C }, { 0x6E, 0x01 }, { 0x72, 0x01 },
+	{ 0x73, 0x35 }, { 0x74, 0x00 }, { 0x77, 0x01 },
+};
+
+/*
+ * Specific configuration overrides required to enable the internal
+ * 8-gesture state machine.
+ */
+static const struct reg_sequence Init_Gesture_Array[] = {
+	{ 0xEF, 0x00 }, { 0x41, 0x00 }, { 0x42, 0x00 }, { 0xEF, 0x00 },
+	{ 0x48, 0x3C }, { 0x49, 0x00 }, { 0x51, 0x10 }, { 0x83, 0x20 },
+	{ 0x9F, 0xF9 }, { 0xEF, 0x01 }, { 0x01, 0x1E }, { 0x02, 0x0F },
+	{ 0x03, 0x10 }, { 0x04, 0x02 }, { 0x41, 0x40 }, { 0x43, 0x30 },
+	{ 0x65, 0x96 }, { 0x66, 0x00 }, { 0x67, 0x97 }, { 0x68, 0x01 },
+	{ 0x69, 0xCD }, { 0x6A, 0x01 }, { 0x6B, 0xB0 }, { 0x6C, 0x04 },
+	{ 0x6D, 0x2C }, { 0x6E, 0x01 }, { 0x74, 0x00 }, { 0xEF, 0x00 },
+	{ 0x41, 0xFF }, { 0x42, 0x01 },
+};
+
+static void paj7620_report_keys(struct input_dev *idev, int gesture)
+{
+	static const struct { int bit; int key; } map[] = {
+		{ PAJ_UP,        KEY_UP },
+		{ PAJ_DOWN,      KEY_DOWN },
+		{ PAJ_LEFT,      KEY_LEFT },
+		{ PAJ_RIGHT,     KEY_RIGHT },
+		{ PAJ_FORWARD,   KEY_ENTER },
+		{ PAJ_BACKWARD,  KEY_BACK },
+		{ PAJ_CLOCKWISE, KEY_NEXT },
+		{ PAJ_ANTICLOCK, KEY_PREVIOUS },
+		{ PAJ_WAVE,      KEY_MENU },
+	};
+	// gesture mode does not support key hold, so pulse event
+	for (int i = 0; i < ARRAY_SIZE(map); i++) {
+		if (gesture & map[i].bit) {
+			input_report_key(idev, map[i].key, 1);
+			input_sync(idev);
+			input_report_key(idev, map[i].key, 0);
+			input_sync(idev);
+		}
+	}
+}
+
+static irqreturn_t paj7620_irq_thread(int irq, void *ptr)
+{
+	struct paj7620_data *data = ptr;
+	unsigned int g1, g2;
+	int ret;
+
+	/* 2. RUNTIME PM: Force awake to read registers */
+	pm_runtime_get_sync(&data->client->dev);
+
+	regmap_write(data->regmap, PAJ7620_REG_BANK_SEL, 0);
+	ret = regmap_read(data->regmap, PAJ7620_REG_GES_RESULT1, &g1);
+	ret |= regmap_read(data->regmap, PAJ7620_REG_GES_RESULT2, &g2);
+
+	if (!ret && (g1 || g2))
+		paj7620_report_keys(data->idev, (g2 << 8) | g1);
+
+	pm_runtime_mark_last_busy(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+
+	return IRQ_HANDLED;
+}
+
+static int paj7620_init(struct paj7620_data *data)
+{
+	int state = 0, ret, i;
+
+	/* 1. Wake-up sequence: Read register 0x00 until it returns 0x20 */
+	for (i = 0; i < 10; i++) {
+		ret = regmap_read(data->regmap, 0x00, &state);
+		if (ret >= 0 && state == 0x20)
+			break;
+		usleep_range(1000, 2000);
+	}
+
+	if (state != 0x20) {
+		dev_err(&data->client->dev, "Sensor wake-up failed (0x%02x)\n", state);
+		return -ENODEV;
+	}
+
+	/* 2. Blast full register array into PAJ7620 instantly */
+	ret = regmap_multi_reg_write(data->regmap, Init_Register,
+				     ARRAY_SIZE(Init_Register));
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Multi-reg write failed (%d)\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(data->regmap, PAJ7620_REG_BANK_SEL, 0x00);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_multi_reg_write(data->regmap, Init_Gesture_Array,
+				     ARRAY_SIZE(Init_Gesture_Array));
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Multi-reg write failed (%d)\n", ret);
+		return ret;
+	}
+
+	dev_info(&data->client->dev, "Gesture Sensor Registers Initialized\n");
+	return 0;
+}
+
+static int paj7620_power_down(struct paj7620_data *data)
+{
+	int ret;
+	/* Deep sleep sequence */
+	ret = regmap_write(data->regmap, PAJ7620_REG_BANK_SEL, 0x00);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, PAJ7620_REG_SLEEP_BANK0, 0x01);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, PAJ7620_REG_BANK_SEL, 0x01);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, PAJ7620_REG_SLEEP_BANK1, 0x01);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int paj7620_runtime_suspend(struct device *dev)
+{
+	int ret;
+	struct paj7620_data *data = dev_get_drvdata(dev);
+
+	ret = regmap_write(data->regmap, PAJ7620_REG_BANK_SEL, 0x01);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, PAJ7620_REG_AUTO_STANDBY, 0x30);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int paj7620_runtime_resume(struct device *dev)
+{
+	int ret;
+	struct paj7620_data *data = dev_get_drvdata(dev);
+
+	ret = regmap_write(data->regmap, PAJ7620_REG_BANK_SEL, 0x01);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, PAJ7620_REG_AUTO_STANDBY, 0x00);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, PAJ7620_REG_BANK_SEL, 0x00);
+	if (ret)
+		return ret;
+
+	usleep_range(1000, 2000);	// Stabilization delay (1ms minimum)
+	return 0;
+}
+
+static const struct dev_pm_ops paj7620_pm_ops = {
+	SET_RUNTIME_PM_OPS(paj7620_runtime_suspend, paj7620_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+};
+
+static const struct regmap_config paj7620_reg_config = {
+	.reg_bits = 8, .val_bits = 8, .max_register = 0xEF,
+};
+
+static int paj7620_probe(struct i2c_client *client)
+{
+	struct paj7620_data *data;
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	i2c_set_clientdata(client, data);
+
+	data->supplies[0].supply = "vdd";
+	data->supplies[1].supply = "vbus";
+	data->supplies[2].supply = "vled";
+
+	ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->supplies), data->supplies);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to get regulators\n");
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
+	if (ret)
+		return ret;
+
+	data->regmap = devm_regmap_init_i2c(client, &paj7620_reg_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	ret = paj7620_init(data);
+	if (ret)
+		goto err_reg;
+
+	data->idev = devm_input_allocate_device(&client->dev);
+	if (!data->idev) {
+		ret = -ENOMEM; goto err_reg;
+	}
+
+	data->idev->name = "PAJ7620 Gesture Sensor";
+	data->idev->id.bustype = BUS_I2C;
+
+	input_set_capability(data->idev, EV_KEY, KEY_UP);
+	input_set_capability(data->idev, EV_KEY, KEY_DOWN);
+	input_set_capability(data->idev, EV_KEY, KEY_LEFT);
+	input_set_capability(data->idev, EV_KEY, KEY_RIGHT);
+	input_set_capability(data->idev, EV_KEY, KEY_ENTER);
+	input_set_capability(data->idev, EV_KEY, KEY_BACK);
+	input_set_capability(data->idev, EV_KEY, KEY_NEXT);
+	input_set_capability(data->idev, EV_KEY, KEY_PREVIOUS);
+	input_set_capability(data->idev, EV_KEY, KEY_MENU);
+
+	ret = input_register_device(data->idev);
+	if (ret)
+		goto err_reg;
+
+	pm_runtime_set_active(&client->dev);
+	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev, 2000);
+	pm_runtime_use_autosuspend(&client->dev);
+
+	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					paj7620_irq_thread, IRQF_ONESHOT,
+					"paj7620", data);
+	if (ret)
+		goto err_reg;
+
+	dev_info(&client->dev, "Gesture Sensor Initialized\n");
+	return 0;
+
+err_reg:
+	dev_err_probe(&client->dev, ret, "%s: failed with error %d\n", __func__, ret);
+	if (pm_runtime_enabled(&client->dev)) {
+		pm_runtime_disable(&client->dev);
+		pm_runtime_dont_use_autosuspend(&client->dev);
+	}
+	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+	return ret;
+}
+
+static void paj7620_remove(struct i2c_client *client)
+{
+	int ret;
+	struct paj7620_data *data = i2c_get_clientdata(client);
+
+	pm_runtime_get_sync(&client->dev);
+	pm_runtime_disable(&client->dev);
+	pm_runtime_dont_use_autosuspend(&client->dev);
+	pm_runtime_put_noidle(&client->dev);
+
+	ret = paj7620_power_down(data);
+	if (ret)
+		dev_err(&data->client->dev, "Sensor power down failed\n");
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+	if (ret)
+		dev_err(&data->client->dev, "Sensor regulator disable failed\n");
+}
+
+static const struct of_device_id paj7620_of_match[] = {
+	{ .compatible = "pixart,paj7620" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, paj7620_of_match);
+
+static struct i2c_driver paj7620_driver = {
+	.driver = {
+		.name = "paj7620",
+		.of_match_table = paj7620_of_match,
+		.pm = &paj7620_pm_ops,
+	},
+	.probe = paj7620_probe,
+	.remove = paj7620_remove,
+};
+module_i2c_driver(paj7620_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Harpreet Saini");
+MODULE_DESCRIPTION("PAJ7620 Gesture Input Driver");
-- 
2.43.0

