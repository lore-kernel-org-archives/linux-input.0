Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E736A002
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873457; cv=none; b=Hrfogs/5amwTY53+hS2kHAyTxaf1i8JfKC7COCd54G/DTNB7U8jCa918ZemcBIlmeGiAHGqmSZvFABR+yuj5wZoUCBszRDIZykZb5JjUx+I8o1dvd7LAf142Zr62MQHwUVhUFMklmNdypAKc7zLkzinTfkTXrGI581TMRbDpzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873457; c=relaxed/simple;
	bh=LT8OlbCV7ZreBqtYldjMu76TbsrnI5P3wgQ4abPQQvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM2NXUsojGFSWP0R/5FehOH7XxjOQ6XLtCrln89w4ByPwWjmPdn0Su9+x/IxVUuzB3Gjulq2HFI9PBiFeNmzJ0txwnDH4EaWKtZqY264Rg6iR4h6NN1QD0KSogZyxmz+U8W2H5edPaSc9sC2TjrkovfSCDFqt5nrprD0VvOBIpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdaUOO9M; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdaUOO9M"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so7606119a12.2
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 11:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771873453; x=1772478253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exgfE8ktpWjoGx7BWRifvOIDppNSZSX62nYtLWrbQms=;
        b=QdaUOO9MXjIDNULiXBN3VjvErrAmPNe2MQtb1whZXr6F/c1BCG2tPQShEbF1xQRsV4
         X8sVHStoOe6TGBZxiaaJd8/x663hP9gYyW8pJlltqlH+6tRtOsUGARVdY+Ag1sXw6dxr
         qnDqnELv9OEUE+SSLUnuxwfXWSO+n3hvNSNzlOWabjiVwy4jeMCZYWyYmfsgpfLiS7yl
         CyBhbioMlr1sSXOqVVeZUKozE85t6iijWy8P2JfMpCWbrXZKboA7SkIGnsekuKgrNqwn
         NkquwLybDjh6EaH9xkuOD0aVnVXGsJAdPGwThIt/bZ+Tpl0ilyyZAQeSdz4o4gV6akHn
         zbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873453; x=1772478253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=exgfE8ktpWjoGx7BWRifvOIDppNSZSX62nYtLWrbQms=;
        b=QnZMU6gg1wI2shQsgwFXqmE99daLOEDFAy5Z7+wAmzuhXjG/npjxAQUDx6MoEM674o
         LuOkd6A3NE4hHOOZ9I7Z0oDeed+mDjIEjCutOIhrOTeXTMiZFJ/EI7iDzbQtuzwhrx0Q
         F/nZEAou/sZLzznE7eYIxPNEoGj1ZH2+ylnUbNBjQF6HuXIXWne+2J3bITjEoDP6pQQl
         t08MfcsNZr1yv++ZnRpJOC2SfCAt7W2zUtKhGDTKiaZ428kqhaAsfFQz02+e1OlMCMJF
         aRuhA1iF6qH++tatT0IL04j6hmKjr9Pr0bOE3CGzBkTnZEurK9BqmruoZd09i7xSvF9W
         dM9g==
X-Forwarded-Encrypted: i=1; AJvYcCW6oGspKjYB7MqKVscJ6i2ZvimBcGpdol3wxS4O9KsAZbemV3XXDk6reUoUwAjkXRXU8disyrsl/UgTGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2zMSZEBzyq3LYB05lY7FrW0r1VF9G6U/D1SyLQF8tiNGIEaE
	MvgILOZoyo6p83WoPTQuTExxmjcBV9dg/VP75j4fNqYZz2tsAOFQnoR++Ns9tw==
X-Gm-Gg: ATEYQzwxAKRPS08kEKmYC8Cm+vM2lCgfcxJ7L5URBGv4dJpVCwCB1dbcShvwL8qxvuu
	JMEBhkZ5rDeS2i83m5jKtQnH/dG+rVTQ8RHSAoQ3YCiTtbJOEOPZLjt9Ml4dLmmMnzOb6WrR8qw
	2ZN32PViK0XsQyKhJHvBpXb0vvjw+x/FsPg3newBvQX7FMjuFzN9TDdPNxsAF+vosIZOOuMKHqH
	qtlaaCzXWG1IOeNwW69HwwCd+7oxROaW7IdO19wfu0RAodrNJJWLO8TNSLR+XFk/cA5rniMhRdt
	hEd3Nger0iiOwn5I1QKw6G1Spzh3TLz+HAZC6JMXWbvUX0DF3cfF9uPihmKCtlV9sZw7vZkR6Cl
	JqVtw05x3EyyAezRrd9GEAHceMXqmUxXZHQCrwsx29YIOOwkTyG9QOjCkMmYApRYrYdozkKds2v
	LYwCXXdi8AwMs3lBcodVlowJiEpBjcWw==
X-Received: by 2002:a05:600c:1c04:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-483a95cfc62mr176431495e9.15.1771867090231;
        Mon, 23 Feb 2026 09:18:10 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c982sm20871454f8f.31.2026.02.23.09.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:18:09 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 6/9] regulator: mt6392: Add support for MT6392 regulator
Date: Mon, 23 Feb 2026 17:12:45 +0000
Message-ID: <81250922d4095d1be0a96a5148b206e03123256d.1771865015.git.l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771865014.git.l.scorcia@gmail.com>
References: <cover.1771865014.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabien Parent <parent.f@gmail.com>

The MT6392 is a regulator found on boards based on the MediaTek
MT8167, MT8516, and probably other SoCs. It is a so called PMIC and
connects as a slave to a SoC using SPI, wrapped inside PWRAP.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Co-developed-by: Val Packett <val@packett.cool>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/regulator/Kconfig                  |   9 +
 drivers/regulator/Makefile                 |   1 +
 drivers/regulator/mt6392-regulator.c       | 491 +++++++++++++++++++++
 include/linux/regulator/mt6392-regulator.h |  40 ++
 4 files changed, 541 insertions(+)
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/linux/regulator/mt6392-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index d2335276cce5..66876d730807 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -991,6 +991,15 @@ config REGULATOR_MT6380
 	  This driver supports the control of different power rails of device
 	  through regulator interface.
 
+config REGULATOR_MT6392
+	tristate "MediaTek MT6392 PMIC"
+	depends on MFD_MT6397
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6392 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
 config REGULATOR_MT6397
 	tristate "MediaTek MT6397 PMIC"
 	depends on MFD_MT6397
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 1beba1493241..db5145cfcf36 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -117,6 +117,7 @@ obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
 obj-$(CONFIG_REGULATOR_MT6363) += mt6363-regulator.o
 obj-$(CONFIG_REGULATOR_MT6370) += mt6370-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
+obj-$(CONFIG_REGULATOR_MT6392)	+= mt6392-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_MTK_DVFSRC) += mtk-dvfsrc-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_LABIBB) += qcom-labibb-regulator.o
diff --git a/drivers/regulator/mt6392-regulator.c b/drivers/regulator/mt6392-regulator.c
new file mode 100644
index 000000000000..1ac5cdf4eb7f
--- /dev/null
+++ b/drivers/regulator/mt6392-regulator.c
@@ -0,0 +1,491 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2020 MediaTek Inc.
+// Copyright (c) 2020 BayLibre, SAS.
+// Author: Chen Zhong <chen.zhong@mediatek.com>
+// Author: Fabien Parent <fparent@baylibre.com>
+//
+// Based on mt6397-regulator.c
+
+#include <linux/module.h>
+#include <linux/linear_range.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/mt6397/core.h>
+#include <linux/mfd/mt6392/registers.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/mt6392-regulator.h>
+#include <linux/regulator/of_regulator.h>
+
+#define MT6392_BUCK_MODE_AUTO	0
+#define MT6392_BUCK_MODE_FORCE_PWM	1
+#define MT6392_LDO_MODE_NORMAL	0
+#define MT6392_LDO_MODE_LP	1
+
+/*
+ * MT6392 regulators' information
+ *
+ * @desc: standard fields of regulator description.
+ * @qi: Mask for query enable signal status of regulators
+ * @vselon_reg: Register sections for hardware control mode of bucks
+ * @vselctrl_reg: Register for controlling the buck control mode.
+ * @vselctrl_mask: Mask for query buck's voltage control mode.
+ */
+struct mt6392_regulator_info {
+	struct regulator_desc desc;
+	u32 qi;
+	u32 vselon_reg;
+	u32 vselctrl_reg;
+	u32 vselctrl_mask;
+	u32 modeset_reg;
+	u32 modeset_mask;
+};
+
+#define MT6392_BUCK(match, vreg, min, max, step, volt_ranges, enreg,	\
+		vosel, vosel_mask, voselon, vosel_ctrl,			\
+		_modeset_reg, _modeset_mask, rampdelay)		\
+[MT6392_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6392_volt_range_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6392_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min)/step + 1,			\
+		.linear_ranges = volt_ranges,				\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges),		\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(0),					\
+		.ramp_delay = rampdelay,				\
+	},								\
+	.qi = BIT(13),							\
+	.vselon_reg = voselon,						\
+	.vselctrl_reg = vosel_ctrl,					\
+	.vselctrl_mask = BIT(1),					\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = _modeset_mask,					\
+}
+
+#define MT6392_LDO(match, vreg, ldo_volt_table, enreg, enbit, vosel,	\
+		vosel_mask, _modeset_reg, _modeset_mask, entime)	\
+[MT6392_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6392_volt_table_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6392_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = ARRAY_SIZE(ldo_volt_table),		\
+		.volt_table = ldo_volt_table,				\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+		.enable_time = entime,					\
+	},								\
+	.qi = BIT(15),							\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = _modeset_mask,					\
+}
+
+#define MT6392_LDO_LINEAR(match, vreg, min, max, step, volt_ranges,	\
+		enreg, enbit, vosel, vosel_mask, _modeset_reg,		\
+		_modeset_mask, entime)					\
+[MT6392_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6392_volt_ldo_range_ops,			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6392_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min)/step + 1,			\
+		.linear_ranges = volt_ranges,				\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges),		\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+		.enable_time = entime,					\
+	},								\
+	.qi = BIT(15),							\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = _modeset_mask,					\
+}
+
+#define MT6392_REG_FIXED(match, vreg, enreg, enbit, volt,		\
+		_modeset_reg, _modeset_mask, entime)			\
+[MT6392_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6392_volt_fixed_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6392_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = 1,					\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+		.enable_time = entime,					\
+		.min_uV = volt,						\
+	},								\
+	.qi = BIT(15),							\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = _modeset_mask,					\
+}
+
+#define MT6392_REG_FIXED_NO_MODE(match, vreg, enreg, enbit, volt,	\
+	entime)								\
+[MT6392_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6392_volt_fixed_no_mode_ops,			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6392_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = 1,					\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+		.enable_time = entime,					\
+		.min_uV = volt,						\
+	},								\
+	.qi = BIT(15),							\
+}
+
+static const struct linear_range buck_volt_range1[] = {
+	REGULATOR_LINEAR_RANGE(700000, 0, 0x7f, 6250),
+};
+
+static const struct linear_range buck_volt_range2[] = {
+	REGULATOR_LINEAR_RANGE(1400000, 0, 0x7f, 12500),
+};
+
+static const u32 ldo_volt_table1[] = {
+	1800000, 1900000, 2000000, 2200000,
+};
+
+static const struct linear_range ldo_volt_range2[] = {
+	REGULATOR_LINEAR_RANGE(3300000, 0, 3, 100000),
+};
+
+static const u32 ldo_volt_table3[] = {
+	1800000, 3300000,
+};
+
+static const u32 ldo_volt_table4[] = {
+	3000000, 3300000,
+};
+
+static const u32 ldo_volt_table5[] = {
+	1200000, 1300000, 1500000, 1800000, 2000000, 2800000, 3000000, 3300000,
+};
+
+static const u32 ldo_volt_table6[] = {
+	1240000, 1390000,
+};
+
+static const u32 ldo_volt_table7[] = {
+	1200000, 1300000, 1500000, 1800000,
+};
+
+static const u32 ldo_volt_table8[] = {
+	1800000, 2000000,
+};
+
+static int mt6392_buck_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	int ret, val = 0;
+	struct mt6392_regulator_info *info = rdev_get_drvdata(rdev);
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		val = MT6392_BUCK_MODE_FORCE_PWM;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		val = MT6392_BUCK_MODE_AUTO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val <<= ffs(info->modeset_mask) - 1;
+
+	ret = regmap_update_bits(rdev->regmap, info->modeset_reg,
+				  info->modeset_mask, val);
+
+	return ret;
+}
+
+static unsigned int mt6392_buck_get_mode(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	unsigned int mode;
+	int ret;
+	struct mt6392_regulator_info *info = rdev_get_drvdata(rdev);
+
+	ret = regmap_read(rdev->regmap, info->modeset_reg, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= info->modeset_mask;
+	val >>= ffs(info->modeset_mask) - 1;
+
+	if (val & 0x1)
+		mode = REGULATOR_MODE_FAST;
+	else
+		mode = REGULATOR_MODE_NORMAL;
+
+	return mode;
+}
+
+static int mt6392_ldo_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	int ret, val = 0;
+	struct mt6392_regulator_info *info = rdev_get_drvdata(rdev);
+
+	switch (mode) {
+	case REGULATOR_MODE_STANDBY:
+		val = MT6392_LDO_MODE_LP;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		val = MT6392_LDO_MODE_NORMAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val <<= ffs(info->modeset_mask) - 1;
+
+	ret = regmap_update_bits(rdev->regmap, info->modeset_reg,
+				  info->modeset_mask, val);
+
+	return ret;
+}
+
+static unsigned int mt6392_ldo_get_mode(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	unsigned int mode;
+	int ret;
+	struct mt6392_regulator_info *info = rdev_get_drvdata(rdev);
+
+	ret = regmap_read(rdev->regmap, info->modeset_reg, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= info->modeset_mask;
+	val >>= ffs(info->modeset_mask) - 1;
+
+	if (val & 0x1)
+		mode = REGULATOR_MODE_STANDBY;
+	else
+		mode = REGULATOR_MODE_NORMAL;
+
+	return mode;
+}
+
+static const struct regulator_ops mt6392_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6392_buck_set_mode,
+	.get_mode = mt6392_buck_get_mode,
+};
+
+static const struct regulator_ops mt6392_volt_table_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6392_ldo_set_mode,
+	.get_mode = mt6392_ldo_get_mode,
+};
+
+static const struct regulator_ops mt6392_volt_ldo_range_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6392_ldo_set_mode,
+	.get_mode = mt6392_ldo_get_mode,
+};
+
+static const struct regulator_ops mt6392_volt_fixed_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6392_ldo_set_mode,
+	.get_mode = mt6392_ldo_get_mode,
+};
+
+static const struct regulator_ops mt6392_volt_fixed_no_mode_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+/* The array is indexed by id(MT6392_ID_XXX) */
+static struct mt6392_regulator_info mt6392_regulators[] = {
+	MT6392_BUCK("buck_vproc", VPROC, 700000, 1493750, 6250,
+		buck_volt_range1, MT6392_VPROC_CON7, MT6392_VPROC_CON9, 0x7f,
+		MT6392_VPROC_CON10, MT6392_VPROC_CON5, MT6392_VPROC_CON2,
+		0x100, 12500),
+	MT6392_BUCK("buck_vsys", VSYS, 1400000, 2987500, 12500,
+		buck_volt_range2, MT6392_VSYS_CON7, MT6392_VSYS_CON9, 0x7f,
+		MT6392_VSYS_CON10, MT6392_VSYS_CON5, MT6392_VSYS_CON2, 0x100,
+		25000),
+	MT6392_BUCK("buck_vcore", VCORE, 700000, 1493750, 6250,
+		buck_volt_range1, MT6392_VCORE_CON7, MT6392_VCORE_CON9, 0x7f,
+		MT6392_VCORE_CON10, MT6392_VCORE_CON5, MT6392_VCORE_CON2,
+		0x100, 12500),
+	MT6392_REG_FIXED("ldo_vxo22", VXO22, MT6392_ANALDO_CON1, 10, 2200000,
+		MT6392_ANALDO_CON1, 0x2, 110),
+	MT6392_LDO("ldo_vaud22", VAUD22, ldo_volt_table1,
+		MT6392_ANALDO_CON2, 14, MT6392_ANALDO_CON8, 0x60,
+		MT6392_ANALDO_CON2, 0x2, 264),
+	MT6392_REG_FIXED_NO_MODE("ldo_vcama", VCAMA, MT6392_ANALDO_CON4, 15,
+		2800000, 264),
+	MT6392_REG_FIXED("ldo_vaud28", VAUD28, MT6392_ANALDO_CON23, 14, 2800000,
+		MT6392_ANALDO_CON23, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vadc18", VADC18, MT6392_ANALDO_CON25, 14, 1800000,
+		MT6392_ANALDO_CON25, 0x2, 264),
+	MT6392_LDO_LINEAR("ldo_vcn35", VCN35, 3300000, 3600000, 100000,
+		ldo_volt_range2, MT6392_ANALDO_CON21, 12, MT6392_ANALDO_CON16,
+		0xC, MT6392_ANALDO_CON21, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vio28", VIO28, MT6392_DIGLDO_CON0, 14, 2800000,
+		MT6392_DIGLDO_CON0, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vusb", VUSB, MT6392_DIGLDO_CON2, 14, 3300000,
+		MT6392_DIGLDO_CON2, 0x2, 264),
+	MT6392_LDO("ldo_vmc", VMC, ldo_volt_table3,
+		MT6392_DIGLDO_CON3, 12, MT6392_DIGLDO_CON24, 0x10,
+		MT6392_DIGLDO_CON3, 0x2, 264),
+	MT6392_LDO("ldo_vmch", VMCH, ldo_volt_table4,
+		MT6392_DIGLDO_CON5, 14, MT6392_DIGLDO_CON26, 0x80,
+		MT6392_DIGLDO_CON5, 0x2, 264),
+	MT6392_LDO("ldo_vemc3v3", VEMC3V3, ldo_volt_table4,
+		MT6392_DIGLDO_CON6, 14, MT6392_DIGLDO_CON27, 0x80,
+		MT6392_DIGLDO_CON6, 0x2, 264),
+	MT6392_LDO("ldo_vgp1", VGP1, ldo_volt_table5,
+		MT6392_DIGLDO_CON7, 15, MT6392_DIGLDO_CON28, 0xE0,
+		MT6392_DIGLDO_CON7, 0x2, 264),
+	MT6392_LDO("ldo_vgp2", VGP2, ldo_volt_table5,
+		MT6392_DIGLDO_CON8, 15, MT6392_DIGLDO_CON29, 0xE0,
+		MT6392_DIGLDO_CON8, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vcn18", VCN18, MT6392_DIGLDO_CON11, 14, 1800000,
+		MT6392_DIGLDO_CON11, 0x2, 264),
+	MT6392_LDO("ldo_vcamaf", VCAMAF, ldo_volt_table5,
+		MT6392_DIGLDO_CON31, 15, MT6392_DIGLDO_CON32, 0xE0,
+		MT6392_DIGLDO_CON31, 0x2, 264),
+	MT6392_LDO("ldo_vm", VM, ldo_volt_table6,
+		MT6392_DIGLDO_CON47, 14, MT6392_DIGLDO_CON48, 0x30,
+		MT6392_DIGLDO_CON47, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vio18", VIO18, MT6392_DIGLDO_CON49, 14, 1800000,
+		MT6392_DIGLDO_CON49, 0x2, 264),
+	MT6392_LDO("ldo_vcamd", VCAMD, ldo_volt_table7,
+		MT6392_DIGLDO_CON51, 14, MT6392_DIGLDO_CON52, 0x60,
+		MT6392_DIGLDO_CON51, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vcamio", VCAMIO, MT6392_DIGLDO_CON53, 14, 1800000,
+		MT6392_DIGLDO_CON53, 0x2, 264),
+	MT6392_REG_FIXED("ldo_vm25", VM25, MT6392_DIGLDO_CON55, 14, 2500000,
+		MT6392_DIGLDO_CON55, 0x2, 264),
+	MT6392_LDO("ldo_vefuse", VEFUSE, ldo_volt_table8,
+		MT6392_DIGLDO_CON57, 14, MT6392_DIGLDO_CON58, 0x10,
+		MT6392_DIGLDO_CON57, 0x2, 264),
+};
+
+static int mt6392_set_buck_vosel_reg(struct platform_device *pdev)
+{
+	struct mt6397_chip *mt6392 = dev_get_drvdata(pdev->dev.parent);
+	int i;
+	u32 regval;
+
+	for (i = 0; i < MT6392_MAX_REGULATOR; i++) {
+		if (mt6392_regulators[i].vselctrl_reg) {
+			if (regmap_read(mt6392->regmap,
+				mt6392_regulators[i].vselctrl_reg,
+				&regval) < 0) {
+				dev_err(&pdev->dev,
+					"Failed to read buck ctrl\n");
+				return -EIO;
+			}
+
+			if (regval & mt6392_regulators[i].vselctrl_mask) {
+				mt6392_regulators[i].desc.vsel_reg =
+				mt6392_regulators[i].vselon_reg;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int mt6392_regulator_probe(struct platform_device *pdev)
+{
+	struct mt6397_chip *mt6392 = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	int i;
+
+	/* Query buck controller to select activated voltage register part */
+	if (mt6392_set_buck_vosel_reg(pdev))
+		return -EIO;
+
+	for (i = 0; i < MT6392_MAX_REGULATOR; i++) {
+		config.dev = &pdev->dev;
+		config.driver_data = &mt6392_regulators[i];
+		config.regmap = mt6392->regmap;
+
+		rdev = devm_regulator_register(&pdev->dev,
+					       &mt6392_regulators[i].desc,
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "failed to register %s\n",
+				mt6392_regulators[i].desc.name);
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id mt6392_platform_ids[] = {
+	{"mt6392-regulator", 0},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, mt6392_platform_ids);
+
+static struct platform_driver mt6392_regulator_driver = {
+	.driver = {
+		.name = "mt6392-regulator",
+	},
+	.probe = mt6392_regulator_probe,
+	.id_table = mt6392_platform_ids,
+};
+
+module_platform_driver(mt6392_regulator_driver);
+
+MODULE_AUTHOR("Chen Zhong <chen.zhong@mediatek.com>");
+MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6392 PMIC");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regulator/mt6392-regulator.h b/include/linux/regulator/mt6392-regulator.h
new file mode 100644
index 000000000000..dfcbcacb5ad4
--- /dev/null
+++ b/include/linux/regulator/mt6392-regulator.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Chen Zhong <chen.zhong@mediatek.com>
+ */
+
+#ifndef __LINUX_REGULATOR_MT6392_H
+#define __LINUX_REGULATOR_MT6392_H
+
+enum {
+	MT6392_ID_VPROC = 0,
+	MT6392_ID_VSYS,
+	MT6392_ID_VCORE,
+	MT6392_ID_VXO22,
+	MT6392_ID_VAUD22,
+	MT6392_ID_VCAMA,
+	MT6392_ID_VAUD28,
+	MT6392_ID_VADC18,
+	MT6392_ID_VCN35,
+	MT6392_ID_VIO28,
+	MT6392_ID_VUSB = 10,
+	MT6392_ID_VMC,
+	MT6392_ID_VMCH,
+	MT6392_ID_VEMC3V3,
+	MT6392_ID_VGP1,
+	MT6392_ID_VGP2,
+	MT6392_ID_VCN18,
+	MT6392_ID_VCAMAF,
+	MT6392_ID_VM,
+	MT6392_ID_VIO18,
+	MT6392_ID_VCAMD,
+	MT6392_ID_VCAMIO,
+	MT6392_ID_VM25,
+	MT6392_ID_VEFUSE,
+	MT6392_ID_RG_MAX,
+};
+
+#define MT6392_MAX_REGULATOR	MT6392_ID_RG_MAX
+
+#endif /* __LINUX_REGULATOR_MT6392_H */
-- 
2.43.0

