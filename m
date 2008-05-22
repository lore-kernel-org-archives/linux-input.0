From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] wm97xx-core: Report a phys for WM97xx touchscreens
Date: Thu, 22 May 2008 12:35:06 +0100
Message-ID: <1211456106-10882-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2089 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756708AbYEVLfW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2008 07:35:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

phys is displayed in various diagnostic output so ensure that it is set
to something sensible.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
It'd be nice to get this merged into 2.6.26 since this is rather user visible
and given that this is a new driver there's no risk of regressions.

 drivers/input/touchscreen/wm97xx-core.c |    2 ++
 include/linux/wm97xx.h                  |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index e9c7ea4..12ae1ba 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -616,6 +616,8 @@ static int wm97xx_probe(struct device *dev)
 
 	/* set up touch configuration */
 	wm->input_dev->name = "wm97xx touchscreen";
+	snprintf(wm->phys, sizeof(wm->phys), "%s/input0", dev->bus_id);
+	wm->input_dev->phys = wm->phys;
 	wm->input_dev->open = wm97xx_ts_input_open;
 	wm->input_dev->close = wm97xx_ts_input_close;
 	set_bit(EV_ABS, wm->input_dev->evbit);
diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
index 4d13732..1f38fc4 100644
--- a/include/linux/wm97xx.h
+++ b/include/linux/wm97xx.h
@@ -261,6 +261,7 @@ struct wm97xx_mach_ops {
 };
 
 struct wm97xx {
+	char phys[32];			/* Device name */
 	u16 dig[3], id, gpio[6], misc;	/* Cached codec registers */
 	u16 dig_save[3];		/* saved during aux reading */
 	struct wm97xx_codec_drv *codec;	/* attached codec driver*/
-- 
1.5.3.2

