From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2] ALSA: ac97: Switch to dev_pm_ops
Date: Fri, 21 Aug 2015 09:48:33 +0200
Message-ID: <1440143313-27914-1-git-send-email-lars@metafoo.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out-030.synserver.de ([212.40.185.30]:1050 "EHLO
	smtp-out-030.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbbHUHtI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Aug 2015 03:49:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>
Cc: Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>

Convert the ac97_bus from legacy suspend/resume callbacks to dev_pm_ops.

Since there isn't anything special to do at the bus level the bus driver
does not have to implement any callbacks. The device driver core will
automatically pick up and execute the device's PM ops.

As there is only a single AC'97 driver implementing suspend and resume,
update both the core and driver at the same time to avoid unnecessary code
churn.

While we are at it also drop the ifdefs around the suspend/resume functions
to increase compile test coverage.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
This patch touches code in both ALSA and the input subsystem. Ideally this
patch will be merged via the ALSA tree. Given that the wm97xx touchscreen
driver is not seeing too many changes these days the risk of conflicts
should be low.

Changes since v1:
	* Drop ifdefs around suspend/resum functions
---
 drivers/input/touchscreen/wm97xx-core.c | 13 ++++---------
 sound/ac97_bus.c                        | 26 --------------------------
 2 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index b1ae779..1534e9b 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -732,8 +732,7 @@ static int wm97xx_remove(struct device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int wm97xx_suspend(struct device *dev, pm_message_t state)
+static int __maybe_unused wm97xx_suspend(struct device *dev)
 {
 	struct wm97xx *wm = dev_get_drvdata(dev);
 	u16 reg;
@@ -765,7 +764,7 @@ static int wm97xx_suspend(struct device *dev, pm_message_t state)
 	return 0;
 }
 
-static int wm97xx_resume(struct device *dev)
+static int __maybe_unused wm97xx_resume(struct device *dev)
 {
 	struct wm97xx *wm = dev_get_drvdata(dev);
 
@@ -799,10 +798,7 @@ static int wm97xx_resume(struct device *dev)
 	return 0;
 }
 
-#else
-#define wm97xx_suspend		NULL
-#define wm97xx_resume		NULL
-#endif
+static SIMPLE_DEV_PM_OPS(wm97xx_pm_ops, wm97xx_suspend, wm97xx_resume);
 
 /*
  * Machine specific operations
@@ -836,8 +832,7 @@ static struct device_driver wm97xx_driver = {
 	.owner =	THIS_MODULE,
 	.probe =	wm97xx_probe,
 	.remove =	wm97xx_remove,
-	.suspend =	wm97xx_suspend,
-	.resume =	wm97xx_resume,
+	.pm =		&wm97xx_pm_ops,
 };
 
 static int __init wm97xx_init(void)
diff --git a/sound/ac97_bus.c b/sound/ac97_bus.c
index 2b50cbe..57a6dfc 100644
--- a/sound/ac97_bus.c
+++ b/sound/ac97_bus.c
@@ -27,35 +27,9 @@ static int ac97_bus_match(struct device *dev, struct device_driver *drv)
 	return 1;
 }
 
-#ifdef CONFIG_PM
-static int ac97_bus_suspend(struct device *dev, pm_message_t state)
-{
-	int ret = 0;
-
-	if (dev->driver && dev->driver->suspend)
-		ret = dev->driver->suspend(dev, state);
-
-	return ret;
-}
-
-static int ac97_bus_resume(struct device *dev)
-{
-	int ret = 0;
-
-	if (dev->driver && dev->driver->resume)
-		ret = dev->driver->resume(dev);
-
-	return ret;
-}
-#endif /* CONFIG_PM */
-
 struct bus_type ac97_bus_type = {
 	.name		= "ac97",
 	.match		= ac97_bus_match,
-#ifdef CONFIG_PM
-	.suspend	= ac97_bus_suspend,
-	.resume		= ac97_bus_resume,
-#endif /* CONFIG_PM */
 };
 
 static int __init ac97_bus_init(void)
-- 
2.1.4

