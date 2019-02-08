From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [RFC PATCH 1/2] Input: lm8323: switch to using set_brightness_blocking
Date: Fri,  8 Feb 2019 14:34:33 -0500
Message-ID: <20190208193434.5629-1-TheSven73@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Disclaimer:
I cannot test this driver as I do not have any h/w.
This RFC patch is not intended as a ready-made solution,
but to provoke discussion.

Problem 1:
lm8323_pwm_work() could still run after the device has been removed, which
would result in a use-after-free.

Problem 2:
The brightness_set callback must not sleep, but in this case it grabs a
mutex, which can potentially sleep.

Solution:
lm8323_pwm_work() grabs a mutex and performs i2c accesses, therefore it may
sleep, and that is not allowed in brightness_set callback.
Use brightness_set_blocking callback instead. This has its own workqueue,
which is handled correctly on device removal. So the use-after-free
disappears. As a bonus, we no longer require a separate work_struct.

Question:
The original set_brightness had a separate code path when the device is in
suspend:

	/*
	* Schedule PWM work as usual unless we are going into suspend
	*/
	mutex_lock(&lm->lock);
	if (likely(!lm->pm_suspend))
	       schedule_work(&pwm->work);
	else
	       lm8323_pwm_work(&pwm->work);
	mutex_unlock(&lm->lock);

Why was it there, and does the current led core code handle this case
correctly?

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/input/keyboard/lm8323.c | 49 ++++++---------------------------
 1 file changed, 8 insertions(+), 41 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 04a5d7e134d7..ea4ed1750eb5 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -137,7 +137,6 @@ struct lm8323_pwm {
 	bool			running;
 	/* pwm lock */
 	struct mutex		lock;
-	struct work_struct	work;
 	struct led_classdev	cdev;
 	struct lm8323_chip	*chip;
 };
@@ -148,7 +147,6 @@ struct lm8323_chip {
 	struct i2c_client	*client;
 	struct input_dev	*idev;
 	bool			kp_enabled;
-	bool			pm_suspend;
 	unsigned		keys_down;
 	char			phys[32];
 	unsigned short		keymap[LM8323_KEYMAP_SIZE];
@@ -162,7 +160,6 @@ struct lm8323_chip {
 #define client_to_lm8323(c)	container_of(c, struct lm8323_chip, client)
 #define dev_to_lm8323(d)	container_of(d, struct lm8323_chip, client->dev)
 #define cdev_to_pwm(c)		container_of(c, struct lm8323_pwm, cdev)
-#define work_to_pwm(w)		container_of(w, struct lm8323_pwm, work)
 
 #define LM8323_MAX_DATA 8
 
@@ -365,7 +362,7 @@ static void pwm_done(struct lm8323_pwm *pwm)
 	mutex_lock(&pwm->lock);
 	pwm->running = false;
 	if (pwm->desired_brightness != pwm->brightness)
-		schedule_work(&pwm->work);
+		led_set_brightness(&pwm->cdev, pwm->desired_brightness);
 	mutex_unlock(&pwm->lock);
 }
 
@@ -450,15 +447,18 @@ static void lm8323_write_pwm(struct lm8323_pwm *pwm, int kill,
 	pwm->running = true;
 }
 
-static void lm8323_pwm_work(struct work_struct *work)
+static int lm8323_pwm_set_brightness(struct led_classdev *led_cdev,
+				      enum led_brightness brightness)
 {
-	struct lm8323_pwm *pwm = work_to_pwm(work);
+	struct lm8323_pwm *pwm = cdev_to_pwm(led_cdev);
 	int div512, perstep, steps, hz, up, kill;
 	u16 pwm_cmds[3];
 	int num_cmds = 0;
 
 	mutex_lock(&pwm->lock);
 
+	pwm->desired_brightness = brightness;
+
 	/*
 	 * Do nothing if we're already at the requested level,
 	 * or previous setting is not yet complete. In the latter
@@ -504,31 +504,7 @@ static void lm8323_pwm_work(struct work_struct *work)
 
  out:
 	mutex_unlock(&pwm->lock);
-}
-
-static void lm8323_pwm_set_brightness(struct led_classdev *led_cdev,
-				      enum led_brightness brightness)
-{
-	struct lm8323_pwm *pwm = cdev_to_pwm(led_cdev);
-	struct lm8323_chip *lm = pwm->chip;
-
-	mutex_lock(&pwm->lock);
-	pwm->desired_brightness = brightness;
-	mutex_unlock(&pwm->lock);
-
-	if (in_interrupt()) {
-		schedule_work(&pwm->work);
-	} else {
-		/*
-		 * Schedule PWM work as usual unless we are going into suspend
-		 */
-		mutex_lock(&lm->lock);
-		if (likely(!lm->pm_suspend))
-			schedule_work(&pwm->work);
-		else
-			lm8323_pwm_work(&pwm->work);
-		mutex_unlock(&lm->lock);
-	}
+	return 0;
 }
 
 static ssize_t lm8323_pwm_show_time(struct device *dev,
@@ -579,13 +555,12 @@ static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
 	pwm->desired_brightness = 0;
 	pwm->running = false;
 	pwm->enabled = false;
-	INIT_WORK(&pwm->work, lm8323_pwm_work);
 	mutex_init(&pwm->lock);
 	pwm->chip = lm;
 
 	if (name) {
 		pwm->cdev.name = name;
-		pwm->cdev.brightness_set = lm8323_pwm_set_brightness;
+		pwm->cdev.brightness_set_blocking = lm8323_pwm_set_brightness;
 		pwm->cdev.groups = lm8323_pwm_groups;
 		if (led_classdev_register(dev, &pwm->cdev) < 0) {
 			dev_err(dev, "couldn't register PWM %d\n", id);
@@ -799,10 +774,6 @@ static int lm8323_suspend(struct device *dev)
 	irq_set_irq_wake(client->irq, 0);
 	disable_irq(client->irq);
 
-	mutex_lock(&lm->lock);
-	lm->pm_suspend = true;
-	mutex_unlock(&lm->lock);
-
 	for (i = 0; i < 3; i++)
 		if (lm->pwm[i].enabled)
 			led_classdev_suspend(&lm->pwm[i].cdev);
@@ -816,10 +787,6 @@ static int lm8323_resume(struct device *dev)
 	struct lm8323_chip *lm = i2c_get_clientdata(client);
 	int i;
 
-	mutex_lock(&lm->lock);
-	lm->pm_suspend = false;
-	mutex_unlock(&lm->lock);
-
 	for (i = 0; i < 3; i++)
 		if (lm->pwm[i].enabled)
 			led_classdev_resume(&lm->pwm[i].cdev);
-- 
2.17.1
