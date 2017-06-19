From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 02/12] ASoC: add new ac97 bus support
Date: Mon, 19 Jun 2017 09:26:59 +0200
Message-ID: <1497857229-12049-3-git-send-email-robert.jarzmik@free.fr>
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:31300 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753728AbdFSH2b (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 03:28:31 -0400
In-Reply-To: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

Add the new ac97 bus support, with ac97 bus automatic probing.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/Kconfig     | 2 ++
 sound/Makefile    | 1 +
 sound/soc/Kconfig | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/sound/Kconfig b/sound/Kconfig
index ee2e69a9ecd1..141b145c4195 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -80,6 +80,8 @@ source "sound/hda/Kconfig"
 
 source "sound/ppc/Kconfig"
 
+source "sound/ac97/Kconfig"
+
 source "sound/aoa/Kconfig"
 
 source "sound/arm/Kconfig"
diff --git a/sound/Makefile b/sound/Makefile
index 6de45d2c32f7..c03b0bed65d5 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SND_AOA) += aoa/
 
 # This one must be compilable even if sound is configured out
 obj-$(CONFIG_AC97_BUS) += ac97_bus.o
+obj-$(CONFIG_AC97_BUS_NEW) += ac97/
 
 ifeq ($(CONFIG_SND),y)
   obj-y += last.o
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 182d92efc7c8..5ad0a0422054 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -6,6 +6,7 @@ menuconfig SND_SOC
 	tristate "ALSA for SoC audio support"
 	select SND_PCM
 	select AC97_BUS if SND_SOC_AC97_BUS
+	select AC97_BUS_NEW if SND_SOC_AC97_BUS_NEW
 	select SND_JACK
 	select REGMAP_I2C if I2C
 	select REGMAP_SPI if SPI_MASTER
@@ -25,6 +26,9 @@ if SND_SOC
 config SND_SOC_AC97_BUS
 	bool
 
+config SND_SOC_AC97_BUS_NEW
+	bool
+
 config SND_SOC_GENERIC_DMAENGINE_PCM
 	bool
 	select SND_DMAENGINE_PCM
-- 
2.1.4

