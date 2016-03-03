From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH] da9052: ensure da9052_ts_input_open will not lock up on irq flood
Date: Thu,  3 Mar 2016 11:52:02 +0100
Message-ID: <1457002322-21953-1-git-send-email-m.grzeschik@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54244 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755079AbcCCKwI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Mar 2016 05:52:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, support.opensource@diasemi.com, kernel@pengutronix.de

It is possible that da9052_ts_input_open is called and the touchscreen
is triggering continuous interrupts. In this case we will never leave
da9052_ts_input_open. The da9052_reg_update will never get the i2c bus
as the interrupt handler will continuously lock it.

This patch switch places of da9052_reg_update and the setting of
tsi->stopped. This way its ensured that da9052_ts_input_open will never
lockup on interrupt flood.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/input/touchscreen/da9052_tsi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
index 5a013bb..1b136b8 100644
--- a/drivers/input/touchscreen/da9052_tsi.c
+++ b/drivers/input/touchscreen/da9052_tsi.c
@@ -189,17 +189,20 @@ static int da9052_configure_tsi(struct da9052_tsi *tsi)
 
 static int da9052_ts_input_open(struct input_dev *input_dev)
 {
+	int val;
 	struct da9052_tsi *tsi = input_get_drvdata(input_dev);
 
-	tsi->stopped = false;
-	mb();
+	val = da9052_reg_update(tsi->da9052, DA9052_TSI_CONT_A_REG,
+				 1 << 1, 1 << 1);
 
 	/* Unmask PEN_DOWN event */
 	da9052_enable_irq(tsi->da9052, DA9052_IRQ_PENDOWN);
 
+	tsi->stopped = false;
+	mb();
+
 	/* Enable Pen Detect Circuit */
-	return da9052_reg_update(tsi->da9052, DA9052_TSI_CONT_A_REG,
-				 1 << 1, 1 << 1);
+	return val;
 }
 
 static void da9052_ts_input_close(struct input_dev *input_dev)
-- 
2.7.0

