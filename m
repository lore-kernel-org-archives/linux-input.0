From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 14/17] Input: tsc2005 - do not rearm timer in hardirq handler
Date: Wed, 16 Mar 2011 00:19:12 -0700
Message-ID: <20110316071912.25664.23883.stgit@hammer.corenet.prv>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37590 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1CPHTR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:19:17 -0400
Received: by mail-gw0-f46.google.com with SMTP id a18so544592gwa.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:19:17 -0700 (PDT)
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

We will most likely rearm it yet again the IRQ thread so doing it here
is pointless.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2005.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index c0980ae..16c9f57 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -225,17 +225,6 @@ static void tsc2005_update_pen_state(struct tsc2005 *ts,
 		pressure);
 }
 
-static irqreturn_t tsc2005_irq_handler(int irq, void *dev_id)
-{
-	struct tsc2005 *ts = dev_id;
-
-	/* update the penup timer only if it's pending */
-	mod_timer_pending(&ts->penup_timer,
-			  jiffies + msecs_to_jiffies(TSC2005_PENUP_TIME_MS));
-
-	return IRQ_WAKE_THREAD;
-}
-
 static irqreturn_t tsc2005_irq_thread(int irq, void *_ts)
 {
 	struct tsc2005 *ts = _ts;
@@ -594,8 +583,7 @@ static int __devinit tsc2005_probe(struct spi_device *spi)
 	input_set_abs_params(input_dev, ABS_Y, 0, max_y, fudge_y, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, max_p, fudge_p, 0);
 
-	error = request_threaded_irq(spi->irq,
-				     tsc2005_irq_handler, tsc2005_irq_thread,
+	error = request_threaded_irq(spi->irq, NULL, tsc2005_irq_thread,
 				     IRQF_TRIGGER_RISING, "tsc2005", ts);
 	if (error) {
 		dev_err(&spi->dev, "Failed to request irq, err: %d\n", error);

