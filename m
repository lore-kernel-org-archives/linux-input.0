From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: h3600_ts: fix a leak of the IRQ during init failure
Date: Mon, 02 May 2011 00:13:32 +0800
Message-ID: <1304266412.3000.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In h3600ts_connect error path, free_irq() was using ts->dev rather than the
&ts->dev as the data pointer so free_irq() wouldn't have matched.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/touchscreen/h3600_ts_input.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
index 45f93d0..e45ae38 100644
--- a/drivers/input/touchscreen/h3600_ts_input.c
+++ b/drivers/input/touchscreen/h3600_ts_input.c
@@ -424,8 +424,8 @@ static int h3600ts_connect(struct serio *serio, struct serio_driver *drv)
 
 fail4:	serio_close(serio);
 fail3:	serio_set_drvdata(serio, NULL);
-	free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, ts->dev);
-fail2:	free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, ts->dev);
+	free_irq(IRQ_GPIO_BITSY_NPOWER_BUTTON, &ts->dev);
+fail2:	free_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, &ts->dev);
 fail1:	input_free_device(input_dev);
 	kfree(ts);
 	return err;
-- 
1.7.1
