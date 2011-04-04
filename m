From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH] Input: h3600_ts - fix error handling at connect
Date: Tue, 05 Apr 2011 00:57:12 +0200
Message-ID: <1301957832.3352.8.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55030 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab1DDW5T (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Apr 2011 18:57:19 -0400
Received: by wya21 with SMTP id 21so5099084wya.19
        for <linux-input@vger.kernel.org>; Mon, 04 Apr 2011 15:57:17 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, jsimmons@transvirtual.com

In case of an error in h3600ts_connect(), deconstruct by correct order
and with the right calls.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/input/touchscreen/h3600_ts_input.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
index b4d7f63..6ae063e 100644
--- a/drivers/input/touchscreen/h3600_ts_input.c
+++ b/drivers/input/touchscreen/h3600_ts_input.c
@@ -399,31 +399,34 @@ static int h3600ts_connect(struct serio *serio, struct serio_driver *drv)
 			IRQF_SHARED | IRQF_DISABLED, "h3600_action", &ts->dev)) {
 		printk(KERN_ERR "h3600ts.c: Could not allocate Action Button IRQ!\n");
 		err = -EBUSY;
-		goto fail2;
+		goto fail1;
 	}
 
 	if (request_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, npower_button_handler,
 			IRQF_SHARED | IRQF_DISABLED, "h3600_suspend", &ts->dev)) {
 		printk(KERN_ERR "h3600ts.c: Could not allocate Power Button IRQ!\n");
 		err = -EBUSY;
-		goto fail3;
+		goto fail2;
 	}
 
 	serio_set_drvdata(serio, ts);
 
 	err = serio_open(serio, drv);
 	if (err)
-		return err;
+		goto fail3;
 
 	//h3600_flite_control(1, 25);     /* default brightness */
-	input_register_device(ts->dev);
+	err = input_register_device(ts->dev);
+	if (err)
+		goto fail4;
 
 	return 0;
 
-fail3:	free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, ts->dev);
+fail4:	serio_close(serio);
+fail3:	serio_set_drvdata(serio, NULL);
+	free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, ts->dev);
 fail2:	free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, ts->dev);
-fail1:	serio_set_drvdata(serio, NULL);
-	input_free_device(input_dev);
+fail1:	input_free_device(input_dev);
 	kfree(ts);
 	return err;
 }
-- 
1.7.2.5



