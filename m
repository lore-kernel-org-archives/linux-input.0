From: WEN Pingbo <pingbo.wen@linaro.org>
Subject: [PATCH V2] hp_sdc: fixed y2038 problem
Date: Fri, 23 Oct 2015 16:53:26 +0800
Message-ID: <1445590406-30448-1-git-send-email-pingbo.wen@linaro.org>
References: <5041745.xAgMz1TQSE@wuerfel>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34093 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbbJWIyP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Oct 2015 04:54:15 -0400
Received: by padhk11 with SMTP id hk11so113084443pad.1
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2015 01:54:14 -0700 (PDT)
In-Reply-To: <5041745.xAgMz1TQSE@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: arnd@arndb.de
Cc: y2038@lists.linaro.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, WEN Pingbo <pingbo.wen@linaro.org>

1. Converting timeval to ktime_t, and there is no need to handle sec and
usec separately

2. hp_sdc.rtv is only used for time diff, monotonic time is better here

Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
---
 drivers/input/serio/hp_sdc.c | 16 ++++++----------
 include/linux/hp_sdc.h       |  6 +++---
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index 852858e..8ef82ee 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -193,7 +193,7 @@ static void hp_sdc_take(int irq, void *dev_id, uint8_t status, uint8_t data)
 	curr->seq[curr->idx++] = status;
 	curr->seq[curr->idx++] = data;
 	hp_sdc.rqty -= 2;
-	do_gettimeofday(&hp_sdc.rtv);
+	hp_sdc.rtv = ktime_get();
 
 	if (hp_sdc.rqty <= 0) {
 		/* All data has been gathered. */
@@ -306,13 +306,9 @@ static void hp_sdc_tasklet(unsigned long foo)
 	write_lock_irq(&hp_sdc.rtq_lock);
 
 	if (hp_sdc.rcurr >= 0) {
-		struct timeval tv;
+		ktime_t time_diff = ktime_sub(ktime_get(), hp_sdc.rtv);
 
-		do_gettimeofday(&tv);
-		if (tv.tv_sec > hp_sdc.rtv.tv_sec)
-			tv.tv_usec += USEC_PER_SEC;
-
-		if (tv.tv_usec - hp_sdc.rtv.tv_usec > HP_SDC_MAX_REG_DELAY) {
+		if (time_diff.tv64 > HP_SDC_MAX_REG_DELAY) {
 			hp_sdc_transaction *curr;
 			uint8_t tmp;
 
@@ -321,8 +317,8 @@ static void hp_sdc_tasklet(unsigned long foo)
 			 * we'll need to figure out a way to communicate
 			 * it back to the application. and be less verbose.
 			 */
-			printk(KERN_WARNING PREFIX "read timeout (%ius)!\n",
-			       (int)(tv.tv_usec - hp_sdc.rtv.tv_usec));
+			printk(KERN_WARNING PREFIX "read timeout (%llins)!\n",
+			       time_diff.tv64);
 			curr->idx += hp_sdc.rqty;
 			hp_sdc.rqty = 0;
 			tmp = curr->seq[curr->actidx];
@@ -551,7 +547,7 @@ unsigned long hp_sdc_put(void)
 
 			/* Start a new read */
 			hp_sdc.rqty = curr->seq[curr->idx];
-			do_gettimeofday(&hp_sdc.rtv);
+			hp_sdc.rtv = ktime_get();
 			curr->idx++;
 			/* Still need to lock here in case of spurious irq. */
 			write_lock_irq(&hp_sdc.rtq_lock);
diff --git a/include/linux/hp_sdc.h b/include/linux/hp_sdc.h
index d392975..348a9b5 100644
--- a/include/linux/hp_sdc.h
+++ b/include/linux/hp_sdc.h
@@ -47,9 +47,9 @@
 #endif
 
 
-/* No 4X status reads take longer than this (in usec).
+/* No 4X status reads take longer than this (in nsec).
  */
-#define HP_SDC_MAX_REG_DELAY 20000
+#define HP_SDC_MAX_REG_DELAY 20000000
 
 typedef void (hp_sdc_irqhook) (int irq, void *dev_id, 
 			       uint8_t status, uint8_t data);
@@ -281,7 +281,7 @@ typedef struct {
 	hp_sdc_transaction *tq[HP_SDC_QUEUE_LEN]; /* All pending read/writes */
 
 	int		rcurr, rqty;	/* Current read transact in process */
-	struct timeval	rtv;		/* Time when current read started */
+	ktime_t		rtv;		/* Time when current read started */
 	int		wcurr;		/* Current write transact in process */
 
 	int		dev_err;	/* carries status from registration */
-- 
1.9.1

