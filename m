From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: Re: [PATCH 2/2 v3] Input: atmel_mxt_ts - Make CHG line high after
 the interrupts are enabled
Date: Fri, 08 Apr 2011 16:16:18 +0300
Message-ID: <4D9F0AA2.3010501@atmel.com>
References: <4D821E00.5060104@atmel.com>	<AANLkTikncdvefBBYyhmjNGrqy5915Xw_pqmSG85VO2xV@mail.gmail.com>	<4D95DB70.2090604@atmel.com> <BANLkTi=PRjx3nN0LQs9Asdj0PHj-ripv4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:20936 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab1DHNSo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Apr 2011 09:18:44 -0400
In-Reply-To: <BANLkTi=PRjx3nN0LQs9Asdj0PHj-ripv4g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <dofmind@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Make the CHG line (interrupt line) go high after the interrupts have been enabled to make sure
we don't miss the falling edge.

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
v3: Change the locations where this is done to ensure correct operation at FW update, 
    and to get rid of some error handling

 drivers/input/touchscreen/atmel_mxt_ts.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 4012436..5f09f57 100644
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
@@ -981,6 +977,10 @@ static ssize_t mxt_update_fw_store(struct device *dev,
 
 	enable_irq(data->irq);
 
+	error = mxt_make_highchg(data);
+	if (error)
+		return error;
+
 	return count;
 }
 
@@ -1090,6 +1090,10 @@ static int __devinit mxt_probe(struct i2c_client *client,
 		goto err_free_object;
 	}
 
+	error = mxt_make_highchg(data);
+	if (error)
+		goto err_free_irq;
+
 	error = input_register_device(input_dev);
 	if (error)
 		goto err_free_irq;
-- 
1.7.0.4

