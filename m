Received: from sonic315-8.consmr.mail.gq1.yahoo.com (sonic315-8.consmr.mail.gq1.yahoo.com [98.137.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669EE2236E3
	for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776744950; cv=none; b=FLJLbJ6NH3ivwQuErShV3DYqSUE3m+4XRD8k0OQ0PSMMDpXPtgn3WePHVhLW+UbJmV+RSe7OYqC1MUFAbp0P46Tvju5olU9BEBWs+oBIibHmwxmJd7Xmsw+opBRPzLPYQQRUEUkHZj5V4tW8lU8zxi5h0+TnV5sWJUqCIixgu7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776744950; c=relaxed/simple;
	bh=1M/eiT7+1QlD7ugBdkYfyjce9MRZ8mx3m19dzCnrZHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUKcx0wAE9BK3s91qDMv8Z74RDEwjplr48bsn3O5on6gPmMQ+c4j17maJhlZp1RXHIAjL5idIQ/NwthZGOwlCJ89ad1fZ6NjfXHu5ZcOYOQEsL7tAgdkY9Pizp9FgZRyLSZ9uaRie/ca8zTmkpA5dNli0jwU2uYORFPUdkxn1cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=d67WfN7I; arc=none smtp.client-ip=98.137.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="d67WfN7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776744941; bh=nUtUJys4O34TwWHPEXfvLYfiRO4mMMlUjpPlWcgxrF8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=d67WfN7IKdpp3lZhNrS4S9YZRpnjBAGmC01+SrufbtrGI5JY/PfRzxVRal4tq9RJ0lr4ZhbYrgl03SAe7CaV+s1HDnp13Mzx3eJ+OOSDCoJ2bNfQZVZYRGA4lMZXrjSULYtVqpC0BvV5NdrzE6UTVm7xlyaAcTwNmjrY6/6DLORpDV+VE1xvjEwLAqnvXTomZdNTMdqrBVN/NIrvscu37I6HhfRDWHa1c4qtb2riTEU9DwWSM8xYwU+Q3vjC11QRWO4SIw1okm0LwVD7xfzaqkQ8XJ4D0XHyYaQ1qi5/M9+d3HT143NvlbibPvKRvR8n7Yyosr7UV07F18oYXAh5xQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776744941; bh=l4WCgL5HO56c2HuCiytX8NxhTZLWIObKB3H8916X+8s=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BTeuSs5eIccB023HgLV4it/kwdIdS7ij0IsXrdHT6LyAvvSVpPIaiG1HX9FHkR38g8Y5SzirzcTtRIUE6aqMzij7/Ye8Djv3eb3+0uM5k3ASlOsxv5iunaG/LAcmNd22cFyIQbwJUr7ctUiPDkRexbZRYPc4zSZzc74j9awQ917m+O1jdnSHmjxiLOFMX3htqoQJbxy8jhpmf2D1V3J+/X63L2AScrq18fWQZbpiNFncehLrdC1E2LcqF9nbNMSzAFwXej3wDiF72ho4/QbYpemsp3Ku8nqihvws0cCmfVrlu5MUFwHj/0AdKjh4o9yjR7XhxRCssgEsxgWyWViY/Q==
X-YMail-OSG: dlbc9AYVM1lDQ3_swv9_UElqEJvOvj6phpzKqTB6c_41e0KtdxanCHlLJtELIqq
 SEVS_Yc9PsuEny2jXR.9mIlZmW2QMItFSsvsa_GCDl6MEynP6LctGEVer3E0bYh2rO8Do7J6Pb9Q
 1MBnwKqqv1LXjvhN29U9P_vMGdczhdXA.nEXZBmvHWXzkjOOWLAFYWLo7R48KqEfk.HL2y9eBK12
 jNaebUftxNqNBHXB91KF_DKCaoO817z2Ng.QrDk3wuycPxbgb9WL_y8YhlGvD5lBbpfBbic7C9Z1
 n6DuVk3lXT0wj0fkmE6gfNBqZ8b0BaGAtb5QChKECNI0VYvphJREemwKWSJ175lQysNgoiV1H82u
 OYs.2LTwKT7lCkAYbIkAuq6HMtZvf8XSjxk9U8Hm26Zbp48oBUIhj3WKDWLFCATyywMJs5OgKeoL
 ilkF7rGGOBl_h_Laf6WUvHeASkfghA5oAfWm7ylSBag9hS4WQZ0JBwIEtr5z7T_S99OFdYpjRqgC
 E5w_kBSutEFpC4emesQopwgmPfIOmAKbSlKIKGHLEmt76z48HMvKU3gZGnTWCsNqjURVkwUKhHr7
 IjsmfO3qOphKS_cbpjtv4BdYmYvxMk2T3A2Y7oSarPhiO80ZotBraEuDiJ7l7vE7xaLkULRs8noz
 3ZYcRz4i9.2dF7PWga7eayIMZYqiwcW2I6ftlYd9_zgfHfv93gCsNzgZ7LY1rF6gLsuYH9Hh3wQ9
 TcChF7SgFgeKsWC4m8QnBEaJdbku3zlidOrTkoOny0S2yWqL9NkFtqj5WbGkqlVCQIji5NWqlyDN
 ePA_3xtaQHuqGTDPv8o6HpEfG3WkcS85HkwY1jugyOj2AymquC7ipYd1bsnaWuf4jypz5J.X3sgd
 ZtEFOd44PGUkHksmq4ArczRvZd._Exv60exNNGxB5P68_0jkrhHHIQupLvUOTqHKdgv9pzOjxONN
 jZVPwgsSmrkddlqBfWCpAkZrs5LQOM9D8Yh1aZxvI0LcKwHAiroK3dIRy2AQRz14.C4GxlROMkth
 hBOAxvTMVFa64nffxXAzeDGywACHvuzt8PQl_9m0bjzEafDDafUCtrd8rZzQrYgWXGskyjJkxBf8
 1wuM5F2IJUYiitU0cBkWmX5k0KTw7gcpgbPLHv.QdtcK_kKvmltcySI1wFWpZU5HI6eqAu5F2Wy7
 xMClOxrHKRPlO10jl44isuwakyio0MHCCyLjLdf4w_XF4f81WRU1pU2sNGNCu.eGRMKVSnqlUdPI
 N5AIk8UDHeN.SSOPK8ZPb6wxCa.Ybgkz4izwcNk4WNUVP_lXuRtmLYjy0qgnpb.3GbUnBg1B5f8L
 oZicncQh57xnuj_3DOf0LqiwA5rDHs7iZFXAJo60rW.c1lQqBU8fVSd1uNAXhRDVHwcTQBMIBXtR
 Mf03ZxfRTPedrEQMl53MhV7wBCMe7hh8unYrJ2xkC5957OOwjDxkfGtYfgvh0n0dY9ip9DkETPf8
 W5Dn6UmTgSPGkFs4wbCNZoPC_hfVZyXM3V0nmCR1.nPrjyjSi0Gjrv1zJME7YLGbSLDHhvc8d6ei
 OFBmf9IEuakEdjYEVZdDh4Ey6wKXguqT19vYCJGXjXu1Jcd63Ws4ejou9suwHSGsN_hKK5kIqukz
 NsaKR4XkEREDYigndow2OjXAP17qXHqiiqm77YgLWdd7wwn1Kr3JuXV45yECtBSOiol78U7PEfiS
 fvXwQiIhgIcqrjZ8QnQEVHzki6rsxER0GoHu7iZVRAZeAq0WjaZLRVNghoRa.WjtF0MMC50jnRp5
 EyYRf9Kw_CjAaoH9LRkqQjxUSI0PicraQrCrPWQxBwAl12wjeFRV8EkzrT4PANzMFvieQfr_si5T
 oZgU6VCqhqBO8JlPDRa_Yzo5BuWS6zctprr2Ee4BN9_lyF0mIUnFhzSXXwrQWTg2R4fCARNwBprF
 Z6cVlNTz13fcP.BXHozSdyaoIzqMSBnoudr49PCUSnaN28.nCCtMlNA6TQlfWCjubuYnJX8iWkhB
 nHo0oFCwDI0CwpeUQHOjr2G1n5Bx7rHGwfVNultBgwqlLLQ93FJb22cBEh1pokqhp5nm3NxhXirI
 f3lGonQOw8M.SkxxkZoMHmTiD6KDUwxKwmm5v5bruCBW0svON3rITEKg227.KPrhfLSppLfxvUAq
 yrg82LMwGZDF9owkEM5RUqS0J4YBzbem9tVfWstOOUMeqHGW6L1FTuboKuSbebuz742wivjM9VFE
 jTTMLv2TVzr3pApiT04dyVUox_i5bfT.9O8UtwseMO_t69v1g6vq80kJ.mlB5dCbE4WBiwzqrBd7
 1de1uMDNLe30-
X-Sonic-MF: <sainiharpreet29@yahoo.com>
X-Sonic-ID: 1d5c0ab7-89de-4c4c-8afc-40191db8bf2b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Tue, 21 Apr 2026 04:15:41 +0000
Received: by hermes--production-bf1-697f88457-thlw6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c07a4f27f7f326745dd3a3aad1055617;
          Tue, 21 Apr 2026 04:15:38 +0000 (UTC)
From: Harpreet Saini <sainiharpreet29@yahoo.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski@linaro.org
Cc: Lee Jones <lee@kernel.org>,
	Job Sava <jsava@criticallink.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Samuel Kayode <samkay014@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 2/2] input: misc: Add PixArt PAJ7620 gesture sensor driver
Date: Tue, 21 Apr 2026 00:12:40 -0400
Message-ID: <20260421041505.4548-3-sainiharpreet29@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421041505.4548-1-sainiharpreet29@yahoo.com>
References: <20260421041505.4548-1-sainiharpreet29@yahoo.com>
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

