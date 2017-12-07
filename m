From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v4 4/4] input: serio: Replace timeval by timespec64
Date: Thu,  7 Dec 2017 10:13:06 -0800
Message-ID: <20171207181306.5623-5-deepa.kernel@gmail.com>
References: <20171207181306.5623-1-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207181306.5623-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: peter.hutterer@who-t.net, arnd@arndb.de, y2038@lists.linaro.org
List-Id: linux-input@vger.kernel.org

struct timeval is not y2038 safe.
All references to timeval will be deleted from the
kernel to make it y2038 safe.
Replace its uses by y2038 safe struct timespec64.

The timestamps changed here only keep track of delta
times. These timestamps are also internal to kernel.
Hence, monotonic times are sufficient here.
The unit of the delta times is also changed in certain
cases to nanoseconds rather than microseconds. This is
in line with timespec64 which keeps time in nanoseconds.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/serio/hil_mlc.c    | 37 ++++++++++++++++++-------------------
 drivers/input/serio/hp_sdc.c     | 17 +++++++++--------
 drivers/input/serio/hp_sdc_mlc.c | 10 +++++-----
 include/linux/hil_mlc.h          |  6 +++---
 include/linux/hp_sdc.h           |  6 +++---
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index d66d01c5373b..b5856b4d3717 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -274,14 +274,14 @@ static int hilse_match(hil_mlc *mlc, int unused)
 /* An LCV used to prevent runaway loops, forces 5 second sleep when reset. */
 static int hilse_init_lcv(hil_mlc *mlc, int unused)
 {
-	struct timeval tv;
+	time64_t time;
 
-	do_gettimeofday(&tv);
+	time = ktime_get_seconds();
 
-	if (mlc->lcv && (tv.tv_sec - mlc->lcv_tv.tv_sec) < 5)
+	if (mlc->lcv && (time - mlc->lcv_tv.tv_sec) < 5)
 		return -1;
 
-	mlc->lcv_tv = tv;
+	mlc->lcv_tv.tv_sec = time;
 	mlc->lcv = 0;
 
 	return 0;
@@ -466,7 +466,7 @@ static const struct hilse_node hil_mlc_se[HILSEN_END] = {
 	FUNC(hilse_init_lcv, 0,	HILSEN_NEXT,	HILSEN_SLEEP,	0)
 
 	/* 1  HILSEN_RESTART */
-	FUNC(hilse_inc_lcv, 10,	HILSEN_NEXT,	HILSEN_START,  0)
+	FUNC(hilse_inc_lcv, 10000,	HILSEN_NEXT,	HILSEN_START,  0)
 	OUT(HIL_CTRL_ONLY)			/* Disable APE */
 	CTS
 
@@ -485,7 +485,7 @@ static const struct hilse_node hil_mlc_se[HILSEN_END] = {
 	FUNC(hilse_init_lcv, 0,	HILSEN_NEXT,	HILSEN_SLEEP,	0)
 
 	/* 10 HILSEN_DHR2 */
-	FUNC(hilse_inc_lcv, 10,	HILSEN_NEXT,	HILSEN_START,	0)
+	FUNC(hilse_inc_lcv, 10000,	HILSEN_NEXT,	HILSEN_START,	0)
 	FUNC(hilse_set_ddi, -1,	HILSEN_NEXT,	0,		0)
 	OUT(HIL_PKT_CMD | HIL_CMD_DHR)
 	IN(300000,		HILSEN_DHR2,	HILSEN_DHR2,	HILSEN_NEXT)
@@ -515,7 +515,7 @@ static const struct hilse_node hil_mlc_se[HILSEN_END] = {
 	FUNC(hilse_init_lcv, 0,	HILSEN_NEXT,	HILSEN_DOZE,	0)
 
 	/* 22 HILSEN_ACF2 */
-	FUNC(hilse_inc_lcv, 10,	HILSEN_NEXT,	HILSEN_START,	0)
+	FUNC(hilse_inc_lcv, 10000,	HILSEN_NEXT,	HILSEN_START,	0)
 	OUT(HIL_PKT_CMD | HIL_CMD_ACF | 1)
 	IN(20000,		HILSEN_NEXT,	HILSEN_DSR,	HILSEN_NEXT)
 
@@ -572,7 +572,7 @@ static const struct hilse_node hil_mlc_se[HILSEN_END] = {
 	OUT(HIL_PKT_CMD | HIL_CMD_RPL)
 	EXPECT(HIL_PKT_CMD | HIL_CMD_RPL | HIL_ERR_INT,
 	       20000,		HILSEN_NEXT,	HILSEN_DSR,	HILSEN_NEXT)
-	FUNC(hilse_operate, 1,	HILSEN_OPERATE,	HILSEN_IFC,	HILSEN_PROBE)
+	FUNC(hilse_operate, 1000, HILSEN_OPERATE, HILSEN_IFC,	HILSEN_PROBE)
 
 	/* 58 HILSEN_IFCACF */
 	OUT(HIL_PKT_CMD | HIL_CMD_IFC)
@@ -584,7 +584,6 @@ static const struct hilse_node hil_mlc_se[HILSEN_END] = {
 
 static inline void hilse_setup_input(hil_mlc *mlc, const struct hilse_node *node)
 {
-
 	switch (node->act) {
 	case HILSE_EXPECT_DISC:
 		mlc->imatch = node->object.packet;
@@ -605,7 +604,7 @@ static inline void hilse_setup_input(hil_mlc *mlc, const struct hilse_node *node
 	}
 	mlc->istarted = 1;
 	mlc->intimeout = node->arg;
-	do_gettimeofday(&(mlc->instart));
+	ktime_get_ts64(&(mlc->instart));
 	mlc->icount = 15;
 	memset(mlc->ipacket, 0, 16 * sizeof(hil_packet));
 	BUG_ON(down_trylock(&mlc->isem));
@@ -710,7 +709,7 @@ static int hilse_donode(hil_mlc *mlc)
 			break;
 		}
 		mlc->ostarted = 0;
-		do_gettimeofday(&(mlc->instart));
+		ktime_get_ts64(&(mlc->instart));
 		write_unlock_irqrestore(&mlc->lock, flags);
 		nextidx = HILSEN_NEXT;
 		break;
@@ -731,18 +730,18 @@ static int hilse_donode(hil_mlc *mlc)
 #endif
 
 	while (nextidx & HILSEN_SCHED) {
-		struct timeval tv;
+		struct timespec64 ts;
 
 		if (!sched_long)
 			goto sched;
 
-		do_gettimeofday(&tv);
-		tv.tv_usec += USEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
-		tv.tv_usec -= mlc->instart.tv_usec;
-		if (tv.tv_usec >= mlc->intimeout) goto sched;
-		tv.tv_usec = (mlc->intimeout - tv.tv_usec) * HZ / USEC_PER_SEC;
-		if (!tv.tv_usec) goto sched;
-		mod_timer(&hil_mlcs_kicker, jiffies + tv.tv_usec);
+		ktime_get_ts64(&ts);
+		ts.tv_nsec += NSEC_PER_SEC * (ts.tv_sec - mlc->instart.tv_sec);
+		ts.tv_nsec -= mlc->instart.tv_nsec;
+		if (ts.tv_nsec >= mlc->intimeout) goto sched;
+		ts.tv_nsec = (mlc->intimeout - ts.tv_nsec) * HZ / NSEC_PER_SEC;
+		if (!ts.tv_nsec) goto sched;
+		mod_timer(&hil_mlcs_kicker, jiffies + ts.tv_nsec);
 		break;
 	sched:
 		tasklet_schedule(&hil_mlcs_tasklet);
diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index 1d7c7d81a5ef..c8e3eb1c98c0 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -193,7 +193,7 @@ static void hp_sdc_take(int irq, void *dev_id, uint8_t status, uint8_t data)
 	curr->seq[curr->idx++] = status;
 	curr->seq[curr->idx++] = data;
 	hp_sdc.rqty -= 2;
-	do_gettimeofday(&hp_sdc.rtv);
+	ktime_get_ts64(&hp_sdc.rtv);
 
 	if (hp_sdc.rqty <= 0) {
 		/* All data has been gathered. */
@@ -306,13 +306,13 @@ static void hp_sdc_tasklet(unsigned long foo)
 	write_lock_irq(&hp_sdc.rtq_lock);
 
 	if (hp_sdc.rcurr >= 0) {
-		struct timeval tv;
+		struct timespec64 ts;
 
-		do_gettimeofday(&tv);
-		if (tv.tv_sec > hp_sdc.rtv.tv_sec)
-			tv.tv_usec += USEC_PER_SEC;
+		ktime_get_ts64(&ts);
+		if (ts.tv_sec > hp_sdc.rtv.tv_sec)
+			ts.tv_nsec += NSEC_PER_SEC;
 
-		if (tv.tv_usec - hp_sdc.rtv.tv_usec > HP_SDC_MAX_REG_DELAY) {
+		if (ts.tv_nsec - hp_sdc.rtv.tv_nsec > HP_SDC_MAX_REG_DELAY) {
 			hp_sdc_transaction *curr;
 			uint8_t tmp;
 
@@ -322,7 +322,8 @@ static void hp_sdc_tasklet(unsigned long foo)
 			 * it back to the application. and be less verbose.
 			 */
 			printk(KERN_WARNING PREFIX "read timeout (%ius)!\n",
-			       (int)(tv.tv_usec - hp_sdc.rtv.tv_usec));
+			       (int)(ts.tv_nsec - hp_sdc.rtv.tv_nsec) /
+				     (int)NSEC_PER_USEC);
 			curr->idx += hp_sdc.rqty;
 			hp_sdc.rqty = 0;
 			tmp = curr->seq[curr->actidx];
@@ -551,7 +552,7 @@ unsigned long hp_sdc_put(void)
 
 			/* Start a new read */
 			hp_sdc.rqty = curr->seq[curr->idx];
-			do_gettimeofday(&hp_sdc.rtv);
+			ktime_get_ts64(&hp_sdc.rtv);
 			curr->idx++;
 			/* Still need to lock here in case of spurious irq. */
 			write_lock_irq(&hp_sdc.rtq_lock);
diff --git a/drivers/input/serio/hp_sdc_mlc.c b/drivers/input/serio/hp_sdc_mlc.c
index d50f0678bf47..66020cd931be 100644
--- a/drivers/input/serio/hp_sdc_mlc.c
+++ b/drivers/input/serio/hp_sdc_mlc.c
@@ -149,7 +149,7 @@ static int hp_sdc_mlc_in(hil_mlc *mlc, suseconds_t timeout)
 
 	/* Try to down the semaphore */
 	if (down_trylock(&mlc->isem)) {
-		struct timeval tv;
+		struct timespec64 ts;
 		if (priv->emtestmode) {
 			mlc->ipacket[0] =
 				HIL_ERR_INT | (mlc->opacket &
@@ -160,11 +160,11 @@ static int hp_sdc_mlc_in(hil_mlc *mlc, suseconds_t timeout)
 			/* printk(KERN_DEBUG PREFIX ">[%x]\n", mlc->ipacket[0]); */
 			goto wasup;
 		}
-		do_gettimeofday(&tv);
-		tv.tv_usec += USEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
-		if (tv.tv_usec - mlc->instart.tv_usec > mlc->intimeout) {
+		ktime_get_ts64(&ts);
+		ts.tv_nsec += NSEC_PER_SEC * (ts.tv_sec - mlc->instart.tv_sec);
+		if (ts.tv_nsec - mlc->instart.tv_nsec > mlc->intimeout) {
 			/*	printk("!%i %i",
-				tv.tv_usec - mlc->instart.tv_usec,
+				tv.tv_nsec - mlc->instart.tv_nsec,
 				mlc->intimeout);
 			 */
 			rc = 1;
diff --git a/include/linux/hil_mlc.h b/include/linux/hil_mlc.h
index 394a8405dd74..f846730d6595 100644
--- a/include/linux/hil_mlc.h
+++ b/include/linux/hil_mlc.h
@@ -32,7 +32,7 @@
  */
 
 #include <linux/hil.h>
-#include <linux/time.h>
+#include <linux/time64.h>
 #include <linux/interrupt.h>
 #include <linux/semaphore.h>
 #include <linux/serio.h>
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
+	struct timespec64	lcv_tv; /* Time loop was started */
 
 	int			di_map[7]; /* Maps below items to live devs */
 	struct hil_mlc_devinfo	di[HIL_MLC_DEVMEM];
diff --git a/include/linux/hp_sdc.h b/include/linux/hp_sdc.h
index d392975d8887..d863944f5c0c 100644
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
+	struct timespec64 rtv;		/* Monotonic time when current read started */
 	int		wcurr;		/* Current write transact in process */
 
 	int		dev_err;	/* carries status from registration */
-- 
2.14.1
