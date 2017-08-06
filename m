From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v5 00/12] AC97 device/driver model revamp
Date: Sun,  6 Aug 2017 23:36:01 +0200
Message-ID: <20170806213613.5600-1-robert.jarzmik@free.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:21638 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdHFVgX (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 6 Aug 2017 17:36:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

Hi Lars, Mark, Charles, Lee,

This is a minor revision after v4, mainly reviews from Takashi, Charles.

I extracted the diff from the v3 of sound/ac97 which is in [1] for easier
spotting of what has globally changed. I tentatively kept your Ack Charles for
patch 11/12, please shout if you disagree (there is an #ifdef added).

I would still need a review from you, Lee, for the mfd patch (patch 6/12).

Happy review.

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
 drivers/mfd/Kconfig                     |  15 +
 drivers/mfd/Makefile                    |   1 +
 drivers/mfd/wm97xx-core.c               | 405 ++++++++++++++++++++++++
 include/linux/mfd/wm97xx.h              |  31 ++
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
 29 files changed, 2011 insertions(+), 414 deletions(-)
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

[1] sound diff from last revision
   (git diff submit/ac97-3..submit/ac97-4 sound/ac97 include/sound/ac97)
diff --git a/include/sound/ac97/compat.h b/include/sound/ac97/compat.h
index d876464bf7e4..1351cba40048 100644
--- a/include/sound/ac97/compat.h
+++ b/include/sound/ac97/compat.h
@@ -13,7 +13,6 @@
 #define AC97_COMPAT_H
 
 #include <sound/ac97_codec.h>
-#include <sound/soc.h>
 
 struct snd_ac97 *snd_ac97_compat_alloc(struct ac97_codec_device *adev);
 void snd_ac97_compat_release(struct snd_ac97 *ac97);
diff --git a/include/sound/ac97/controller.h b/include/sound/ac97/controller.h
index 18c699925a85..b36ecdd64f14 100644
--- a/include/sound/ac97/controller.h
+++ b/include/sound/ac97/controller.h
@@ -8,12 +8,13 @@
 #ifndef AC97_CONTROLLER_H
 #define AC97_CONTROLLER_H
 
+#include <linux/device.h>
 #include <linux/list.h>
 
 #define AC97_BUS_MAX_CODECS 4
 #define AC97_SLOTS_AVAILABLE_ALL 0xf
 
-struct device;
+struct ac97_controller_ops;
 
 /**
  * struct ac97_controller - The AC97 controller of the AC-Link
@@ -21,8 +22,8 @@ struct device;
  * @controllers:	linked list of all existing controllers.
  * @adap:		the shell device ac97-%d, ie. ac97 adapter
  * @nr:			the number of the shell device
- * @parent:		the device providing the AC97 controller.
  * @slots_available:	the mask of accessible/scanable codecs.
+ * @parent:		the device providing the AC97 controller.
  * @codecs:		the 4 possible AC97 codecs (NULL if none found).
  * @codecs_pdata:	platform_data for each codec (NULL if no pdata).
  *
@@ -34,8 +35,8 @@ struct ac97_controller {
 	struct list_head controllers;
 	struct device adap;
 	int nr;
-	struct device *parent;
 	unsigned short slots_available;
+	struct device *parent;
 	struct ac97_codec_device *codecs[AC97_BUS_MAX_CODECS];
 	void *codecs_pdata[AC97_BUS_MAX_CODECS];
 };
diff --git a/sound/ac97/ac97_core.h b/sound/ac97/ac97_core.h
index 219fec0d52e0..08441a4fda7c 100644
--- a/sound/ac97/ac97_core.h
+++ b/sound/ac97/ac97_core.h
@@ -8,3 +8,9 @@
 
 unsigned int snd_ac97_bus_scan_one(struct ac97_controller *ac97,
 				   unsigned int codec_num);
+
+static inline bool ac97_ids_match(unsigned int id1, unsigned int id2,
+				  unsigned int mask)
+{
+	return (id1 & mask) == (id2 & mask);
+}
diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index af618a0e89cb..31f858eceffc 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -105,6 +105,7 @@ static int ac97_codec_add(struct ac97_controller *ac97_ctrl, int idx,
 
 	return 0;
 err_free_codec:
+	put_device(&codec->dev);
 	kfree(codec);
 	ac97_ctrl->codecs[idx] = NULL;
 
@@ -171,14 +172,10 @@ static int ac97_bus_reset(struct ac97_controller *ac97_ctrl)
  */
 int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
 {
-	int ret;
-
 	drv->driver.bus = &ac97_bus_type;
-	ret = driver_register(&drv->driver);
-
-	return ret;
+	return driver_register(&drv->driver);
 }
-EXPORT_SYMBOL(snd_ac97_codec_driver_register);
+EXPORT_SYMBOL_GPL(snd_ac97_codec_driver_register);
 
 /**
  * snd_ac97_codec_driver_unregister - unregister an AC97 codec driver
@@ -190,7 +187,7 @@ void snd_ac97_codec_driver_unregister(struct ac97_codec_driver *drv)
 {
 	driver_unregister(&drv->driver);
 }
-EXPORT_SYMBOL(snd_ac97_codec_driver_unregister);
+EXPORT_SYMBOL_GPL(snd_ac97_codec_driver_unregister);
 
 /**
  * snd_ac97_codec_get_platdata - get platform_data
@@ -208,7 +205,7 @@ void *snd_ac97_codec_get_platdata(const struct ac97_codec_device *adev)
 
 	return ac97_ctrl->codecs_pdata[adev->num];
 }
-EXPORT_SYMBOL(snd_ac97_codec_get_platdata);
+EXPORT_SYMBOL_GPL(snd_ac97_codec_get_platdata);
 
 static void ac97_ctrl_codecs_unregister(struct ac97_controller *ac97_ctrl)
 {
@@ -359,7 +356,7 @@ struct ac97_controller *snd_ac97_controller_register(
 	kfree(ac97_ctrl);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL(snd_ac97_controller_register);
+EXPORT_SYMBOL_GPL(snd_ac97_controller_register);
 
 /**
  * snd_ac97_controller_unregister - unregister an ac97 controller
@@ -370,7 +367,7 @@ void snd_ac97_controller_unregister(struct ac97_controller *ac97_ctrl)
 {
 	ac97_del_adapter(ac97_ctrl);
 }
-EXPORT_SYMBOL(snd_ac97_controller_unregister);
+EXPORT_SYMBOL_GPL(snd_ac97_controller_unregister);
 
 #ifdef CONFIG_PM
 static int ac97_pm_runtime_suspend(struct device *dev)
@@ -466,7 +463,7 @@ static int ac97_bus_match(struct device *dev, struct device_driver *drv)
 		return false;
 
 	do {
-		if ((id[i].id & id->mask) == (adev->vendor_id & id[i].mask))
+		if (ac97_ids_match(id[i].id, adev->vendor_id, id[i].mask))
 			return true;
 	} while (id[i++].id);
 
diff --git a/sound/ac97/snd_ac97_compat.c b/sound/ac97/snd_ac97_compat.c
index ac8d835c1513..61544e0d8de4 100644
--- a/sound/ac97/snd_ac97_compat.c
+++ b/sound/ac97/snd_ac97_compat.c
@@ -88,16 +88,19 @@ int snd_ac97_reset(struct snd_ac97 *ac97, bool try_warm, unsigned int id,
 {
 	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
 	struct ac97_controller *actrl = adev->ac97_ctrl;
+	unsigned int scanned;
 
 	if (try_warm) {
 		compat_ac97_warm_reset(ac97);
-		if (snd_ac97_bus_scan_one(actrl, adev->num) == adev->vendor_id)
+		scanned = snd_ac97_bus_scan_one(actrl, adev->num);
+		if (ac97_ids_match(scanned, adev->vendor_id, id_mask))
 			return 1;
 	}
 
 	compat_ac97_reset(ac97);
 	compat_ac97_warm_reset(ac97);
-	if (snd_ac97_bus_scan_one(actrl, adev->num) == adev->vendor_id)
+	scanned = snd_ac97_bus_scan_one(actrl, adev->num);
+	if (ac97_ids_match(scanned, adev->vendor_id, id_mask))
 		return 0;
 
 	return -ENODEV;
