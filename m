From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] input: eglx_ts, remove irq trigger flags
Date: Thu, 12 Mar 2015 15:50:16 +0100
Message-ID: <1426171816-26609-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>
List-Id: linux-input@vger.kernel.org

The trigger settings for a given irq are parsed from DT. Defining them
as flag for devm_request_threaded_irq() overwrites these settings. This
results in wrong trigger settings for boards which have different irq
triggers.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/input/touchscreen/egalax_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 4c56299284ef..b0e6448b743c 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -218,7 +218,7 @@ static int egalax_ts_probe(struct i2c_client *client,
 
 	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
 					  egalax_ts_interrupt,
-					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					  IRQF_ONESHOT,
 					  "egalax_ts", ts);
 	if (error < 0) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
-- 
2.1.4
