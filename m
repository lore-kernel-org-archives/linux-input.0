From: WEN Pingbo <pingbo.wen@linaro.org>
Subject: [PATCH] hil_mlc: convert timeval to timespec64
Date: Sun, 18 Oct 2015 17:45:19 +0800
Message-ID: <1445161519-27000-1-git-send-email-pingbo.wen@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35533 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbbJRJrM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Oct 2015 05:47:12 -0400
Received: by pasz6 with SMTP id z6so534042pas.2
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2015 02:47:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, y2038@lists.linaro.org, WEN Pingbo <pingbo.wen@linaro.org>

Using struct timeval will cause time overflow in 2038, replacing it with
a 64bit version.

In addition, the origin driver try to covert usec to jiffies manually in
hilse_donode(). This is not a universal and safe way, using
nsecs_to_jiffies() to fix that.

Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
---
 drivers/input/serio/hil_mlc.c    | 31 +++++++++++++++++--------------
 drivers/input/serio/hp_sdc_mlc.c | 10 ++++++----
 include/linux/hil_mlc.h          |  4 ++--
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index 65605e4..4e3b926 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -274,14 +274,14 @@ static int hilse_match(hil_mlc *mlc, int unused)
 /* An LCV used to prevent runaway loops, forces 5 second sleep when reset. */
 static int hilse_init_lcv(hil_mlc *mlc, int unused)
 {
-	struct timeval tv;
+	struct timespec64 ts64;
 
-	do_gettimeofday(&tv);
+	ktime_get_ts64(&ts64);
 
-	if (mlc->lcv && (tv.tv_sec - mlc->lcv_tv.tv_sec) < 5)
+	if (mlc->lcv && (ts64.tv_sec - mlc->lcv_ts64.tv_sec) < 5)
 		return -1;
 
-	mlc->lcv_tv = tv;
+	mlc->lcv_ts64 = ts64;
 	mlc->lcv = 0;
 
 	return 0;
@@ -605,7 +605,7 @@ static inline void hilse_setup_input(hil_mlc *mlc, const struct hilse_node *node
 	}
 	mlc->istarted = 1;
 	mlc->intimeout = node->arg;
-	do_gettimeofday(&(mlc->instart));
+	ktime_get_ts64(&(mlc->instart));
 	mlc->icount = 15;
 	memset(mlc->ipacket, 0, 16 * sizeof(hil_packet));
 	BUG_ON(down_trylock(&mlc->isem));
@@ -710,7 +710,7 @@ static int hilse_donode(hil_mlc *mlc)
 			break;
 		}
 		mlc->ostarted = 0;
-		do_gettimeofday(&(mlc->instart));
+		ktime_get_ts64(&(mlc->instart));
 		write_unlock_irqrestore(&mlc->lock, flags);
 		nextidx = HILSEN_NEXT;
 		break;
@@ -731,18 +731,21 @@ static int hilse_donode(hil_mlc *mlc)
 #endif
 
 	while (nextidx & HILSEN_SCHED) {
-		struct timeval tv;
+		struct timespec64 ts64;
 
 		if (!sched_long)
 			goto sched;
 
-		do_gettimeofday(&tv);
-		tv.tv_usec += USEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
-		tv.tv_usec -= mlc->instart.tv_usec;
-		if (tv.tv_usec >= mlc->intimeout) goto sched;
-		tv.tv_usec = (mlc->intimeout - tv.tv_usec) * HZ / USEC_PER_SEC;
-		if (!tv.tv_usec) goto sched;
-		mod_timer(&hil_mlcs_kicker, jiffies + tv.tv_usec);
+		ktime_get_ts64(&ts64);
+		ts64.tv_nsec += NSEC_PER_SEC *
+			(ts64.tv_sec - mlc->instart.tv_sec);
+		ts64.tv_nsec -= mlc->instart.tv_nsec;
+		if (ts64.tv_nsec >= (mlc->intimeout * NSEC_PER_USEC))
+			goto sched;
+		ts64.tv_nsec = mlc->intimeout * NSEC_PER_USEC - ts64.tv_nsec;
+		if (!ts64.tv_nsec) goto sched;
+		mod_timer(&hil_mlcs_kicker,
+				jiffies + nsecs_to_jiffies(ts64.tv_nsec));
 		break;
 	sched:
 		tasklet_schedule(&hil_mlcs_tasklet);
diff --git a/drivers/input/serio/hp_sdc_mlc.c b/drivers/input/serio/hp_sdc_mlc.c
index d50f067..369885d 100644
--- a/drivers/input/serio/hp_sdc_mlc.c
+++ b/drivers/input/serio/hp_sdc_mlc.c
@@ -149,7 +149,7 @@ static int hp_sdc_mlc_in(hil_mlc *mlc, suseconds_t timeout)
 
 	/* Try to down the semaphore */
 	if (down_trylock(&mlc->isem)) {
-		struct timeval tv;
+		struct timespec64 ts64;
 		if (priv->emtestmode) {
 			mlc->ipacket[0] =
 				HIL_ERR_INT | (mlc->opacket &
@@ -160,9 +160,11 @@ static int hp_sdc_mlc_in(hil_mlc *mlc, suseconds_t timeout)
 			/* printk(KERN_DEBUG PREFIX ">[%x]\n", mlc->ipacket[0]); */
 			goto wasup;
 		}
-		do_gettimeofday(&tv);
-		tv.tv_usec += USEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
-		if (tv.tv_usec - mlc->instart.tv_usec > mlc->intimeout) {
+		ktime_get_ts64(&ts64);
+		ts64.tv_nsec += NSEC_PER_SEC *
+			(ts64.tv_sec - mlc->instart.tv_sec);
+		if (ts64.tv_nsec - mlc->instart.tv_nsec > mlc->intimeout *
+				NSEC_PER_USEC) {
 			/*	printk("!%i %i",
 				tv.tv_usec - mlc->instart.tv_usec,
 				mlc->intimeout);
diff --git a/include/linux/hil_mlc.h b/include/linux/hil_mlc.h
index 394a840..a6b62fb 100644
--- a/include/linux/hil_mlc.h
+++ b/include/linux/hil_mlc.h
@@ -144,12 +144,12 @@ struct hil_mlc {
 	hil_packet		ipacket[16];
 	hil_packet		imatch;
 	int			icount;
-	struct timeval		instart;
+	struct timespec64	instart;
 	suseconds_t		intimeout;
 
 	int			ddi;	/* Last operational device id */
 	int			lcv;	/* LCV to throttle loops */
-	struct timeval		lcv_tv; /* Time loop was started */
+	struct timespec64	lcv_ts64; /* Time loop was started */
 
 	int			di_map[7]; /* Maps below items to live devs */
 	struct hil_mlc_devinfo	di[HIL_MLC_DEVMEM];
-- 
1.9.1

