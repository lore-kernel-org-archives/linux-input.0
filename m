From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: h3600_ts_input - bugfix for
 request_irq()/free_irq() parameters
Date: Wed, 13 Apr 2011 20:37:11 +0800
Message-ID: <1302698231.3002.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64036 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab1DMMhS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Apr 2011 08:37:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The dev field of h3600_dev is a pointer, thus use ts->dev instead of &ts->dev
as the dev_id argument while calling request_irq()/free_irq().

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/touchscreen/h3600_ts_input.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
index 45f93d0..211811a 100644
--- a/drivers/input/touchscreen/h3600_ts_input.c
+++ b/drivers/input/touchscreen/h3600_ts_input.c
@@ -396,14 +396,14 @@ static int h3600ts_connect(struct serio *serio, struct serio_driver *drv)
 	set_GPIO_IRQ_edge(GPIO_BITSY_NPOWER_BUTTON, GPIO_RISING_EDGE);
 
 	if (request_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, action_button_handler,
-			IRQF_SHARED | IRQF_DISABLED, "h3600_action", &ts->dev)) {
+			IRQF_SHARED | IRQF_DISABLED, "h3600_action", ts->dev)) {
 		printk(KERN_ERR "h3600ts.c: Could not allocate Action Button IRQ!\n");
 		err = -EBUSY;
 		goto fail1;
 	}
 
 	if (request_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, npower_button_handler,
-			IRQF_SHARED | IRQF_DISABLED, "h3600_suspend", &ts->dev)) {
+			IRQF_SHARED | IRQF_DISABLED, "h3600_suspend", ts->dev)) {
 		printk(KERN_ERR "h3600ts.c: Could not allocate Power Button IRQ!\n");
 		err = -EBUSY;
 		goto fail2;
@@ -439,8 +439,8 @@ static void h3600ts_disconnect(struct serio *serio)
 {
 	struct h3600_dev *ts = serio_get_drvdata(serio);
 
-	free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, &ts->dev);
-	free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, &ts->dev);
+	free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, ts->dev);
+	free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, ts->dev);
 	input_get_device(ts->dev);
 	input_unregister_device(ts->dev);
 	serio_close(serio);
-- 
1.7.1



