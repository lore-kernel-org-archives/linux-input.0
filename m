From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] Input - arizona-haptics: Add driver haptics module on Arizona CODECs
Date: Tue, 27 Nov 2012 07:08:06 +0000
Message-ID: <1354000088-30517-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1354000088-30517-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56265 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755574Ab2K0HIU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 02:08:20 -0500
In-Reply-To: <1354000088-30517-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

The Arizona CODECs contain a haptics module providing vibration feedback
support. Implement basic support for this, providing simple start/stop and
signal magnitude control.

Since the output path for haptics is routed through the CODEC audio routing
it is modelled as a signal generator within ASoC, the haptics driver calls
DAPM to start and stop the output drivers. An appropriate output path must
be configured via ALSA to connect the haptics source to the correct output.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/misc/Kconfig           |   10 ++
 drivers/input/misc/Makefile          |    1 +
 drivers/input/misc/arizona-haptics.c |  255 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/arizona/pdata.h    |    6 +
 4 files changed, 272 insertions(+)
 create mode 100644 drivers/input/misc/arizona-haptics.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 2a1647e..259ef31 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -72,6 +72,16 @@ config INPUT_AD714X_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad714x-spi.
 
+config INPUT_ARIZONA_HAPTICS
+	tristate "Arizona haptics support"
+	depends on MFD_ARIZONA && SND_SOC
+	select INPUT_FF_MEMLESS
+	help
+	  Say Y to enable support for the haptics module in Arizona CODECs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called arizona-haptics.
+
 config INPUT_BMA150
 	tristate "BMA150/SMB380 acceleration sensor support"
 	depends on I2C
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 1f874af..1f1e1b1 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_INPUT_ADXL34X)		+= adxl34x.o
 obj-$(CONFIG_INPUT_ADXL34X_I2C)		+= adxl34x-i2c.o
 obj-$(CONFIG_INPUT_ADXL34X_SPI)		+= adxl34x-spi.o
 obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
+obj-$(CONFIG_INPUT_ARIZONA_HAPTICS)	+= arizona-haptics.o
 obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
 obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
 obj-$(CONFIG_INPUT_BFIN_ROTARY)		+= bfin_rotary.o
diff --git a/drivers/input/misc/arizona-haptics.c b/drivers/input/misc/arizona-haptics.c
new file mode 100644
index 0000000..4ecff75
--- /dev/null
+++ b/drivers/input/misc/arizona-haptics.c
@@ -0,0 +1,255 @@
+/*
+ * Arizona haptics driver
+ *
+ * Copyright 2012 Wolfson Microelectronics plc
+ *
+ * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <linux/mfd/arizona/core.h>
+#include <linux/mfd/arizona/pdata.h>
+#include <linux/mfd/arizona/registers.h>
+
+struct arizona_haptics {
+	struct arizona *arizona;
+	struct input_dev *input_dev;
+	struct work_struct work;
+
+	struct mutex mutex;
+	u8 intensity;
+};
+
+static void arizona_haptics_work(struct work_struct *work)
+{
+	struct arizona_haptics *haptics = container_of(work,
+						       struct arizona_haptics,
+						       work);
+	struct arizona *arizona = haptics->arizona;
+	struct mutex *dapm_mutex = &arizona->dapm->card->dapm_mutex;
+	int ret;
+
+	if (!haptics->arizona->dapm) {
+		dev_err(arizona->dev, "No DAPM context\n");
+		return;
+	}
+
+	if (haptics->intensity) {
+		ret = regmap_update_bits(arizona->regmap,
+					 ARIZONA_HAPTICS_PHASE_2_INTENSITY,
+					 ARIZONA_PHASE2_INTENSITY_MASK,
+					 haptics->intensity);
+		if (ret != 0) {
+			dev_err(arizona->dev, "Failed to set intensity: %d\n",
+				ret);
+			return;
+		}
+
+		/* This enable sequence will be a noop if already enabled */
+		ret = regmap_update_bits(arizona->regmap,
+					 ARIZONA_HAPTICS_CONTROL_1,
+					 ARIZONA_HAP_CTRL_MASK,
+					 1 << ARIZONA_HAP_CTRL_SHIFT);
+		if (ret != 0) {
+			dev_err(arizona->dev, "Failed to start haptics: %d\n",
+				ret);
+			return;
+		}
+
+		mutex_lock_nested(dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+
+		ret = snd_soc_dapm_enable_pin(arizona->dapm, "HAPTICS");
+		if (ret != 0) {
+			dev_err(arizona->dev, "Failed to start HAPTICS: %d\n",
+				ret);
+			mutex_unlock(dapm_mutex);
+			return;
+		}
+
+		ret = snd_soc_dapm_sync(arizona->dapm);
+		if (ret != 0) {
+			dev_err(arizona->dev, "Failed to sync DAPM: %d\n",
+				ret);
+			mutex_unlock(dapm_mutex);
+			return;
+		}
+
+		mutex_unlock(dapm_mutex);
+
+	} else {
+		/* This disable sequence will be a noop if already enabled */
+		mutex_lock_nested(dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+
+		ret = snd_soc_dapm_disable_pin(arizona->dapm, "HAPTICS");
+		if (ret != 0) {
+			dev_err(arizona->dev, "Failed to disable HAPTICS: %d\n",
+				ret);
+			mutex_unlock(dapm_mutex);
+			return;
+		}
+
+		ret = snd_soc_dapm_sync(arizona->dapm);
+		if (ret != 0) {
+			dev_err(arizona->dev, "Failed to sync DAPM: %d\n",
+				ret);
+			mutex_unlock(dapm_mutex);
+			return;
+		}
+
+		mutex_unlock(dapm_mutex);
+
+		ret = regmap_update_bits(arizona->regmap,
+					 ARIZONA_HAPTICS_CONTROL_1,
+					 ARIZONA_HAP_CTRL_MASK,
+					 1 << ARIZONA_HAP_CTRL_SHIFT);
+		if (ret != 0) {
+			dev_err(arizona->dev, "Failed to stop haptics: %d\n",
+				ret);
+			return;
+		}
+	}
+}
+
+static int arizona_haptics_play(struct input_dev *input, void *data,
+				struct ff_effect *effect)
+{
+	struct arizona_haptics *haptics = input_get_drvdata(input);
+	struct arizona *arizona = haptics->arizona;
+
+	if (!arizona->dapm) {
+		dev_err(arizona->dev, "No DAPM context\n");
+		return -EBUSY;
+	}
+
+	if (effect->u.rumble.strong_magnitude) {
+		/* Scale the magnitude into the range the device supports */
+		if (arizona->pdata.hap_act) {
+			haptics->intensity = effect->u.rumble.strong_magnitude
+				>> 9;
+			if (effect->direction < 0x8000)
+				haptics->intensity += 0x7f;
+		} else {
+			haptics->intensity = effect->u.rumble.strong_magnitude
+				>> 8;
+		}
+	} else {
+		haptics->intensity = 0;
+	}
+
+	schedule_work(&haptics->work);
+
+	return 0;
+}
+
+static void arizona_haptics_close(struct input_dev *input)
+{
+	struct arizona_haptics *haptics = input_get_drvdata(input);
+	struct mutex *dapm_mutex = &haptics->arizona->dapm->card->dapm_mutex;
+
+	cancel_work_sync(&haptics->work);
+
+	mutex_lock_nested(dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+
+	if (haptics->arizona->dapm)
+		snd_soc_dapm_disable_pin(haptics->arizona->dapm, "HAPTICS");
+
+	mutex_unlock(dapm_mutex);
+}
+
+static int arizona_haptics_probe(struct platform_device *pdev)
+{
+	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
+	struct arizona_haptics *haptics;
+	int ret;
+
+	haptics = kzalloc(sizeof(*haptics), GFP_KERNEL);
+	if (!haptics)
+		return -ENOMEM;
+
+	haptics->arizona = arizona;
+
+	ret = regmap_update_bits(arizona->regmap, ARIZONA_HAPTICS_CONTROL_1,
+				 ARIZONA_HAP_ACT, arizona->pdata.hap_act);
+	if (ret != 0) {
+		dev_err(arizona->dev, "Failed to set haptics actuator: %d\n",
+			ret);
+		return ret;
+	}
+
+	INIT_WORK(&haptics->work, arizona_haptics_work);
+
+	haptics->input_dev = input_allocate_device();
+	if (haptics->input_dev == NULL) {
+		dev_err(arizona->dev, "Failed to allocate input device\n");
+		return -ENOMEM;
+	}
+
+	input_set_drvdata(haptics->input_dev, haptics);
+
+	haptics->input_dev->name = "arizona:haptics";
+	haptics->input_dev->dev.parent = pdev->dev.parent;
+	haptics->input_dev->close = arizona_haptics_close;
+	__set_bit(FF_RUMBLE, haptics->input_dev->ffbit);
+
+	ret = input_ff_create_memless(haptics->input_dev, NULL,
+				      arizona_haptics_play);
+	if (ret < 0) {
+		dev_err(arizona->dev, "input_ff_create_memless() failed: %d\n",
+			ret);
+		goto err_ialloc;
+	}
+
+	ret = input_register_device(haptics->input_dev);
+	if (ret < 0) {
+		dev_err(arizona->dev, "couldn't register input device: %d\n",
+			ret);
+		goto err_iff;
+	}
+
+	platform_set_drvdata(pdev, haptics);
+
+	return 0;
+
+err_iff:
+	if (haptics->input_dev)
+		input_ff_destroy(haptics->input_dev);
+err_ialloc:
+	input_free_device(haptics->input_dev);
+
+	return ret;
+}
+
+static int arizona_haptics_remove(struct platform_device *pdev)
+{
+	struct arizona_haptics *haptics = platform_get_drvdata(pdev);
+
+	input_unregister_device(haptics->input_dev);
+
+	return 0;
+}
+
+static struct platform_driver arizona_haptics_driver = {
+	.probe		= arizona_haptics_probe,
+	.remove		= arizona_haptics_remove,
+	.driver		= {
+		.name	= "arizona-haptics",
+		.owner	= THIS_MODULE,
+	},
+};
+module_platform_driver(arizona_haptics_driver);
+
+MODULE_ALIAS("platform:arizona-haptics");
+MODULE_DESCRIPTION("Arizona haptics driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
index 7ab4429..8b1d1da 100644
--- a/include/linux/mfd/arizona/pdata.h
+++ b/include/linux/mfd/arizona/pdata.h
@@ -62,6 +62,9 @@
 
 #define ARIZONA_MAX_OUTPUT 6
 
+#define ARIZONA_HAP_ACT_ERM 0
+#define ARIZONA_HAP_ACT_LRA 2
+
 #define ARIZONA_MAX_PDM_SPK 2
 
 struct regulator_init_data;
@@ -114,6 +117,9 @@ struct arizona_pdata {
 
 	/** PDM speaker format */
 	unsigned int spk_fmt[ARIZONA_MAX_PDM_SPK];
+
+	/** Haptic actuator type */
+	unsigned int hap_act;
 };
 
 #endif
-- 
1.7.10.4

