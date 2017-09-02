From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v6 00/12] AC97 device/driver model revamp
Date: Sat,  2 Sep 2017 21:54:02 +0200
Message-ID: <20170902195414.3699-1-robert.jarzmik@free.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:24635 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752739AbdIBTy3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 2 Sep 2017 15:54:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

Hi Lars, Mark, Charles, Lee,

This is a revision for Lee, only targetted at wm97xx-core changes suggested by
Lee. I hope I have every concern covered Lee, just le me know if it suits you.

For easier spotting, I included in [1] the diff from the last serie.

I kept Charles ack for patch 6/12 following Lee's review, if you don't agree
Charles, I'll remove it.

Cheers.

--
Robert

Robert Jarzmik (12):
  ALSA: ac97: split out the generic ac97 registers
  ALSA: ac97: add an ac97 bus
  ASoC: add new ac97 bus support
  ASoC: arm: make pxa2xx-ac97-lib ac97 codec agnostic
  Input: wm97xx: split out touchscreen registering
  mfd: wm97xx-core: core support for wm97xx Codec
  Input: wm97xx: add new AC97 bus support
  ASoC: wm9713: add ac97 new bus support
  ASoC: wm9712: add ac97 new bus support
  ASoC: wm9705: add private structure
  ASoC: wm9705: add ac97 new bus support
  ASoC: pxa: switch to new ac97 bus support

 drivers/input/touchscreen/Kconfig       |   2 +-
 drivers/input/touchscreen/wm97xx-core.c | 252 ++++++++++-----
 drivers/mfd/Kconfig                     |  14 +
 drivers/mfd/Makefile                    |   1 +
 drivers/mfd/wm97xx-core.c               | 379 ++++++++++++++++++++++
 include/linux/mfd/wm97xx.h              |  25 ++
 include/sound/ac97/codec.h              | 118 +++++++
 include/sound/ac97/compat.h             |  20 ++
 include/sound/ac97/controller.h         |  85 +++++
 include/sound/ac97/regs.h               | 262 ++++++++++++++++
 include/sound/ac97_codec.h              | 239 +-------------
 include/sound/pxa2xx-lib.h              |  15 +-
 sound/Kconfig                           |   2 +
 sound/Makefile                          |   1 +
 sound/ac97/Kconfig                      |  19 ++
 sound/ac97/Makefile                     |   8 +
 sound/ac97/ac97_core.h                  |  16 +
 sound/ac97/bus.c                        | 539 ++++++++++++++++++++++++++++++++
 sound/ac97/codec.c                      |  15 +
 sound/ac97/snd_ac97_compat.c            | 108 +++++++
 sound/arm/Kconfig                       |   1 -
 sound/arm/pxa2xx-ac97-lib.c             |  37 ++-
 sound/arm/pxa2xx-ac97.c                 |  35 ++-
 sound/soc/codecs/Kconfig                |   9 +-
 sound/soc/codecs/wm9705.c               |  61 ++--
 sound/soc/codecs/wm9712.c               |  39 ++-
 sound/soc/codecs/wm9713.c               |  39 ++-
 sound/soc/pxa/Kconfig                   |   5 +-
 sound/soc/pxa/pxa2xx-ac97.c             |  46 ++-
 29 files changed, 1978 insertions(+), 414 deletions(-)
 create mode 100644 drivers/mfd/wm97xx-core.c
 create mode 100644 include/linux/mfd/wm97xx.h
 create mode 100644 include/sound/ac97/codec.h
 create mode 100644 include/sound/ac97/compat.h
 create mode 100644 include/sound/ac97/controller.h
 create mode 100644 include/sound/ac97/regs.h
 create mode 100644 sound/ac97/Kconfig
 create mode 100644 sound/ac97/Makefile
 create mode 100644 sound/ac97/ac97_core.h
 create mode 100644 sound/ac97/bus.c
 create mode 100644 sound/ac97/codec.c
 create mode 100644 sound/ac97/snd_ac97_compat.c

-- 
2.11.0

[1] Diff from the previous serie
---8>---
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5ffe4f4dfa10..6d175698a49a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1635,7 +1635,6 @@ config MFD_WM97xx
 	select AC97_BUS_COMPAT
 	depends on AC97_BUS_NEW
 	help
-
 	  The WM9705, WM9712 and WM9713 is a highly integrated hi-fi CODEC
 	  designed for smartphone applications.  As well as audio functionality
 	  it has on board GPIO and a touchscreen functionality which is
diff --git a/drivers/mfd/wm97xx-core.c b/drivers/mfd/wm97xx-core.c
index 473bbf9510e5..66e477fffd43 100644
--- a/drivers/mfd/wm97xx-core.c
+++ b/drivers/mfd/wm97xx-core.c
@@ -1,7 +1,7 @@
 /*
  * Wolfson WM97xx -- Core device
  *
- * Copyright (C) 2016 Robert Jarzmik
+ * Copyright (C) 2017 Robert Jarzmik
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -14,14 +14,13 @@
  *  - a GPIO block
  */
 
-#include <linux/module.h>
-
 #include <linux/device.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/wm97xx.h>
-#include <linux/wm97xx.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/wm97xx.h>
 #include <sound/ac97/codec.h>
 #include <sound/ac97/compat.h>
 
@@ -34,6 +33,7 @@ struct wm97xx_priv {
 	struct regmap *regmap;
 	struct snd_ac97 *ac97;
 	struct device *dev;
+	struct wm97xx_platform_data codec_pdata;
 };
 
 static bool wm97xx_readable_reg(struct device *dev, unsigned int reg)
@@ -108,33 +108,14 @@ static const struct regmap_config wm9705_regmap_config = {
 	.writeable_reg = wm97xx_writeable_reg,
 };
 
-static int wm9705_register(struct wm97xx_priv *wm97xx,
-			   struct wm97xx_pdata *pdata)
-{
-	static struct wm97xx_platform_data codec_pdata;
-	static const struct mfd_cell cells[] = {
-		{
-			.name = "wm9705-codec",
-			.platform_data = &codec_pdata,
-			.pdata_size = sizeof(codec_pdata),
-		},
-		{
-			.name = "wm97xx-ts",
-			.platform_data = &codec_pdata,
-			.pdata_size = sizeof(codec_pdata),
-		},
-	};
-
-	codec_pdata.ac97 = wm97xx->ac97;
-	codec_pdata.regmap = devm_regmap_init_ac97(wm97xx->ac97,
-						   &wm9705_regmap_config);
-	codec_pdata.batt_pdata = pdata->batt_pdata;
-	if (IS_ERR(codec_pdata.regmap))
-		return PTR_ERR(codec_pdata.regmap);
-
-	return devm_mfd_add_devices(wm97xx->dev, PLATFORM_DEVID_NONE, cells,
-				    ARRAY_SIZE(cells), NULL, 0, NULL);
-}
+static struct mfd_cell wm9705_cells[] = {
+	{
+		.name = "wm9705-codec",
+	},
+	{
+		.name = "wm97xx-ts",
+	},
+};
 
 static bool wm9712_volatile_reg(struct device *dev, unsigned int reg)
 {
@@ -199,33 +180,14 @@ static const struct regmap_config wm9712_regmap_config = {
 	.writeable_reg = wm97xx_writeable_reg,
 };
 
-static int wm9712_register(struct wm97xx_priv *wm97xx,
-			   struct wm97xx_pdata *pdata)
-{
-	static struct wm97xx_platform_data codec_pdata;
-	static const struct mfd_cell cells[] = {
-		{
-			.name = "wm9712-codec",
-			.platform_data = &codec_pdata,
-			.pdata_size = sizeof(codec_pdata),
-		},
-		{
-			.name = "wm97xx-ts",
-			.platform_data = &codec_pdata,
-			.pdata_size = sizeof(codec_pdata),
-		},
-	};
-
-	codec_pdata.ac97 = wm97xx->ac97;
-	codec_pdata.regmap = devm_regmap_init_ac97(wm97xx->ac97,
-						   &wm9712_regmap_config);
-	codec_pdata.batt_pdata = pdata->batt_pdata;
-	if (IS_ERR(codec_pdata.regmap))
-		return PTR_ERR(codec_pdata.regmap);
-
-	return devm_mfd_add_devices(wm97xx->dev, PLATFORM_DEVID_NONE, cells,
-				    ARRAY_SIZE(cells), NULL, 0, NULL);
-}
+static struct mfd_cell wm9712_cells[] = {
+	{
+		.name = "wm9712-codec",
+	},
+	{
+		.name = "wm97xx-ts",
+	},
+};
 
 static const struct reg_default wm9713_reg_defaults[] = {
 	{ 0x02, 0x8080 },	/* Speaker Output Volume */
@@ -293,39 +255,23 @@ static const struct regmap_config wm9713_regmap_config = {
 	.writeable_reg = wm97xx_writeable_reg,
 };
 
-static int wm9713_register(struct wm97xx_priv *wm97xx,
-			   struct wm97xx_pdata *pdata)
-{
-	static struct wm97xx_platform_data codec_pdata;
-	static const struct mfd_cell cells[] = {
-		{
-			.name = "wm9713-codec",
-			.platform_data = &codec_pdata,
-			.pdata_size = sizeof(codec_pdata),
-		},
-		{
-			.name = "wm97xx-ts",
-			.platform_data = &codec_pdata,
-			.pdata_size = sizeof(codec_pdata),
-		},
-	};
-
-	codec_pdata.ac97 = wm97xx->ac97;
-	codec_pdata.regmap = devm_regmap_init_ac97(wm97xx->ac97,
-						   &wm9713_regmap_config);
-	codec_pdata.batt_pdata = pdata->batt_pdata;
-	if (IS_ERR(codec_pdata.regmap))
-		return PTR_ERR(codec_pdata.regmap);
-
-	return devm_mfd_add_devices(wm97xx->dev, PLATFORM_DEVID_NONE, cells,
-				    ARRAY_SIZE(cells), NULL, 0, NULL);
-}
+static struct mfd_cell wm9713_cells[] = {
+	{
+		.name = "wm9713-codec",
+	},
+	{
+		.name = "wm97xx-ts",
+	},
+};
 
 static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
 {
 	struct wm97xx_priv *wm97xx;
-	int ret;
-	void *pdata = snd_ac97_codec_get_platdata(adev);
+	const struct regmap_config *config;
+	struct wm97xx_platform_data *codec_pdata;
+	struct mfd_cell *cells;
+	int ret = 0, nb_cells, i;
+	struct wm97xx_pdata *pdata = snd_ac97_codec_get_platdata(adev);
 
 	wm97xx = devm_kzalloc(ac97_codec_dev2dev(adev),
 			      sizeof(*wm97xx), GFP_KERNEL);
@@ -342,20 +288,48 @@ static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
 	dev_info(wm97xx->dev, "wm97xx core found, id=0x%x\n",
 		 adev->vendor_id);
 
+	codec_pdata = &wm97xx->codec_pdata;
+	codec_pdata->ac97 = wm97xx->ac97;
+	codec_pdata->batt_pdata = pdata->batt_pdata;
+
 	switch (adev->vendor_id) {
 	case WM9705_VENDOR_ID:
-		ret = wm9705_register(wm97xx, pdata);
+		config = &wm9705_regmap_config;
+		cells = wm9705_cells;
+		nb_cells = ARRAY_SIZE(wm9705_cells);
 		break;
 	case WM9712_VENDOR_ID:
-		ret = wm9712_register(wm97xx, pdata);
+		config = &wm9712_regmap_config;
+		cells = wm9712_cells;
+		nb_cells = ARRAY_SIZE(wm9712_cells);
 		break;
 	case WM9713_VENDOR_ID:
-		ret = wm9713_register(wm97xx, pdata);
+		config = &wm9713_regmap_config;
+		cells = wm9713_cells;
+		nb_cells = ARRAY_SIZE(wm9713_cells);
 		break;
 	default:
+		config = NULL;
+	}
+
+	for (i = 0; i < nb_cells; i++) {
+		cells[i].platform_data = codec_pdata;
+		cells[i].pdata_size = sizeof(*codec_pdata);
+	}
+
+	if (config) {
+		codec_pdata->regmap =
+			devm_regmap_init_ac97(wm97xx->ac97, config);
+		if (IS_ERR(codec_pdata->regmap))
+			ret = PTR_ERR(codec_pdata->regmap);
+	} else {
 		ret = -ENODEV;
 	}
 
+	if (!ret)
+		ret = devm_mfd_add_devices(wm97xx->dev, PLATFORM_DEVID_NONE,
+					   cells, nb_cells, NULL, 0, NULL);
+
 	if (ret)
 		snd_ac97_compat_release(wm97xx->ac97);
 
diff --git a/include/linux/mfd/wm97xx.h b/include/linux/mfd/wm97xx.h
index 627322f14d48..45fb54f19d09 100644
--- a/include/linux/mfd/wm97xx.h
+++ b/include/linux/mfd/wm97xx.h
@@ -1,17 +1,12 @@
 /*
  * wm97xx client interface
  *
- * Copyright (C) 2016 Robert Jarzmik
+ * Copyright (C) 2017 Robert Jarzmik
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __LINUX_MFD_WM97XX_H
@@ -27,5 +22,4 @@ struct wm97xx_platform_data {
 	struct wm97xx_batt_pdata *batt_pdata;
 };
 
-
 #endif
