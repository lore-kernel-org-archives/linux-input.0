From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 4/7] Input: pwm-beeper - fix race when suspending
Date: Thu, 19 Jan 2017 14:40:54 -0800
Message-ID: <20170119224057.9995-4-dmitry.torokhov@gmail.com>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>, Frieder Schrempf <frieder.schrempf@exceet.de>
List-Id: linux-input@vger.kernel.org

Usually userspace sends SND_BELL and SND_TONE events, and by the time
pwm_beeper_suspend() runs userpsace is already frozen, but theoretically
in-kernel users may send these events too, and that may cause
pwm_beeper_event() scheduling another work after we canceled it.

Let's introduce a "suspended" flag and check it in pwm_beeper_event() to
avoid this race.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/pwm-beeper.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index ce6eec48ec5f..04c8ad3827d9 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -27,6 +27,7 @@ struct pwm_beeper {
 	struct pwm_device *pwm;
 	struct work_struct work;
 	unsigned long period;
+	bool suspended;
 };
 
 #define HZ_TO_NANOSECONDS(x) (1000000000UL/(x))
@@ -73,7 +74,8 @@ static int pwm_beeper_event(struct input_dev *input,
 	else
 		beeper->period = HZ_TO_NANOSECONDS(value);
 
-	schedule_work(&beeper->work);
+	if (!beeper->suspended)
+		schedule_work(&beeper->work);
 
 	return 0;
 }
@@ -154,6 +156,15 @@ static int __maybe_unused pwm_beeper_suspend(struct device *dev)
 {
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
 
+	/*
+	 * Spinlock is taken here is not to protect write to
+	 * beeper->suspended, but to ensure that pwm_beeper_event
+	 * does not re-submit work once flag is set.
+	 */
+	spin_lock_irq(&beeper->input->event_lock);
+	beeper->suspended = true;
+	spin_unlock_irq(&beeper->input->event_lock);
+
 	pwm_beeper_stop(beeper);
 
 	return 0;
@@ -163,8 +174,12 @@ static int __maybe_unused pwm_beeper_resume(struct device *dev)
 {
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
 
-	if (beeper->period)
-		__pwm_beeper_set(beeper);
+	spin_lock_irq(&beeper->input->event_lock);
+	beeper->suspended = false;
+	spin_unlock_irq(&beeper->input->event_lock);
+
+	/* Let worker figure out if we should resume beeping */
+	schedule_work(&beeper->work);
 
 	return 0;
 }
-- 
2.11.0.483.g087da7b7c-goog
