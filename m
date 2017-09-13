From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v7 2/8] mfd: wm97xx-core: core support for
	wm97xx Codec
Date: Wed, 13 Sep 2017 21:37:17 +0200
Message-ID: <20170913193723.16234-3-robert.jarzmik@free.fr>
References: <20170913193723.16234-1-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170913193723.16234-1-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The WM9705, WM9712 and WM9713 are highly integrated codecs, with an
audio codec, DAC and ADC, GPIO unit and a touchscreen interface.

Historically the support was spread across drivers/input/touchscreen and
sound/soc/codecs. The sharing was done through ac97 bus sharing. This
model will not withstand the new AC97 bus model, where codecs are
discovered on runtime.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
Since v3:
 - added a "depends on AC97_BUS_NEW" Kconfig statement
 - added default values for wm9705, wm9712 per Charles's comment
Since v4:
 - added Charles's ack
Since v5:
 - took into account Lee's comments
Since v6:
 - took into account Lee's comments
---
 drivers/mfd/Kconfig        |  14 ++
 drivers/mfd/Makefile       |   1 +
 drivers/mfd/wm97xx-core.c  | 366 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/wm97xx.h |  25 ++++
 4 files changed, 406 insertions(+)
 create mode 100644 drivers/mfd/wm97xx-core.c
 create mode 100644 include/linux/mfd/wm97xx.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 55ecdfb74d31..6d175698a49a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1628,6 +1628,20 @@ config MFD_WM8994
 	  core support for the WM8994, in order to use the actual
 	  functionaltiy of the device other drivers must be enabled.
 
+config MFD_WM97xx
+	tristate "Wolfson Microelectronics WM97xx"
+	select MFD_CORE
+	select REGMAP_AC97
+	select AC97_BUS_COMPAT
+	depends on AC97_BUS_NEW
+	help
+	  The WM9705, WM9712 and WM9713 is a highly integrated hi-fi CODEC
+	  designed for smartphone applications.  As well as audio functionality
+	  it has on board GPIO and a touchscreen functionality which is
+	  supported via the relevant subsystems.  This driver provides core
+	  support for the WM97xx, in order to use the actual functionaltiy of
+	  the device other drivers must be enabled.
+
 config MFD_STW481X
 	tristate "Support for ST Microelectronics STw481x"
 	depends on I2C && (ARCH_NOMADIK || COMPILE_TEST)
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 31ce07611a6f..902c2e46f310 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_MFD_WM8350)	+= wm8350.o
 obj-$(CONFIG_MFD_WM8350_I2C)	+= wm8350-i2c.o
 wm8994-objs			:= wm8994-core.o wm8994-irq.o wm8994-regmap.o
 obj-$(CONFIG_MFD_WM8994)	+= wm8994.o
+obj-$(CONFIG_MFD_WM97xx)	+= wm97xx-core.o
 
 obj-$(CONFIG_TPS6105X)		+= tps6105x.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
diff --git a/drivers/mfd/wm97xx-core.c b/drivers/mfd/wm97xx-core.c
new file mode 100644
index 000000000000..4141ee52a70b
--- /dev/null
+++ b/drivers/mfd/wm97xx-core.c
@@ -0,0 +1,366 @@
+/*
+ * Wolfson WM97xx -- Core device
+ *
+ * Copyright (C) 2017 Robert Jarzmik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Features:
+ *  - an AC97 audio codec
+ *  - a touchscreen driver
+ *  - a GPIO block
+ */
+
+#include <linux/device.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/wm97xx.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/wm97xx.h>
+#include <sound/ac97/codec.h>
+#include <sound/ac97/compat.h>
+
+#define WM9705_VENDOR_ID 0x574d4c05
+#define WM9712_VENDOR_ID 0x574d4c12
+#define WM9713_VENDOR_ID 0x574d4c13
+#define WM97xx_VENDOR_ID_MASK 0xffffffff
+
+struct wm97xx_priv {
+	struct regmap *regmap;
+	struct snd_ac97 *ac97;
+	struct device *dev;
+	struct wm97xx_platform_data codec_pdata;
+};
+
+static bool wm97xx_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AC97_RESET ... AC97_PCM_SURR_DAC_RATE:
+	case AC97_PCM_LR_ADC_RATE:
+	case AC97_CENTER_LFE_MASTER:
+	case AC97_SPDIF ... AC97_LINE1_LEVEL:
+	case AC97_GPIO_CFG ... 0x5c:
+	case AC97_CODEC_CLASS_REV ... AC97_PCI_SID:
+	case 0x74 ... AC97_VENDOR_ID2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool wm97xx_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AC97_VENDOR_ID1:
+	case AC97_VENDOR_ID2:
+		return false;
+	default:
+		return wm97xx_readable_reg(dev, reg);
+	}
+}
+
+static const struct reg_default wm9705_reg_defaults[] = {
+	{ 0x02, 0x8000 },
+	{ 0x04, 0x8000 },
+	{ 0x06, 0x8000 },
+	{ 0x0a, 0x8000 },
+	{ 0x0c, 0x8008 },
+	{ 0x0e, 0x8008 },
+	{ 0x10, 0x8808 },
+	{ 0x12, 0x8808 },
+	{ 0x14, 0x8808 },
+	{ 0x16, 0x8808 },
+	{ 0x18, 0x8808 },
+	{ 0x1a, 0x0000 },
+	{ 0x1c, 0x8000 },
+	{ 0x20, 0x0000 },
+	{ 0x22, 0x0000 },
+	{ 0x26, 0x000f },
+	{ 0x28, 0x0605 },
+	{ 0x2a, 0x0000 },
+	{ 0x2c, 0xbb80 },
+	{ 0x32, 0xbb80 },
+	{ 0x34, 0x2000 },
+	{ 0x5a, 0x0000 },
+	{ 0x5c, 0x0000 },
+	{ 0x72, 0x0808 },
+	{ 0x74, 0x0000 },
+	{ 0x76, 0x0006 },
+	{ 0x78, 0x0000 },
+	{ 0x7a, 0x0000 },
+};
+
+static const struct regmap_config wm9705_regmap_config = {
+	.reg_bits = 16,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.max_register = 0x7e,
+	.cache_type = REGCACHE_RBTREE,
+
+	.reg_defaults = wm9705_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm9705_reg_defaults),
+	.volatile_reg = regmap_ac97_default_volatile,
+	.readable_reg = wm97xx_readable_reg,
+	.writeable_reg = wm97xx_writeable_reg,
+};
+
+static struct mfd_cell wm9705_cells[] = {
+	{ .name = "wm9705-codec", },
+	{ .name = "wm97xx-ts", },
+};
+
+static bool wm9712_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AC97_REC_GAIN:
+		return true;
+	default:
+		return regmap_ac97_default_volatile(dev, reg);
+	}
+}
+
+static const struct reg_default wm9712_reg_defaults[] = {
+	{ 0x02, 0x8000 },
+	{ 0x04, 0x8000 },
+	{ 0x06, 0x8000 },
+	{ 0x08, 0x0f0f },
+	{ 0x0a, 0xaaa0 },
+	{ 0x0c, 0xc008 },
+	{ 0x0e, 0x6808 },
+	{ 0x10, 0xe808 },
+	{ 0x12, 0xaaa0 },
+	{ 0x14, 0xad00 },
+	{ 0x16, 0x8000 },
+	{ 0x18, 0xe808 },
+	{ 0x1a, 0x3000 },
+	{ 0x1c, 0x8000 },
+	{ 0x20, 0x0000 },
+	{ 0x22, 0x0000 },
+	{ 0x26, 0x000f },
+	{ 0x28, 0x0605 },
+	{ 0x2a, 0x0410 },
+	{ 0x2c, 0xbb80 },
+	{ 0x2e, 0xbb80 },
+	{ 0x32, 0xbb80 },
+	{ 0x34, 0x2000 },
+	{ 0x4c, 0xf83e },
+	{ 0x4e, 0xffff },
+	{ 0x50, 0x0000 },
+	{ 0x52, 0x0000 },
+	{ 0x56, 0xf83e },
+	{ 0x58, 0x0008 },
+	{ 0x5c, 0x0000 },
+	{ 0x60, 0xb032 },
+	{ 0x62, 0x3e00 },
+	{ 0x64, 0x0000 },
+	{ 0x76, 0x0006 },
+	{ 0x78, 0x0001 },
+	{ 0x7a, 0x0000 },
+};
+
+static const struct regmap_config wm9712_regmap_config = {
+	.reg_bits = 16,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.max_register = 0x7e,
+	.cache_type = REGCACHE_RBTREE,
+
+	.reg_defaults = wm9712_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm9712_reg_defaults),
+	.volatile_reg = wm9712_volatile_reg,
+	.readable_reg = wm97xx_readable_reg,
+	.writeable_reg = wm97xx_writeable_reg,
+};
+
+static struct mfd_cell wm9712_cells[] = {
+	{ .name = "wm9712-codec", },
+	{ .name = "wm97xx-ts", },
+};
+
+static const struct reg_default wm9713_reg_defaults[] = {
+	{ 0x02, 0x8080 },	/* Speaker Output Volume */
+	{ 0x04, 0x8080 },	/* Headphone Output Volume */
+	{ 0x06, 0x8080 },	/* Out3/OUT4 Volume */
+	{ 0x08, 0xc880 },	/* Mono Volume */
+	{ 0x0a, 0xe808 },	/* LINEIN Volume */
+	{ 0x0c, 0xe808 },	/* DAC PGA Volume */
+	{ 0x0e, 0x0808 },	/* MIC PGA Volume */
+	{ 0x10, 0x00da },	/* MIC Routing Control */
+	{ 0x12, 0x8000 },	/* Record PGA Volume */
+	{ 0x14, 0xd600 },	/* Record Routing */
+	{ 0x16, 0xaaa0 },	/* PCBEEP Volume */
+	{ 0x18, 0xaaa0 },	/* VxDAC Volume */
+	{ 0x1a, 0xaaa0 },	/* AUXDAC Volume */
+	{ 0x1c, 0x0000 },	/* Output PGA Mux */
+	{ 0x1e, 0x0000 },	/* DAC 3D control */
+	{ 0x20, 0x0f0f },	/* DAC Tone Control*/
+	{ 0x22, 0x0040 },	/* MIC Input Select & Bias */
+	{ 0x24, 0x0000 },	/* Output Volume Mapping & Jack */
+	{ 0x26, 0x7f00 },	/* Powerdown Ctrl/Stat*/
+	{ 0x28, 0x0405 },	/* Extended Audio ID */
+	{ 0x2a, 0x0410 },	/* Extended Audio Start/Ctrl */
+	{ 0x2c, 0xbb80 },	/* Audio DACs Sample Rate */
+	{ 0x2e, 0xbb80 },	/* AUXDAC Sample Rate */
+	{ 0x32, 0xbb80 },	/* Audio ADCs Sample Rate */
+	{ 0x36, 0x4523 },	/* PCM codec control */
+	{ 0x3a, 0x2000 },	/* SPDIF control */
+	{ 0x3c, 0xfdff },	/* Powerdown 1 */
+	{ 0x3e, 0xffff },	/* Powerdown 2 */
+	{ 0x40, 0x0000 },	/* General Purpose */
+	{ 0x42, 0x0000 },	/* Fast Power-Up Control */
+	{ 0x44, 0x0080 },	/* MCLK/PLL Control */
+	{ 0x46, 0x0000 },	/* MCLK/PLL Control */
+
+	{ 0x4c, 0xfffe },	/* GPIO Pin Configuration */
+	{ 0x4e, 0xffff },	/* GPIO Pin Polarity / Type */
+	{ 0x50, 0x0000 },	/* GPIO Pin Sticky */
+	{ 0x52, 0x0000 },	/* GPIO Pin Wake-Up */
+				/* GPIO Pin Status */
+	{ 0x56, 0xfffe },	/* GPIO Pin Sharing */
+	{ 0x58, 0x4000 },	/* GPIO PullUp/PullDown */
+	{ 0x5a, 0x0000 },	/* Additional Functions 1 */
+	{ 0x5c, 0x0000 },	/* Additional Functions 2 */
+	{ 0x60, 0xb032 },	/* ALC Control */
+	{ 0x62, 0x3e00 },	/* ALC / Noise Gate Control */
+	{ 0x64, 0x0000 },	/* AUXDAC input control */
+	{ 0x74, 0x0000 },	/* Digitiser Reg 1 */
+	{ 0x76, 0x0006 },	/* Digitiser Reg 2 */
+	{ 0x78, 0x0001 },	/* Digitiser Reg 3 */
+	{ 0x7a, 0x0000 },	/* Digitiser Read Back */
+};
+
+static const struct regmap_config wm9713_regmap_config = {
+	.reg_bits = 16,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.max_register = 0x7e,
+	.cache_type = REGCACHE_RBTREE,
+
+	.reg_defaults = wm9713_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm9713_reg_defaults),
+	.volatile_reg = regmap_ac97_default_volatile,
+	.readable_reg = wm97xx_readable_reg,
+	.writeable_reg = wm97xx_writeable_reg,
+};
+
+static struct mfd_cell wm9713_cells[] = {
+	{ .name = "wm9713-codec", },
+	{ .name = "wm97xx-ts", },
+};
+
+static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
+{
+	struct wm97xx_priv *wm97xx;
+	const struct regmap_config *config;
+	struct wm97xx_platform_data *codec_pdata;
+	struct mfd_cell *cells;
+	int ret = -ENODEV, nb_cells, i;
+	struct wm97xx_pdata *pdata = snd_ac97_codec_get_platdata(adev);
+
+	wm97xx = devm_kzalloc(ac97_codec_dev2dev(adev),
+			      sizeof(*wm97xx), GFP_KERNEL);
+	if (!wm97xx)
+		return -ENOMEM;
+
+	wm97xx->dev = ac97_codec_dev2dev(adev);
+	wm97xx->ac97 = snd_ac97_compat_alloc(adev);
+	if (IS_ERR(wm97xx->ac97))
+		return PTR_ERR(wm97xx->ac97);
+
+
+	ac97_set_drvdata(adev, wm97xx);
+	dev_info(wm97xx->dev, "wm97xx core found, id=0x%x\n",
+		 adev->vendor_id);
+
+	codec_pdata = &wm97xx->codec_pdata;
+	codec_pdata->ac97 = wm97xx->ac97;
+	codec_pdata->batt_pdata = pdata->batt_pdata;
+
+	switch (adev->vendor_id) {
+	case WM9705_VENDOR_ID:
+		config = &wm9705_regmap_config;
+		cells = wm9705_cells;
+		nb_cells = ARRAY_SIZE(wm9705_cells);
+		break;
+	case WM9712_VENDOR_ID:
+		config = &wm9712_regmap_config;
+		cells = wm9712_cells;
+		nb_cells = ARRAY_SIZE(wm9712_cells);
+		break;
+	case WM9713_VENDOR_ID:
+		config = &wm9713_regmap_config;
+		cells = wm9713_cells;
+		nb_cells = ARRAY_SIZE(wm9713_cells);
+		break;
+	default:
+		goto err_free_compat;
+	}
+
+	for (i = 0; i < nb_cells; i++) {
+		cells[i].platform_data = codec_pdata;
+		cells[i].pdata_size = sizeof(*codec_pdata);
+	}
+
+	codec_pdata->regmap = devm_regmap_init_ac97(wm97xx->ac97, config);
+	if (IS_ERR(codec_pdata->regmap)) {
+		ret = PTR_ERR(codec_pdata->regmap);
+		goto err_free_compat;
+	}
+
+	ret = devm_mfd_add_devices(wm97xx->dev, PLATFORM_DEVID_NONE,
+				   cells, nb_cells, NULL, 0, NULL);
+	if (ret)
+		goto err_free_compat;
+
+	return ret;
+
+err_free_compat:
+	snd_ac97_compat_release(wm97xx->ac97);
+	return ret;
+}
+
+static int wm97xx_ac97_remove(struct ac97_codec_device *adev)
+{
+	struct wm97xx_priv *wm97xx = ac97_get_drvdata(adev);
+
+	snd_ac97_compat_release(wm97xx->ac97);
+
+	return 0;
+}
+
+static const struct ac97_id wm97xx_ac97_ids[] = {
+	{ .id = WM9705_VENDOR_ID, .mask = WM97xx_VENDOR_ID_MASK },
+	{ .id = WM9712_VENDOR_ID, .mask = WM97xx_VENDOR_ID_MASK },
+	{ .id = WM9713_VENDOR_ID, .mask = WM97xx_VENDOR_ID_MASK },
+	{ }
+};
+
+static struct ac97_codec_driver wm97xx_ac97_driver = {
+	.driver = {
+		.name = "wm97xx-core",
+	},
+	.probe		= wm97xx_ac97_probe,
+	.remove		= wm97xx_ac97_remove,
+	.id_table	= wm97xx_ac97_ids,
+};
+
+static int __init wm97xx_module_init(void)
+{
+	return snd_ac97_codec_driver_register(&wm97xx_ac97_driver);
+}
+module_init(wm97xx_module_init);
+
+static void __exit wm97xx_module_exit(void)
+{
+	snd_ac97_codec_driver_unregister(&wm97xx_ac97_driver);
+}
+module_exit(wm97xx_module_exit);
+
+MODULE_DESCRIPTION("WM9712, WM9713 core driver");
+MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
+MODULE_LICENSE("GPL");
+
diff --git a/include/linux/mfd/wm97xx.h b/include/linux/mfd/wm97xx.h
new file mode 100644
index 000000000000..45fb54f19d09
--- /dev/null
+++ b/include/linux/mfd/wm97xx.h
@@ -0,0 +1,25 @@
+/*
+ * wm97xx client interface
+ *
+ * Copyright (C) 2017 Robert Jarzmik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_MFD_WM97XX_H
+#define __LINUX_MFD_WM97XX_H
+
+struct regmap;
+struct wm97xx_batt_pdata;
+struct snd_ac97;
+
+struct wm97xx_platform_data {
+	struct snd_ac97 *ac97;
+	struct regmap *regmap;
+	struct wm97xx_batt_pdata *batt_pdata;
+};
+
+#endif
-- 
2.11.0
