From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: wm97xx-core - use platform_device_del instead of
	platform_device_unregister for error handling
Date: Thu, 02 Sep 2010 16:27:09 +0800
Message-ID: <1283416029.19272.3.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/touchscreen/wm97xx-core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index cbfef1e..770537c 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -684,8 +684,7 @@ static int wm97xx_probe(struct device *dev)
  touch_reg_err:
 	platform_device_put(wm->touch_dev);
  touch_err:
-	platform_device_unregister(wm->battery_dev);
-	wm->battery_dev = NULL;
+	platform_device_del(wm->battery_dev);
  batt_reg_err:
 	platform_device_put(wm->battery_dev);
  batt_err:
-- 
1.7.2
