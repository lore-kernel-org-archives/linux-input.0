From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: tsc2004/5 - do not use irq_set_irq_wake() directly
Date: Sun, 12 Feb 2017 15:43:33 -0800
Message-ID: <20170212234333.GA25725@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36225 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbdBLXnh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 18:43:37 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Michael Welling <mwelling@ieee.org>, linux-kernel@vger.kernel.org

Instead of setting irq_set_irq_wake() directly in probe(), mark the device
as wakeup-capable, and use enable_irq_wake() and disable_irq_wake() in
suspend/resume path.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc200x-core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index 88ea5e1b72ae..d1c40c803d61 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -114,7 +114,9 @@ struct tsc200x {
 
 	struct gpio_desc	*reset_gpio;
 	int			(*tsc200x_cmd)(struct device *dev, u8 cmd);
+
 	int			irq;
+	bool			wake_irq_enabled;
 };
 
 static void tsc200x_update_pen_state(struct tsc200x *ts,
@@ -573,7 +575,8 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 		goto err_remove_sysfs;
 	}
 
-	irq_set_irq_wake(irq, 1);
+	device_init_wakeup(dev, true);
+
 	return 0;
 
 err_remove_sysfs:
@@ -607,6 +610,9 @@ static int __maybe_unused tsc200x_suspend(struct device *dev)
 
 	ts->suspended = true;
 
+	if (device_may_wakeup(dev))
+		ts->wake_irq_enabled = enable_irq_wake(ts->irq) == 0;
+
 	mutex_unlock(&ts->mutex);
 
 	return 0;
@@ -618,6 +624,11 @@ static int __maybe_unused tsc200x_resume(struct device *dev)
 
 	mutex_lock(&ts->mutex);
 
+	if (ts->wake_irq_enabled) {
+		disable_irq_wake(ts->irq);
+		ts->wake_irq_enabled = false;
+	}
+
 	if (ts->suspended && ts->opened)
 		__tsc200x_enable(ts);
 
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
