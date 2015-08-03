From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 7/9] Input: atmel_mxt_ts - disable interrupt for 50ms after reset
Date: Mon,  3 Aug 2015 16:23:15 +0100
Message-ID: <1438615397-17112-8-git-send-email-nick.dyer@itdev.co.uk>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:17627 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754236AbbHCPcr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 11:32:47 -0400
In-Reply-To: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Nick Dyer <nick.dyer@itdev.co.uk>

The CHG/interrupt line is momentarily set (approximately 100 ms) as an
input after power-up or reset for diagnostic purposes. This may cause
spurious interrupts, so disable interrupt handler during this period.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 7c14faa..ff48d45 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1098,7 +1098,9 @@ static int mxt_soft_reset(struct mxt_data *data)
 	struct device *dev = &data->client->dev;
 	int ret = 0;
 
-	dev_info(dev, "Resetting chip\n");
+	dev_info(dev, "Resetting device\n");
+
+	disable_irq(data->irq);
 
 	reinit_completion(&data->reset_completion);
 
@@ -1106,6 +1108,11 @@ static int mxt_soft_reset(struct mxt_data *data)
 	if (ret)
 		return ret;
 
+	/* Ignore CHG line for 100ms after reset */
+	msleep(100);
+
+	enable_irq(data->irq);
+
 	ret = mxt_wait_for_completion(data, &data->reset_completion,
 				      MXT_RESET_TIMEOUT);
 	if (ret)
-- 
2.4.6

