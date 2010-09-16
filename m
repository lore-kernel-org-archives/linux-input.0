From: Jason Wang <jason77.wang@gmail.com>
Subject: [PATCH 4/4] Input: ads7846 - modificatons of _stop()/_disable() conditions
Date: Thu, 16 Sep 2010 18:51:26 +0800
Message-ID: <1284634286-8871-5-git-send-email-jason77.wang@gmail.com>
References: <1284634286-8871-1-git-send-email-jason77.wang@gmail.com>
 <1284634286-8871-2-git-send-email-jason77.wang@gmail.com>
 <1284634286-8871-3-git-send-email-jason77.wang@gmail.com>
 <1284634286-8871-4-git-send-email-jason77.wang@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:38255 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338Ab0IPKsB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Sep 2010 06:48:01 -0400
In-Reply-To: <1284634286-8871-4-git-send-email-jason77.wang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, notasas@gmail.com, vapier@gentoo.org
Cc: linux-input@vger.kernel.org

The design like that, we can stop or disable ADC, one difference is
the disable not only stop the ADC but also close the power regulator.
So we change the condition flag to stopped in the _stop() function.

Because we call __ads7846_disable() in the suspend/resume process, so
move disabled flag modification from ads7846_disable() to the
__ads7846_disable(), otherwise when we call _disable() in the suspend,
and the ADC is really suspended but the flag shows that it isn't.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 drivers/input/touchscreen/ads7846.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index eab8b0b..349031d 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -198,7 +198,7 @@ struct ads7846 {
 /* Must be called with ts->lock held */
 static void ads7846_stop(struct ads7846 *ts)
 {
-	if (!ts->disabled && !ts->suspended) {
+	if (!ts->stopped) {
 		/* Signal IRQ thread to stop polling and disable the handler. */
 		ts->stopped = true;
 		mb();
@@ -210,7 +210,7 @@ static void ads7846_stop(struct ads7846 *ts)
 /* Must be called with ts->lock held */
 static void ads7846_restart(struct ads7846 *ts)
 {
-	if (!ts->disabled && !ts->suspended) {
+	if (ts->stopped) {
 		/* Tell IRQ thread that it may poll the device. */
 		ts->stopped = false;
 		mb();
@@ -223,7 +223,7 @@ static void __ads7846_disable(struct ads7846 *ts)
 {
 	ads7846_stop(ts);
 	regulator_disable(ts->reg);
-
+	ts->disabled = true;
 	/*
 	 * We know the chip's in low power mode since we always
 	 * leave it that way after every request
@@ -235,6 +235,7 @@ static void __ads7846_enable(struct ads7846 *ts)
 {
 	regulator_enable(ts->reg);
 	ads7846_restart(ts);
+	ts->disabled = false;
 }
 
 static void ads7846_disable(struct ads7846 *ts)
@@ -244,8 +245,6 @@ static void ads7846_disable(struct ads7846 *ts)
 	if (!ts->disabled && !ts->suspended)
 		__ads7846_disable(ts);
 
-	ts->disabled = true;
-
 	mutex_unlock(&ts->lock);
 }
 
@@ -256,8 +255,6 @@ static void ads7846_enable(struct ads7846 *ts)
 	if (ts->disabled && !ts->suspended)
 		__ads7846_enable(ts);
 
-	ts->disabled = false;
-
 	mutex_unlock(&ts->lock);
 }
 
@@ -919,7 +916,7 @@ static int ads7846_resume(struct spi_device *spi)
 		if (device_may_wakeup(&ts->spi->dev))
 			disable_irq_wake(ts->spi->irq);
 
-		if (!ts->disabled)
+		if (ts->disabled)
 			__ads7846_enable(ts);
 
 		ts->suspended = false;
-- 
1.5.6.5

