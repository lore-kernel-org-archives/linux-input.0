From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/6] Core driver for WM97xx touchscreens
Date: Tue, 12 Feb 2008 22:58:50 +0000 (UTC)
Message-ID: <fot8b9$b6c$1@ger.gmane.org>
References: <20080212101738.GB21039@rakim.wolfsonmicro.main>
	<1202811705-2303-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754255AbYBLW7Y@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

Mark Brown wrote:

> This patch series adds support for the touchscreen controllers provided
> by Wolfson Microelectronics WM97xx series chips in both polled and
> streaming modes.

You used platform_device_register, but should be using platform_device_add,
otherwise you get barfs with 2.6.25-rc1 (device is initialized twice). Also
as <sound/driver.h> got deprecated there is no point including it.

Patch below

-- 
With best wishes
Dmitry

>From 81b96191eb50837bdf1f437a6f4f05786cc0b49e Mon Sep 17 00:00:00 2001
From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Date: Wed, 13 Feb 2008 01:55:10 +0300
Subject: [PATCH] wm97xx-core fixes

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 drivers/input/touchscreen/wm97xx-core.c |    8 ++++----
 include/linux/wm97xx.h                  |    1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 840d9ff..4cbb9e5 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -596,7 +596,7 @@ static int wm97xx_probe(struct device *dev)
 	}
 	platform_set_drvdata(wm->battery_dev, wm);
 	wm->battery_dev->dev.parent = dev;
-	ret = platform_device_register(wm->battery_dev);
+	ret = platform_device_add(wm->battery_dev);
 	if (ret < 0)
 		goto batt_reg_err;
 
@@ -609,7 +609,7 @@ static int wm97xx_probe(struct device *dev)
 	}
 	platform_set_drvdata(wm->touch_dev, wm);
 	wm->touch_dev->dev.parent = dev;
-	ret = platform_device_register(wm->touch_dev);
+	ret = platform_device_add(wm->touch_dev);
 	if (ret < 0)
 		goto touch_reg_err;
 
@@ -619,12 +619,12 @@ static int wm97xx_probe(struct device *dev)
 	platform_device_put(wm->touch_dev);
  touch_err:
 	platform_device_unregister(wm->battery_dev);
-	wm->battery_dev = 0;
+	wm->battery_dev = NULL;
  batt_reg_err:
 	platform_device_put(wm->battery_dev);
  batt_err:
 	input_unregister_device(wm->input_dev);
-	wm->input_dev = 0;
+	wm->input_dev = NULL;
  dev_alloc_err:
 	input_free_device(wm->input_dev);
  alloc_err:
diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
index fc6e0b3..f0d9fc0 100644
--- a/include/linux/wm97xx.h
+++ b/include/linux/wm97xx.h
@@ -6,7 +6,6 @@
 #ifndef _LINUX_WM97XX_H
 #define _LINUX_WM97XX_H
 
-#include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
-- 
1.5.3.8
