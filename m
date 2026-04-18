Received: from sonic314-21.consmr.mail.gq1.yahoo.com (sonic314-21.consmr.mail.gq1.yahoo.com [98.137.69.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3525EF87
	for <linux-input@vger.kernel.org>; Sat, 18 Apr 2026 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776495265; cv=none; b=cK3HbVFmQgikUM6Y0l2v+mLtLOHQpxnFcmgX3hkTyjJacQK1uEu3asQKLxvo9khBlwq3cjINlZaoidU1zU0tOK5c73z/BXTxyiZ+Y7uoPzYb2w9kN8fUKAvlW5w9vTp371MNtE4MDuvAQ6xlSc92FTGQnH9xiyUtAaoHKteexkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776495265; c=relaxed/simple;
	bh=1M/eiT7+1QlD7ugBdkYfyjce9MRZ8mx3m19dzCnrZHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+cXe6RnXUa4y8NC31rbpid2bxrhbYQT77E05ZWLyVFxCJOUg6he6sQU9KK5X9aCvnbu6nUJdYlqCHlzNcbg5NN9uqBIM7/0u7rEwUw0kmslDxsVyoVVeViYWwHZBMnDwzeVlLnxhnnNr0y03lDP4N+idmJ27WCb7GpnbqAFxVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Q8zjzk7j; arc=none smtp.client-ip=98.137.69.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Q8zjzk7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776495264; bh=nUtUJys4O34TwWHPEXfvLYfiRO4mMMlUjpPlWcgxrF8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Q8zjzk7jh3ncCzdUrVmNrVg5w5tvNUzyJSUspZJpGnOZhA3N5TE3v3176q88g7eWerGUN1DbonW60+cskvxPWXy+Gv6M9IX6siaLR7ZkAi6wv4Dzf1BCEEx4UzQ4XaNeoPbW8zitsf+iCLWnYKZvCB3M24i0fKjcPSvQOZKfYJWe6deysngMDy0kLJOPE5/DHN0BtTtfn0DhtEcRkS49tbaiJ8LZW4YKnHXVOl38TRUvdQUEZseeUErJwiwQ+FFFJ6FrWFZKtX3ekJixfqUgTZY5dP8xSlCfwxlORDHt1Wphcra0CZI3YHegonw8ZQmkMF9Zw8OtIbUt9Rxtp6JOMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776495264; bh=o0uKyeqCsPHin+Cbh5X9+jGrkmHH+wf5Fk3415XAXw5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=irqABXo7+UZFCHRLgZmoZTLDWBBTzYIIO09d2MIKrQQjaWCXzlaAyonXGb9pAu0k01NKp34upMSLmV0ElfytCeMs2669nX5jmof6oOThojePMdBDkE98ao3AjEcw31j0v37vbc/VEE2JSq1a+C9C1Qvuq7QobE8c1Nal/fHVU0KzHS6wReVXieXtn4sdQmSm3DvcJqAeuZRvwpeN9eg7S9KJ44oKljO+S4K44EdKX6LE0ZquyWeY1HmE9gWu9gRM/WCngmsVHR4AAYYhqy86kpsy30nLcKk47sz8fKE3/OsflLir2sUa3nxewTvkkyH0bkQCxJ+ZO9gnejmOt9j4GA==
X-YMail-OSG: 7x9okcQVM1k17s3nS3ATrsggxpGBNza_Rl6N0iorZlkKZH3ei4P2Z3tbVInzvsJ
 qXb7DDZCk4uWuur4RQuEsu9JE3bVuRuTghBeTvmpyF1Z0xqc5giCFP_RzpIwokTZTA194_XUJa.e
 zdX8E_llEYl2lHkuLjs5HfgraoPHLdXwYWgnmZ0OMaNbGmic5UlMjAv4WeOjv7RBj5yctLjdwTCU
 H5TICVwTdb9l82TH39gvvvSRzpbttpY98gROONTg2n049P0tVc7L5MsbJGbzQHY09LUOLlC77EY3
 iMN6ofIb3hj7tjKfTJm0C9odk87604uCIsDY1TyynjFe1Vz6Qry8qrqxGJZrnus7JuPq2kyVGymn
 LiR5V031nqiO_pgyuHawSsl5q_SqF5QdZWKszS2q9VVhocfVKK3E3kodR7ADFnKyAgWgDtPh9OW5
 fNpPQJMu5Is7D5Q7UY_ytPTLOoTlOPa.RNgt1bNJR9AV2VCxP7SgPY6MkoSYxqUGH8FsfXseVyAZ
 9vtiYzkuXv8ZkqkHwqlt1GHkXCFP.PUtYhdCPQsS3KZD7SDhXzgBO6ez13sTPtkxoYdBkT0U106Z
 C2kNAX3uetsVezOkjqlHQB4D4HCghd9Gq8._QVHkP4WhJeHzTWqq24lsG5KqlwfiGxzCLtfBvzxN
 .6ehbmXfGDkLXm7DvouQDc9s_.BY3_UQVQ25EuOM_bpseqzmcUap7tAxV.hGNbqhcZhr9jQcZutT
 03VMBYkkudKXUJMBNJ7FR.ur5blbjQCB9R85sB8gyMzq7a.09BeTCWulw.HpKxIQ19lwDCcWsN.c
 tCNNVllhBlJ4ggqU4jL_tJbdHwl5PZGIVQxlm1KhoUwNWdjjRVTD9zcN9s3.Dgnd75hYtOXAEELy
 WfaIlUSeF0zaDbJUdxf9OaEixyfvTJGs2fWXLiix0_gjxOXoOjk45w_YzU.0xS6QGqh0zZusVZ3N
 FElvec3sVJSKI6acmfo4NIXJMdK7H2Z7oLSa2JOHnzZ6i4BBxjdIMObT50rUR7.2F3Db1F2sZFSL
 5jyT_fN.3y_Oz2NiPe2tOGwvff8uFyIkIPtO0PibNyPWLo1uMLZaptVlffJ3Zn37nUDvXIjJ4C6v
 6weNZYvISau1uWGXbVq0kwhHoMP4uZgjpwQLCvlzuTcN39FZ4aDPVuOKVn9mt3WvLMAKc_IBW_fF
 yxv7dUMjYZQulGr3rUw2cSB_EGOIJ9RG8a32i99yw9XOzO8WB1HoDxRGPjhGz.TF5Jm4s6uFOGnk
 7macs02g73pS6f3J2WC3dTp0RfGg5owS6Y8Kci26uG0Cdu2pLNsYs5EsUscUdODkJjKobw9Hm5I4
 5RvZnbGKcIzYTpgJ7aCaeto8Itce8vz79U8jgBQvV7xGv2pIdeo0KD2iLzwHoS2jxoOnFYWsNOu5
 C0wfmWlvDqOHDAPsA3SHf_ZiXkWRMVE1vXESNMIg5LHX1DV.OX_CItlC2_NzcybwmrYY.BKoDFwY
 j1vD48GQIA62ZRHw0xk3BdsV.yHy19gHb7Pf62c.vMI3DyKC8aI9P2qjKS79ZRdx63TFJQ_F5aTe
 pcnll5_Y3_QuENAWN2usgk_wV2GCcdKbSjeaUOoIH4FHPF9omGLJD9atqd9JVpUzF.D78eQsMl2B
 5XnXbM7tbEUQSan3F4c1eeyEzW2AV9fPaU5CMl37FU.LX1m8KddYDlzDW7t0HDD1KJgjsa6QykiU
 Fma1e0j4JIuFc2bJ0m3djqoOasLnshVu2HuY0ufdvhOWQHIOs6psrEFYAkYsMy3DBPupZEZP1k5m
 SGlfR58tYO48BKI0SmU2kd_3v4sUwhQx1_F5Tl9Iz6N2Nnk0HAzhhsdNZ1Db564zHoIgeRuGY5.5
 cUK4Mu1TxmSM4d2eR41oWVUqeqZT2bBAmj52tiKu0u7t.XqtorlauTHhqrRvUR1gSE404T1k_V2w
 1F9VSJdu9OjyCZxMJsGNA.R514kYCtAFLYSDl.T5oR4Djs5thxZqdax44ooBCV23b0zhCY_9w5_U
 BhbMGEjW6D_YsXf1C0q_1nTvfr1qiePCK8JQMDkItJo936GYXgy..vF7fm2kWkRoldB4UHXhdwub
 eRtIwAJWtPZIcUZ0LO9fZjFkfzQPCmZF4UmT_LbmpLRd21LW_ZKIjZKCzUj9OuLAMSodhtZUtp5Z
 qPt.5DLS8LIk0Xo3X32DXS9TTAn3VVEHWN1ObUv.1XZbteqtDst12sBTJMFzvJDAtO8qCYNjq_vS
 VtofLEKD6cMQTtr7dhNPaYDgVCxC2sdmr5xlp_pVBnBUioI90ofihD6duE6RE5wIKV01vxWQ3YJW
 N1NgFxkuO
X-Sonic-MF: <sainiharpreet29@yahoo.com>
X-Sonic-ID: 354f1f99-f4a9-4f3c-b98f-629c0c95f96d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Sat, 18 Apr 2026 06:54:24 +0000
Received: by hermes--production-bf1-697f88457-w2c9n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1e7afc1cf157fe4496c824b71ef29ec9;
          Sat, 18 Apr 2026 06:23:02 +0000 (UTC)
From: Harpreet Saini <sainiharpreet29@yahoo.com>
To: Rob Herring <robh@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v3 2/2] input: misc: Add PixArt PAJ7620 gesture sensor driver
Date: Sat, 18 Apr 2026 02:22:33 -0400
Message-ID: <20260418062241.104697-3-sainiharpreet29@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260418062241.104697-1-sainiharpreet29@yahoo.com>
References: <20260418062241.104697-1-sainiharpreet29@yahoo.com>
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
 drivers/input/misc/paj7620.c | 338 +++++++++++++++++++++++++++++++++++
 3 files changed, 351 insertions(+)
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
index 000000000000..8738c174bcc1
--- /dev/null
+++ b/drivers/input/misc/paj7620.c
@@ -0,0 +1,338 @@
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
+#define PAJ_MAX_GESTURES 9
+
+struct paj7620_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct input_dev *idev;
+	struct regulator_bulk_data supplies[3];
+	u32 keymap[PAJ_MAX_GESTURES];
+};
+
+/*
+ * The following arrays contain undocumented register sequences required to
+ * initialize the sensor's internal DSP and gesture engine.
+ * These were derived from vendor reference code and verified via testing.
+ */
+static const struct reg_sequence init_register[] = {
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
+static const struct reg_sequence init_gesture_array[] = {
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
+static const struct reg_sequence paj7620_suspend_regs[] = {
+	{ PAJ7620_REG_BANK_SEL, 0x00 },
+	{ PAJ7620_REG_SLEEP_BANK0, 0x01 },
+	{ PAJ7620_REG_BANK_SEL, 0x01 },
+	{ PAJ7620_REG_SLEEP_BANK1, 0x01 },
+};
+
+static void paj7620_report_keys(struct paj7620_data *data, int gesture)
+{
+	int i;
+
+	for (i = 0; i < PAJ_MAX_GESTURES; i++) {
+		if (gesture & BIT(i)) {
+			int key = data->keymap[i];
+
+			input_report_key(data->idev, key, 1);
+			input_sync(data->idev);
+			input_report_key(data->idev, key, 0);
+			input_sync(data->idev);
+		}
+	}
+}
+
+static irqreturn_t paj7620_irq_thread(int irq, void *ptr)
+{
+	struct paj7620_data *data = ptr;
+	unsigned int g1, g2;
+	int error;
+
+	/* 2. RUNTIME PM: Force awake to read registers */
+	pm_runtime_get_sync(&data->client->dev);
+
+	regmap_write(data->regmap, PAJ7620_REG_BANK_SEL, 0);
+	error = regmap_read(data->regmap, PAJ7620_REG_GES_RESULT1, &g1);
+	error |= regmap_read(data->regmap, PAJ7620_REG_GES_RESULT2, &g2);
+
+	if (!error && (g1 || g2))
+		paj7620_report_keys(data, (g2 << 8) | g1);
+
+	pm_runtime_mark_last_busy(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+
+	return IRQ_HANDLED;
+}
+
+static int paj7620_init(struct paj7620_data *data)
+{
+	int state = 0, error, i;
+
+	/* 1. Wake-up sequence: Read register 0x00 until it returns 0x20 */
+	for (i = 0; i < 10; i++) {
+		error = regmap_read(data->regmap, 0x00, &state);
+		if (error >= 0 && state == 0x20)
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
+	error = regmap_multi_reg_write(data->regmap, init_register,
+				       ARRAY_SIZE(init_register));
+	if (error < 0) {
+		dev_err(&data->client->dev, "Multi-reg write failed (%d)\n", error);
+		return error;
+	}
+
+	error = regmap_write(data->regmap, PAJ7620_REG_BANK_SEL, 0x00);
+	if (error < 0)
+		return error;
+
+	error = regmap_multi_reg_write(data->regmap, init_gesture_array,
+				       ARRAY_SIZE(init_gesture_array));
+	if (error < 0) {
+		dev_err(&data->client->dev, "Multi-reg write failed (%d)\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int paj7620_input_open(struct input_dev *idev)
+{
+	int error;
+	struct paj7620_data *data = input_get_drvdata(idev);
+
+	error = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
+	if (error)
+		return error;
+
+	error = paj7620_init(data);
+	if (error) {
+		regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+		return error;
+	}
+
+	return 0;
+}
+
+static void paj7620_input_close(struct input_dev *idev)
+{
+	struct paj7620_data *data = input_get_drvdata(idev);
+
+	regmap_multi_reg_write(data->regmap, paj7620_suspend_regs,
+			       ARRAY_SIZE(paj7620_suspend_regs));
+
+	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+}
+
+static int paj7620_runtime_suspend(struct device *dev)
+{
+	int error;
+	struct paj7620_data *data = dev_get_drvdata(dev);
+
+	error = regmap_write(data->regmap, PAJ7620_REG_BANK_SEL, 0x01);
+	if (error)
+		return error;
+
+	error = regmap_write(data->regmap, PAJ7620_REG_AUTO_STANDBY, 0x30);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static int paj7620_runtime_resume(struct device *dev)
+{
+	int error;
+	struct paj7620_data *data = dev_get_drvdata(dev);
+
+	error = regmap_write(data->regmap, PAJ7620_REG_BANK_SEL, 0x01);
+	if (error)
+		return error;
+
+	error = regmap_write(data->regmap, PAJ7620_REG_AUTO_STANDBY, 0x00);
+	if (error)
+		return error;
+
+	error = regmap_write(data->regmap, PAJ7620_REG_BANK_SEL, 0x00);
+	if (error)
+		return error;
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
+static void paj7620_disable_pm(void *dev)
+{
+	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+}
+
+static int paj7620_probe(struct i2c_client *client)
+{
+	struct paj7620_data *data;
+	int error, i;
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
+	error = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->supplies), data->supplies);
+	if (error)
+		return dev_err_probe(&client->dev, error, "Failed to get regulators\n");
+
+	error = device_property_read_u32_array(&client->dev, "linux,keycodes",
+					       data->keymap, ARRAY_SIZE(data->keymap));
+
+	if (error) {
+		data->keymap[0] = KEY_UP;
+		data->keymap[1] = KEY_DOWN;
+		data->keymap[2] = KEY_LEFT;
+		data->keymap[3] = KEY_RIGHT;
+		data->keymap[4] = KEY_ENTER;
+		data->keymap[5] = KEY_BACK;
+		data->keymap[6] = KEY_NEXT;
+		data->keymap[7] = KEY_PREVIOUS;
+		data->keymap[8] = KEY_MENU;
+	}
+
+	data->regmap = devm_regmap_init_i2c(client, &paj7620_reg_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	data->idev = devm_input_allocate_device(&client->dev);
+	if (!data->idev)
+		return -ENOMEM;
+
+	data->idev->name = "PAJ7620 Gesture Sensor";
+	data->idev->id.bustype = BUS_I2C;
+	data->idev->open = paj7620_input_open;
+	data->idev->close = paj7620_input_close;
+	data->idev->keycode = data->keymap;
+	data->idev->keycodemax = ARRAY_SIZE(data->keymap);
+	data->idev->keycodesize = sizeof(u32);
+
+	for (i = 0; i < ARRAY_SIZE(data->keymap); i++)
+		input_set_capability(data->idev, EV_KEY, data->keymap[i]);
+
+	input_set_drvdata(data->idev, data);
+
+	error = input_register_device(data->idev);
+	if (error)
+		return error;
+
+	pm_runtime_set_active(&client->dev);
+	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev, 2000);
+	pm_runtime_use_autosuspend(&client->dev);
+
+	error = devm_add_action_or_reset(&client->dev, paj7620_disable_pm, &client->dev);
+	if (error)
+		return error;
+
+	return devm_request_threaded_irq(&client->dev, client->irq,
+									 NULL, paj7620_irq_thread,
+									 IRQF_ONESHOT, "paj7620",
+									 data);
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
+};
+module_i2c_driver(paj7620_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Harpreet Saini");
+MODULE_DESCRIPTION("PAJ7620 Gesture Input Driver");
-- 
2.43.0

