From: Derek Foreman <derek.foreman@collabora.co.uk>
Subject: [PATCH 2/4] Input: Report defuzzed event once before filtering for devices with the INCONSISTENT_RATE property
Date: Fri, 10 Jun 2011 15:55:02 -0400
Message-ID: <1307735704-30673-3-git-send-email-derek.foreman@collabora.co.uk>
References: <1307735704-30673-1-git-send-email-derek.foreman@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.128.226]:37422 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757848Ab1FJUCi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2011 16:02:38 -0400
In-Reply-To: <1307735704-30673-1-git-send-email-derek.foreman@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Some input devices have a non-uniform report rate, which can make it difficult for a userspace driver to distinguish between a lack of motion or a lack of new input.

With this patch, if multiple duplicate events (after defuzz) are received in a row, the first duplicate is posted to userspace.

Signed-off-by: Derek Foreman <derek.foreman@collabora.co.uk>
---
 drivers/input/input.c |   22 +++++++++++++++++++---
 include/linux/input.h |    4 ++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 75e11c7..5c7af82 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -198,8 +198,15 @@ static int input_handle_abs_event(struct input_dev *dev,
 	if (pold) {
 		*pval = input_defuzz_abs_event(*pval, *pold,
 						dev->absinfo[code].fuzz);
-		if (*pold == *pval)
-			return INPUT_IGNORE_EVENT;
+		if (*pold == *pval) {
+			if (!test_bit(INPUT_PROP_INCONSISTENT_RATE,
+				      dev->propbit)
+			    || dev->reposted[code])
+				return INPUT_IGNORE_EVENT;
+			else
+				dev->reposted[code] = 1;
+		} else
+			dev->reposted[code] = 0;
 
 		*pold = *pval;
 	}
@@ -405,6 +412,14 @@ void input_alloc_absinfo(struct input_dev *dev)
 					GFP_KERNEL);
 
 	WARN(!dev->absinfo, "%s(): kcalloc() failed?\n", __func__);
+
+	if (!dev->absinfo)
+		return;
+
+	if (!dev->reposted)
+		dev->reposted = kcalloc(ABS_CNT, sizeof(bool), GFP_KERNEL);
+
+	WARN(!dev->reposted, "%s(): kcalloc() failed?\n", __func__);
 }
 EXPORT_SYMBOL(input_alloc_absinfo);
 
@@ -414,7 +429,7 @@ void input_set_abs_params(struct input_dev *dev, unsigned int axis,
 	struct input_absinfo *absinfo;
 
 	input_alloc_absinfo(dev);
-	if (!dev->absinfo)
+	if (!dev->absinfo || !dev->reposted)
 		return;
 
 	absinfo = &dev->absinfo[axis];
@@ -1416,6 +1431,7 @@ static void input_dev_release(struct device *device)
 	input_ff_destroy(dev);
 	input_mt_destroy_slots(dev);
 	kfree(dev->absinfo);
+	kfree(dev->reposted);
 	kfree(dev);
 
 	module_put(THIS_MODULE);
diff --git a/include/linux/input.h b/include/linux/input.h
index f8a0c2d..388cdef 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1178,6 +1178,9 @@ struct ff_effect {
  * @absinfo: array of &struct input_absinfo elements holding information
  *	about absolute axes (current value, min, max, flat, fuzz,
  *	resolution)
+ * @reposted: boolean for each absinfo indicating whether the current
+ *	value has been posted a second time and the defuzz algorithm
+ *	can remove subsequent identical values
  * @key: reflects current state of device's keys/buttons
  * @led: reflects current state of device's LEDs
  * @snd: reflects current state of sound effects
@@ -1260,6 +1263,7 @@ struct input_dev {
 	int trkid;
 
 	struct input_absinfo *absinfo;
+	bool *reposted;
 
 	unsigned long key[BITS_TO_LONGS(KEY_CNT)];
 	unsigned long led[BITS_TO_LONGS(LED_CNT)];
-- 
1.7.5.3

