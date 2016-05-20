From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: pwm-beeper - fix: scheduling while atomic
Date: Fri, 20 May 2016 09:59:18 -0700
Message-ID: <20160520165918.GE14951@dtor-ws>
References: <56C4735E.6020300@gmx.at>
 <20160222194639.GD26177@dtor-ws>
 <20160512121852.GB26824@ulmo.ba.sec>
 <5735F4E3.20008@gmx.at>
 <573C8761.9070601@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <573C8761.9070601@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Cc: Thierry Reding <thierry.reding@gmail.com>, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Luis de Bethencourt <luis@debethencourt.com>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

Hi Manfred,

On Wed, May 18, 2016 at 05:16:49PM +0200, Manfred Schlaegl wrote:
> @@ -133,6 +149,8 @@ static int pwm_beeper_remove(struct platform_device *pdev)
>  {
>  	struct pwm_beeper *beeper = platform_get_drvdata(pdev);
>  
> +	cancel_work_sync(&beeper->work);
> +
>  	input_unregister_device(beeper->input);

This is racy, request to play may come in after cancel_work_sync()
returns but before we unregistered input device. I think you want the
version below.

-- 
Dmitry


Input: pwm-beeper - fix 'scheduling while atomic'

From: Manfred Schlaegl <manfred.schlaegl@gmx.at>

Pwm config may sleep so defer it using a worker.

Trigger:
On a Freescale i.MX53 based board we ran into "BUG: scheduling while
atomic" because input_inject_event locks interrupts, but
imx_pwm_config_v2 sleeps.

Tested on Freescale i.MX53 SoC with 4.6.0 and 4.1.24.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/pwm-beeper.c |   70 +++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index f2261ab..27de150 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -20,21 +20,41 @@
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
@@ -49,22 +69,31 @@ static int pwm_beeper_event(struct input_dev *input,
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
@@ -87,6 +116,8 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	INIT_WORK(&beeper->work, pwm_beeper_work);
+
 	beeper->input = input_allocate_device();
 	if (!beeper->input) {
 		dev_err(&pdev->dev, "Failed to allocate input device\n");
@@ -106,6 +137,7 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	beeper->input->sndbit[0] = BIT(SND_TONE) | BIT(SND_BELL);
 
 	beeper->input->event = pwm_beeper_event;
+	beeper->input->close = pwm_beeper_close;
 
 	input_set_drvdata(beeper->input, beeper);
 
@@ -135,7 +167,6 @@ static int pwm_beeper_remove(struct platform_device *pdev)
 
 	input_unregister_device(beeper->input);
 
-	pwm_disable(beeper->pwm);
 	pwm_free(beeper->pwm);
 
 	kfree(beeper);
@@ -147,8 +178,7 @@ static int __maybe_unused pwm_beeper_suspend(struct device *dev)
 {
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
 
-	if (beeper->period)
-		pwm_disable(beeper->pwm);
+	pwm_beeper_stop(beeper);
 
 	return 0;
 }
@@ -157,10 +187,8 @@ static int __maybe_unused pwm_beeper_resume(struct device *dev)
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
