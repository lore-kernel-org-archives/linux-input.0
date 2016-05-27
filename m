From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Subject: Re: [PATCH] Input: pwm-beeper - fix: scheduling while atomic
Date: Fri, 27 May 2016 11:14:27 +0200
Message-ID: <57480FF3.9060107@gmx.at>
References: <56C4735E.6020300@gmx.at> <20160222194639.GD26177@dtor-ws>
 <20160512121852.GB26824@ulmo.ba.sec> <5735F4E3.20008@gmx.at>
 <573C8761.9070601@gmx.at> <20160520165918.GE14951@dtor-ws>
 <574411B5.2010407@gmx.at> <20160526003615.GE22369@dtor-ws>
 <57480B5C.7080409@gmx.at> <57480F45.7070106@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:51280 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932463AbcE0JOv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 May 2016 05:14:51 -0400
In-Reply-To: <57480F45.7070106@gmx.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Luis de Bethencourt <luis@debethencourt.com>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Pwm config may sleep so defer it using a worker.

On a Freescale i.MX53 based board we ran into "BUG: scheduling while
atomic" because input_inject_event locks interrupts, but
imx_pwm_config_v2 sleeps.

Tested on Freescale i.MX53 SoC with 4.6.0.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>
---
 drivers/input/misc/pwm-beeper.c | 69 ++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 8d71332..5f9655d 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -20,21 +20,40 @@
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 struct pwm_beeper {
 	struct input_dev *input;
 	struct pwm_device *pwm;
+	struct work_struct work;
 	unsigned long period;
 };
 
 #define HZ_TO_NANOSECONDS(x) (1000000000UL/(x))
 
+static void __pwm_beeper_set(struct pwm_beeper *beeper)
+{
+	unsigned long period = beeper->period;
+
+	if (period) {
+		pwm_config(beeper->pwm, period / 2, period);
+		pwm_enable(beeper->pwm);
+	} else
+		pwm_disable(beeper->pwm);
+}
+
+static void pwm_beeper_work(struct work_struct *work)
+{
+	struct pwm_beeper *beeper =
+		container_of(work, struct pwm_beeper, work);
+
+	__pwm_beeper_set(beeper);
+}
+
 static int pwm_beeper_event(struct input_dev *input,
 			    unsigned int type, unsigned int code, int value)
 {
-	int ret = 0;
 	struct pwm_beeper *beeper = input_get_drvdata(input);
-	unsigned long period;
 
 	if (type != EV_SND || value < 0)
 		return -EINVAL;
@@ -49,22 +68,31 @@ static int pwm_beeper_event(struct input_dev *input,
 		return -EINVAL;
 	}
 
-	if (value == 0) {
-		pwm_disable(beeper->pwm);
-	} else {
-		period = HZ_TO_NANOSECONDS(value);
-		ret = pwm_config(beeper->pwm, period / 2, period);
-		if (ret)
-			return ret;
-		ret = pwm_enable(beeper->pwm);
-		if (ret)
-			return ret;
-		beeper->period = period;
-	}
+	if (value == 0)
+		beeper->period = 0;
+	else
+		beeper->period = HZ_TO_NANOSECONDS(value);
+
+	schedule_work(&beeper->work);
 
 	return 0;
 }
 
+static void pwm_beeper_stop(struct pwm_beeper *beeper)
+{
+	cancel_work_sync(&beeper->work);
+
+	if (beeper->period)
+		pwm_disable(beeper->pwm);
+}
+
+static void pwm_beeper_close(struct input_dev *input)
+{
+	struct pwm_beeper *beeper = input_get_drvdata(input);
+
+	pwm_beeper_stop(beeper);
+}
+
 static int pwm_beeper_probe(struct platform_device *pdev)
 {
 	unsigned long pwm_id = (unsigned long)dev_get_platdata(&pdev->dev);
@@ -93,6 +121,8 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	 */
 	pwm_apply_args(beeper->pwm);
 
+	INIT_WORK(&beeper->work, pwm_beeper_work);
+
 	beeper->input = input_allocate_device();
 	if (!beeper->input) {
 		dev_err(&pdev->dev, "Failed to allocate input device\n");
@@ -112,6 +142,7 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	beeper->input->sndbit[0] = BIT(SND_TONE) | BIT(SND_BELL);
 
 	beeper->input->event = pwm_beeper_event;
+	beeper->input->close = pwm_beeper_close;
 
 	input_set_drvdata(beeper->input, beeper);
 
@@ -141,7 +172,6 @@ static int pwm_beeper_remove(struct platform_device *pdev)
 
 	input_unregister_device(beeper->input);
 
-	pwm_disable(beeper->pwm);
 	pwm_free(beeper->pwm);
 
 	kfree(beeper);
@@ -153,8 +183,7 @@ static int __maybe_unused pwm_beeper_suspend(struct device *dev)
 {
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
 
-	if (beeper->period)
-		pwm_disable(beeper->pwm);
+	pwm_beeper_stop(beeper);
 
 	return 0;
 }
@@ -163,10 +192,8 @@ static int __maybe_unused pwm_beeper_resume(struct device *dev)
 {
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
 
-	if (beeper->period) {
-		pwm_config(beeper->pwm, beeper->period / 2, beeper->period);
-		pwm_enable(beeper->pwm);
-	}
+	if (beeper->period)
+		__pwm_beeper_set(beeper);
 
 	return 0;
 }
-- 
2.1.4

