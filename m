From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH] Input: stmfts: set IRQ_NOAUTOEN to the irq flag
Date: Wed, 27 Sep 2017 21:58:31 +0900
Message-ID: <20170927125831.11759-1-andi.shyti@samsung.com>
References: <CGME20170927125843epcas2p3a703ab81e165bdaf5bfd100dc08f9ae1@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

The interrupt is requested before the device is powered on and
it's value in some cases cannot be reliable. It happens on some
devices that an interrupt is generated as soon as requested
before having the chance to disable the irq.

Set the irq flag as IRQ_NOAUTOEN before requesting it.

This patch mutes the error:

  stmfts 2-0049: failed to read events: -11

received sometimes during boot time.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/input/touchscreen/stmfts.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 2351199189a4..362de0001b33 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -689,6 +689,14 @@ static int stmfts_probe(struct i2c_client *client,
 
 	input_set_drvdata(sdata->input, sdata);
 
+	/*
+	 * stmfts_power_on expects interrupt to be disabled, but
+	 * at this point the device is still off and I do not trust
+	 * the status of the irq line that can generate some spurious
+	 * interrupts. To be on the safe side it's better to not enable
+	 * the interrupts during their request.
+	 */
+	irq_set_status_flags(client->irq, IRQ_NOAUTOEN);
 	err = devm_request_threaded_irq(&client->dev, client->irq,
 					NULL, stmfts_irq_handler,
 					IRQF_ONESHOT,
@@ -696,9 +704,6 @@ static int stmfts_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	/* stmfts_power_on expects interrupt to be disabled */
-	disable_irq(client->irq);
-
 	dev_dbg(&client->dev, "initializing ST-Microelectronics FTS...\n");
 
 	err = stmfts_power_on(sdata);
-- 
2.14.2
