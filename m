From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH RESEND] tps6507: remove bogus unreachable code
Date: Thu, 25 Oct 2012 15:28:51 +0100
Message-ID: <20121025142845.16911.4538.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53783 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759106Ab2JYO1Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 10:27:16 -0400
Received: from localhost.localdomain (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.5/8.14.1) with ESMTP id q9PExDGe006723
	for <linux-input@vger.kernel.org>; Thu, 25 Oct 2012 15:59:21 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

tsc->polling is write only and the poll local is meaningless

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/input/touchscreen/tps6507x-ts.c |   25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index f7eda3d..27f95ad 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -42,7 +42,6 @@ struct tps6507x_ts {
 	struct device		*dev;
 	char			phys[32];
 	struct delayed_work	work;
-	unsigned		polling;	/* polling is active */
 	struct ts_event		tc;
 	struct tps6507x_dev	*mfd;
 	u16			model;
@@ -168,7 +167,6 @@ static void tps6507x_ts_handler(struct work_struct *work)
 	struct input_dev *input_dev = tsc->input_dev;
 	int pendown;
 	int schd;
-	int poll = 0;
 	s32 ret;
 
 	ret =  tps6507x_adc_conversion(tsc, TPS6507X_TSCMODE_PRESSURE,
@@ -209,24 +207,14 @@ static void tps6507x_ts_handler(struct work_struct *work)
 		input_report_abs(input_dev, ABS_PRESSURE, tsc->tc.pressure);
 		input_sync(input_dev);
 		tsc->pendown = 1;
-		poll = 1;
 	}
 
 done:
 	/* always poll if not using interrupts */
-	poll = 1;
-
-	if (poll) {
-		schd = schedule_delayed_work(&tsc->work,
-					msecs_to_jiffies(tsc->poll_period));
-		if (schd)
-			tsc->polling = 1;
-		else {
-			tsc->polling = 0;
-			dev_err(tsc->dev, "re-schedule failed");
-		}
-	} else
-		tsc->polling = 0;
+	schd = schedule_delayed_work(&tsc->work,
+				msecs_to_jiffies(tsc->poll_period));
+	if (!schd)
+		dev_err(tsc->dev, "re-schedule failed");
 
 	ret = tps6507x_adc_standby(tsc);
 }
@@ -324,10 +312,7 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 	schd = schedule_delayed_work(&tsc->work,
 				     msecs_to_jiffies(tsc->poll_period));
 
-	if (schd)
-		tsc->polling = 1;
-	else {
-		tsc->polling = 0;
+	if (!schd) {
 		dev_err(tsc->dev, "schedule failed");
 		goto err2;
 	 }

