From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: [PATCH 2/2] Input: atmel_mxt_ts - Make CHG line high after the interrupts
 are enabled
Date: Thu, 17 Mar 2011 16:43:12 +0200
Message-ID: <4D821E00.5060104@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:59114 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab1CQOpB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Mar 2011 10:45:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Make the CHG line (interrupt line) go high after the interrupts have been enabled to make sure we don't miss the falling edge.

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index f8cd478..ca2062a 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -804,10 +804,6 @@ static int mxt_initialize(struct mxt_data *data)
 	if (error)
 		return error;
 
-	error = mxt_make_highchg(data);
-	if (error)
-		return error;
-
 	mxt_handle_pdata(data);
 
 	/* Backup to memory */
@@ -1098,6 +1094,10 @@ static int __devinit mxt_probe(struct i2c_client *client,
 	if (error)
 		goto err_unregister_device;
 
+	error = mxt_make_highchg(data);
+	if (error)
+		goto err_unregister_device;
+
 	return 0;
 
 err_unregister_device:
-- 
1.7.0.4
