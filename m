From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] Input: hp_sdc: convert to ktime_get()
Date: Mon, 27 Nov 2017 12:22:59 +0100
Message-ID: <20171127112324.1917698-3-arnd@arndb.de>
References: <20171127112324.1917698-1-arnd@arndb.de>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20171127112324.1917698-1-arnd@arndb.de>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, "James E . J . Bottomley" <jejb@parisc-linux.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This gets rid of the deprecated do_gettimeofday() call in favor
of ktime_get(), which is also more reliable as it uses monotonic
times. The code now gets a bit simpler.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/serio/hp_sdc.c | 17 +++++++----------
 include/linux/hp_sdc.h       |  2 +-
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index 1d7c7d81a5ef..0b8a25c58d02 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -193,7 +193,7 @@ static void hp_sdc_take(int irq, void *dev_id, uint8_t status, uint8_t data)
 	curr->seq[curr->idx++] = status;
 	curr->seq[curr->idx++] = data;
 	hp_sdc.rqty -= 2;
-	do_gettimeofday(&hp_sdc.rtv);
+	hp_sdc.rtime = ktime_get();
 
 	if (hp_sdc.rqty <= 0) {
 		/* All data has been gathered. */
@@ -306,13 +306,10 @@ static void hp_sdc_tasklet(unsigned long foo)
 	write_lock_irq(&hp_sdc.rtq_lock);
 
 	if (hp_sdc.rcurr >= 0) {
-		struct timeval tv;
+		ktime_t now = ktime_get();
 
-		do_gettimeofday(&tv);
-		if (tv.tv_sec > hp_sdc.rtv.tv_sec)
-			tv.tv_usec += USEC_PER_SEC;
-
-		if (tv.tv_usec - hp_sdc.rtv.tv_usec > HP_SDC_MAX_REG_DELAY) {
+		if (ktime_after(now, ktime_add_us(hp_sdc.rtime,
+						  HP_SDC_MAX_REG_DELAY))) {
 			hp_sdc_transaction *curr;
 			uint8_t tmp;
 
@@ -321,8 +318,8 @@ static void hp_sdc_tasklet(unsigned long foo)
 			 * we'll need to figure out a way to communicate
 			 * it back to the application. and be less verbose.
 			 */
-			printk(KERN_WARNING PREFIX "read timeout (%ius)!\n",
-			       (int)(tv.tv_usec - hp_sdc.rtv.tv_usec));
+			printk(KERN_WARNING PREFIX "read timeout (%lldus)!\n",
+			       ktime_us_delta(now, hp_sdc.rtime));
 			curr->idx += hp_sdc.rqty;
 			hp_sdc.rqty = 0;
 			tmp = curr->seq[curr->actidx];
@@ -551,7 +548,7 @@ unsigned long hp_sdc_put(void)
 
 			/* Start a new read */
 			hp_sdc.rqty = curr->seq[curr->idx];
-			do_gettimeofday(&hp_sdc.rtv);
+			hp_sdc.rtime = ktime_get();
 			curr->idx++;
 			/* Still need to lock here in case of spurious irq. */
 			write_lock_irq(&hp_sdc.rtq_lock);
diff --git a/include/linux/hp_sdc.h b/include/linux/hp_sdc.h
index d392975d8887..6f1dee7e67e0 100644
--- a/include/linux/hp_sdc.h
+++ b/include/linux/hp_sdc.h
@@ -281,7 +281,7 @@ typedef struct {
 	hp_sdc_transaction *tq[HP_SDC_QUEUE_LEN]; /* All pending read/writes */
 
 	int		rcurr, rqty;	/* Current read transact in process */
-	struct timeval	rtv;		/* Time when current read started */
+	ktime_t		rtime;		/* Time when current read started */
 	int		wcurr;		/* Current write transact in process */
 
 	int		dev_err;	/* carries status from registration */
-- 
2.9.0
