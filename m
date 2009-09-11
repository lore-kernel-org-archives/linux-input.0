From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/3] Input: add generic suspend and resume for input devices
Date: Thu, 10 Sep 2009 22:48:11 -0700
Message-ID: <20090911054811.27150.19714.stgit@localhost.localdomain>
References: <20090911054210.27150.93405.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:43458 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbZIKFsL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Sep 2009 01:48:11 -0400
Received: by pxi27 with SMTP id 27so621346pxi.15
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2009 22:48:14 -0700 (PDT)
In-Reply-To: <20090911054210.27150.93405.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rjw@sisk.pl

Automatically turn off leds and sound effects as part of suspend
process and restore led state, sounds and repeat rate at resume.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/input.h |    2 +-
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index d7e1c48..e8d723f 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/types.h>
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/random.h>
@@ -530,7 +531,7 @@ static void input_disconnect_device(struct input_dev *dev)
 	 * that there are no threads in the middle of input_open_device()
 	 */
 	mutex_lock(&dev->mutex);
-	dev->going_away = 1;
+	dev->going_away = true;
 	mutex_unlock(&dev->mutex);
 
 	spin_lock_irq(&dev->event_lock);
@@ -1278,10 +1279,71 @@ static int input_dev_uevent(struct device *device, struct kobj_uevent_env *env)
 	return 0;
 }
 
+#define INPUT_DO_TOGGLE(dev, type, bits, on)			\
+	do {							\
+		int i;						\
+		if (!test_bit(EV_##type, dev->evbit))		\
+			break;					\
+		for (i = 0; i < type##_MAX; i++) {		\
+			if (!test_bit(i, dev->bits##bit) ||	\
+			    !test_bit(i, dev->bits))		\
+				continue;			\
+			dev->event(dev, EV_##type, i, on);	\
+		}						\
+	} while (0)
+
+static void input_dev_reset(struct input_dev *dev, bool activate)
+{
+	if (!dev->event)
+		return;
+
+	INPUT_DO_TOGGLE(dev, LED, led, activate);
+	INPUT_DO_TOGGLE(dev, SND, snd, activate);
+
+	if (activate && test_bit(EV_REP, dev->evbit)) {
+		dev->event(dev, EV_REP, REP_PERIOD, dev->rep[REP_PERIOD]);
+		dev->event(dev, EV_REP, REP_DELAY, dev->rep[REP_DELAY]);
+	}
+}
+
+#ifdef CONFIG_PM
+static int input_dev_suspend(struct device *dev)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+
+	mutex_lock(&input_dev->mutex);
+	input_dev_reset(input_dev, false);
+	mutex_unlock(&input_dev->mutex);
+
+	return 0;
+}
+
+static int input_dev_resume(struct device *dev)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+
+	mutex_lock(&input_dev->mutex);
+	input_dev_reset(input_dev, true);
+	mutex_unlock(&input_dev->mutex);
+
+	return 0;
+}
+
+static const struct dev_pm_ops input_dev_pm_ops = {
+	.suspend	= input_dev_suspend,
+	.resume		= input_dev_resume,
+	.poweroff	= input_dev_suspend,
+	.restore	= input_dev_resume,
+};
+#endif /* CONFIG_PM */
+
 static struct device_type input_dev_type = {
 	.groups		= input_dev_attr_groups,
 	.release	= input_dev_release,
 	.uevent		= input_dev_uevent,
+#ifdef CONFIG_PM
+	.pm		= &input_dev_pm_ops,
+#endif
 };
 
 static char *input_nodename(struct device *dev)
diff --git a/include/linux/input.h b/include/linux/input.h
index c8e11f1..8adad05 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1123,7 +1123,7 @@ struct input_dev {
 	struct mutex mutex;
 
 	unsigned int users;
-	int going_away;
+	bool going_away;
 
 	struct device dev;
 

