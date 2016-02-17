From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Subject: [PATCH] Input: pwm-beeper - defer pwm config if pwm can sleep
Date: Wed, 17 Feb 2016 14:19:26 +0100
Message-ID: <56C4735E.6020300@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Luis de Bethencourt <luis@debethencourt.com>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

If the pwm can sleep defer actions to it using a worker.
A similar approach was used in leds-pwm (c971ff185)

Trigger:
On a Freescale i.MX53 based board we ran into "BUG: scheduling while
atomic" because input_inject_event locks interrupts, but
imx_pwm_config_v2 sleeps.

Tested on Freescale i.MX53 SoC with 4.5-rc1 and 4.1.

Unmodified applicable to
 * 4.5-rc4
 * 4.4.1 (stable)
 * 4.3.5 (stable)
 * 4.1.18 (longterm)

Modified applicable to
 * 3.18.27 (longterm)

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>
---
 drivers/input/misc/pwm-beeper.c | 62 +++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index f2261ab..c160b5e 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -20,21 +20,42 @@
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 struct pwm_beeper {
 	struct input_dev *input;
 	struct pwm_device *pwm;
+	struct work_struct work;
 	unsigned long period;
+	bool can_sleep;
 };
 
 #define HZ_TO_NANOSECONDS(x) (1000000000UL/(x))
 
+static void __pwm_beeper_set(struct pwm_beeper *beeper)
+{
+	unsigned long period = beeper->period;
+
+	pwm_config(beeper->pwm, period / 2, period);
+
+	if (period == 0)
+		pwm_disable(beeper->pwm);
+	else
+		pwm_enable(beeper->pwm);
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
@@ -49,18 +70,15 @@ static int pwm_beeper_event(struct input_dev *input,
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
+	if (beeper->can_sleep)
+		schedule_work(&beeper->work);
+	else
+		__pwm_beeper_set(beeper);
 
 	return 0;
 }
@@ -87,6 +105,10 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	beeper->can_sleep = pwm_can_sleep(beeper->pwm);
+	if (beeper->can_sleep)
+		INIT_WORK(&beeper->work, pwm_beeper_work);
+
 	beeper->input = input_allocate_device();
 	if (!beeper->input) {
 		dev_err(&pdev->dev, "Failed to allocate input device\n");
@@ -133,6 +155,9 @@ static int pwm_beeper_remove(struct platform_device *pdev)
 {
 	struct pwm_beeper *beeper = platform_get_drvdata(pdev);
 
+	if (beeper->can_sleep)
+		cancel_work_sync(&beeper->work);
+
 	input_unregister_device(beeper->input);
 
 	pwm_disable(beeper->pwm);
@@ -147,6 +172,9 @@ static int __maybe_unused pwm_beeper_suspend(struct device *dev)
 {
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
 
+	if (beeper->can_sleep)
+		cancel_work_sync(&beeper->work);
+
 	if (beeper->period)
 		pwm_disable(beeper->pwm);
 
@@ -157,10 +185,8 @@ static int __maybe_unused pwm_beeper_resume(struct device *dev)
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
