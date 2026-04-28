Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB13AF642
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376608; cv=none; b=f1dbipHVA/+d1fsPyXPRpTBkUnvx1wVInGP6Yg11MVj2Nkj95Z6G2On73vnJcveG/NnYQ7atB89MkkKBrUCLzKNCtgOUBpQBzD7sEXrQKhrKGPwjDNQPaEzB0kLWS6kLfY4s6r5aQ/gXA2wv5MMEBGgOr/EwObnGrEwD9OFbORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376608; c=relaxed/simple;
	bh=MAgK1N7TaQw3owaZZNfmDz3iU8YgbdaC1lt8a4Y1rrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnU9NiWmbpRcOuGIuv50LHTKLj0eSa0OZf2+ty532No9fXomkSRgIHLWUd38kkFTHTrJYbRHoxo+G6mwFuQZG/8bJaWvCmjxztQHjLsHyHsXvZb9tBMp2sj5ghCvpXRJ6hNz40Hs+IVmiOEKiwcIdm8LGckssAC8G8UTR6SMmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed08AhPN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed08AhPN"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44261378651so2038608f8f.0
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 04:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777376604; x=1777981404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtutnHk6KQtRiu/n3zcr06oeNW2s9We5/dtsspoc6Is=;
        b=ed08AhPN5+OuVc2+HU79p5eBhIvZk0hyvgls4g57T16eEjrpGXHugujXeI98VOQH9m
         ukomQ2hOo0+qVW2F4rHTj+XvExeEoRfFWJ7q2KnvZ12MGsaDbpLX7jhsc6o8NS+x69YZ
         9/m+dliPl1CWBu4uidqemfSRfe73lnyW8tbTslo+z9kCJtQON7XlSTn+Dd+vm4KBm9Yp
         PunRUOnIpLi6QK34G0wZkgzdL8ux6SIgWkDH2A4F9aDGnALbuFELJdd1K5yfRezUhUI/
         CgM4+Zp6tpnNjxtiLewoLxg8diE8HShhgc9D21IX6cDU6muAOtW5WRrVqytJH1ueReH5
         GyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376604; x=1777981404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dtutnHk6KQtRiu/n3zcr06oeNW2s9We5/dtsspoc6Is=;
        b=QX5PozCB7pRYd9fF8LPVI99QIftWNuGujqlL/452Qj+si2Hx2k4M0NvvcXGdNBs77Q
         CTNKhPR6blSRdTTiMp6T3odKRP2FIrT8nAvlDlH6BiVM917V9Jdl4QqxcUPwgZEU7aeb
         ks2jrHTqsVdfhTRX16GEuO8S8K+OwbkHMutiJBz2uv6lVs3LWrlZuWLWok/9LrdG91GU
         VuFSZnCAyZUma3lr91Thr9eyoDLEDmJr7yNfGysYyt4ktpOubvBmrGvvA+DlC7sdE2UX
         3Xsgw0vVjMPxa+ju6vLTIAPB8j8Zr1lAjtFjugfCWkF1fjcA3e1K95YcQF2bdGuCSeTI
         ZJ5w==
X-Gm-Message-State: AOJu0YxwU4agZ+GQMwz9GW/8Sgy2xmf+JJaal3/ykHyRD2BNgQQFVT+G
	S3otti/rcyPtkHWzttHU7n9hIKVjLOkVLQeCxZuMmFtQ6wK0G/HySZX5
X-Gm-Gg: AeBDievmtAjJ9inJmMKngwvm1UhUoM3Pov2vYeRcIo5/8xxRmuqN1agrnkbyRu4Y/2B
	mtEMhahgG8xNF2ZDfrDaPcWAcS4viKzXsDKFRD7SL1ygZmRnSgethxsxhYRMHNY7AMntpVGnpkE
	VO9R9x9TlcULNml6sW79r5YkKxgHxClBvbOBaA4QesMXp6zU9Gg96jpMp5eb65h+iDDEEBZRqcv
	xcmjlm+sRxtBxkGhvjq5piQqZNzzQbcbZLYXIH1BswCZgOv8Lsyp+HtVXZ/ppZNNaTrstS6Qaxr
	OLsE+/kXImaYQm3XP4hmtWR7sopYPV/wjb2xsV8u8AwK0c3hTgpWDtHyLT+SC0mIFxbnh7KOfXh
	WAVpofNA2q4UgTeZc3sJaTCuFnUVJgzff1yAtmcURPUXIMb2rc6rPQoWue/GhLMj86XhWj7bkvX
	H2eZxM0Oz8bXIfC4MeUaj1jmQ=
X-Received: by 2002:adf:e781:0:b0:43d:78ae:b785 with SMTP id ffacd0b85a97d-446905ee7bbmr2568239f8f.21.1777376604130;
        Tue, 28 Apr 2026 04:43:24 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463ff5a1acsm5589842f8f.33.2026.04.28.04.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:43:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Input: isa1200 - new driver for Imagis ISA1200
Date: Tue, 28 Apr 2026 14:43:08 +0300
Message-ID: <20260428114308.113253-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428114308.113253-1-clamor95@gmail.com>
References: <20260428114308.113253-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Linus Walleij <linusw@kernel.org>

The ISA1200 is a haptic feedback unit from Imagis Technology using two
motors for haptic feedback in mobile phones. Used in many mobile devices
c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Beam
GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.

The exact datasheet for the ISA1200 is not available; all data was modeled
based on available downstream kernel sources for various devices and
fragments of information scattered across the internet.

Signed-off-by: Linus Walleij <linusw@kernel.org>
Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/misc/Kconfig   |  11 +
 drivers/input/misc/Makefile  |   1 +
 drivers/input/misc/isa1200.c | 507 +++++++++++++++++++++++++++++++++++
 3 files changed, 519 insertions(+)
 create mode 100644 drivers/input/misc/isa1200.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 94a753fcb64f..5e5d46f44b91 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -852,6 +852,17 @@ config INPUT_IQS7222
 	  To compile this driver as a module, choose M here: the
 	  module will be called iqs7222.
 
+config INPUT_ISA1200_HAPTIC
+	tristate "Imagis ISA1200 haptic feedback unit"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for the Imagis ISA1200 haptic
+	  feedback unit.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called isa1200.
+
 config INPUT_CMA3000
 	tristate "VTI CMA3000 Tri-axis accelerometer"
 	help
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 415fc4e2918b..d62bf2e9d85f 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_INPUT_IMS_PCU)		+= ims-pcu.o
 obj-$(CONFIG_INPUT_IQS269A)		+= iqs269a.o
 obj-$(CONFIG_INPUT_IQS626A)		+= iqs626a.o
 obj-$(CONFIG_INPUT_IQS7222)		+= iqs7222.o
+obj-$(CONFIG_INPUT_ISA1200_HAPTIC)	+= isa1200.o
 obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
 obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
diff --git a/drivers/input/misc/isa1200.c b/drivers/input/misc/isa1200.c
new file mode 100644
index 000000000000..9a9d980ae47f
--- /dev/null
+++ b/drivers/input/misc/isa1200.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/array_size.h>
+#include <linux/bitmap.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/devm-helpers.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/units.h>
+
+/*
+ * System control (LDO regulator)
+ *
+ * LDO voltage to register mapping is linear, but it is split in two parts:
+ * 2.3V - 3.0V map to 0x08 - 0x0f; 3.1V - 3.8V map to 0x00 - 0x7
+ */
+
+#define ISA1200_SCTRL			0x00
+#define ISA1200_LDO_VOLTAGE_BASE	0x08
+#define ISA1200_LDO_VOLTAGE_STEP	100000
+#define ISA1200_LDO_VOLTAGE_2V3		23
+#define ISA1200_LDO_VOLTAGE_3V1		31
+
+/*
+ * The output frequency is calculated with this formula:
+ *
+ *                 base clock frequency
+ * fout = -----------------------------------------
+ *        (128 - PWM_FREQ) * 2 * PLLDIV * PWM_PERIOD
+ *
+ * The base clock frequency is the clock frequency provided on the
+ * clock input to the chip, divided by the value in HCTRL0
+ *
+ * PWM_FREQ is configured in register HCTRL4, it is common to set this
+ * to 0 to get only two variables to calculate.
+ *
+ * PLLDIV is configured in register HCTRL3 (bits 7..4, so 0..15)
+ * PWM_PERIOD is configured in register HCTRL6
+ * Further the duty cycle can be configured in HCTRL5
+ */
+
+/*
+ * HCTRL0 configures clock or PWM input and selects the divider for
+ * the clock input.
+ */
+#define ISA1200_HCTRL0			0x30
+#define ISA1200_HCTRL0_HAP_ENABLE	BIT(7)
+#define ISA1200_HCTRL0_PWM_GEN_MODE	BIT(4)
+#define ISA1200_HCTRL0_PWM_INPUT_MODE	BIT(3)
+#define ISA1200_HCTRL0_CLKDIV_128	128
+
+/*
+ * HCTRL1 configures the motor type and clock sourse
+ */
+#define ISA1200_HCTRL1			0x31
+#define ISA1200_HCTRL1_EXT_CLOCK	BIT(7)
+#define ISA1200_HCTRL1_DAC_INVERT	BIT(6)
+#define ISA1200_HCTRL1_MODE(n)		((n) << 5)
+
+/* HCTRL2 controls software reset of the chip */
+#define ISA1200_HCTRL2			0x32
+#define ISA1200_HCTRL2_SW_RESET		BIT(0)
+
+/*
+ * HCTRL3 controls the PLL divisor
+ *
+ * Bits [0,1] are always set to 1 (we don't know what they are
+ * used for) and bit 4 and upward control the PLL divisor.
+ */
+#define ISA1200_HCTRL3			0x33
+#define ISA1200_HCTRL3_DEFAULT		0x03
+#define ISA1200_HCTRL3_PLLDIV(n)	(((n) & 0xf) << 4)
+
+/* HCTRL4 controls the PWM frequency of external channel */
+#define ISA1200_HCTRL4			0x34
+
+/* HCTRL5 controls the PWM high duty cycle of internal channel */
+#define ISA1200_HCTRL5			0x35
+
+/* HCTRL6 controls the PWM period of internal channel */
+#define ISA1200_HCTRL6			0x36
+#define ISA1200_HCTRL6_PERIOD_SCALE	100
+
+/* The use for these registers is unknown but they exist */
+#define ISA1200_HCTRL7			0x37
+#define ISA1200_HCTRL8			0x38
+#define ISA1200_HCTRL9			0x39
+#define ISA1200_HCTRLA			0x3a
+#define ISA1200_HCTRLB			0x3b
+#define ISA1200_HCTRLC			0x3c
+#define ISA1200_HCTRLD			0x3d
+
+#define ISA1200_EN_PINS_MAX		2
+
+struct isa1200_config {
+	u32 ldo_voltage;
+	u32 mode;
+	u32 clkdiv;
+	u32 plldiv;
+	u32 freq;
+	u32 period;
+	u32 duty;
+};
+
+struct isa1200 {
+	struct input_dev *input;
+	struct regmap *map;
+
+	struct clk *clk;
+	struct pwm_device *pwm;
+	struct gpio_descs *enable_gpios;
+
+	struct work_struct play_work;
+	struct isa1200_config config;
+
+	int level;
+};
+
+static const struct regmap_config isa1200_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ISA1200_HCTRLD,
+};
+
+static void isa1200_start(struct isa1200 *isa)
+{
+	struct isa1200_config *config = &isa->config;
+	struct pwm_state state;
+	u8 hctrl0 = 0, hctrl1 = 0;
+	DECLARE_BITMAP(values, ISA1200_EN_PINS_MAX);
+
+	clk_prepare_enable(isa->clk);
+
+	bitmap_fill(values, ISA1200_EN_PINS_MAX);
+	gpiod_multi_set_value_cansleep(isa->enable_gpios, values);
+
+	usleep_range(200, 300);
+
+	regmap_write(isa->map, ISA1200_SCTRL, config->ldo_voltage);
+
+	if (isa->clk) {
+		hctrl0 = ISA1200_HCTRL0_PWM_GEN_MODE;
+		hctrl1 = ISA1200_HCTRL1_EXT_CLOCK;
+	}
+
+	if (isa->pwm) {
+		hctrl0 = ISA1200_HCTRL0_PWM_INPUT_MODE;
+		hctrl1 = 0;
+	}
+
+	hctrl0 |= __ffs(config->clkdiv / ISA1200_HCTRL0_CLKDIV_128);
+	hctrl1 |= ISA1200_HCTRL1_DAC_INVERT;
+	hctrl1 |= ISA1200_HCTRL1_MODE(config->mode);
+
+	regmap_write(isa->map, ISA1200_HCTRL0, hctrl0);
+	regmap_write(isa->map, ISA1200_HCTRL1, hctrl1);
+
+	/* Make sure to de-assert software reset */
+	regmap_write(isa->map, ISA1200_HCTRL2, 0x00);
+
+	/* PLL divisor */
+	regmap_write(isa->map, ISA1200_HCTRL3,
+		     ISA1200_HCTRL3_PLLDIV(config->plldiv) |
+		     ISA1200_HCTRL3_DEFAULT);
+
+	/* Frequency */
+	regmap_write(isa->map, ISA1200_HCTRL4, config->freq);
+	/* Duty cycle */
+	regmap_write(isa->map, ISA1200_HCTRL5, config->period >> 1);
+	/* Period */
+	regmap_write(isa->map, ISA1200_HCTRL6, config->period);
+
+	hctrl0 |= ISA1200_HCTRL0_HAP_ENABLE;
+	regmap_write(isa->map, ISA1200_HCTRL0, hctrl0);
+
+	if (isa->clk)
+		regmap_write(isa->map, ISA1200_HCTRL5, config->duty);
+
+	if (isa->pwm) {
+		pwm_get_state(isa->pwm, &state);
+		state.duty_cycle = config->duty;
+		state.enabled = true;
+		pwm_apply_might_sleep(isa->pwm, &state);
+	}
+}
+
+static void isa1200_power_off(void *data)
+{
+	struct isa1200 *isa = data;
+
+	DECLARE_BITMAP(values, ISA1200_EN_PINS_MAX);
+
+	bitmap_zero(values, ISA1200_EN_PINS_MAX);
+	gpiod_multi_set_value_cansleep(isa->enable_gpios, values);
+
+	clk_disable_unprepare(isa->clk);
+}
+
+static void isa1200_stop(struct isa1200 *isa)
+{
+	struct pwm_state state;
+
+	if (isa->pwm) {
+		pwm_get_state(isa->pwm, &state);
+		state.duty_cycle = 0;
+		state.enabled = false;
+		pwm_apply_might_sleep(isa->pwm, &state);
+	}
+
+	regmap_write(isa->map, ISA1200_HCTRL0, 0x00);
+	isa1200_power_off(isa);
+}
+
+static void isa1200_play_work(struct work_struct *work)
+{
+	struct isa1200 *isa =
+		container_of(work, struct isa1200, play_work);
+
+	if (isa->level)
+		isa1200_start(isa);
+	else
+		isa1200_stop(isa);
+}
+
+static int isa1200_vibrator_play_effect(struct input_dev *input, void *data,
+					struct ff_effect *effect)
+{
+	struct isa1200 *isa = input_get_drvdata(input);
+	int level;
+
+	/*
+	 * TODO: we currently only support rumble.
+	 * The ISA1200 can control two motors and some devices
+	 * also have two motors mounted.
+	 */
+	level = effect->u.rumble.strong_magnitude;
+	if (!level)
+		level = effect->u.rumble.weak_magnitude;
+
+	dev_dbg(&input->dev, "FF effect type %d level %d\n",
+		effect->type, level);
+
+	if (isa->level != level) {
+		isa->level = level;
+		schedule_work(&isa->play_work);
+	}
+
+	return 0;
+}
+
+static void isa1200_vibrator_close(struct input_dev *input)
+{
+	struct isa1200 *isa = input_get_drvdata(input);
+
+	cancel_work_sync(&isa->play_work);
+
+	if (isa->level)
+		isa1200_stop(isa);
+
+	isa->level = 0;
+}
+
+static int isa1200_of_probe(struct i2c_client *client)
+{
+	static const char * const isa1200_supplies[] = { "vdd", "vddp" };
+	struct isa1200 *isa = i2c_get_clientdata(client);
+	struct isa1200_config *config = &isa->config;
+	struct device *dev = &client->dev;
+	struct fwnode_handle *ldo_node;
+	int ret;
+
+	isa->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(isa->clk))
+		return dev_err_probe(dev, PTR_ERR(isa->clk),
+				     "failed to get clock\n");
+
+	isa->pwm = devm_pwm_get(dev, NULL);
+	if (IS_ERR(isa->pwm)) {
+		ret = PTR_ERR(isa->pwm);
+		if (ret == -ENODEV || ret == -EINVAL)
+			isa->pwm = NULL;
+		else
+			return dev_err_probe(dev, ret, "getting PWM\n");
+	}
+
+	if (!isa->clk && !isa->pwm)
+		return dev_err_probe(dev, -EINVAL,
+				     "clock or PWM are required, none were provided\n");
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(isa1200_supplies),
+					     isa1200_supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set up supplies\n");
+
+	isa->enable_gpios = devm_gpiod_get_array_optional(dev, "control",
+							  GPIOD_OUT_LOW);
+	if (IS_ERR(isa->enable_gpios))
+		return dev_err_probe(dev, PTR_ERR(isa->enable_gpios),
+				     "failed to get enable gpios\n");
+
+	ldo_node = device_get_named_child_node(dev, "ldo");
+	if (!ldo_node)
+		return dev_err_probe(dev, -ENODEV,
+				     "failed to get embedded LDO node\n");
+
+	config->ldo_voltage = 2300000;
+	ret = fwnode_property_read_u32(ldo_node, "regulator-min-microvolt",
+				       &config->ldo_voltage);
+	fwnode_handle_put(ldo_node);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get ldo voltage\n");
+
+	/* Device supports only 2.3V - 3.8V range */
+	if (config->ldo_voltage < 2300000 || config->ldo_voltage > 3800000)
+		return dev_err_probe(dev, -EINVAL,
+				     "voltage is out of 2.3V - 3.8V range\n");
+
+	config->ldo_voltage /= ISA1200_LDO_VOLTAGE_STEP;
+	if (config->ldo_voltage < ISA1200_LDO_VOLTAGE_3V1)
+		config->ldo_voltage = config->ldo_voltage -
+				      ISA1200_LDO_VOLTAGE_2V3 +
+				      ISA1200_LDO_VOLTAGE_BASE;
+	else
+		config->ldo_voltage -= ISA1200_LDO_VOLTAGE_3V1;
+
+	config->mode = 0; /* LRA_MODE */
+	device_property_read_u32(dev, "imagis,mode", &config->mode);
+
+	config->clkdiv = ISA1200_HCTRL0_CLKDIV_128;
+	device_property_read_u32(dev, "imagis,clk-div", &config->clkdiv);
+	if (!config->clkdiv)
+		return dev_err_probe(dev, -EINVAL, "clk-div cannot be zero\n");
+
+	config->plldiv = 1;
+	device_property_read_u32(dev, "imagis,pll-div", &config->plldiv);
+
+	config->period = 0;
+	config->freq = 0;
+	config->duty = 0;
+
+	if (isa->clk) {
+		ret = device_property_read_u32(dev, "imagis,period-ns",
+					       &config->period);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to get period\n");
+
+		config->period /= ISA1200_HCTRL6_PERIOD_SCALE;
+		config->duty = config->period >> 1;
+	}
+
+	if (isa->pwm) {
+		struct pwm_state state;
+
+		pwm_init_state(isa->pwm, &state);
+
+		if (!state.period)
+			return dev_err_probe(dev, -EINVAL,
+					     "PWM period cannot be zero\n");
+
+		config->freq = div64_u64(NANO, state.period * config->clkdiv);
+		config->duty = state.period >> 1;
+
+		ret = pwm_apply_might_sleep(isa->pwm, &state);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to apply initial PWM state\n");
+	}
+
+	device_property_read_u32(dev, "imagis,duty-cycle-ns", &config->duty);
+
+	return 0;
+}
+
+static int isa1200_probe(struct i2c_client *client)
+{
+	struct isa1200 *isa;
+	struct device *dev = &client->dev;
+	DECLARE_BITMAP(values, ISA1200_EN_PINS_MAX);
+	u32 val;
+	int ret;
+
+	isa = devm_kzalloc(dev, sizeof(*isa), GFP_KERNEL);
+	if (!isa)
+		return -ENOMEM;
+
+	isa->input = devm_input_allocate_device(dev);
+	if (!isa->input)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, isa);
+
+	ret = isa1200_of_probe(client);
+	if (ret)
+		return ret;
+
+	isa->map = devm_regmap_init_i2c(client, &isa1200_regmap_config);
+	if (IS_ERR(isa->map))
+		return dev_err_probe(dev, PTR_ERR(isa->map),
+				     "failed to initialize register map\n");
+
+	clk_prepare_enable(isa->clk);
+
+	bitmap_fill(values, ISA1200_EN_PINS_MAX);
+	gpiod_multi_set_value_cansleep(isa->enable_gpios, values);
+
+	ret = devm_add_action_or_reset(dev, isa1200_power_off, isa);
+	if (ret)
+		return ret;
+
+	usleep_range(200, 300);
+
+	/* Read a register so we know that regmap and I2C transport works */
+	ret = regmap_read(isa->map, ISA1200_SCTRL, &val);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read SCTRL\n");
+
+	ret = devm_work_autocancel(dev, &isa->play_work, isa1200_play_work);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init work\n");
+
+	isa->input->name = "isa1200-haptic";
+	isa->input->id.bustype = BUS_HOST;
+	isa->input->dev.parent = dev;
+	isa->input->close = isa1200_vibrator_close;
+
+	input_set_drvdata(isa->input, isa);
+
+	/* TODO: this hardware can likely support more than rumble */
+	input_set_capability(isa->input, EV_FF, FF_RUMBLE);
+
+	ret = input_ff_create_memless(isa->input, NULL,
+				      isa1200_vibrator_play_effect);
+	if (ret)
+		return dev_err_probe(dev, ret, "couldn't create FF dev\n");
+
+	ret = input_register_device(isa->input);
+	if (ret)
+		return dev_err_probe(dev, ret, "couldn't register input dev\n");
+
+	return ret;
+}
+
+static int isa1200_suspend(struct device *dev)
+{
+	struct isa1200 *isa = dev_get_drvdata(dev);
+	struct input_dev *input_dev = isa->input;
+
+	guard(mutex)(&input_dev->mutex);
+
+	if (input_device_enabled(input_dev)) {
+		cancel_work_sync(&isa->play_work);
+		if (isa->level)
+			isa1200_stop(isa);
+	}
+
+	return 0;
+}
+
+static int isa1200_resume(struct device *dev)
+{
+	struct isa1200 *isa = dev_get_drvdata(dev);
+	struct input_dev *input_dev = isa->input;
+
+	guard(mutex)(&input_dev->mutex);
+
+	if (input_device_enabled(input_dev))
+		if (isa->level)
+			isa1200_start(isa);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(isa1200_pm_ops, isa1200_suspend, isa1200_resume);
+
+static const struct of_device_id isa1200_of_match[] = {
+	{ .compatible = "imagis,isa1200" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, isa1200_of_match);
+
+static struct i2c_driver isa1200_i2c_driver = {
+	.driver = {
+		.name = "isa1200",
+		.of_match_table = isa1200_of_match,
+		.pm = pm_sleep_ptr(&isa1200_pm_ops),
+	},
+	.probe = isa1200_probe,
+};
+module_i2c_driver(isa1200_i2c_driver);
+
+MODULE_AUTHOR("Linus Walleij <linusw@kernel.org>");
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("Imagis ISA1200 haptic feedback unit");
+MODULE_LICENSE("GPL");
-- 
2.51.0

