From: Jason Wang <jason77.wang@gmail.com>
Subject: [PATCH] Input: ads7846 - move regulator codes out of spinlock protected area
Date: Thu, 19 Aug 2010 16:14:30 +0800
Message-ID: <1282205670-30618-1-git-send-email-jason77.wang@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:39251 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab0HSILS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Aug 2010 04:11:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, notasas@gmail.com, vapier@gentoo.org
Cc: linux-input@vger.kernel.org

The commit 9114337 introduces regulator operations in the ads7846
touchscreen driver. Among these operations, some are called in the
spinlock protected context.
On most platforms, the regulator operation is achieved through
i2c/spi bus transfer operations, some of bus transfer operations will
call wait_for_completion function. It isn't allowable  to call
sleepable function in the atomic context. So move them out from the
atomic context.

[tested on TI OMAP3530EVM board]

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 drivers/input/touchscreen/ads7846.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 1603193..9421df9 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -531,6 +531,9 @@ static ssize_t ads7846_disable_store(struct device *dev,
 	if (strict_strtoul(buf, 10, &i))
 		return -EINVAL;
 
+	if (!i)
+		regulator_enable(ts->reg);
+
 	spin_lock_irq(&ts->lock);
 
 	if (i)
@@ -540,6 +543,9 @@ static ssize_t ads7846_disable_store(struct device *dev,
 
 	spin_unlock_irq(&ts->lock);
 
+	if (i)
+		regulator_disable(ts->reg);
+
 	return count;
 }
 
@@ -855,8 +861,6 @@ static void ads7846_disable(struct ads7846 *ts)
 		}
 	}
 
-	regulator_disable(ts->reg);
-
 	/* we know the chip's in lowpower mode since we always
 	 * leave it that way after every request
 	 */
@@ -868,8 +872,6 @@ static void ads7846_enable(struct ads7846 *ts)
 	if (!ts->disabled)
 		return;
 
-	regulator_enable(ts->reg);
-
 	ts->disabled = 0;
 	ts->irq_disabled = 0;
 	enable_irq(ts->spi->irq);
@@ -886,6 +888,8 @@ static int ads7846_suspend(struct spi_device *spi, pm_message_t message)
 
 	spin_unlock_irq(&ts->lock);
 
+	regulator_disable(ts->reg);
+
 	if (device_may_wakeup(&ts->spi->dev))
 		enable_irq_wake(ts->spi->irq);
 
@@ -900,6 +904,8 @@ static int ads7846_resume(struct spi_device *spi)
 	if (device_may_wakeup(&ts->spi->dev))
 		disable_irq_wake(ts->spi->irq);
 
+	regulator_enable(ts->reg);
+
 	spin_lock_irq(&ts->lock);
 
 	ts->is_suspended = 0;
-- 
1.5.6.5

