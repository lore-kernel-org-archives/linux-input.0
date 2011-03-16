From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 13/17] Input: tsc2005 - don't use work for 'pen up' handling
Date: Wed, 16 Mar 2011 00:19:07 -0700
Message-ID: <20110316071907.25664.46804.stgit@hammer.corenet.prv>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43936 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1CPHTM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:19:12 -0400
Received: by mail-yx0-f174.google.com with SMTP id 7so546881yxs.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:19:12 -0700 (PDT)
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

We do not need process context to send input events so let's switch to
a regular timer. I am going to get rid of taking ts->mutex in
tsc2005_irq_thread() later.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2005.c |   58 ++++++++++++++++-------------------
 1 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 8a9c072..c0980ae 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -129,8 +129,8 @@ struct tsc2005 {
 	int                     in_z1;
 	int			in_z2;
 
+	spinlock_t		lock;
 	struct timer_list	penup_timer;
-	struct work_struct	penup_work;
 
 	unsigned int		esd_timeout;
 	struct timer_list	esd_timer;
@@ -239,11 +239,10 @@ static irqreturn_t tsc2005_irq_handler(int irq, void *dev_id)
 static irqreturn_t tsc2005_irq_thread(int irq, void *_ts)
 {
 	struct tsc2005 *ts = _ts;
+	unsigned long flags;
 	unsigned int pressure;
-	u32 x;
-	u32 y;
-	u32 z1;
-	u32 z2;
+	u32 x, y;
+	u32 z1, z2;
 
 	mutex_lock(&ts->mutex);
 
@@ -261,46 +260,50 @@ static irqreturn_t tsc2005_irq_thread(int irq, void *_ts)
 	if (unlikely(x > MAX_12BIT || y > MAX_12BIT))
 		goto out;
 
-	/* skip coords if the pressure components are out of range */
+	/* Skip reading if the pressure components are out of range */
 	if (unlikely(z1 == 0 || z2 > MAX_12BIT || z1 >= z2))
 		goto out;
 
-       /* skip point if this is a pen down with the exact same values as
+       /*
+	* Skip point if this is a pen down with the exact same values as
 	* the value before pen-up - that implies SPI fed us stale data
 	*/
 	if (!ts->pen_down &&
-	ts->in_x == x &&
-	ts->in_y == y &&
-	ts->in_z1 == z1 &&
-	ts->in_z2 == z2)
+	    ts->in_x == x && ts->in_y == y &&
+	    ts->in_z1 == z1 && ts->in_z2 == z2) {
 		goto out;
+	}
 
-	/* At this point we are happy we have a valid and useful reading.
-	* Remember it for later comparisons. We may now begin downsampling
-	*/
+	/*
+	 * At this point we are happy we have a valid and useful reading.
+	 * Remember it for later comparisons. We may now begin downsampling.
+	 */
 	ts->in_x = x;
 	ts->in_y = y;
 	ts->in_z1 = z1;
 	ts->in_z2 = z2;
 
-	/* compute touch pressure resistance using equation #1 */
+	/* Compute touch pressure resistance using equation #1 */
 	pressure = x * (z2 - z1) / z1;
 	pressure = pressure * ts->x_plate_ohm / 4096;
 	if (unlikely(pressure > MAX_12BIT))
 		goto out;
 
+	spin_lock_irqsave(&ts->lock, flags);
+
 	tsc2005_update_pen_state(ts, x, y, pressure);
 
 	/* set the penup timer */
 	mod_timer(&ts->penup_timer,
 		  jiffies + msecs_to_jiffies(TSC2005_PENUP_TIME_MS));
 
-	if (!ts->esd_timeout)
-		goto out;
+	if (ts->esd_timeout && ts->set_reset) {
+		/* update the watchdog timer */
+		mod_timer(&ts->esd_timer, round_jiffies(jiffies +
+					msecs_to_jiffies(ts->esd_timeout)));
+	}
 
-	/* update the watchdog timer */
-	mod_timer(&ts->esd_timer,
-		  round_jiffies(jiffies + msecs_to_jiffies(ts->esd_timeout)));
+	spin_unlock_irqrestore(&ts->lock, flags);
 
 out:
 	mutex_unlock(&ts->mutex);
@@ -310,17 +313,11 @@ out:
 static void tsc2005_penup_timer(unsigned long data)
 {
 	struct tsc2005 *ts = (struct tsc2005 *)data;
+	unsigned long flags;
 
-	schedule_work(&ts->penup_work);
-}
-
-static void tsc2005_penup_work(struct work_struct *work)
-{
-	struct tsc2005 *ts = container_of(work, struct tsc2005, penup_work);
-
-	mutex_lock(&ts->mutex);
+	spin_lock_irqsave(&ts->lock, flags);
 	tsc2005_update_pen_state(ts, 0, 0, 0);
-	mutex_unlock(&ts->mutex);
+	spin_unlock_irqrestore(&ts->lock, flags);
 }
 
 static void tsc2005_start_scan(struct tsc2005 *ts)
@@ -575,8 +572,8 @@ static int __devinit tsc2005_probe(struct spi_device *spi)
 
 	mutex_init(&ts->mutex);
 
+	spin_lock_init(&ts->lock);
 	setup_timer(&ts->penup_timer, tsc2005_penup_timer, (unsigned long)ts);
-	INIT_WORK(&ts->penup_work, tsc2005_penup_work);
 
 	setup_timer(&ts->esd_timer, tsc2005_esd_timer, (unsigned long)ts);
 	INIT_WORK(&ts->esd_work, tsc2005_esd_work);
@@ -657,7 +654,6 @@ static int __devexit tsc2005_remove(struct spi_device *spi)
 	del_timer_sync(&ts->penup_timer);
 
 	flush_work(&ts->esd_work);
-	flush_work(&ts->penup_work);
 
 	free_irq(ts->spi->irq, ts);
 	input_unregister_device(ts->idev);

