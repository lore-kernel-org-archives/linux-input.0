From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] input: hil_mlc: convert timeval to jiffies
Date: Mon, 27 Nov 2017 12:22:58 +0100
Message-ID: <20171127112324.1917698-2-arnd@arndb.de>
References: <20171127112324.1917698-1-arnd@arndb.de>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20171127112324.1917698-1-arnd@arndb.de>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, "James E . J . Bottomley" <jejb@parisc-linux.org>, WEN Pingbo <pingbo.wen@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: WEN Pingbo <pingbo.wen@linaro.org>

struct timeval is not y2038 safe, and what mlc->instart do is
scheduling a task in a fixed timeout, so jiffies is the
simplest choice here.

In hilse_donode(), the expires in mod_timer equals

	jiffies + intimeout - (now - instart)

If we use jiffies in 'now', the expires equals

	instart + intimeout

So, all we need to do is that making sure expires is a future
timestamp before passed it to mod_timer.

[arnd: slightly simplified patch further]

Link: https://lists.linaro.org/pipermail/y2038/2015-October/000937.html
Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/serio/hil_mlc.c    | 18 +++++++-----------
 drivers/input/serio/hp_sdc_mlc.c |  5 +----
 include/linux/hil_mlc.h          |  4 ++--
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index 581e47119363..e1423f7648d6 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -602,8 +602,8 @@ static inline void hilse_setup_input(hil_mlc *mlc, const struct hilse_node *node
 		BUG();
 	}
 	mlc->istarted = 1;
-	mlc->intimeout = node->arg;
-	do_gettimeofday(&(mlc->instart));
+	mlc->intimeout = usecs_to_jiffies(node->arg);
+	mlc->instart = jiffies;
 	mlc->icount = 15;
 	memset(mlc->ipacket, 0, 16 * sizeof(hil_packet));
 	BUG_ON(down_trylock(&mlc->isem));
@@ -708,7 +708,7 @@ static int hilse_donode(hil_mlc *mlc)
 			break;
 		}
 		mlc->ostarted = 0;
-		do_gettimeofday(&(mlc->instart));
+		mlc->instart = jiffies;
 		write_unlock_irqrestore(&mlc->lock, flags);
 		nextidx = HILSEN_NEXT;
 		break;
@@ -729,18 +729,14 @@ static int hilse_donode(hil_mlc *mlc)
 #endif
 
 	while (nextidx & HILSEN_SCHED) {
-		struct timeval tv;
+		unsigned long now = jiffies;
 
 		if (!sched_long)
 			goto sched;
 
-		do_gettimeofday(&tv);
-		tv.tv_usec += USEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
-		tv.tv_usec -= mlc->instart.tv_usec;
-		if (tv.tv_usec >= mlc->intimeout) goto sched;
-		tv.tv_usec = (mlc->intimeout - tv.tv_usec) * HZ / USEC_PER_SEC;
-		if (!tv.tv_usec) goto sched;
-		mod_timer(&hil_mlcs_kicker, jiffies + tv.tv_usec);
+		if (time_after(now, mlc->instart + mlc->intimeout))
+			 goto sched;
+		mod_timer(&hil_mlcs_kicker, mlc->instart + mlc->intimeout);
 		break;
 	sched:
 		tasklet_schedule(&hil_mlcs_tasklet);
diff --git a/drivers/input/serio/hp_sdc_mlc.c b/drivers/input/serio/hp_sdc_mlc.c
index d50f0678bf47..232d30c825bd 100644
--- a/drivers/input/serio/hp_sdc_mlc.c
+++ b/drivers/input/serio/hp_sdc_mlc.c
@@ -149,7 +149,6 @@ static int hp_sdc_mlc_in(hil_mlc *mlc, suseconds_t timeout)
 
 	/* Try to down the semaphore */
 	if (down_trylock(&mlc->isem)) {
-		struct timeval tv;
 		if (priv->emtestmode) {
 			mlc->ipacket[0] =
 				HIL_ERR_INT | (mlc->opacket &
@@ -160,9 +159,7 @@ static int hp_sdc_mlc_in(hil_mlc *mlc, suseconds_t timeout)
 			/* printk(KERN_DEBUG PREFIX ">[%x]\n", mlc->ipacket[0]); */
 			goto wasup;
 		}
-		do_gettimeofday(&tv);
-		tv.tv_usec += USEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
-		if (tv.tv_usec - mlc->instart.tv_usec > mlc->intimeout) {
+		if (time_after(jiffies, mlc->instart + mlc->intimeout)) {
 			/*	printk("!%i %i",
 				tv.tv_usec - mlc->instart.tv_usec,
 				mlc->intimeout);
diff --git a/include/linux/hil_mlc.h b/include/linux/hil_mlc.h
index d6fc839bdf46..774f7d3b8f6a 100644
--- a/include/linux/hil_mlc.h
+++ b/include/linux/hil_mlc.h
@@ -144,8 +144,8 @@ struct hil_mlc {
 	hil_packet		ipacket[16];
 	hil_packet		imatch;
 	int			icount;
-	struct timeval		instart;
-	suseconds_t		intimeout;
+	unsigned long		instart;
+	unsigned long		intimeout;
 
 	int			ddi;	/* Last operational device id */
 	int			lcv;	/* LCV to throttle loops */
-- 
2.9.0
