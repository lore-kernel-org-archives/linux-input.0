From: Bastian Hecht <hechtb@gmail.com>
Subject: [PATCH] input: st1232: Add IRQF_NO_SUSPEND flag
Date: Thu, 14 Feb 2013 11:32:12 -0600
Message-ID: <1360863132-11227-1-git-send-email-hechtb+renesas@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Tony SIM <chinyeow.sim.xt@renesas.com>, Bastian Hecht <hechtb+renesas@gmail.com>
List-Id: linux-input@vger.kernel.org

When registering the interrupt handler we add the IRQF_NO_SUSPEND flag
to save the IRQ line from being disabled during suspension. This way we
keep the ability to use the device as a wakeup source.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 drivers/input/touchscreen/st1232.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index d9d05e2..4f37199 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -180,7 +180,7 @@ static int st1232_ts_probe(struct i2c_client *client,
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, MIN_Y, MAX_Y, 0, 0);
 
 	error = request_threaded_irq(client->irq, NULL, st1232_ts_irq_handler,
-				     IRQF_ONESHOT, client->name, ts);
+			IRQF_ONESHOT | IRQF_NO_SUSPEND, client->name, ts);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
 		goto err_free_mem;
-- 
1.7.9.5

